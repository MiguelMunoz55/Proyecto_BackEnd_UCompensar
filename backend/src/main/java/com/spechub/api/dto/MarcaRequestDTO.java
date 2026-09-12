package com.spechub.api.dto;

import jakarta.validation.constraints.NotBlank;

public class MarcaRequestDTO {

    @NotBlank(message = "El nombre de la marca es obligatorio")
    private String name;

    private String country;

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
}
