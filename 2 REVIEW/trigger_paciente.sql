use mysqlii;
DELIMITER $$
CREATE TRIGGER validar_paciente
BEFORE INSERT ON Paciente
FOR EACH ROW
BEGIN
    IF NEW.Nombre_Paciente = '' OR NEW.Nombre_Paciente IS NULL THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('validar_paciente', 'Paciente', 400,
               'El nombre del paciente no puede estar vacío');
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El nombre del paciente no puede estar vacío';
    END IF;

    IF NEW.Telefono = '' OR NEW.Telefono IS NULL THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('validar_paciente', 'Paciente', 400,
               'El teléfono del paciente no puede estar vacío');
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'El teléfono del paciente no puede estar vacío';
    END IF;

    IF NEW.Telefono NOT REGEXP '^[0-9-]+$' THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('validar_paciente', 'Paciente', 400,
               CONCAT('El teléfono ', NEW.Telefono, ' tiene formato inválido'));
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'El teléfono solo puede contener números y guiones';
    END IF;
END$$
DELIMITER ;

INSERT INTO Paciente VALUES ('P-505', '', '600-444');
INSERT INTO Paciente VALUES ('P-505', 'Carlos', '');
INSERT INTO Paciente VALUES ('P-505', 'Carlos', 'abc-123');
INSERT INTO Paciente VALUES ('P-505', 'Carlos Lopez', '600-444');