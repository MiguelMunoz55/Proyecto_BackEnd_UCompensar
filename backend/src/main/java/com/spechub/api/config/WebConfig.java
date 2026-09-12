package com.spechub.api.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

import java.nio.file.Path;
import java.nio.file.Paths;

/**
 * Expone la carpeta donde se guardan las imágenes de dispositivos
 * (spechub.uploads.dir) como recursos estáticos bajo /uploads/**, para que
 * el frontend pueda mostrarlas directamente con un <img src="...">.
 */
@Configuration
public class WebConfig implements WebMvcConfigurer {

    private final String directorioUploads;

    public WebConfig(@Value("${spechub.uploads.dir:uploads}") String directorioUploads) {
        this.directorioUploads = directorioUploads;
    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        Path base = Paths.get(directorioUploads).toAbsolutePath().normalize();
        registry.addResourceHandler("/uploads/**")
                .addResourceLocations("file:" + base + "/");
    }
}
