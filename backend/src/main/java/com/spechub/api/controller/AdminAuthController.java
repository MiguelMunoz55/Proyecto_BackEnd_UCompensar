package com.spechub.api.controller;

import com.spechub.api.dto.LoginRequestDTO;
import com.spechub.api.dto.LoginResponseDTO;
import com.spechub.api.exception.ResourceNotFoundException;
import com.spechub.api.model.UsuarioAdmin;
import com.spechub.api.dao.UsuarioAdminDAO;
import com.spechub.api.security.JwtService;
import jakarta.validation.Valid;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/api/auth")
public class AdminAuthController {

    private final AuthenticationManager authenticationManager;
    private final JwtService jwtService;
    private final UsuarioAdminDAO usuarioAdminDAO;

    public AdminAuthController(AuthenticationManager authenticationManager,
                                JwtService jwtService,
                                UsuarioAdminDAO usuarioAdminDAO) {
        this.authenticationManager = authenticationManager;
        this.jwtService = jwtService;
        this.usuarioAdminDAO = usuarioAdminDAO;
    }

    @PostMapping("/login")
    public LoginResponseDTO login(@Valid @RequestBody LoginRequestDTO request) {
        // Si las credenciales son inválidas, lanza BadCredentialsException,
        // que GlobalExceptionHandler traduce a 401.
        var authentication = authenticationManager.authenticate(
                new UsernamePasswordAuthenticationToken(request.getUsername(), request.getPassword())
        );

        UserDetails userDetails = (UserDetails) authentication.getPrincipal();
        UsuarioAdmin usuario = usuarioAdminDAO.findByUsername(userDetails.getUsername())
                .orElseThrow(() -> new ResourceNotFoundException("Usuario no encontrado"));

        String token = jwtService.generateToken(userDetails, usuario.getRol());
        return new LoginResponseDTO(token, usuario.getUsername(), usuario.getRol());
    }
}
