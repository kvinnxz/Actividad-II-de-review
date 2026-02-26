use mysqlii;
CREATE TABLE Informe_Diario (
    Informe_ID      INT PRIMARY KEY AUTO_INCREMENT,
    Fecha           DATE NOT NULL,
    Hospital_Sede   VARCHAR(50) NOT NULL,
    Nombre_Medico   VARCHAR(50) NOT NULL,
    Total_Pacientes INT NOT NULL,
    Fecha_Generado  DATETIME DEFAULT NOW()
);

SET GLOBAL event_scheduler = ON;
DELIMITER $$
CREATE EVENT actualizar_informe_diario
ON SCHEDULE EVERY 1 DAY
STARTS CURRENT_TIMESTAMP
DO
BEGIN
    DELETE FROM Informe_Diario WHERE Fecha = CURDATE();
    INSERT INTO Informe_Diario(Fecha, Hospital_Sede, Nombre_Medico, Total_Pacientes)
    SELECT 
        CURDATE(),
        H.Hospital_Sede,
        M.Nombre_Medico,
        COUNT(DISTINCT C.Paciente_ID) AS Total_Pacientes
    FROM Cita C
    JOIN Hospital H ON C.Hospital_ID = H.Hospital_ID
    JOIN Medico M ON C.Medico_ID = M.Medico_ID
    WHERE C.Fecha_Cita = CURDATE()
    GROUP BY H.Hospital_Sede, M.Nombre_Medico;
END$$
DELIMITER ;

INSERT INTO Informe_Diario(Fecha, Hospital_Sede, Nombre_Medico, Total_Pacientes)
SELECT 
    CURDATE(),
    H.Hospital_Sede,
    M.Nombre_Medico,
    COUNT(DISTINCT C.Paciente_ID) AS Total_Pacientes
FROM Cita C
JOIN Hospital H ON C.Hospital_ID = H.Hospital_ID
JOIN Medico M ON C.Medico_ID = M.Medico_ID
GROUP BY H.Hospital_Sede, M.Nombre_Medico;


SELECT * FROM Informe_Diario;