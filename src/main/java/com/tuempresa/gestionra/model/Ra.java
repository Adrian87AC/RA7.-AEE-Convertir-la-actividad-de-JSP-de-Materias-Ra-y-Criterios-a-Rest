package com.tuempresa.gestionra.model;

import com.fasterxml.jackson.annotation.JsonIgnore;
import jakarta.persistence.*;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.ToString;

import java.sql.Timestamp;
import java.util.List;

@Entity
@Table(name = "resultados_aprendizaje")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Ra {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer id;

    @Column(nullable = false, length = 20)
    private String codigo;

    @Column(columnDefinition = "TEXT", nullable = false)
    private String descripcion;

    @Column(name = "fecha_creacion", insertable = false, updatable = false)
    private Timestamp fechaCreacion;

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "asignatura_id", nullable = false)
    @ToString.Exclude
    @JsonIgnore
    private Materia materia;

    @OneToMany(mappedBy = "ra", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Criterio> criterios;
}
