<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="dao.AsignaturaDAO, model.Asignatura, java.util.List" %>
        <% request.setCharacterEncoding("UTF-8"); AsignaturaDAO dao=new AsignaturaDAO(); String mensaje="" ; String
            tipoMensaje="" ; String accion=request.getParameter("accion"); if (accion !=null) { if
            (accion.equals("insertar")) { String nombre=request.getParameter("nombre"); String
            codigo=request.getParameter("codigo"); String descripcion=request.getParameter("descripcion"); String
            creditosStr=request.getParameter("creditos"); if (nombre==null || nombre.trim().isEmpty() || codigo==null ||
            codigo.trim().isEmpty()) { mensaje="Error: El nombre y el código son obligatorios." ; tipoMensaje="danger" ;
            } else if (dao.existeCodigo(codigo.trim(), 0)) { mensaje="Error: Ya existe una asignatura con el código '" +
            codigo.trim() + "'." ; tipoMensaje="danger" ; } else { int creditos=0; try {
            creditos=Integer.parseInt(creditosStr); } catch (Exception e) {} Asignatura asignatura=new
            Asignatura(nombre.trim(), codigo.trim(), descripcion !=null ? descripcion.trim() : "" , creditos); if
            (dao.insertar(asignatura)) { mensaje="Asignatura '" + nombre.trim() + "' creada correctamente." ;
            tipoMensaje="success" ; } else { mensaje="Error al crear la asignatura." ; tipoMensaje="danger" ; } } } else
            if (accion.equals("actualizar")) { String idStr=request.getParameter("id"); String
            nombre=request.getParameter("nombre"); String codigo=request.getParameter("codigo"); String
            descripcion=request.getParameter("descripcion"); String creditosStr=request.getParameter("creditos"); if
            (nombre==null || nombre.trim().isEmpty() || codigo==null || codigo.trim().isEmpty()) {
            mensaje="Error: El nombre y el código son obligatorios." ; tipoMensaje="danger" ; } else { int
            id=Integer.parseInt(idStr); if (dao.existeCodigo(codigo.trim(), id)) {
            mensaje="Error: Ya existe otra asignatura con el código '" + codigo.trim() + "'." ; tipoMensaje="danger" ; }
            else { int creditos=0; try { creditos=Integer.parseInt(creditosStr); } catch (Exception e) {} Asignatura
            asignatura=new Asignatura(id, nombre.trim(), codigo.trim(), descripcion !=null ? descripcion.trim() : "" ,
            creditos); if (dao.actualizar(asignatura)) { mensaje="Asignatura actualizada correctamente." ;
            tipoMensaje="success" ; } else { mensaje="Error al actualizar la asignatura." ; tipoMensaje="danger" ; } } }
            } else if (accion.equals("carga_masiva")) { String datos=request.getParameter("datos"); if (datos !=null &&
            !datos.trim().isEmpty()) { String[] lineas=datos.split("\n"); int exitos=0; int errores=0; for (String linea
            : lineas) { try { if (linea.trim().isEmpty()) continue; String[] campos=linea.split(";"); if (campos.length>
            = 2) {
            String cod = campos[0].trim();
            String nom = campos[1].trim();
            int cred = (campos.length >= 3) ? Integer.parseInt(campos[2].trim()) : 0;
            String desc = (campos.length >= 4) ? campos[3].trim() : "";
            if (!dao.existeCodigo(cod, 0)) {
            if (dao.insertar(new Asignatura(nom, cod, desc, cred))) exitos++;
            else errores++;
            } else { errores++; }
            }
            } catch (Exception e) { errores++; }
            }
            mensaje = "Carga masiva finalizada: " + exitos + " creadas, " + errores + " fallidas.";
            tipoMensaje = (exitos > 0) ? "success" : "warning";
            }
            } else if (accion.equals("eliminar")) { String idStr=request.getParameter("id"); int
            id=Integer.parseInt(idStr); java.sql.Connection conn=null; try { conn=util.Database.getConnection();
            conn.setAutoCommit(false); if (dao.eliminar(id)) { conn.commit();
            mensaje="Asignatura y sus datos asociados eliminados correctamente." ; tipoMensaje="success" ; } else {
            conn.rollback(); mensaje="Error al eliminar la asignatura." ; tipoMensaje="danger" ; } } catch (Exception e)
            { if (conn !=null) try { conn.rollback(); } catch (Exception ex) {} mensaje="Error al eliminar: " +
            e.getMessage(); tipoMensaje="danger" ; } finally { if (conn !=null) try { conn.setAutoCommit(true);
            conn.close(); } catch (Exception e) {} } } } List<Asignatura> asignaturas = dao.listarAsignaturas();
                %>
                <!DOCTYPE html>
                <html lang="es">

                <head>
                    <meta charset="UTF-8">
                    <meta name="viewport" content="width=device-width, initial-scale=1.0">
                    <title>Asignaturas - Gestión Académica</title>
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
                            <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                                data-bs-target="#navbarNav"><span class="navbar-toggler-icon"></span></button>
                            <div class="collapse navbar-collapse" id="navbarNav">
                                <ul class="navbar-nav ms-auto">
                                    <li class="nav-item"><a class="nav-link" href="index.jsp"><i
                                                class="bi bi-house-door me-1"></i>Inicio</a></li>
                                    <li class="nav-item"><a class="nav-link active" href="asignaturas.jsp"><i
                                                class="bi bi-book me-1"></i>Asignaturas</a></li>
                                    <li class="nav-item"><a class="nav-link" href="resultados.jsp"><i
                                                class="bi bi-clipboard-check me-1"></i>Resultados</a></li>
                                    <li class="nav-item"><a class="nav-link" href="criterios.jsp"><i
                                                class="bi bi-list-check me-1"></i>Criterios</a></li>
                                </ul>
                            </div>
                        </div>
                    </nav>
                    <div class="container">
                        <div class="page-header d-flex justify-content-between align-items-center">
                            <h2><i class="bi bi-book me-2"></i>Gestión de Asignaturas</h2>
                            <div class="d-flex gap-2">
                                <button class="btn btn-outline-primary rounded-pill px-3" data-bs-toggle="modal"
                                    data-bs-target="#modalCargaMasiva">
                                    <i class="bi bi-file-earmark-arrow-up me-1"></i>Carga Masiva
                                </button>
                                <button class="btn btn-add" data-bs-toggle="modal" data-bs-target="#modalAsignatura"
                                    onclick="limpiarFormulario()"><i class="bi bi-plus-circle me-1"></i>Nueva
                                    Asignatura</button>
                            </div>
                        </div>
                        <% if (!mensaje.isEmpty()) { %>
                            <div class="alert alert-<%= tipoMensaje %> alert-custom alert-dismissible fade show fade-in-up"
                                role="alert">
                                <i class="bi bi-<%= tipoMensaje.equals(" success") ? "check-circle"
                                    : "exclamation-triangle" %> me-2"></i>
                                <%= mensaje %>
                                    <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
                            </div>
                            <% } %>
                                <div class="table-container fade-in-up">
                                    <% if (asignaturas.isEmpty()) { %>
                                        <div class="text-center py-5"><i class="bi bi-inbox text-muted"
                                                style="font-size: 3rem;"></i>
                                            <p class="text-muted mt-3">No hay asignaturas registradas.</p><button
                                                class="btn btn-add" data-bs-toggle="modal"
                                                data-bs-target="#modalAsignatura" onclick="limpiarFormulario()"><i
                                                    class="bi bi-plus-circle me-1"></i>Crear
                                                primera asignatura</button>
                                        </div>
                                        <% } else { %>
                                            <div class="table-responsive">
                                                <table class="table table-hover">
                                                    <thead>
                                                        <tr>
                                                            <th>ID</th>
                                                            <th>Código</th>
                                                            <th>Nombre</th>
                                                            <th>Descripción</th>
                                                            <th>Créditos</th>
                                                            <th>Acciones</th>
                                                        </tr>
                                                    </thead>
                                                    <tbody>
                                                        <% for (Asignatura a : asignaturas) { %>
                                                            <tr>
                                                                <td><strong>#<%= a.getId() %></strong></td>
                                                                <td><span class="badge bg-primary badge-relation">
                                                                        <%= a.getCodigo() %>
                                                                    </span></td>
                                                                <td>
                                                                    <%= a.getNombre() %>
                                                                </td>
                                                                <td>
                                                                    <%= a.getDescripcion() !=null ? a.getDescripcion()
                                                                        : "-" %>
                                                                </td>
                                                                <td>
                                                                    <%= a.getCreditos() %>
                                                                </td>
                                                                <td class="text-center">
                                                                    <button class="btn btn-action btn-edit me-1"
                                                                        onclick="editarAsignatura(<%= a.getId() %>, '<%= a.getNombre().replace("'", "\\'") %>', '<%= a.getCodigo().replace("'", "\\'") %>', '<%= a.getDescripcion() != null ? a.getDescripcion().replace("'", "\\'") : "" %>', <%= a.getCreditos() %>)"
                                                                        title="Editar"><i class="bi bi-pencil"></i>
                                                                        Editar</button>
                                                                    <button class="btn btn-action btn-delete"
                                                                        onclick="confirmarEliminar(<%= a.getId() %>, '<%= a.getNombre().replace("'", "\\'") %>')"
                                                                        title="Eliminar"><i class="bi bi-trash"></i>
                                                                        Eliminar</button>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </tbody>
                                                </table>
                                            </div>
                                            <% } %>
                                </div>
                    </div>
                    <div class="modal fade" id="modalCargaMasiva" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog modal-lg">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title"><i class="bi bi-file-earmark-arrow-up me-2"></i>Carga Masiva
                                        de
                                        Asignaturas</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form action="asignaturas.jsp" method="post">
                                    <div class="modal-body">
                                        <input type="hidden" name="accion" value="carga_masiva">
                                        <p class="text-muted small">Pega aquí tu lista de asignaturas siguiendo este
                                            formato
                                            (una por línea):<br>
                                            <code>CODIGO;NOMBRE;CREDITOS;DESCRIPCION</code>
                                        </p>
                                        <div class="mb-3">
                                            <textarea class="form-control" name="datos" rows="10"
                                                placeholder="DWEC;Desarrollo Web Cliente;6;JavaScript y más...&#10;DWES;Desarrollo Web Servidor;8;Java y PHP..."></textarea>
                                        </div>
                                        <div class="alert alert-info py-2 small">
                                            <i class="bi bi-info-circle me-2"></i>Los créditos y la descripción son
                                            opcionales. El separador es el punto y coma (;).
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <button type="button" class="btn btn-secondary rounded-pill"
                                            data-bs-dismiss="modal">Cancelar</button>
                                        <button type="submit" class="btn btn-primary rounded-pill">Importar
                                            Todo</button>
                                    </div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="modalAsignatura" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header">
                                    <h5 class="modal-title" id="modalLabel"><i class="bi bi-book me-2"></i>Nueva
                                        Asignatura
                                    </h5><button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <form id="formAsignatura" action="asignaturas.jsp" method="post"
                                    class="needs-validation" novalidate>
                                    <div class="modal-body"><input type="hidden" name="accion" id="accionForm"
                                            value="insertar"><input type="hidden" name="id" id="idForm" value="">
                                        <div class="mb-3"><label for="nombre" class="form-label">Nombre *</label><input
                                                type="text" class="form-control" id="nombre" name="nombre" required
                                                minlength="3" maxlength="100"></div>
                                        <div class="mb-3"><label for="codigo" class="form-label">Código *</label><input
                                                type="text" class="form-control" id="codigo" name="codigo" required
                                                minlength="2" maxlength="20" style="text-transform: uppercase;"></div>
                                        <div class="mb-3"><label for="descripcion"
                                                class="form-label">Descripción</label><textarea class="form-control"
                                                id="descripcion" name="descripcion" rows="3" maxlength="500"></textarea>
                                        </div>
                                        <div class="mb-3"><label for="creditos"
                                                class="form-label">Créditos</label><input type="number"
                                                class="form-control" id="creditos" name="creditos" min="0" max="30"
                                                value="0"></div>
                                    </div>
                                    <div class="modal-footer"><button type="button"
                                            class="btn btn-secondary rounded-pill"
                                            data-bs-dismiss="modal">Cancelar</button><button type="submit"
                                            class="btn btn-add"><i class="bi bi-save me-1"></i>Guardar</button></div>
                                </form>
                            </div>
                        </div>
                    </div>
                    <div class="modal fade" id="modalEliminar" tabindex="-1" aria-hidden="true">
                        <div class="modal-dialog">
                            <div class="modal-content">
                                <div class="modal-header"
                                    style="background: linear-gradient(135deg, #eb3349 0%, #f45c43 100%);">
                                    <h5 class="modal-title text-white"><i
                                            class="bi bi-exclamation-triangle me-2"></i>Confirmar Eliminación</h5>
                                    <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                </div>
                                <div class="modal-body">
                                    <p>¿Estás seguro de que deseas eliminar la asignatura <strong
                                            id="nombreEliminar"></strong>?</p>
                                    <div class="alert alert-warning"><i
                                            class="bi bi-exclamation-triangle me-1"></i><strong>Atención:</strong> Se
                                        eliminarán también todos los RA y Criterios asociados.</div>
                                </div>
                                <div class="modal-footer"><button type="button" class="btn btn-secondary rounded-pill"
                                        data-bs-dismiss="modal">Cancelar</button><a id="btnConfirmarEliminar" href="#"
                                        class="btn btn-danger rounded-pill"><i class="bi bi-trash me-1"></i>Eliminar</a>
                                </div>
                            </div>
                        </div>
                    </div>
                    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
                    <script>
                        (function () { 'use strict'; var forms = document.querySelectorAll('.needs-validation'); Array.prototype.slice.call(forms).forEach(function (form) { form.addEventListener('submit', function (event) { if (!form.checkValidity()) { event.preventDefault(); event.stopPropagation(); } form.classList.add('was-validated'); }, false); }); })();
                        function limpiarFormulario() { document.getElementById('modalLabel').innerHTML = '<i class="bi bi-book me-2"></i>Nueva Asignatura'; document.getElementById('accionForm').value = 'insertar'; document.getElementById('idForm').value = ''; document.getElementById('nombre').value = ''; document.getElementById('codigo').value = ''; document.getElementById('descripcion').value = ''; document.getElementById('creditos').value = '0'; document.getElementById('formAsignatura').classList.remove('was-validated'); }
                        function editarAsignatura(id, nombre, codigo, descripcion, creditos) { document.getElementById('modalLabel').innerHTML = '<i class="bi bi-pencil me-2"></i>Editar Asignatura'; document.getElementById('accionForm').value = 'actualizar'; document.getElementById('idForm').value = id; document.getElementById('nombre').value = nombre; document.getElementById('codigo').value = codigo; document.getElementById('descripcion').value = descripcion; document.getElementById('creditos').value = creditos; document.getElementById('formAsignatura').classList.remove('was-validated'); new bootstrap.Modal(document.getElementById('modalAsignatura')).show(); }
                        function confirmarEliminar(id, nombre) { document.getElementById('nombreEliminar').textContent = nombre; document.getElementById('btnConfirmarEliminar').href = 'asignaturas.jsp?accion=eliminar&id=' + id; new bootstrap.Modal(document.getElementById('modalEliminar')).show(); }
                    </script>
                </body>

                </html>