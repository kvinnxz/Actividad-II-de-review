use mysqlii;

CREATE USER 'admin_clinica'@'localhost' IDENTIFIED BY 'admin123';
CREATE USER 'medico_clinica'@'localhost' IDENTIFIED BY 'medico123';
CREATE USER 'recepcionista_clinica'@'localhost' IDENTIFIED BY 'recep123';
CREATE USER 'auditor_clinica'@'localhost' IDENTIFIED BY 'audit123';


-- permisos para admin
GRANT ALL PRIVILEGES ON mysqlii.* TO 'admin_clinica'@'localhost';

-- permisos para medico
GRANT SELECT ON mysqlii.Cita TO 'medico_clinica'@'localhost';
GRANT SELECT ON mysqlii.Paciente TO 'medico_clinica'@'localhost';
GRANT SELECT ON mysqlii.Medico TO 'medico_clinica'@'localhost';
GRANT SELECT ON mysqlii.Cita_Medicamento TO 'medico_clinica'@'localhost';
GRANT INSERT ON mysqlii.Cita TO 'medico_clinica'@'localhost';
GRANT INSERT ON mysqlii.Cita_Medicamento TO 'medico_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.insert_cita TO 'medico_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.select_cita TO 'medico_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.insert_cita_med TO 'medico_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.select_cita_med TO 'medico_clinica'@'localhost';


-- permisos para recepcionista
GRANT SELECT, INSERT, UPDATE ON mysqlii.Paciente TO 'recepcionista_clinica'@'localhost';
GRANT SELECT, INSERT, UPDATE ON mysqlii.Cita TO 'recepcionista_clinica'@'localhost';
GRANT SELECT ON mysqlii.Medico TO 'recepcionista_clinica'@'localhost';
GRANT SELECT ON mysqlii.Hospital TO 'recepcionista_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.insert_paciente TO 'recepcionista_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.update_paciente TO 'recepcionista_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.select_paciente TO 'recepcionista_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.insert_cita TO 'recepcionista_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.update_cita TO 'recepcionista_clinica'@'localhost';
GRANT EXECUTE ON PROCEDURE mysqlii.select_cita TO 'recepcionista_clinica'@'localhost';


-- permisos para auditor
GRANT SELECT ON mysqlii.* TO 'auditor_clinica'@'localhost';




FLUSH PRIVILEGES;