package com.spechub.api.dao;

import com.spechub.api.model.Marca;
import org.springframework.data.jpa.repository.JpaRepository;

public interface MarcaDAO extends JpaRepository<Marca, Long> {
    boolean existsByNombreIgnoreCase(String nombre);
}
