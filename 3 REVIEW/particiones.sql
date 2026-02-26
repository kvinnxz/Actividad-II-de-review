use mysqlii;
DROP TABLE IF EXISTS Cita_Medicamento;
DROP TABLE IF EXISTS Cita;

CREATE TABLE Cita (
    Cod_Cita    VARCHAR(10),
    Fecha_Cita  DATE NOT NULL,
    Diagnostico VARCHAR(100) NOT NULL,
    Paciente_ID VARCHAR(10) NOT NULL,
    Medico_ID   VARCHAR(10) NOT NULL,
    Hospital_ID VARCHAR(10) NOT NULL,
    PRIMARY KEY (Cod_Cita, Fecha_Cita)
)
PARTITION BY RANGE (YEAR(Fecha_Cita)) (
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p2025 VALUES LESS THAN (2026),
    PARTITION p_futuro VALUES LESS THAN MAXVALUE
);

CREATE TABLE Cita_Medicamento (
    Cod_Cita    VARCHAR(10) NOT NULL,
    Medicamento VARCHAR(50) NOT NULL,
    Dosis       VARCHAR(20) NOT NULL,
    PRIMARY KEY (Cod_Cita, Medicamento)
);

INSERT INTO Cita VALUES 
('C-001', '2024-05-10', 'Gripe Fuerte', 'P-501', 'M-10', 'H-01'),
('C-002', '2024-05-11', 'Infección',    'P-502', 'M-10', 'H-01'),
('C-003', '2024-05-12', 'Arritmia',     'P-501', 'M-22', 'H-02'),
('C-004', '2024-05-15', 'Migraña',      'P-503', 'M-30', 'H-02');

INSERT INTO Cita_Medicamento VALUES 
('C-001', 'Paracetamol', '500mg'),
('C-001', 'Ibuprofeno',  '400mg'),
('C-002', 'Amoxicilina', '875mg'),
('C-003', 'Aspirina',    '100mg'),
('C-004', 'Ergotamina',  '1mg');

SELECT PARTITION_NAME, TABLE_ROWS 
FROM INFORMATION_SCHEMA.PARTITIONS 
WHERE TABLE_NAME = 'Cita';