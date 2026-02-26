use mysqlii;
DELIMITER $$
CREATE TRIGGER validar_fecha_cita
BEFORE INSERT ON Cita
FOR EACH ROW
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('validar_fecha_cita', 'Cita', @cod, @msg);
    END;

    IF NEW.Fecha_Cita > CURDATE() THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('validar_fecha_cita', 'Cita', 400,
               CONCAT('La fecha ', NEW.Fecha_Cita, ' no puede ser futura'));
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'La fecha de la cita no puede ser futura';
    END IF;
END$$
DELIMITER ;

INSERT INTO Cita VALUES ('C-009', '2027-01-01', 'Gripe', 'P-501', 'M-10', 'H-01');
SELECT * FROM Log_Errores;