<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
    <%@ page import="dao.AsignaturaDAO, dao.ResultadoAprendizajeDAO, dao.CriterioEvaluacionDAO" %>
        <% /* Obtener conteos para el dashboard */ AsignaturaDAO asignaturaDAO=new AsignaturaDAO();
            ResultadoAprendizajeDAO raDAO=new ResultadoAprendizajeDAO(); CriterioEvaluacionDAO criterioDAO=new
            CriterioEvaluacionDAO(); int totalAsignaturas=asignaturaDAO.listarAsignaturas().size(); int
            totalRA=raDAO.listarTodos().size(); int totalCriterios=criterioDAO.listarTodos().size(); %>
            <!DOCTYPE html>
            <html lang="es">

            <head>
                <meta charset="UTF-8">
                <meta name="viewport" content="width=device-width, initial-scale=1.0">
                <title>Gestión Académica - Inicio</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
                <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.0/font/bootstrap-icons.css"
                    rel="stylesheet">
                <link href="css/styles.css" rel="stylesheet">
            </head>

            <body>
                <!-- Navbar -->
                <nav class="navbar navbar-expand-lg navbar-custom">
                    <div class="container">
                        <a class="navbar-brand" href="index.jsp">
                            <i class="bi bi-mortarboard-fill me-2"></i>Gestión Académica
                        </a>
                        <button class="navbar-toggler" type="button" data-bs-toggle="collapse"
                            data-bs-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false"
                            aria-label="Toggle navigation">
                            <span class="navbar-toggler-icon"></span>
                        </button>
                        <div class="collapse navbar-collapse" id="navbarNav">
                            <ul class="navbar-nav ms-auto">
                                <li class="nav-item">
                                    <a class="nav-link active" href="index.jsp"><i
                                            class="bi bi-house-door me-1"></i>Inicio</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="asignaturas.jsp"><i
                                            class="bi bi-book me-1"></i>Asignaturas</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="resultados.jsp"><i
                                            class="bi bi-clipboard-check me-1"></i>Resultados de
                                        Aprendizaje</a>
                                </li>
                                <li class="nav-item">
                                    <a class="nav-link" href="criterios.jsp"><i
                                            class="bi bi-list-check me-1"></i>Criterios de
                                        Evaluación</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>

                <!-- Contenido Principal -->
                <div class="container mt-4">
                    <!-- Cabecera -->
                    <div class="text-center mb-4 fade-in-up">
                        <h1 class="fw-bold text-dark">Sistema de Gestión Académica</h1>
                        <p class="text-muted fs-5">CRUD con JSP, MySQL y Bootstrap</p>
                    </div>

                    <!-- Tarjetas de resumen -->
                    <div class="row g-4 mb-4">
                        <!-- Asignaturas -->
                        <div class="col-md-4 fade-in-up">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div>
                                        <div class="card-count">
                                            <%= totalAsignaturas %>
                                        </div>
                                        <div class="card-label">Asignaturas</div>
                                    </div>
                                    <div class="card-icon icon-asignaturas">
                                        <i class="bi bi-book"></i>
                                    </div>
                                </div>
                                <a href="asignaturas.jsp"
                                    class="btn btn-sm btn-outline-primary mt-3 w-100 rounded-pill">
                                    Gestionar <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>

                        <!-- Resultados de Aprendizaje -->
                        <div class="col-md-4 fade-in-up">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div>
                                        <div class="card-count">
                                            <%= totalRA %>
                                        </div>
                                        <div class="card-label">Resultados de Aprendizaje</div>
                                    </div>
                                    <div class="card-icon icon-resultados">
                                        <i class="bi bi-clipboard-check"></i>
                                    </div>
                                </div>
                                <a href="resultados.jsp" class="btn btn-sm btn-outline-success mt-3 w-100 rounded-pill">
                                    Gestionar <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>

                        <!-- Criterios de Evaluación -->
                        <div class="col-md-4 fade-in-up">
                            <div class="dashboard-card p-4">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div>
                                        <div class="card-count">
                                            <%= totalCriterios %>
                                        </div>
                                        <div class="card-label">Criterios de Evaluación</div>
                                    </div>
                                    <div class="card-icon icon-criterios">
                                        <i class="bi bi-list-check"></i>
                                    </div>
                                </div>
                                <a href="criterios.jsp" class="btn btn-sm btn-outline-warning mt-3 w-100 rounded-pill">
                                    Gestionar <i class="bi bi-arrow-right"></i>
                                </a>
                            </div>
                        </div>
                    </div>

                    <!-- Información del proyecto -->
                    <div class="table-container fade-in-up">
                        <h5 class="fw-bold mb-3"><i class="bi bi-info-circle me-2"></i>Acerca del Proyecto</h5>
                        <p class="text-muted">
                            Esta aplicación web permite gestionar <strong>Asignaturas</strong>,
                            <strong>Resultados de Aprendizaje (RA)</strong> y <strong>Criterios de Evaluación</strong>
                            mediante operaciones CRUD (Crear, Leer, Actualizar, Eliminar).
                        </p>
                        <hr>
                        <div class="row">
                            <div class="col-md-4">
                                <h6 class="fw-bold"><i class="bi bi-code-slash me-1"></i>Tecnologías</h6>
                                <ul class="list-unstyled text-muted">
                                    <li><i class="bi bi-check-circle text-success me-1"></i> JSP (Java Server Pages)
                                    </li>
                                    <li><i class="bi bi-check-circle text-success me-1"></i> MySQL (Base de datos)</li>
                                    <li><i class="bi bi-check-circle text-success me-1"></i> Bootstrap 5 (UI)</li>
                                    <li><i class="bi bi-check-circle text-success me-1"></i> JDBC (Conexión BD)</li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h6 class="fw-bold"><i class="bi bi-diagram-3 me-1"></i>Estructura</h6>
                                <ul class="list-unstyled text-muted">
                                    <li><i class="bi bi-folder me-1"></i> Modelo (POJOs)</li>
                                    <li><i class="bi bi-folder me-1"></i> DAO (Acceso a datos)</li>
                                    <li><i class="bi bi-folder me-1"></i> Vistas (JSP)</li>
                                    <li><i class="bi bi-folder me-1"></i> Utilidades (Conexión)</li>
                                </ul>
                            </div>
                            <div class="col-md-4">
                                <h6 class="fw-bold"><i class="bi bi-shield-check me-1"></i>Características</h6>
                                <ul class="list-unstyled text-muted">
                                    <li><i class="bi bi-check-circle text-success me-1"></i> Validación cliente/servidor
                                    </li>
                                    <li><i class="bi bi-check-circle text-success me-1"></i> Transacciones SQL</li>
                                    <li><i class="bi bi-check-circle text-success me-1"></i> Diseño responsivo</li>
                                    <li><i class="bi bi-check-circle text-success me-1"></i> Relaciones entre entidades
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <!-- Footer -->
                <div class="footer">
                    <p>RA6 - AEE Desarrollo de CRUD con JSP, MySQL y Bootstrap &copy; 2026</p>
                </div>

                <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
            </body>

            </html>