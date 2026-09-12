package com.spechub.api.model;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.FetchType;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;

@Entity
@Table(name = "imagen_dispositivo")
public class ImagenDispositivo {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "dispositivo_id", nullable = false)
    private Dispositivo dispositivo;

    @Column(name = "url_imagen", nullable = false, length = 300)
    private String urlImagen;

    @Column(name = "texto_alternativo", length = 150)
    private String textoAlternativo;

    @Column(name = "orden", nullable = false)
    private Integer orden = 0;

    public ImagenDispositivo() {
    }

    public ImagenDispositivo(Dispositivo dispositivo, String urlImagen, String textoAlternativo, Integer orden) {
        this.dispositivo = dispositivo;
        this.urlImagen = urlImagen;
        this.textoAlternativo = textoAlternativo;
        this.orden = orden;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Dispositivo getDispositivo() { return dispositivo; }
    public void setDispositivo(Dispositivo dispositivo) { this.dispositivo = dispositivo; }
    public String getUrlImagen() { return urlImagen; }
    public void setUrlImagen(String urlImagen) { this.urlImagen = urlImagen; }
    public String getTextoAlternativo() { return textoAlternativo; }
    public void setTextoAlternativo(String textoAlternativo) { this.textoAlternativo = textoAlternativo; }
    public Integer getOrden() { return orden; }
    public void setOrden(Integer orden) { this.orden = orden; }
}
