# SQL Para Análise de Dados e Data Science - Capítulo 12


-- Cria o schema no banco de dados
CREATE SCHEMA cap12;


-- Criação da tabela de Vendas
CREATE TABLE cap12.vendas (
    funcionario VARCHAR(50) NOT NULL,
    ano INT NOT NULL,
    mes VARCHAR(15) NOT NULL,
    unidades_vendidas DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(funcionario, ano, mes)
);


-- Insert na tabela
INSERT INTO cap12.vendas (funcionario, ano, mes, unidades_vendidas) VALUES
('Agatha Christie', 2023, 'Março', 239),
('Agatha Christie', 2023, 'Junho', 241),
('Fernando Pessoa', 2025, 'Março', 290),
('Agatha Christie', 2023, 'Setembro', 276),
('Agatha Christie', 2024, 'Março', 245),
('Agatha Christie', 2025, 'Março', 239),
('Fernando Pessoa', 2023, 'Junho', 333),
('Agatha Christie', 2025, 'Junho', 420),
('Fernando Pessoa', 2023, 'Março', 286),
('Fernando Pessoa', 2024, 'Março', 296),
('Alexandre Dumas', 2024, 'Março', 296),
('Fernando Pessoa', 2024, 'Junho', 480),
('Fernando Pessoa', 2024, 'Setembro', 498),
('Fernando Pessoa', 2025, 'Junho', 522),
('Fernando Pessoa', 2025, 'Setembro', 538),
('Agatha Christie', 2024, 'Setembro', 385),
('Alexandre Dumas', 2023, 'Março', 322),
('Alexandre Dumas', 2023, 'Junho', 333),
('Alexandre Dumas', 2023, 'Setembro', 349),
('Agatha Christie', 2024, 'Junho', 370),
('Alexandre Dumas', 2024, 'Junho', 494),
('Alexandre Dumas', 2024, 'Setembro', 512),
('Fernando Pessoa', 2023, 'Setembro', 310),
('Alexandre Dumas', 2025, 'Março', 529),
('Agatha Christie', 2025, 'Setembro', 453),
('Alexandre Dumas', 2025, 'Junho', 610),
('Alexandre Dumas', 2025, 'Setembro', 634);


SELECT funcionario, ano, mes, CASE
	WHEN mes = 'Janeiro' THEN 1
	WHEN mes = 'Fevereiro' THEN 2
	WHEN mes = 'Março' THEN 3
	WHEN mes = 'Abril' THEN 4
	WHEN mes = 'Maio' THEN 5
	WHEN mes = 'Junho' THEN 6
	WHEN mes = 'Julho' THEN 7
	WHEN mes = 'Agosto' THEN 8
	WHEN mes = 'Setembro' THEN 9
	WHEN mes = 'Outubro' THEN 10
	WHEN mes = 'Novembro' THEN 11
	WHEN mes = 'Dezembro' THEN 12
END as venda_numero, unidades_vendidas 
FROM cap12.vendas
Order by ano, venda_numero

SELECT * from (
SELECT
	funcionario, ano, mes, unidades_vendidas,
	ROW_NUMBER () OVER (PARTITION BY funcionario ORDER BY ano,	
	CASE
	WHEN mes = 'Janeiro' THEN 1
	WHEN mes = 'Fevereiro' THEN 2
	WHEN mes = 'Março' THEN 3
	WHEN mes = 'Abril' THEN 4
	WHEN mes = 'Maio' THEN 5
	WHEN mes = 'Junho' THEN 6
	WHEN mes = 'Julho' THEN 7
	WHEN mes = 'Agosto' THEN 8
	WHEN mes = 'Setembro' THEN 9
	WHEN mes = 'Outubro' THEN 10
	WHEN mes = 'Novembro' THEN 11
	WHEN mes = 'Dezembro' THEN 12
END) as venda_numero
FROM cap12.vendas
where funcionario = 'Agatha Christie'
) as SUB
where venda_numero = 7

SELECT * from (
SELECT
	funcionario, ano, mes, unidades_vendidas,
	ROW_NUMBER () OVER (PARTITION BY funcionario ORDER BY ano,	
	CASE
	WHEN mes = 'Janeiro' THEN 1
	WHEN mes = 'Fevereiro' THEN 2
	WHEN mes = 'Março' THEN 3
	WHEN mes = 'Abril' THEN 4
	WHEN mes = 'Maio' THEN 5
	WHEN mes = 'Junho' THEN 6
	WHEN mes = 'Julho' THEN 7
	WHEN mes = 'Agosto' THEN 8
	WHEN mes = 'Setembro' THEN 9
	WHEN mes = 'Outubro' THEN 10
	WHEN mes = 'Novembro' THEN 11
	WHEN mes = 'Dezembro' THEN 12
END) as venda_numero
FROM cap12.vendas
) as SUB
where venda_numero = 7

SELECT
	funcionario, ano, mes, unidades_vendidas,
	ROW_NUMBER() OVER (ORDER BY funcionario, ano,
	CASE
	WHEN mes = 'Janeiro' THEN 1
	WHEN mes = 'Fevereiro' THEN 2
	WHEN mes = 'Março' THEN 3
	WHEN mes = 'Abril' THEN 4
	WHEN mes = 'Maio' THEN 5
	WHEN mes = 'Junho' THEN 6
	WHEN mes = 'Julho' THEN 7
	WHEN mes = 'Agosto' THEN 8
	WHEN mes = 'Setembro' THEN 9
	WHEN mes = 'Outubro' THEN 10
	WHEN mes = 'Novembro' THEN 11
	WHEN mes = 'Dezembro' THEN 12
END) as venda_numero	
FROM cap12.vendas

