package com.spechub.api.dto;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.PositiveOrZero;
import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.Map;

public class DispositivoRequestDTO {

    @NotBlank(message = "El nombre del dispositivo es obligatorio")
    private String name;

    @NotNull(message = "La marca es obligatoria")
    private Long brandId;

    @NotNull(message = "El tipo de dispositivo es obligatorio")
    private Long typeId;

    @NotNull(message = "La fecha de lanzamiento es obligatoria")
    private LocalDate releaseDate;

    @NotNull(message = "El precio es obligatorio")
    @PositiveOrZero(message = "El precio no puede ser negativo")
    private BigDecimal price;

    private String shortDescription;
    private String review;
    private String imageTone;

    private Map<String, String> specs = new LinkedHashMap<>();

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Long getBrandId() { return brandId; }
    public void setBrandId(Long brandId) { this.brandId = brandId; }
    public Long getTypeId() { return typeId; }
    public void setTypeId(Long typeId) { this.typeId = typeId; }
    public LocalDate getReleaseDate() { return releaseDate; }
    public void setReleaseDate(LocalDate releaseDate) { this.releaseDate = releaseDate; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }
    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }
    public String getImageTone() { return imageTone; }
    public void setImageTone(String imageTone) { this.imageTone = imageTone; }
    public Map<String, String> getSpecs() { return specs; }
    public void setSpecs(Map<String, String> specs) { this.specs = specs; }
}
