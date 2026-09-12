package com.spechub.api.mapper;

import com.spechub.api.dto.ComentarioDTO;
import com.spechub.api.model.Comentario;
import org.springframework.stereotype.Component;

@Component
public class ComentarioMapper {

    public ComentarioDTO aDTO(Comentario comentario) {
        if (comentario == null) return null;
        return new ComentarioDTO(
                comentario.getId(),
                comentario.getDispositivo().getId(),
                comentario.getNombreAutor(),
                comentario.getCalificacion() == null ? null : comentario.getCalificacion().intValue(),
                comentario.getContenido(),
                comentario.getCreadoEn() == null ? null : comentario.getCreadoEn().toLocalDate().toString()
        );
    }
}
