package com.spechub.api.dao;

import com.spechub.api.model.Dispositivo;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import java.math.BigDecimal;
import java.util.List;

public interface DispositivoDAO extends JpaRepository<Dispositivo, Long> {

    List<Dispositivo> findByTipo_Slug(String slug);

    List<Dispositivo> findByMarca_Id(Long marcaId);

    List<Dispositivo> findByTipo_Id(Long tipoId);

    List<Dispositivo> findByPrecioLessThanEqual(BigDecimal precioMaximo);

    List<Dispositivo> findByNombreContainingIgnoreCase(String texto);

    // Filtro combinado equivalente a GET /api/devices?type=&brandId=&maxPrice=&q=
    @Query("""
            SELECT d FROM Dispositivo d
            WHERE (:slugTipo IS NULL OR d.tipo.slug = :slugTipo)
              AND (:marcaId IS NULL OR d.marca.id = :marcaId)
              AND (:precioMaximo IS NULL OR d.precio <= :precioMaximo)
              AND (:texto IS NULL OR LOWER(d.nombre) LIKE LOWER(CONCAT('%', :texto, '%')))
            """)
    List<Dispositivo> buscar(
            @Param("slugTipo") String slugTipo,
            @Param("marcaId") Long marcaId,
            @Param("precioMaximo") BigDecimal precioMaximo,
            @Param("texto") String texto
    );
}
