package com.spechub.api.dto;

import java.math.BigDecimal;
import java.time.LocalDate;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

/**
 * Forma de salida pensada para calzar 1 a 1 con el objeto "enriquecido" que
 * hoy produce enrichDevice() en frontend/src/context/DataContext.jsx, para
 * minimizar cambios en los componentes de React.
 */
public class DispositivoDTO {
    private Long id;
    private String name;
    private Long brandId;
    private Long typeId;
    private String releaseDate;
    private BigDecimal price;
    private String shortDescription;
    private String review;
    private String imageTone;
    private String imageUrl;
    private Map<String, String> specs = new LinkedHashMap<>();

    private MarcaDTO brand;
    private TipoDispositivoDTO type;
    private List<ComentarioDTO> comments;
    private Double averageRating;
    private Integer commentCount;

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public Long getBrandId() { return brandId; }
    public void setBrandId(Long brandId) { this.brandId = brandId; }
    public Long getTypeId() { return typeId; }
    public void setTypeId(Long typeId) { this.typeId = typeId; }
    public String getReleaseDate() { return releaseDate; }
    public void setReleaseDate(String releaseDate) { this.releaseDate = releaseDate; }
    public BigDecimal getPrice() { return price; }
    public void setPrice(BigDecimal price) { this.price = price; }
    public String getShortDescription() { return shortDescription; }
    public void setShortDescription(String shortDescription) { this.shortDescription = shortDescription; }
    public String getReview() { return review; }
    public void setReview(String review) { this.review = review; }
    public String getImageTone() { return imageTone; }
    public void setImageTone(String imageTone) { this.imageTone = imageTone; }
    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }
    public Map<String, String> getSpecs() { return specs; }
    public void setSpecs(Map<String, String> specs) { this.specs = specs; }
    public MarcaDTO getBrand() { return brand; }
    public void setBrand(MarcaDTO brand) { this.brand = brand; }
    public TipoDispositivoDTO getType() { return type; }
    public void setType(TipoDispositivoDTO type) { this.type = type; }
    public List<ComentarioDTO> getComments() { return comments; }
    public void setComments(List<ComentarioDTO> comments) { this.comments = comments; }
    public Double getAverageRating() { return averageRating; }
    public void setAverageRating(Double averageRating) { this.averageRating = averageRating; }
    public Integer getCommentCount() { return commentCount; }
    public void setCommentCount(Integer commentCount) { this.commentCount = commentCount; }
}
