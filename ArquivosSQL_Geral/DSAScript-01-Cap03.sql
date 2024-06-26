# SQL Para Análise de Dados e Data Science - Capítulo 03


-- Cria o schema no banco de dados
CREATE SCHEMA cap03 AUTHORIZATION dsa;


-- Criando a tabela 'estudantes_dsa'
CREATE TABLE cap03.estudantes_dsa (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    nota_exame1 DECIMAL(5, 2),
    nota_exame2 DECIMAL(5, 2),
    tipo_sistema_operacional VARCHAR(20)
);


-- Inserindo 30 registros fictícios na tabela 'estudantes_dsa'
INSERT INTO cap03.estudantes_dsa (nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional) VALUES
('Xavier', 'Murphy', 86.0, 89.0, 'Linux'),
('Yara', 'Bailey', 80.5, 81.0, 'Windows'),
('Alice', 'Smith', 80.5, 85.0, 'Windows'),
('Quincy', 'Roberts', 86.5, 90.0, 'Mac'),
('Bob', 'Johnson', 75.0, 88.0, 'Linux'),
('Carol', 'Williams', 90.0, 90.5, 'Mac'),
('Grace', 'Miller', 95.5, 93.0, 'Windows'),
('Nina', 'Carter', 80.5, 81.0, 'Windows'),
('Ursula', 'Kim', 80.0, 82.5, 'Linux'),
('Eve', 'Jones', 90.0, 88.0, 'Mac'),
('Frank', 'Garcia', 79.0, 82.0, 'Linux'),
('Helen', 'Davis', 90.0, 89.5, 'Mac'),
('Grace', 'Rodriguez', 89.0, 88.0, 'Windows'),
('Jack', 'Martinez', 90.0, 80.0, 'Linux'),
('Karen', 'Hernandez', 93.5, 91.0, 'Windows'),
('Leo', 'Lewis', 82.0, 85.5, 'Mac'),
('Mallory', 'Nelson', 91.0, 89.0, 'Linux'),
('Oscar', 'Mitchell', 88.0, 87.5, 'Linux'),
('Paul', 'Perez', 94.0, 92.0, 'Windows'),
('Rita', 'Gomez', 77.0, 80.0, 'Linux'),
('Steve', 'Freeman', 89.5, 88.5, 'Windows'),
('Troy', 'Reed', 90.0, 92.0, 'Mac'),
('Victor', 'Morgan', 90.0, 85.0, 'Windows'),
('Oscar', 'Bell', 85.5, 87.0, 'Mac'),
('Zane', 'Rivera', 89.0, 90.5, 'Mac'),
('Aria', 'Wright', 75.0, 76.5, 'Linux'),
('Bruce', 'Cooper', 90.0, 84.0, 'Windows'),
('Karen', 'Peterson', 90.0, 92.5, 'Mac'),
('Dave', 'Brown', 88.5, 89.0, 'Windows'),
('Derek', 'Wood', 86.0, 87.5, 'Linux');
