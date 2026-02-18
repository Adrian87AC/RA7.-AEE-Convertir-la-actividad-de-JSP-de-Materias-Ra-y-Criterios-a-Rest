package model;

import java.sql.Timestamp;

/**
 * Clase modelo para la entidad Resultado de Aprendizaje
 */
public class ResultadoAprendizaje {
    private int id;
    private String codigo;
    private String descripcion;
    private int asignaturaId;
    private String asignaturaNombre; // Para mostrar en las vistas
    private Timestamp fechaCreacion;

    // Constructor vacío
    public ResultadoAprendizaje() {
    }

    // Constructor con parámetros principales
    public ResultadoAprendizaje(String codigo, String descripcion, int asignaturaId) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.asignaturaId = asignaturaId;
    }

    // Constructor completo con ID
    public ResultadoAprendizaje(int id, String codigo, String descripcion, int asignaturaId) {
        this.id = id;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.asignaturaId = asignaturaId;
    }

    // Constructor con nombre de asignatura para vistas
    public ResultadoAprendizaje(int id, String codigo, String descripcion, int asignaturaId, String asignaturaNombre) {
        this.id = id;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.asignaturaId = asignaturaId;
        this.asignaturaNombre = asignaturaNombre;
    }

    // Getters y Setters
    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getCodigo() {
        return codigo;
    }

    public void setCodigo(String codigo) {
        this.codigo = codigo;
    }

    public String getDescripcion() {
        return descripcion;
    }

    public void setDescripcion(String descripcion) {
        this.descripcion = descripcion;
    }

    public int getAsignaturaId() {
        return asignaturaId;
    }

    public void setAsignaturaId(int asignaturaId) {
        this.asignaturaId = asignaturaId;
    }

    public String getAsignaturaNombre() {
        return asignaturaNombre;
    }

    public void setAsignaturaNombre(String asignaturaNombre) {
        this.asignaturaNombre = asignaturaNombre;
    }

    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }

    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }

    @Override
    public String toString() {
        return "ResultadoAprendizaje{" +
                "id=" + id +
                ", codigo='" + codigo + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", asignaturaId=" + asignaturaId +
                '}';
    }

    public ResultadoAprendizaje(int id, String codigo, String descripcion, int asignaturaId, String asignaturaNombre,
            Timestamp fechaCreacion) {
        this.id = id;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.asignaturaId = asignaturaId;
        this.asignaturaNombre = asignaturaNombre;
        this.fechaCreacion = fechaCreacion;
    }
}