package com.spechub.api.service;

import com.spechub.api.dto.ComentarioDTO;
import com.spechub.api.dto.ComentarioRequestDTO;
import com.spechub.api.exception.ResourceNotFoundException;
import com.spechub.api.mapper.ComentarioMapper;
import com.spechub.api.model.Comentario;
import com.spechub.api.model.Dispositivo;
import com.spechub.api.dao.ComentarioDAO;
import com.spechub.api.dao.DispositivoDAO;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ComentarioService {

    private final ComentarioDAO comentarioDAO;
    private final DispositivoDAO dispositivoDAO;
    private final ComentarioMapper comentarioMapper;

    public ComentarioService(ComentarioDAO comentarioDAO,
                              DispositivoDAO dispositivoDAO,
                              ComentarioMapper comentarioMapper) {
        this.comentarioDAO = comentarioDAO;
        this.dispositivoDAO = dispositivoDAO;
        this.comentarioMapper = comentarioMapper;
    }

    @Transactional(readOnly = true)
    public List<ComentarioDTO> listarPorDispositivo(Long dispositivoId) {
        return comentarioDAO.findByDispositivo_IdOrderByCreadoEnDesc(dispositivoId).stream()
                .map(comentarioMapper::aDTO)
                .toList();
    }

    @Transactional
    public ComentarioDTO crear(Long dispositivoId, ComentarioRequestDTO request) {
        Dispositivo dispositivo = dispositivoDAO.findById(dispositivoId)
                .orElseThrow(() -> new ResourceNotFoundException("Dispositivo no encontrado: " + dispositivoId));

        Comentario comentario = new Comentario();
        comentario.setDispositivo(dispositivo);
        comentario.setNombreAutor(request.getAuthor());
        comentario.setEmailAutor(request.getAuthorEmail());
        comentario.setCalificacion(request.getRating().shortValue());
        comentario.setContenido(request.getContent());

        return comentarioMapper.aDTO(comentarioDAO.save(comentario));
    }

    @Transactional
    public void eliminar(Long id) {
        if (!comentarioDAO.existsById(id)) {
            throw new ResourceNotFoundException("Comentario no encontrado: " + id);
        }
        comentarioDAO.deleteById(id);
    }
}
