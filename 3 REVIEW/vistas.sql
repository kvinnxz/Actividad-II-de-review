use mysqlii;
CREATE VIEW vista_medico_facultad AS
SELECT 
    M.Medico_ID,
    M.Nombre_Medico,
    M.Especialidad,
    F.Nombre_Facultad,
    F.Decano
FROM Medico M
JOIN Facultad F ON M.Facultad_ID = F.Facultad_ID;

-- -------------------------------------------------------------------
CREATE VIEW vista_pacientes_medicamento AS
SELECT 
    CM.Medicamento,
    CM.Dosis,
    COUNT(DISTINCT C.Paciente_ID) AS Total_Pacientes
FROM Cita_Medicamento CM
JOIN Cita C ON CM.Cod_Cita = C.Cod_Cita
GROUP BY CM.Medicamento, CM.Dosis;


SELECT * FROM vista_medico_facultad;
SELECT * FROM vista_pacientes_medicamento;