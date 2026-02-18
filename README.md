# Gestión RA - API REST con Spring Boot

Esta aplicación es una API REST desarrollada con Spring Boot para la gestión de Materias, Resultados de Aprendizaje (RA) y Criterios de Evaluación. Sustituye a la anterior versión basada en JSP.

## Estructura del Proyecto

El proyecto sigue una arquitectura MVC estricta con la siguiente estructura de paquetes:

- `com.tuempresa.gestionra.controller`: Controladores REST que exponen los endpoints.
- `com.tuempresa.gestionra.service`: Lógica de negocio.
- `com.tuempresa.gestionra.repository`: Interfaces para acceso a datos (Spring Data JPA).
- `com.tuempresa.gestionra.model`: Entidades JPA.

## Tecnologías

- Java 17
- Spring Boot 3.2.3
- Spring Data JPA
- MySQL Driver
- Lombok

## Configuración

1. Asegúrate de tener una base de datos MySQL ejecutándose.
2. Crea la base de datos `gestion_academica` si no existe (gestiona automáticamente por `application.properties` si tienes permisos, o usa el script SQL original).
3. Configura las credenciales en `src/main/resources/application.properties` si son diferentes a `root` / (sin contraseña).

## Ejecución

Para iniciar la aplicación:

```bash
mvn spring-boot:run
```

La API estará disponible en `http://localhost:8080`.

## Endpoints y Pruebas

A continuación se muestran ejemplos de cómo interactuar con la API usando `curl` o Postman.

### 1. Materias

**Listar todas las materias:**
```bash
curl -X GET http://localhost:8080/api/materias
```

**Crear una materia:**
```bash
curl -X POST http://localhost:8080/api/materias \
  -H "Content-Type: application/json" \
  -d '{"nombre": "NUEVA MATERIA", "codigo": "NUEVA", "descripcion": "Descripcion de prueba", "creditos": 6}'
```

**Obtener una materia por ID:**
```bash
curl -X GET http://localhost:8080/api/materias/1
```

### 2. Resultados de Aprendizaje (RA)

**Listar todos los RAs:**
```bash
curl -X GET http://localhost:8080/api/ras
```

**Listar RAs de una Materia (ID=1):**
```bash
curl -X GET http://localhost:8080/api/ras/materia/1
```

**Crear un RA (asociado a Materia ID 1):**
```bash
curl -X POST http://localhost:8080/api/ras \
  -H "Content-Type: application/json" \
  -d '{"codigo": "RA-TEST", "descripcion": "RA de prueba", "materiaId": 1}'
```

### 3. Criterios de Evaluación

**Listar todos los Criterios:**
```bash
curl -X GET http://localhost:8080/api/criterios
```

**Listar Criterios de un RA (ID=1):**
```bash
curl -X GET http://localhost:8080/api/criterios/ra/1
```

**Crear un Criterio (asociado a RA ID 1):**
```bash
curl -X POST http://localhost:8080/api/criterios \
  -H "Content-Type: application/json" \
  -d '{"codigo": "CE-TEST", "descripcion": "Criterio de prueba", "ponderacion": 15.5, "raId": 1}'
```

## Notas adicionales

- La aplicación utiliza `spring.jpa.hibernate.ddl-auto=update`, por lo que las tablas se actualizarán automáticamente.
- Se han eliminado las vistas JSP y los servlets antiguos.
