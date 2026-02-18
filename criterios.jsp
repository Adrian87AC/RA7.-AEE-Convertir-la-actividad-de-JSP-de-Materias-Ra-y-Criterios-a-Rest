<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page
        import="dao.CriterioEvaluacionDAO, dao.ResultadoAprendizajeDAO, model.CriterioEvaluacion, model.ResultadoAprendizaje, java.util.List, java.math.BigDecimal"
        %>
        <% request.setCharacterEncoding("UTF-8"); CriterioEvaluacionDAO dao=new CriterioEvaluacionDAO();
            ResultadoAprendizajeDAO raDAO=new ResultadoAprendizajeDAO(); String mensaje="" ; String tipoMensaje="" ;
            String accion=request.getParameter("accion"); if (accion !=null) { try { if (accion.equals("insertar")) {
            String codigo=request.getParameter("codigo"); String descripcion=request.getParameter("descripcion"); String
            raIdStr=request.getParameter("resultado_aprendizaje_id"); String
            ponderacionStr=request.getParameter("ponderacion"); if (codigo==null || codigo.trim().isEmpty() ||
            descripcion==null || raIdStr==null) { mensaje="Error: Faltan campos obligatorios." ; tipoMensaje="danger" ;
            } else { int raId=Integer.parseInt(raIdStr); BigDecimal pond=new BigDecimal(ponderacionStr !=null &&
            !ponderacionStr.trim().isEmpty() ? ponderacionStr : "0" ); CriterioEvaluacion c=new
            CriterioEvaluacion(codigo.trim(), descripcion.trim(), raId, pond); if (dao.insertar(c)) {
            mensaje="Criterio creado correctamente." ; tipoMensaje="success" ; } else {
            mensaje="Error al crear el criterio." ; tipoMensaje="danger" ; } } } else if (accion.equals("actualizar")) {
            String idStr=request.getParameter("id"); String codigo=request.getParameter("codigo"); String
            descripcion=request.getParameter("descripcion"); String
            raIdStr=request.getParameter("resultado_aprendizaje_id"); String
            ponderacionStr=request.getParameter("ponderacion"); if (idStr !=null && codigo !=null &&
            !codigo.trim().isEmpty()) { int id=Integer.parseInt(idStr); int raId=Integer.parseInt(raIdStr); BigDecimal
            pond=new BigDecimal(ponderacionStr !=null && !ponderacionStr.trim().isEmpty() ? ponderacionStr : "0" );
            CriterioEvaluacion c=new CriterioEvaluacion(id, codigo.trim(), descripcion.trim(), raId, pond); if
            (dao.actualizar(c)) { mensaje="Criterio actualizado correctamente." ; tipoMensaje="success" ; } else {
            mensaje="Error al actualizar el criterio." ; tipoMensaje="danger" ; } } } else if
            (accion.equals("eliminar")) { String idStr=request.getParameter("id"); if (idStr !=null) { int
            id=Integer.parseInt(idStr); if (dao.eliminar(id)) { mensaje="Criterio eliminado correctamente." ;
            tipoMensaje="success" ; } else { mensaje="Error al eliminar el criterio." ; tipoMensaje="danger" ; } } } }
            catch (Exception e) { mensaje="Error: " + e.getMessage(); tipoMensaje="danger" ; } }
            List<CriterioEvaluacion> criterios = dao.listarTodos();
            List<ResultadoAprendizaje> resultados = raDAO.listarTodos();
                %>
                <!DOCTYPE html>
                <html lang="es">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Criterios de Evaluación - Gestión Académica</title>
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css"
                        rel="stylesheet">
                    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
                        rel="stylesheet">
                    <link href="css/styles.css" rel="stylesheet">
                </head>

                <body>
                    <nav class="navbar navbar-expand-lg navbar-custom">
                        <div class="container">
                            <a class="navbar-brand" href="index.jsp">Gestión Académica</a>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item"><a class="nav-link" href="index.jsp">Inicio</a></li>
                                    <li class="nav-item"><a class="nav-link" href="asignaturas.jsp">Asignaturas</a></li>
                                    <li class="nav-item"><a class="nav-link" href="resultados.jsp">Resultados</a></li>
                                    <li class="nav-item"><a class="nav-link active" href="criterios.jsp">Criterios</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                    <div class="container mt-4">
                        <div class="d-flex justify-content-between align-items-center mb-4">
                            <h2>Criterios de Evaluación</h2>
                            <button class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#modalCriterio"
                                onclick="limpiarFormulario()">Nuevo Criterio</button>
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
                                                    <th>RA</th>
                                                    <th>Pond.</th>
                                                    <th>Acciones</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (CriterioEvaluacion c : criterios) { String
                                                    descEsc=(c.getDescripcion() !=null) ?
                                                    c.getDescripcion().replace("'", "\\'" ).replace("\n", " "
                                                    ).replace("\r", " " ) : "" ; String codEsc=(c.getCodigo() !=null) ?
                                                    c.getCodigo().replace("'", "\\'" ) : "" ; %>
                                                    <tr>
                                                        <td>
                                                            <%= c.getId() %>
                                                        </td>
                                                        <td><span class="badge bg-warning text-dark">
                                                                <%= c.getCodigo() %>
                                                            </span></td>
                                                        <td>
                                                            <%= c.getDescripcion() %>
                                                        </td>
                                                        <td>
                                                            <%= c.getResultadoAprendizajeCodigo() %>
                                                        </td>
                                                        <td>
                                                            <%= c.getPonderacion() %>%
                                                        </td>
                                                        <td>
                                                            <button class="btn btn-sm btn-outline-primary"
                                                                onclick="editarCriterio(<%= c.getId() %>, '<%= codEsc %>', '<%= descEsc %>', <%= c.getResultadoAprendizajeId() %>, '<%= c.getPonderacion() %>')">Editar</button>
                                                            <button class="btn btn-sm btn-outline-danger"
                                                                onclick="confirmarEliminar(<%= c.getId() %>, '<%= codEsc %>')">Eliminar</button>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                    </div>
                    <div class="modal fade" id="modalCriterio" tabindex="-1">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <form id="formCriterio" action="criterios.jsp" method="post" class="needs-validation"
                                    novalidate>
                                    <div class="modal-header">
                                        <h5 class="modal-title" id="modalLabel">Nuevo Criterio</h5><button type="button"
                                            class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <input type="hidden" name="accion" id="accionForm" value="insertar"><input
                                            type="hidden" name="id" id="idForm">
                                        <div class="mb-3"><label class="form-label">Código</label><input type="text"
                                                class="form-control" name="codigo" id="codigo" required></div>
                                        <div class="mb-3"><label class="form-label">Descripción</label><textarea
                                                class="form-control" name="descripcion" id="descripcion"
                                                required></textarea></div>
                                        <div class="mb-3"><label class="form-label">RA Asociado</label>
                                            <select class="form-select" name="resultado_aprendizaje_id"
                                                id="resultado_aprendizaje_id" required>
                                                <option value="">-- Seleccionar --</option>
                                                <% for (ResultadoAprendizaje ra : resultados) { String
                                                    raDesc=(ra.getDescripcion() !=null) ? (ra.getDescripcion().length()>
                                                    40 ? ra.getDescripcion().substring(0, 40) + "..." :
                                                    ra.getDescripcion()) : "";
                                                    %><option value="<%= ra.getId() %>">
                                                        <%= ra.getCodigo() %> - <%= raDesc %>
                                                    </option>
                                                    <% } %>
                                            </select>
                                        </div>
                                        <div class="mb-3"><label class="form-label">Ponderación (%)</label><input
                                                type="number" step="0.01" class="form-control" name="ponderacion"
                                                id="ponderacion" required></div>
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
                                <div class="modal-body">¿Seguro que quieres eliminar el criterio <strong
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
                        function limpiarFormulario() { document.getElementById('modalLabel').innerText = 'Nuevo Criterio'; document.getElementById('accionForm').value = 'insertar'; document.getElementById('idForm').value = ''; document.getElementById('codigo').value = ''; document.getElementById('descripcion').value = ''; document.getElementById('resultado_aprendizaje_id').value = ''; document.getElementById('ponderacion').value = '0'; document.getElementById('formCriterio').classList.remove('was-validated'); }
                        function editarCriterio(id, cod, desc, raId, pond) { document.getElementById('modalLabel').innerText = 'Editar Criterio'; document.getElementById('accionForm').value = 'actualizar'; document.getElementById('idForm').value = id; document.getElementById('codigo').value = cod; document.getElementById('descripcion').value = desc; document.getElementById('resultado_aprendizaje_id').value = raId; document.getElementById('ponderacion').value = pond; document.getElementById('formCriterio').classList.remove('was-validated'); new bootstrap.Modal(document.getElementById('modalCriterio')).show(); }
                        function confirmarEliminar(id, cod) { document.getElementById('codigoEliminar').innerText = cod; document.getElementById('btnConfirmarEliminar').href = 'criterios.jsp?accion=eliminar&id=' + id; new bootstrap.Modal(document.getElementById('modalEliminar')).show(); }
                    </script>
                </body>

                </html>