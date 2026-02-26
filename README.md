# Actividad Review MySQL II

## Descripción
Implementación de usuarios con roles, triggers, informe diario, 
vistas y particiones sobre la base de datos de clínica universitaria.

## Actividad 1 - Usuarios y Procedimientos
### Roles
- **admin_clinica** - Acceso total a la base de datos
- **medico_clinica** - Consultar e insertar citas y medicamentos
- **recepcionista_clinica** - Gestionar pacientes y citas
- **auditor_clinica** - Solo lectura

### Procedimientos con PREPARE y EXECUTE
- `insert_paciente`, `update_paciente`, `delete_paciente`, `select_paciente`

## Actividad 2 - Triggers e Informe
### Triggers
- `validar_paciente` - Valida nombre y teléfono al insertar
- `validar_fecha_cita` - Valida que la fecha no sea futura

### Informe Diario
- Tabla `Informe_Diario` con sede, médico y total de pacientes por día
- Evento automático que se actualiza cada 24 horas

## Actividad 3 - Vistas y Particiones
### Vistas
- `vista_medico_facultad` - Médico, facultad y especialidad
- `vista_pacientes_medicamento` - Número de pacientes por medicamento

### Particiones
- Tabla `Cita` particionada por año (2023, 2024, 2025, futuro)
- Mejora el rendimiento en consultas filtradas por fecha

## Herramientas
- MySQL
- MySQL Workbench
- Visual Studio Code

## Autor
**Kevin Pico**  
GitHub: [https://github.com/kvinnxz](https://github.com/kvinnxz)
