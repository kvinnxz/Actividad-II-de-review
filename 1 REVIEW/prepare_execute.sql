use mysqlii; 
 
DROP PROCEDURE IF EXISTs Select_paciente;
DELIMITER $$
CREATE PROCEDURE select_paciente(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;  
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('select_paciente', 'Paciente', @cod,
               CONCAT('Error al consultar paciente: ', @msg));
    END;
    IF p_id IS NULL THEN
        SET @v_sql = 'SELECT * FROM Paciente';
        PREPARE stmt FROM @v_sql;
        EXECUTE stmt;
        DEALLOCATE PREPARE stmt;
    ELSE
        SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
        IF existe = 0 THEN
            INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
            VALUES('select_paciente', 'Paciente', 404,
                   CONCAT('El paciente ', p_id, ' no existe'));
        ELSE
            SET @v_sql = 'SELECT * FROM Paciente WHERE Paciente_ID = ?';
            SET @pid = p_id;
            PREPARE stmt FROM @v_sql;
            EXECUTE stmt USING @pid;
            DEALLOCATE PREPARE stmt;
        END IF;
    END IF;
END$$
DELIMITER ;

CALL select_paciente(NULL);       
CALL select_paciente('P-501');    

-- --------------------------------------------------------------------------------------------------------------------------------

DROP PROCEDURE IF exists insert_paciente;

DELIMITER $$

CREATE PROCEDURE insert_paciente(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_tel VARCHAR(20))
BEGIN
    DECLARE existe INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_paciente', 'Paciente', @cod,
               CONCAT('Error al insertar paciente: ', @msg));
    END;
    
    SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
    
    IF existe > 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('insert_paciente', 'Paciente', 404,
               CONCAT('El paciente ', p_id, ' ya existe'));
    ELSE
        SET @v_sql = 'INSERT INTO Paciente(Paciente_ID, Nombre_Paciente, Telefono) VALUES(?, ?, ?)';
        SET @pid = p_id;
        SET @pnombre = p_nombre;
        SET @ptel = p_tel;
        PREPARE stmt FROM @v_sql;
        EXECUTE stmt USING @pid, @pnombre, @ptel;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$
DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------
DROP PROCEDURE IF exists update_paciente;

DELIMITER $$

CREATE PROCEDURE update_paciente(
    IN p_id VARCHAR(10), 
    IN p_nombre VARCHAR(50), 
    IN p_tel VARCHAR(20))
BEGIN
    DECLARE existe INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_paciente', 'Paciente', @cod,
               CONCAT('Error al actualizar paciente: ', @msg));
    END;
    
    SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
    
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('update_paciente', 'Paciente', 404,
               CONCAT('El paciente ', p_id, ' no existe'));
    ELSE
        SET @v_sql = 'UPDATE Paciente SET Nombre_Paciente = ?, Telefono = ? WHERE Paciente_ID = ?';
        SET @pnombre = p_nombre;
        SET @ptel = p_tel;
        SET @pid = p_id;
        PREPARE stmt FROM @v_sql;
        EXECUTE stmt USING @pnombre, @ptel, @pid;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$
DELIMITER ;

-- ----------------------------------------------------------------------------------------------------------------------------------

DROP PROCEDURE IF exists delete_paciente;
DELIMITER $$
CREATE PROCEDURE delete_paciente(IN p_id VARCHAR(10))
BEGIN
    DECLARE existe INT;
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        GET DIAGNOSTICS CONDITION 1
            @cod = MYSQL_ERRNO, @msg = MESSAGE_TEXT;
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_paciente', 'Paciente', @cod,
               CONCAT('Error al eliminar paciente: ', @msg));
    END;
    SELECT COUNT(*) INTO existe FROM Paciente WHERE Paciente_ID = p_id;
    IF existe = 0 THEN
        INSERT INTO Log_Errores(Procedimiento, Nombre_Tabla, Codigo_Error, Mensaje)
        VALUES('delete_paciente', 'Paciente', 404,
               CONCAT('El paciente ', p_id, ' no existe'));
    ELSE
        SET @v_sql = 'DELETE FROM Paciente WHERE Paciente_ID = ?';
        SET @pid = p_id;
        PREPARE stmt FROM @v_sql;
        EXECUTE stmt USING @pid;
        DEALLOCATE PREPARE stmt;
    END IF;
END$$
DELIMITER ;

CALL insert_paciente('P-504', 'Carlos Lopez', '600-444');
CALL update_paciente('P-504', 'Carlos Lopez Jr', '600-555');
CALL select_paciente('P-504');
CALL delete_paciente('P-504');