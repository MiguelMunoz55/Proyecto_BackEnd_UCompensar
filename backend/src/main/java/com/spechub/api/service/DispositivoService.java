package com.spechub.api.service;

import com.spechub.api.dto.DispositivoDTO;
import com.spechub.api.dto.DispositivoRequestDTO;
import com.spechub.api.exception.ResourceNotFoundException;
import com.spechub.api.mapper.DispositivoMapper;
import com.spechub.api.model.Dispositivo;
import com.spechub.api.model.EspecificacionDispositivo;
import com.spechub.api.model.ImagenDispositivo;
import com.spechub.api.model.Marca;
import com.spechub.api.model.TipoDispositivo;
import com.spechub.api.dao.DispositivoDAO;
import com.spechub.api.dao.MarcaDAO;
import com.spechub.api.dao.TipoDispositivoDAO;
import com.spechub.api.util.AlmacenamientoArchivos;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Service
public class DispositivoService {

    private final DispositivoDAO dispositivoDAO;
    private final MarcaDAO marcaDAO;
    private final TipoDispositivoDAO tipoDispositivoDAO;
    private final DispositivoMapper dispositivoMapper;
    private final AlmacenamientoArchivos almacenamientoArchivos;

    public DispositivoService(DispositivoDAO dispositivoDAO,
                               MarcaDAO marcaDAO,
                               TipoDispositivoDAO tipoDispositivoDAO,
                               DispositivoMapper dispositivoMapper,
                               AlmacenamientoArchivos almacenamientoArchivos) {
        this.dispositivoDAO = dispositivoDAO;
        this.marcaDAO = marcaDAO;
        this.tipoDispositivoDAO = tipoDispositivoDAO;
        this.dispositivoMapper = dispositivoMapper;
        this.almacenamientoArchivos = almacenamientoArchivos;
    }

    @Transactional(readOnly = true)
    public List<DispositivoDTO> listar(String type, Long brandId, BigDecimal maxPrice, String q) {
        return dispositivoDAO.buscar(type, brandId, maxPrice, q).stream()
                .map(dispositivoMapper::aDTO)
                .toList();
    }

    @Transactional(readOnly = true)
    public DispositivoDTO obtenerPorId(Long id) {
        return dispositivoMapper.aDTO(buscarEntidad(id));
    }

    @Transactional
    public DispositivoDTO crear(DispositivoRequestDTO request) {
        Dispositivo dispositivo = new Dispositivo();
        aplicarCambios(dispositivo, request);
        return dispositivoMapper.aDTO(dispositivoDAO.save(dispositivo));
    }

    @Transactional
    public DispositivoDTO actualizar(Long id, DispositivoRequestDTO request) {
        Dispositivo dispositivo = buscarEntidad(id);
        aplicarCambios(dispositivo, request);
        return dispositivoMapper.aDTO(dispositivoDAO.save(dispositivo));
    }

    @Transactional
    public void eliminar(Long id) {
        Dispositivo dispositivo = buscarEntidad(id);
        dispositivoDAO.delete(dispositivo); // cascada a specs, imágenes y comentarios
    }

    @Transactional
    public DispositivoDTO actualizarImagen(Long id, MultipartFile archivo) {
        Dispositivo dispositivo = buscarEntidad(id);

        // Solo manejamos una imagen principal por dispositivo: si ya había
        // una, se borra el archivo físico y el registro antes de guardar la nueva.
        if (!dispositivo.getImagenes().isEmpty()) {
            ImagenDispositivo anterior = dispositivo.getImagenes().get(0);
            almacenamientoArchivos.eliminar(anterior.getUrlImagen());
            dispositivo.getImagenes().clear();
        }

        String url = almacenamientoArchivos.guardarImagenDispositivo(archivo);
        dispositivo.getImagenes().add(new ImagenDispositivo(dispositivo, url, dispositivo.getNombre(), 0));

        return dispositivoMapper.aDTO(dispositivoDAO.save(dispositivo));
    }

    private Dispositivo buscarEntidad(Long id) {
        return dispositivoDAO.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Dispositivo no encontrado: " + id));
    }

    private void aplicarCambios(Dispositivo dispositivo, DispositivoRequestDTO request) {
        Marca marca = marcaDAO.findById(request.getBrandId())
                .orElseThrow(() -> new ResourceNotFoundException("Marca no encontrada: " + request.getBrandId()));
        TipoDispositivo tipo = tipoDispositivoDAO.findById(request.getTypeId())
                .orElseThrow(() -> new ResourceNotFoundException("Tipo de dispositivo no encontrado: " + request.getTypeId()));

        dispositivo.setNombre(request.getName());
        dispositivo.setMarca(marca);
        dispositivo.setTipo(tipo);
        dispositivo.setFechaLanzamiento(request.getReleaseDate());
        dispositivo.setPrecio(request.getPrice());
        dispositivo.setDescripcionCorta(request.getShortDescription());
        dispositivo.setResena(request.getReview());
        dispositivo.setTonoImagen(request.getImageTone());

        reemplazarEspecificaciones(dispositivo, request.getSpecs());
    }

    private void reemplazarEspecificaciones(Dispositivo dispositivo, Map<String, String> specs) {
        dispositivo.getEspecificaciones().clear();
        if (specs == null) return;

        List<EspecificacionDispositivo> nuevas = new ArrayList<>();
        int orden = 0;
        for (Map.Entry<String, String> entry : specs.entrySet()) {
            nuevas.add(new EspecificacionDispositivo(dispositivo, entry.getKey(), entry.getValue(), orden++));
        }
        dispositivo.getEspecificaciones().addAll(nuevas);
    }
}
