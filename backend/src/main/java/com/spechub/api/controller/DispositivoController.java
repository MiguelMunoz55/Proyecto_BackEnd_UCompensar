package com.spechub.api.controller;

import com.spechub.api.dto.DispositivoDTO;
import com.spechub.api.dto.DispositivoRequestDTO;
import com.spechub.api.service.DispositivoService;
import jakarta.validation.Valid;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.math.BigDecimal;
import java.util.List;

@RestController
@RequestMapping("/api/devices")
public class DispositivoController {

    private final DispositivoService dispositivoService;

    public DispositivoController(DispositivoService dispositivoService) {
        this.dispositivoService = dispositivoService;
    }

    // GET /api/devices?type=celular&brandId=1&maxPrice=5000000&q=galaxy
    @GetMapping
    public List<DispositivoDTO> listar(
            @RequestParam(required = false) String type,
            @RequestParam(required = false) Long brandId,
            @RequestParam(required = false) BigDecimal maxPrice,
            @RequestParam(required = false) String q
    ) {
        return dispositivoService.listar(type, brandId, maxPrice, q);
    }

    @GetMapping("/{id}")
    public DispositivoDTO obtener(@PathVariable Long id) {
        return dispositivoService.obtenerPorId(id);
    }

    @PostMapping
    public ResponseEntity<DispositivoDTO> crear(@Valid @RequestBody DispositivoRequestDTO request) {
        DispositivoDTO creado = dispositivoService.crear(request);
        return ResponseEntity.status(HttpStatus.CREATED).body(creado);
    }

    @PutMapping("/{id}")
    public DispositivoDTO actualizar(@PathVariable Long id, @Valid @RequestBody DispositivoRequestDTO request) {
        return dispositivoService.actualizar(id, request);
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> eliminar(@PathVariable Long id) {
        dispositivoService.eliminar(id);
        return ResponseEntity.noContent().build();
    }

    // POST /api/devices/{id}/image (multipart/form-data, campo "file")
    @PostMapping(value = "/{id}/image", consumes = MediaType.MULTIPART_FORM_DATA_VALUE)
    public DispositivoDTO subirImagen(@PathVariable Long id, @RequestParam("file") MultipartFile file) {
        return dispositivoService.actualizarImagen(id, file);
    }
}
