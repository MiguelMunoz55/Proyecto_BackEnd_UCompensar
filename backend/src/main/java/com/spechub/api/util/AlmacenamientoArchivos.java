package com.spechub.api.util;

import com.spechub.api.exception.ConflictoDeNegocioException;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import java.util.Set;
import java.util.UUID;

/**
 * Guarda en disco los archivos de imagen subidos desde el panel de admin y
 * expone la URL pública (servida vía el resource handler configurado en
 * WebConfig) con la que el frontend puede mostrarlas.
 */
@Component
public class AlmacenamientoArchivos {

    private static final Set<String> TIPOS_PERMITIDOS = Set.of(
            "image/jpeg", "image/png", "image/webp", "image/gif"
    );
    private static final long TAMANO_MAXIMO_BYTES = 5L * 1024 * 1024; // 5 MB

    private final Path directorioDispositivos;
    private final Path directorioBase;

    public AlmacenamientoArchivos(@Value("${spechub.uploads.dir:uploads}") String directorioUploads) {
        this.directorioBase = Paths.get(directorioUploads).toAbsolutePath().normalize();
        this.directorioDispositivos = directorioBase.resolve("dispositivos");
        try {
            Files.createDirectories(directorioDispositivos);
        } catch (IOException e) {
            throw new IllegalStateException("No se pudo crear el directorio de subidas: " + directorioDispositivos, e);
        }
    }

    /**
     * Guarda la imagen de un dispositivo y devuelve la URL relativa
     * (ej. "/uploads/dispositivos/&lt;uuid&gt;.jpg") que se almacena en
     * ImagenDispositivo.urlImagen.
     */
    public String guardarImagenDispositivo(MultipartFile archivo) {
        validar(archivo);

        String extension = extraerExtension(archivo.getOriginalFilename());
        String nombreArchivo = UUID.randomUUID() + extension;
        Path destino = directorioDispositivos.resolve(nombreArchivo);

        try (InputStream in = archivo.getInputStream()) {
            Files.copy(in, destino, StandardCopyOption.REPLACE_EXISTING);
        } catch (IOException e) {
            throw new IllegalStateException("No se pudo guardar la imagen del dispositivo", e);
        }

        return "/uploads/dispositivos/" + nombreArchivo;
    }

    /** Elimina un archivo previamente guardado a partir de su URL relativa. */
    public void eliminar(String urlRelativa) {
        if (urlRelativa == null || urlRelativa.isBlank()) return;
        String nombreArchivo = urlRelativa.substring(urlRelativa.lastIndexOf('/') + 1);
        try {
            Files.deleteIfExists(directorioDispositivos.resolve(nombreArchivo));
        } catch (IOException e) {
            // No es crítico: si falla el borrado físico, no debe tumbar la operación.
        }
    }

    private void validar(MultipartFile archivo) {
        if (archivo == null || archivo.isEmpty()) {
            throw new ConflictoDeNegocioException("Selecciona una imagen para subir.");
        }
        if (archivo.getSize() > TAMANO_MAXIMO_BYTES) {
            throw new ConflictoDeNegocioException("La imagen supera el tamaño máximo permitido (5 MB).");
        }
        String tipo = archivo.getContentType();
        if (tipo == null || !TIPOS_PERMITIDOS.contains(tipo.toLowerCase())) {
            throw new ConflictoDeNegocioException("Formato de imagen no soportado. Usa JPG, PNG, WEBP o GIF.");
        }
    }

    private String extraerExtension(String nombreOriginal) {
        if (nombreOriginal == null || !nombreOriginal.contains(".")) return "";
        return nombreOriginal.substring(nombreOriginal.lastIndexOf('.')).toLowerCase();
    }
}
