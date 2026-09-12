package com.spechub.api.mapper;

import com.spechub.api.dto.MarcaDTO;
import com.spechub.api.dto.TipoDispositivoDTO;
import com.spechub.api.model.Marca;
import com.spechub.api.model.TipoDispositivo;
import org.springframework.stereotype.Component;

@Component
public class CatalogoMapper {

    public MarcaDTO aMarcaDTO(Marca marca) {
        if (marca == null) return null;
        return new MarcaDTO(marca.getId(), marca.getNombre(), marca.getPais());
    }

    public TipoDispositivoDTO aTipoDTO(TipoDispositivo tipo) {
        if (tipo == null) return null;
        return new TipoDispositivoDTO(tipo.getId(), tipo.getNombre(), tipo.getSlug());
    }
}
