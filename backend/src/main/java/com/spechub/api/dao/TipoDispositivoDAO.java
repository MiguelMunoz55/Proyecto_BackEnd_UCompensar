package com.spechub.api.dao;

import com.spechub.api.model.TipoDispositivo;
import org.springframework.data.jpa.repository.JpaRepository;

public interface TipoDispositivoDAO extends JpaRepository<TipoDispositivo, Long> {
    boolean existsBySlugIgnoreCase(String slug);
}
