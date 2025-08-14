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

SELECT * from cap12.vendas

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

select * from cap12.vendas


SELECT funcionario, ano, mes, venda_numero, ROW_NUMBER () OVER () 
FROM (
SELECT
	funcionario, ano, mes, CASE
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
	WHEN mes = 'Dezembro' THEN 12 END as venda_numero, unidades_vendidas
FROM cap12.vendas
order by ano, venda_numero ) as SUB

--outras funções windows função ranking
-- ranking de unidades vendidas do maior numero para o menor por ano
-- qual funcionario conduziu a transação com maior numero de unidades vendias em cada ano ?

select
	funcionario, ano, mes, unidades_vendidas,
	RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) as rank_vendas
from cap12.vendas

select * from (
select
	funcionario, ano, mes, unidades_vendidas,
	RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas DESC) as rank_vendas
from cap12.vendas ) as sub
where rank_vendas = 1

select * from (
select
	funcionario, ano, mes, unidades_vendidas,
	RANK() OVER (PARTITION BY ano ORDER BY unidades_vendidas ASC) as rank_vendas
from cap12.vendas ) as sub
where rank_vendas = 1

SELECT * FROM (
	SELECT funcionario, ano, mes, unidades_vendidas, 
	RANK() OVER(PARTITION BY ano ORDER BY unidades_vendidas DESC
) AS rank_vendas
FROM cap12.vendas) as rank_vendas
where rank_vendas = (
	SELECT MAX(rank_vendas)
	FROM (
		SELECT RANK() OVER(PARTITION BY ano
			   ORDER BY unidades_vendidas DESC) AS rank_vendas
		FROM cap12.vendas)as max_rank
)


--função dense_rank variante da função rank

select
	funcionario, ano, mes, unidades_vendidas,
	RANK() OVER(PARTITION BY ano ORDER BY unidades_vendidas DESC) as rank_vendas
FROM cap12.vendas

select
	funcionario, ano, mes, unidades_vendidas,
	DENSE_RANK() OVER(PARTITION BY ano ORDER BY unidades_vendidas DESC) as rank_vendas
FROM cap12.vendas

-- funções NTILE
SELECT funcionario, ano, mes, unidades_vendidas,
	NTILE(2) OVER (PARTITION BY funcionario, ano ORDER BY unidades_vendidas DESC) AS grupo_vendas
FROM cap12.vendas