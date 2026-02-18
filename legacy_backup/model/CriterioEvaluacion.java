package model;

import java.math.BigDecimal;
import java.sql.Timestamp;

/**
 * Clase modelo para la entidad Criterio de Evaluación
 */
public class CriterioEvaluacion {
    private int id;
    private String codigo;
    private String descripcion;
    private int resultadoAprendizajeId;
    private String resultadoAprendizajeCodigo; // Para mostrar en las vistas
    private BigDecimal ponderacion;
    private Timestamp fechaCreacion;
    
    // Constructor vacío
    public CriterioEvaluacion() {
    }
    
    // Constructor con parámetros principales
    public CriterioEvaluacion(String codigo, String descripcion, int resultadoAprendizajeId, BigDecimal ponderacion) {
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.resultadoAprendizajeId = resultadoAprendizajeId;
        this.ponderacion = ponderacion;
    }
    
    // Constructor completo con ID
    public CriterioEvaluacion(int id, String codigo, String descripcion, int resultadoAprendizajeId, BigDecimal ponderacion) {
        this.id = id;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.resultadoAprendizajeId = resultadoAprendizajeId;
        this.ponderacion = ponderacion;
    }
    
    // Constructor con código de RA para vistas
    public CriterioEvaluacion(int id, String codigo, String descripcion, int resultadoAprendizajeId, 
                             String resultadoAprendizajeCodigo, BigDecimal ponderacion) {
        this.id = id;
        this.codigo = codigo;
        this.descripcion = descripcion;
        this.resultadoAprendizajeId = resultadoAprendizajeId;
        this.resultadoAprendizajeCodigo = resultadoAprendizajeCodigo;
        this.ponderacion = ponderacion;
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
    
    public int getResultadoAprendizajeId() {
        return resultadoAprendizajeId;
    }
    
    public void setResultadoAprendizajeId(int resultadoAprendizajeId) {
        this.resultadoAprendizajeId = resultadoAprendizajeId;
    }
    
    public String getResultadoAprendizajeCodigo() {
        return resultadoAprendizajeCodigo;
    }
    
    public void setResultadoAprendizajeCodigo(String resultadoAprendizajeCodigo) {
        this.resultadoAprendizajeCodigo = resultadoAprendizajeCodigo;
    }
    
    public BigDecimal getPonderacion() {
        return ponderacion;
    }
    
    public void setPonderacion(BigDecimal ponderacion) {
        this.ponderacion = ponderacion;
    }
    
    public Timestamp getFechaCreacion() {
        return fechaCreacion;
    }
    
    public void setFechaCreacion(Timestamp fechaCreacion) {
        this.fechaCreacion = fechaCreacion;
    }
    
    @Override
    public String toString() {
        return "CriterioEvaluacion{" +
                "id=" + id +
                ", codigo='" + codigo + '\'' +
                ", descripcion='" + descripcion + '\'' +
                ", resultadoAprendizajeId=" + resultadoAprendizajeId +
                ", ponderacion=" + ponderacion +
                '}';
    }
}