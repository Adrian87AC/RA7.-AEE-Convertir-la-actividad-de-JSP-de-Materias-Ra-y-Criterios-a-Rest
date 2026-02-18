package dao;

import model.ResultadoAprendizaje;
import util.Database;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Data Access Object para la entidad Resultado de Aprendizaje
 * Implementa todas las operaciones CRUD
 */
public class ResultadoAprendizajeDAO {

    /**
     * Lista todos los resultados de aprendizaje con información de la asignatura
     * 
     * @return Lista de objetos ResultadoAprendizaje
     */
    public List<ResultadoAprendizaje> listarTodos() {
        List<ResultadoAprendizaje> resultados = new ArrayList<>();
        String sql = "SELECT r.*, a.nombre as asignatura_nombre " +
                "FROM resultados_aprendizaje r " +
                "INNER JOIN asignaturas a ON r.asignatura_id = a.id " +
                "ORDER BY r.codigo";

        try (Connection con = Database.getConnection();
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                ResultadoAprendizaje ra = new ResultadoAprendizaje();
                ra.setId(rs.getInt("id"));
                ra.setCodigo(rs.getString("codigo"));
                ra.setDescripcion(rs.getString("descripcion"));
                ra.setAsignaturaId(rs.getInt("asignatura_id"));
                ra.setAsignaturaNombre(rs.getString("asignatura_nombre"));
                ra.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                resultados.add(ra);
            }
        } catch (SQLException e) {
            System.err.println("Error al listar resultados de aprendizaje: " + e.getMessage());
            e.printStackTrace();
        }

        return resultados;
    }

    /**
     * Lista los resultados de aprendizaje de una asignatura específica
     * 
     * @param asignaturaId ID de la asignatura
     * @return Lista de objetos ResultadoAprendizaje
     */
    public List<ResultadoAprendizaje> listarPorAsignatura(int asignaturaId) {
        List<ResultadoAprendizaje> resultados = new ArrayList<>();
        String sql = "SELECT r.*, a.nombre as asignatura_nombre " +
                "FROM resultados_aprendizaje r " +
                "INNER JOIN asignaturas a ON r.asignatura_id = a.id " +
                "WHERE r.asignatura_id = ? ORDER BY r.codigo";

        try (Connection con = Database.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, asignaturaId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ResultadoAprendizaje ra = new ResultadoAprendizaje();
                    ra.setId(rs.getInt("id"));
                    ra.setCodigo(rs.getString("codigo"));
                    ra.setDescripcion(rs.getString("descripcion"));
                    ra.setAsignaturaId(rs.getInt("asignatura_id"));
                    ra.setAsignaturaNombre(rs.getString("asignatura_nombre"));
                    ra.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                    resultados.add(ra);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al listar resultados por asignatura: " + e.getMessage());
            e.printStackTrace();
        }

        return resultados;
    }

    /**
     * Obtiene un resultado de aprendizaje por su ID
     * 
     * @param id ID del resultado de aprendizaje
     * @return Objeto ResultadoAprendizaje o null si no existe
     */
    public ResultadoAprendizaje obtenerPorId(int id) {
        String sql = "SELECT r.*, a.nombre as asignatura_nombre " +
                "FROM resultados_aprendizaje r " +
                "INNER JOIN asignaturas a ON r.asignatura_id = a.id " +
                "WHERE r.id = ?";
        ResultadoAprendizaje ra = null;

        try (Connection con = Database.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ra = new ResultadoAprendizaje();
                    ra.setId(rs.getInt("id"));
                    ra.setCodigo(rs.getString("codigo"));
                    ra.setDescripcion(rs.getString("descripcion"));
                    ra.setAsignaturaId(rs.getInt("asignatura_id"));
                    ra.setAsignaturaNombre(rs.getString("asignatura_nombre"));
                    ra.setFechaCreacion(rs.getTimestamp("fecha_creacion"));
                }
            }
        } catch (SQLException e) {
            System.err.println("Error al obtener resultado de aprendizaje: " + e.getMessage());
            e.printStackTrace();
        }

        return ra;
    }

    /**
     * Inserta un nuevo resultado de aprendizaje
     * 
     * @param ra Objeto ResultadoAprendizaje a insertar
     * @return true si la inserción fue exitosa
     */
    public boolean insertar(ResultadoAprendizaje ra) {
        String sql = "INSERT INTO resultados_aprendizaje (codigo, descripcion, asignatura_id) VALUES (?, ?, ?)";

        try (Connection con = Database.getConnection();
                PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, ra.getCodigo());
            ps.setString(2, ra.getDescripcion());
            ps.setInt(3, ra.getAsignaturaId());

            int filasAfectadas = ps.executeUpdate();

            if (filasAfectadas > 0) {
                try (ResultSet rs = ps.getGeneratedKeys()) {
                    if (rs.next()) {
                        ra.setId(rs.getInt(1));
                    }
                }
                return true;
            }
        } catch (SQLException e) {
            System.err.println("Error al insertar resultado de aprendizaje: " + e.getMessage());
            e.printStackTrace();
        }

        return false;
    }

    /**
     * Actualiza un resultado de aprendizaje existente
     * 
     * @param ra Objeto ResultadoAprendizaje con los datos actualizados
     * @return true si la actualización fue exitosa
     */
    public boolean actualizar(ResultadoAprendizaje ra) {
        String sql = "UPDATE resultados_aprendizaje SET codigo = ?, descripcion = ?, asignatura_id = ? WHERE id = ?";

        try (Connection con = Database.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, ra.getCodigo());
            ps.setString(2, ra.getDescripcion());
            ps.setInt(3, ra.getAsignaturaId());
            ps.setInt(4, ra.getId());

            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al actualizar resultado de aprendizaje: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Elimina un resultado de aprendizaje por su ID (con transacción para eliminar
     * criterios asociados)
     * 
     * @param id ID del resultado de aprendizaje a eliminar
     * @return true si la eliminación fue exitosa
     */
    public boolean eliminar(int id) {
        String sql = "DELETE FROM resultados_aprendizaje WHERE id = ?";

        try (Connection con = Database.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            System.err.println("Error al eliminar resultado de aprendizaje: " + e.getMessage());
            e.printStackTrace();
            return false;
        }
    }
}
