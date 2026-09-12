package com.spechub.api.dto;

/**
 * Forma de salida alineada con seedComments en frontend/src/data/seedComments.js
 * ({ id, deviceId, author, rating, content, date }).
 */
public class ComentarioDTO {
    private Long id;
    private Long deviceId;
    private String author;
    private Integer rating;
    private String content;
    private String date;

    public ComentarioDTO() {
    }

    public ComentarioDTO(Long id, Long deviceId, String author, Integer rating, String content, String date) {
        this.id = id;
        this.deviceId = deviceId;
        this.author = author;
        this.rating = rating;
        this.content = content;
        this.date = date;
    }

    public Long getId() { return id; }
    public void setId(Long id) { this.id = id; }
    public Long getDeviceId() { return deviceId; }
    public void setDeviceId(Long deviceId) { this.deviceId = deviceId; }
    public String getAuthor() { return author; }
    public void setAuthor(String author) { this.author = author; }
    public Integer getRating() { return rating; }
    public void setRating(Integer rating) { this.rating = rating; }
    public String getContent() { return content; }
    public void setContent(String content) { this.content = content; }
    public String getDate() { return date; }
    public void setDate(String date) { this.date = date; }
}
