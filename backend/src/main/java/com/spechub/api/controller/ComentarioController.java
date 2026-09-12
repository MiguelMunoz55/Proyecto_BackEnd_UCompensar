package com.spechub.api.controller;

import com.spechub.api.dto.ComentarioDTO;
import com.spechub.api.dto.ComentarioRequestDTO;
import com.spechub.api.service.ComentarioService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
public class ComentarioController {

    private final ComentarioService comentarioService;

    public ComentarioController(ComentarioService comentarioService) {
        this.comentarioService = comentarioService;
    }

    @GetMapping("/api/devices/{deviceId}/comments")
    public List<ComentarioDTO> listar(@PathVariable Long deviceId) {
        return comentarioService.listarPorDispositivo(deviceId);
    }

    // Público: cualquier visitante puede publicar un comentario/reseña.
    @PostMapping("/api/devices/{deviceId}/comments")
    public ResponseEntity<ComentarioDTO> crear(@PathVariable Long deviceId,
                                                @Valid @RequestBody ComentarioRequestDTO request) {
        ComentarioDTO creado = comentarioService.crear(deviceId, request);
        return ResponseEntity.status(HttpStatus.CREATED).body(creado);
    }

    // Admin: moderación de comentarios.
    @DeleteMapping("/api/comments/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        comentarioService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
