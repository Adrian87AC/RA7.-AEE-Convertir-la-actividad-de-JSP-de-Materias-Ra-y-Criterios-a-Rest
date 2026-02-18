package dao;

import model.Asignatura;
import util.Database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object para la entidad Asignatura
 * Implementa todas las operaciones CRUD
 */
public class AsignaturaDAO {
    
    /**
     * Lista todas las asignaturas
     * @return Lista de objetos Asignatura
     */
    public List<Asignatura> listarAsignaturas() {
        List<Asignatura> asignaturas = new ArrayList<>();
        String sql = "SELECT * FROM asignaturas ORDER BY nombre";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            
            while (rs.next()) {
                Asignatura asignatura = new Asignatura();
                asignatura.setId(rs.getInt("id"));
                asignatura.setNombre(rs.getString("nombre"));
                asignatura.setCodigo(rs.getString("codigo"));
                asignatura.setDescripcion(rs.getString("descripcion"));
                asignatura.setCreditos(rs.getInt("creditos"));
                asignatura.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                asignaturas.add(asignatura);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar asignaturas: " + e.getMessage());
            e.printStackTrace();
        }
        
        return asignaturas;
    }
    
    /**
     * Obtiene una asignatura por su ID
     * @param id ID de la asignatura
     * @return Objeto Asignatura o null si no existe
     */
    public Asignatura obtenerPorId(int id) {
        String sql = "SELECT * FROM asignaturas WHERE id = ?";
        Asignatura asignatura = null;
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    asignatura = new Asignatura();
                    asignatura.setId(rs.getInt("id"));
                    asignatura.setNombre(rs.getString("nombre"));
                    asignatura.setCodigo(rs.getString("codigo"));
                    asignatura.setDescripcion(rs.getString("descripcion"));
                    asignatura.setCreditos(rs.getInt("creditos"));
                    asignatura.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener asignatura: " + e.getMessage());
            e.printStackTrace();
        }
        
        return asignatura;
    }
    
    /**
     * Inserta una nueva asignatura
     * @param asignatura Objeto Asignatura a insertar
     * @return true si la inserción fue exitosa
     */
    public boolean insertar(Asignatura asignatura) {
        String sql = "INSERT INTO asignaturas (nombre, codigo, descripcion, creditos) VALUES (?, ?, ?, ?)";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            ps.setString(1, asignatura.getNombre());
            ps.setString(2, asignatura.getCodigo());
            ps.setString(3, asignatura.getDescripcion());
            ps.setInt(4, asignatura.getCreditos());
            
            int filasAfectadas = ps.executeUpdate();
            
            if (filasAfectadas > 0) {
                // Obtener el ID generado
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        asignatura.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error al insertar asignatura: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
    
    /**
     * Actualiza una asignatura existente
     * @param asignatura Objeto Asignatura con los datos actualizados
     * @return true si la actualización fue exitosa
     */
    public boolean actualizar(Asignatura asignatura) {
        String sql = "UPDATE asignaturas SET nombre = ?, codigo = ?, descripcion = ?, creditos = ? WHERE id = ?";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, asignatura.getNombre());
            ps.setString(2, asignatura.getCodigo());
            ps.setString(3, asignatura.getDescripcion());
            ps.setInt(4, asignatura.getCreditos());
            ps.setInt(5, asignatura.getId());
            
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar asignatura: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Elimina una asignatura por su ID
     * @param id ID de la asignatura a eliminar
     * @return true si la eliminación fue exitosa
     */
    public boolean eliminar(int id) {
        String sql = "DELETE FROM asignaturas WHERE id = ?";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar asignatura: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
    
    /**
     * Verifica si existe una asignatura con el código especificado
     * @param codigo Código a verificar
     * @param idExcluir ID a excluir de la búsqueda (para edición)
     * @return true si existe
     */
    public boolean existeCodigo(String codigo, int idExcluir) {
        String sql = "SELECT COUNT(*) FROM asignaturas WHERE codigo = ? AND id != ?";
        
        try (Connection con = Database.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            
            ps.setString(1, codigo);
            ps.setInt(2, idExcluir);
            
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al verificar código: " + e.getMessage());
            e.printStackTrace();
        }
        
        return false;
    }
}