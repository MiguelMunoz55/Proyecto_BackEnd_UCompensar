package com.spechub.api.service;

import com.spechub.api.dto.TipoDispositivoDTO;
import com.spechub.api.dto.TipoDispositivoRequestDTO;
import com.spechub.api.exception.ConflictoDeNegocioException;
import com.spechub.api.exception.ResourceNotFoundException;
import com.spechub.api.mapper.CatalogoMapper;
import com.spechub.api.model.TipoDispositivo;
import com.spechub.api.dao.DispositivoDAO;
import com.spechub.api.dao.TipoDispositivoDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class TipoDispositivoService {

    private final TipoDispositivoDAO tipoDispositivoDAO;
    private final DispositivoDAO dispositivoDAO;
    private final CatalogoMapper catalogoMapper;

    public TipoDispositivoService(TipoDispositivoDAO tipoDispositivoDAO,
                                   DispositivoDAO dispositivoDAO,
                                   CatalogoMapper catalogoMapper) {
        this.tipoDispositivoDAO = tipoDispositivoDAO;
        this.dispositivoDAO = dispositivoDAO;
        this.catalogoMapper = catalogoMapper;
    }

    @Transactional(readOnly = true)
    public List<TipoDispositivoDTO> listar() {
        return tipoDispositivoDAO.findAll().stream().map(catalogoMapper::aTipoDTO).toList();
    }

    @Transactional
    public TipoDispositivoDTO crear(TipoDispositivoRequestDTO request) {
        if (tipoDispositivoDAO.existsBySlugIgnoreCase(request.getSlug())) {
            throw new ConflictoDeNegocioException("Ya existe un tipo de dispositivo con ese slug");
        }
        TipoDispositivo tipo = new TipoDispositivo(request.getName(), request.getSlug());
        return catalogoMapper.aTipoDTO(tipoDispositivoDAO.save(tipo));
    }

    @Transactional
    public void eliminar(Long id) {
        TipoDispositivo tipo = tipoDispositivoDAO.findById(id)
                .orElseThrow(() -> new ResourceNotFoundException("Tipo de dispositivo no encontrado: " + id));

        if (!dispositivoDAO.findByTipo_Id(id).isEmpty()) {
            throw new ConflictoDeNegocioException("No se puede eliminar el tipo: tiene dispositivos asociados");
        }
        tipoDispositivoDAO.delete(tipo);
    }
}
