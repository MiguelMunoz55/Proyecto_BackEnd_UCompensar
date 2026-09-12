package com.spechub.api.security;

import com.spechub.api.model.UsuarioAdmin;
import com.spechub.api.dao.UsuarioAdminDAO;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UsuarioAdminDetailsService implements UserDetailsService {

    private final UsuarioAdminDAO usuarioAdminDAO;

    public UsuarioAdminDetailsService(UsuarioAdminDAO usuarioAdminDAO) {
        this.usuarioAdminDAO = usuarioAdminDAO;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        UsuarioAdmin usuario = usuarioAdminDAO.findByUsername(username)
                .orElseThrow(() -> new UsernameNotFoundException("Usuario no encontrado: " + username));

        return new User(
                usuario.getUsername(),
                usuario.getPasswordHash(),
                List.of(new SimpleGrantedAuthority("ROLE_" + usuario.getRol()))
        );
    }
}
