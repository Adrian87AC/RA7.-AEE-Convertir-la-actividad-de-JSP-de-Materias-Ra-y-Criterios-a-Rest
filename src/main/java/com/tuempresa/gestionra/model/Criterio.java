package com.tuempresa.gestionra.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.math.BigDecimal;
import java.sql.Timestamp;

@Entity
@Table(name = "criterios_evaluacion")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Criterio {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 20)
    private String codigo;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String descripcion;

    @Column(precision = 5, scale = 2)
    private BigDecimal ponderacion = BigDecimal.ZERO;

    @Column(name = "fecha_creacion", insertable = false, updatable = false)
    private Timestamp fechaCreacion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "resultado_aprendizaje_id", nullable = false)
    @ToString.Exclude
    @JsonIgnore
    private Ra ra;
}
