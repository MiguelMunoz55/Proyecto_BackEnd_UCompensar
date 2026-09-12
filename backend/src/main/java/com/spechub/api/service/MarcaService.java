package com.spechub.api.service;

import com.spechub.api.dto.MarcaDTO;
import com.spechub.api.dto.MarcaRequestDTO;
import com.spechub.api.exception.ConflictoDeNegocioException;
import com.spechub.api.exception.ResourceNotFoundException;
import com.spechub.api.mapper.CatalogoMapper;
import com.spechub.api.model.Marca;
import com.spechub.api.dao.DispositivoDAO;
import com.spechub.api.dao.MarcaDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MarcaService {

    private final MarcaDAO marcaDAO;
    private final DispositivoDAO dispositivoDAO;
    private final CatalogoMapper catalogoMapper;

    public MarcaService(MarcaDAO marcaDAO, DispositivoDAO dispositivoDAO, CatalogoMapper catalogoMapper) {
        this.marcaDAO = marcaDAO;
        this.dispositivoDAO = dispositivoDAO;
        this.catalogoMapper = catalogoMapper;
    }

    @Transactional(readOnly = true)
    public List<MarcaDTO> listar() {
        return marcaDAO.findAll().stream().map(catalogoMapper::aMarcaDTO).toList();
    }

    @Transactional
    public MarcaDTO crear(MarcaRequestDTO request) {
        if (marcaDAO.existsByNombreIgnoreCase(request.getName())) {
            throw new ConflictoDeNegocioException("Ya existe una marca con ese nombre");
        }
        Marca marca = new Marca(request.getName(), request.getCountry());
        return catalogoMapper.aMarcaDTO(marcaDAO.save(marca));
    }

    @Transactional
    public void eliminar(Long id) {
        Marca marca = marcaDAO.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Marca no encontrada: " + id));

        if (!dispositivoDAO.findByMarca_Id(id).isEmpty()) {
            throw new ConflictoDeNegocioException("No se puede eliminar la marca: tiene dispositivos asociados");
        }
        marcaDAO.delete(marca);
    }
}
