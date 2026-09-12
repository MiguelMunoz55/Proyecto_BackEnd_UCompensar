package com.spechub.api.dto;

/**
 * Forma de salida alineada con seedBrands en frontend/src/data/seedBrandsTypes.js
 * ({ id, name, country }).
 */
public class MarcaDTO {
    private Long id;
    private String name;
    private String country;

    public MarcaDTO() {
    }

    public MarcaDTO(Long id, String name, String country) {
        this.id = id;
        this.name = name;
        this.country = country;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getCountry() { return country; }
    public void setCountry(String country) { this.country = country; }
}
