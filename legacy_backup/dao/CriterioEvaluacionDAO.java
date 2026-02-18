package dao;

import model.CriterioEvaluacion;
import util.Database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object para la entidad Criterio de Evaluación
 * Implementa todas las operaciones CRUD
 */
public class CriterioEvaluacionDAO {
    
    /**
     * Lista todos los criterios de evaluación con información del resultado de aprendizaje
     * @return Lista de objetos CriterioEvaluacion
     */
    public List<CriterioEvaluacion> listarTodos() {
        List<CriterioEvaluacion> criterios = new ArrayList<>();
        String sql = "SELECT c.*, r.codigo as ra_codigo " +
                    "FROM criterios_evaluacion c " +
                    "INNER JOIN resultados_aprendizaje r ON c.resultado_aprendizaje_id = r.id " +
                    "ORDER BY c.codigo";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                CriterioEvaluacion criterio = new CriterioEvaluacion();
                criterio.setId(rs.getInt("id"));
                criterio.setCodigo(rs.getString("codigo"));
                criterio.setDescripcion(rs.getString("descripcion"));
                criterio.setResultadoAprendizajeId(rs.getInt("resultado_aprendizaje_id"));
                criterio.setResultadoAprendizajeCodigo(rs.getString("ra_codigo"));
                criterio.setPonderacion(rs.getBigDecimal("ponderacion"));
                criterio.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                criterios.add(criterio);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar criterios de evaluación: " + e.getMessage());
            e.printStackTrace();
        }
        
        return criterios;
    }
    
    /**
     * Lista los criterios de evaluación de un resultado de aprendizaje específico
     * @param resultadoAprendizajeId ID del resultado de aprendizaje
     * @return Lista de objetos CriterioEvaluacion
     */
    public List<CriterioEvaluacion> listarPorResultado(int resultadoAprendizajeId) {
        List<CriterioEvaluacion> criterios = new ArrayList<>();
        String sql = "SELECT * FROM criterios_evaluacion WHERE resultado_aprendizaje_id = ? ORDER BY codigo";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, resultadoAprendizajeId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CriterioEvaluacion criterio = new CriterioEvaluacion();
                    criterio.setId(rs.getInt("id"));
                    criterio.setCodigo(rs.getString("codigo"));
                    criterio.setDescripcion(rs.getString("descripcion"));
                    criterio.setResultadoAprendizajeId(rs.getInt("resultado_aprendizaje_id"));
                    criterio.setPonderacion(rs.getBigDecimal("ponderacion"));
                    criterio.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                    criterios.add(criterio);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al listar criterios por resultado: " + e.getMessage());
            e.printStackTrace();
        }
        
        return criterios;
    }
    
    /**
     * Obtiene un criterio de evaluación por su ID
     * @param id ID del criterio de evaluación
     * @return Objeto CriterioEvaluacion o null si no existe
     */
    public CriterioEvaluacion obtenerPorId(int id) {
        String sql = "SELECT c.*, r.codigo as ra_codigo " +
                    "FROM criterios_evaluacion c " +
                    "INNER JOIN resultados_aprendizaje r ON c.resultado_aprendizaje_id = r.id " +
                    "WHERE c.id = ?";
        CriterioEvaluacion criterio = null;
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    criterio = new CriterioEvaluacion();
                    criterio.setId(rs.getInt("id"));
                    criterio.setCodigo(rs.getString("codigo"));
                    criterio.setDescripcion(rs.getString("descripcion"));
                    criterio.setResultadoAprendizajeId(rs.getInt("resultado_aprendizaje_id"));
                    criterio.setResultadoAprendizajeCodigo(rs.getString("ra_codigo"));
                    criterio.setPonderacion(rs.getBigDecimal("ponderacion"));
                    criterio.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener criterio de evaluación: " + e.getMessage());
            e.printStackTrace();
        }
        
        return criterio;
    }
    
    /**
     * Inserta un nuevo criterio de evaluación
     * @param criterio Objeto CriterioEvaluacion a insertar
     * @return true si la inserción fue exitosa
     */
    public boolean insertar(CriterioEvaluacion criterio) {
        String sql = "INSERT INTO criterios_evaluacion (codigo, descripcion, resultado_aprendizaje_id, ponderacion) " +
                    "VALUES (?, ?, ?, ?)";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, criterio.getCodigo());
            ps.setString(2, criterio.getDescripcion());
            ps.setInt(3, criterio.getResultadoAprendizajeId());
            ps.setBigDecimal(4, criterio.getPonderacion());
            
            int filasAfectadas = ps.executeUpdate();
            
            if (filasAfectadas > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        criterio.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error al insertar criterio de evaluación: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Actualiza un criterio de evaluación existente
     * @param criterio Objeto CriterioEvaluacion con los datos actualizados
     * @return true si la actualización fue exitosa
     */
    public boolean actualizar(CriterioEvaluacion criterio) {
        String sql = "UPDATE criterios_evaluacion SET codigo = ?, descripcion = ?, " +
                    "resultado_aprendizaje_id = ?, ponderacion = ? WHERE id = ?";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, criterio.getCodigo());
            ps.setString(2, criterio.getDescripcion());
            ps.setInt(3, criterio.getResultadoAprendizajeId());
            ps.setBigDecimal(4, criterio.getPonderacion());
            ps.setInt(5, criterio.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar criterio de evaluación: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Elimina un criterio de evaluación por su ID
     * @param id ID del criterio de evaluación a eliminar
     * @return true si la eliminación fue exitosa
     */
    public boolean eliminar(int id) {
        String sql = "DELETE FROM criterios_evaluacion WHERE id = ?";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar criterio de evaluación: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}