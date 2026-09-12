package com.spechub.api.dto;

import jakarta.validation.constraints.NotBlank;

public class TipoDispositivoRequestDTO {

    @NotBlank(message = "El nombre del tipo es obligatorio")
    private String name;

    @NotBlank(message = "El slug del tipo es obligatorio")
    private String slug;

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getSlug() { return slug; }
    public void setSlug(String slug) { this.slug = slug; }
}
