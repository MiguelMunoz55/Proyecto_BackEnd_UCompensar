package com.spechub.api.controller;

import com.spechub.api.dto.MarcaDTO;
import com.spechub.api.dto.MarcaRequestDTO;
import com.spechub.api.service.MarcaService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/brands")
public class MarcaController {

    private final MarcaService marcaService;

    public MarcaController(MarcaService marcaService) {
        this.marcaService = marcaService;
    }

    @GetMapping
    public List<MarcaDTO> listar() {
        return marcaService.listar();
    }

    @PostMapping
    public ResponseEntity<MarcaDTO> crear(@Valid @RequestBody MarcaRequestDTO request) {
        MarcaDTO creada = marcaService.crear(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(creada);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        marcaService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
