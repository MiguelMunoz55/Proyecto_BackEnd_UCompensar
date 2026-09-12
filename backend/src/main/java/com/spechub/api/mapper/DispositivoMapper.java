package com.spechub.api.mapper;

import com.spechub.api.dto.DispositivoDTO;
import com.spechub.api.model.Dispositivo;
import com.spechub.api.model.EspecificacionDispositivo;
import org.springframework.stereotype.Component;

import java.util.Comparator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Convierte Dispositivo (entidad) a DispositivoDTO reproduciendo el mismo
 * objeto "enriquecido" que hoy arma enrichDevice() en
 * frontend/src/context/DataContext.jsx: incluye marca, tipo, comentarios
 * ordenados, promedio de calificación y cantidad de comentarios.
 */
@Component
public class DispositivoMapper {

    private final CatalogoMapper catalogoMapper;
    private final ComentarioMapper comentarioMapper;

    public DispositivoMapper(CatalogoMapper catalogoMapper, ComentarioMapper comentarioMapper) {
        this.catalogoMapper = catalogoMapper;
        this.comentarioMapper = comentarioMapper;
    }

    public DispositivoDTO aDTO(Dispositivo d) {
        DispositivoDTO dto = new DispositivoDTO();
        dto.setId(d.getId());
        dto.setName(d.getNombre());
        dto.setBrandId(d.getMarca() != null ? d.getMarca().getId() : null);
        dto.setTypeId(d.getTipo() != null ? d.getTipo().getId() : null);
        dto.setReleaseDate(d.getFechaLanzamiento() != null ? d.getFechaLanzamiento().toString() : null);
        dto.setPrice(d.getPrecio());
        dto.setShortDescription(d.getDescripcionCorta());
        dto.setReview(d.getResena());
        dto.setImageTone(d.getTonoImagen());
        dto.setImageUrl(imagenPrincipal(d));
        dto.setSpecs(aMapaSpecs(d.getEspecificaciones()));
        dto.setBrand(catalogoMapper.aMarcaDTO(d.getMarca()));
        dto.setType(catalogoMapper.aTipoDTO(d.getTipo()));

        List<com.spechub.api.dto.ComentarioDTO> comentarios = d.getComentarios().stream()
                .sorted(Comparator.comparing(com.spechub.api.model.Comentario::getCreadoEn).reversed())
                .map(comentarioMapper::aDTO)
                .toList();
        dto.setComments(comentarios);
        dto.setCommentCount(comentarios.size());
        dto.setAverageRating(promedioCalificacion(d));

        return dto;
    }

    private String imagenPrincipal(Dispositivo d) {
        return d.getImagenes().stream()
                .min(Comparator.comparing(com.spechub.api.model.ImagenDispositivo::getOrden))
                .map(com.spechub.api.model.ImagenDispositivo::getUrlImagen)
                .orElse(null);
    }

    private Map<String, String> aMapaSpecs(List<EspecificacionDispositivo> especificaciones) {
        Map<String, String> specs = new LinkedHashMap<>();
        especificaciones.stream()
                .sorted(Comparator.comparing(EspecificacionDispositivo::getOrden))
                .forEach(e -> specs.put(e.getClave(), e.getValor()));
        return specs;
    }

    private Double promedioCalificacion(Dispositivo d) {
        List<com.spechub.api.model.Comentario> comentarios = d.getComentarios();
        if (comentarios.isEmpty()) return null;
        double suma = comentarios.stream().mapToInt(c -> c.getCalificacion() == null ? 0 : c.getCalificacion()).sum();
        return suma / comentarios.size();
    }
}
