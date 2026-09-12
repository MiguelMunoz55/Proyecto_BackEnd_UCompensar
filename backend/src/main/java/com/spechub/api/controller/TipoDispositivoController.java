package com.spechub.api.controller;

import com.spechub.api.dto.TipoDispositivoDTO;
import com.spechub.api.dto.TipoDispositivoRequestDTO;
import com.spechub.api.service.TipoDispositivoService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/device-types")
public class TipoDispositivoController {

    private final TipoDispositivoService tipoDispositivoService;

    public TipoDispositivoController(TipoDispositivoService tipoDispositivoService) {
        this.tipoDispositivoService = tipoDispositivoService;
    }

    @GetMapping
    public List<TipoDispositivoDTO> listar() {
        return tipoDispositivoService.listar();
    }

    @PostMapping
    public ResponseEntity<TipoDispositivoDTO> crear(@Valid @RequestBody TipoDispositivoRequestDTO request) {
        TipoDispositivoDTO creado = tipoDispositivoService.crear(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(creado);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        tipoDispositivoService.eliminar(id);
        return ResponseEntity.noContent().build();
    }
}
