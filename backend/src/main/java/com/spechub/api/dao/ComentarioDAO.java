package com.spechub.api.dao;

import com.spechub.api.model.Comentario;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface ComentarioDAO extends JpaRepository<Comentario, Long> {
    List<Comentario> findByDispositivo_IdOrderByCreadoEnDesc(Long dispositivoId);
}
