package com.spechub.api.dto;

/**
 * Forma de salida alineada con seedTypes en frontend/src/data/seedBrandsTypes.js
 * ({ id, name, slug }).
 */
public class TipoDispositivoDTO {
    private Long id;
    private String name;
    private String slug;

    public TipoDispositivoDTO() {
    }

    public TipoDispositivoDTO(Long id, String name, String slug) {
        this.id = id;
        this.name = name;
        this.slug = slug;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
}
