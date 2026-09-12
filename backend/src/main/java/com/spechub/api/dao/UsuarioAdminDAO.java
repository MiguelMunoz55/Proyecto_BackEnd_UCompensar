package com.spechub.api.dao;

import com.spechub.api.model.UsuarioAdmin;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.Optional;

public interface UsuarioAdminDAO extends JpaRepository<UsuarioAdmin, Long> {
    Optional<UsuarioAdmin> findByUsername(String username);
}
