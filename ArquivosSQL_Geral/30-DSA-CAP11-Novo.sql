# SQL Para Análise de Dados e Data Science - Capítulo 11

-- Cria o schema no banco de dados
CREATE SCHEMA cap11 AUTHORIZATION dsa;

-- Criação da tabela de Vendas
CREATE TABLE cap11.vendas (
    funcionario VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    mes VARCHAR(15) NOT NULL,
    unidades_vendidas DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(funcionario, ano, mes)
);

-- Insert na tabela
INSERT INTO cap11.vendas (funcionario, ano, mes, unidades_vendidas) VALUES
('Machado de Assis', 2023, 'Julho', 259),
('Machado de Assis', 2023, 'Setembro', 276),
('Machado de Assis', 2024, 'Julho', 370),
('Machado de Assis', 2024, 'Setembro', 385),
('Machado de Assis', 2025, 'Julho', 420),
('Machado de Assis', 2025, 'Setembro', 453),
('Paulo Coelho', 2023, 'Julho', 290),
('Paulo Coelho', 2023, 'Setembro', 310),
('Paulo Coelho', 2024, 'Julho', 480),
('Paulo Coelho', 2024, 'Setembro', 498),
('Paulo Coelho', 2025, 'Julho', 522),
('Paulo Coelho', 2025, 'Setembro', 538),
('Clarice Lispector', 2023, 'Julho', 340),
('Clarice Lispector', 2023, 'Setembro', 350),
('Clarice Lispector', 2024, 'Julho', 497),
('Clarice Lispector', 2024, 'Setembro', 512),
('Clarice Lispector', 2025, 'Julho', 610),
('Clarice Lispector', 2025, 'Setembro', 634);

-- Verifica os dados
SELECT *
FROM cap11.vendas;

