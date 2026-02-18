<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="dao.ResultadoAprendizajeDAO, dao.AsignaturaDAO, model.ResultadoAprendizaje, model.Asignatura, java.util.List"
        %>
        <% request.setCharacterEncoding("UTF-8"); ResultadoAprendizajeDAO dao=new ResultadoAprendizajeDAO();
            AsignaturaDAO asignaturaDAO=new AsignaturaDAO(); String mensaje="" ; String tipoMensaje="" ; String
            accion=request.getParameter("accion"); if (accion !=null) { if (accion.equals("insertar")) { String
            codigo=request.getParameter("codigo"); String descripcion=request.getParameter("descripcion"); String
            asignaturaIdStr=request.getParameter("asignatura_id"); if (codigo==null || codigo.trim().isEmpty() ||
            descripcion==null || descripcion.trim().isEmpty() || asignaturaIdStr==null ||
            asignaturaIdStr.trim().isEmpty()) { mensaje="Error: Todos los campos obligatorios deben estar completos." ;
            tipoMensaje="danger" ; } else { try { int asignaturaId=Integer.parseInt(asignaturaIdStr);
            ResultadoAprendizaje ra=new ResultadoAprendizaje(codigo.trim(), descripcion.trim(), asignaturaId); if
            (dao.insertar(ra)) { mensaje="Resultado de Aprendizaje '" + codigo.trim() + "' creado correctamente." ;
            tipoMensaje="success" ; } else { mensaje="Error al crear el resultado de aprendizaje." ;
            tipoMensaje="danger" ; } } catch (Exception e) { mensaje="Error: " + e.getMessage(); tipoMensaje="danger" ;
            } } } else if (accion.equals("actualizar")) { String idStr=request.getParameter("id"); String
            codigo=request.getParameter("codigo"); String descripcion=request.getParameter("descripcion"); String
            asignaturaIdStr=request.getParameter("asignatura_id"); if (codigo==null || codigo.trim().isEmpty() ||
            descripcion==null || descripcion.trim().isEmpty() || asignaturaIdStr==null ||
            asignaturaIdStr.trim().isEmpty()) { mensaje="Error: Todos los campos obligatorios deben estar completos." ;
            tipoMensaje="danger" ; } else { try { int id=Integer.parseInt(idStr); int
            asignaturaId=Integer.parseInt(asignaturaIdStr); ResultadoAprendizaje ra=new ResultadoAprendizaje(id,
            codigo.trim(), descripcion.trim(), asignaturaId); if (dao.actualizar(ra)) {
            mensaje="Resultado de Aprendizaje actualizado correctamente." ; tipoMensaje="success" ; } else {
            mensaje="Error al actualizar el resultado de aprendizaje." ; tipoMensaje="danger" ; } } catch (Exception e)
            { mensaje="Error: " + e.getMessage(); tipoMensaje="danger" ; } } } else if (accion.equals("eliminar")) {
            String idStr=request.getParameter("id"); if (idStr !=null) { int id=Integer.parseInt(idStr);
            java.sql.Connection conn=null; try { conn=util.Database.getConnection(); if (conn !=null) {
            conn.setAutoCommit(false); if (dao.eliminar(id)) { conn.commit();
            mensaje="Resultado de Aprendizaje eliminado correctamente." ; tipoMensaje="success" ; } else {
            conn.rollback(); mensaje="Error al eliminar el resultado de aprendizaje." ; tipoMensaje="danger" ; } } }
            catch (Exception e) { if (conn !=null) try { conn.rollback(); } catch (Exception ex) {}
            mensaje="Error al eliminar: " + e.getMessage(); tipoMensaje="danger" ; } finally { if (conn !=null) try {
            conn.setAutoCommit(true); conn.close(); } catch (Exception e) {} } } } } List<ResultadoAprendizaje>
            resultados = dao.listarTodos();
            List<Asignatura> asignaturas = asignaturaDAO.listarAsignaturas();
                %>
                <!DOCTYPE html>
                <html lang="es">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Resultados de Aprendizaje - Gestión Académica</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
                        rel="stylesheet">
                    <link href="css/styles.css" rel="stylesheet">
                </head>

                <body>
                    <nav class="navbar navbar-expand-lg navbar-custom">
                        <div class="container">
                            <a class="navbar-brand" href="index.jsp"><i class="bi bi-mortarboard-fill me-2"></i>Gestión
                                Académica</a>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                                    <li class="nav-item"><a class="nav-link" href="asignaturas.jsp">Asignaturas</a></li>
                                    <li class="nav-item"><a class="nav-link active" href="resultados.jsp">Resultados</a>
                                    </li>
                                    <li class="nav-item"><a class="nav-link" href="criterios.jsp">Criterios</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                    <div class="container mt-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2>Resultados de Aprendizaje</h2>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalRA"
                                onclick="limpiarFormulario()">Nuevo RA</button>
                        </div>
                        <% if (!mensaje.isEmpty()) { %>
                            <div class="alert alert-<%= tipoMensaje %> alert-dismissible fade show">
                                <%= mensaje %><button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>
                                <div class="card shadow">
                                    <div class="card-body">
                                        <table class="table table-hover">
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Código</th>
                                                    <th>Descripción</th>
                                                    <th>Asignatura</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (ResultadoAprendizaje ra : resultados) { String
                                                    descEscaped=(ra.getDescripcion() !=null) ?
                                                    ra.getDescripcion().replace("'", "\\'" ).replace("\n", " "
                                                    ).replace("\r", " " ) : "" ; String codEscaped=(ra.getCodigo()
                                                    !=null) ? ra.getCodigo().replace("'", "\\'" ) : "" ; %>
                                                    <tr>
                                                        <td>
                                                            <%= ra.getId() %>
                                                        </td>
                                                        <td><span class="badge bg-success">
                                                                <%= ra.getCodigo() %>
                                                            </span></td>
                                                        <td>
                                                            <%= ra.getDescripcion() %>
                                                        </td>
                                                        <td>
                                                            <%= ra.getAsignaturaNombre() %>
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary"
                                                                onclick="editarRA(<%= ra.getId() %>, '<%= codEscaped %>', '<%= descEscaped %>', <%= ra.getAsignaturaId() %>)">Editar</button>
                                                            <button class="btn btn-sm btn-outline-danger"
                                                                onclick="confirmarEliminar(<%= ra.getId() %>, '<%= codEscaped %>')">Eliminar</button>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                    </div>
                    <div class="modal fade" id="modalRA" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalLabel">Nuevo RA</h5><button type="button"
                                        class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form id="formRA" action="resultados.jsp" method="post" class="needs-validation"
                                    novalidate>
                                    <div class="modal-body">
                                        <input type="hidden" name="accion" id="accionForm" value="insertar"><input
                                            type="hidden" name="id" id="idForm">
                                        <div class="mb-3"><label class="form-label">Código</label><input type="text"
                                                class="form-control" name="codigo" id="codigo" required></div>
                                        <div class="mb-3"><label class="form-label">Descripción</label><textarea
                                                class="form-control" name="descripcion" id="descripcion"
                                                required></textarea></div>
                                        <div class="mb-3"><label class="form-label">Asignatura</label>
                                            <select class="form-select" name="asignatura_id" id="asignatura_id"
                                                required>
                                                <option value="">-- Seleccionar --</option>
                                                <% for (Asignatura a : asignaturas) { %>
                                                    <option value="<%= a.getId() %>">
                                                        <%= a.getNombre() %>
                                                    </option>
                                                    <% } %>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="modal-footer"><button type="submit"
                                            class="btn btn-primary">Guardar</button></div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="modalEliminar" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title">Confirmar Eliminación</h5><button type="button"
                                        class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">¿Seguro que quieres eliminar el RA <strong
                                        id="codigoEliminar"></strong>?</div>
                                <div class="modal-footer"><button type="button" class="btn btn-secondary"
                                        data-bs-dismiss="modal">Cancelar</button><a id="btnConfirmarEliminar" href="#"
                                        class="btn btn-danger">Eliminar</a></div>
                            </div>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        (function () { 'use strict'; var forms = document.querySelectorAll('.needs-validation'); Array.prototype.slice.call(forms).forEach(function (form) { form.addEventListener('submit', function (event) { if (!form.checkValidity()) { event.preventDefault(); event.stopPropagation(); } form.classList.add('was-validated'); }, false); }); })();
                        function limpiarFormulario() { document.getElementById('modalLabel').innerText = 'Nuevo RA'; document.getElementById('accionForm').value = 'insertar'; document.getElementById('idForm').value = ''; document.getElementById('codigo').value = ''; document.getElementById('descripcion').value = ''; document.getElementById('asignatura_id').value = ''; document.getElementById('formRA').classList.remove('was-validated'); }
                        function editarRA(id, cod, desc, asigId) { document.getElementById('modalLabel').innerText = 'Editar RA'; document.getElementById('accionForm').value = 'actualizar'; document.getElementById('idForm').value = id; document.getElementById('codigo').value = cod; document.getElementById('descripcion').value = desc; document.getElementById('asignatura_id').value = asigId; document.getElementById('formRA').classList.remove('was-validated'); new bootstrap.Modal(document.getElementById('modalRA')).show(); }
                        function confirmarEliminar(id, cod) { document.getElementById('codigoEliminar').innerText = cod; document.getElementById('btnConfirmarEliminar').href = 'resultados.jsp?accion=eliminar&id=' + id; new bootstrap.Modal(document.getElementById('modalEliminar')).show(); }
                    </script>
                </body>

                </html>