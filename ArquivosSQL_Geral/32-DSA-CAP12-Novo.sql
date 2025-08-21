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

SELECT
	funcionario, ano, mes, unidades_vendidas,
	RANK() OVER(ORDER BY unidades_vendidas DESC) AS rank_vendas
from cap12.vendas;

-- Calcular a soma acumulada das vendas para cada funcionario ao longo do tempo ano e mes
SELECT
	funcionario, ano, mes, unidades_vendidas,
	sum(unidades_vendidas) OVER(PARTITION BY funcionario ORDER BY ano, CASE
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
		WHEN mes = 'Dezembro' THEN 12 END) as total
FROM cap12.vendas

-- média acumulada até o ponto para cada funcionário (soma / quantidade)
SELECT
	funcionario, ano, mes, unidades_vendidas,
	round(avg(unidades_vendidas) OVER(PARTITION BY funcionario ORDER BY ano, CASE
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
		WHEN mes = 'Dezembro' THEN 12 END),2) as total
FROM cap12.vendas

--calculando a média movel (anterior + atual + proximo / 3)
SELECT
	funcionario,
	ano,
	mes, unidades_vendidas,
	ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
		END ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING), 2) as media_movel
FROM cap12.vendas;

--função LEAD adding a new colum showing next value
SELECT
	funcionario, ano, mes, unidades_vendidas,
	COALESCE(
		CAST(LEAD(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
END)AS VARCHAR), 'Sem dados') as proxima
FROM cap12.vendas;

--função LAG adding a new colum showing previous value
SELECT
	funcionario, ano, mes, unidades_vendidas,
	COALESCE(
		CAST(LAG(unidades_vendidas) OVER (PARTITION BY funcionario ORDER BY ano, CASE
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
END)AS VARCHAR), 'Sem dados') as proxima
FROM cap12.vendas;

-- seleciona os funcionarios juntamente com o valor maximo de unidades vendidas de cada um por ano
SELECT
	funcionario, ano, MAX(unidades_vendidas)
FROM cap12.vendas
GROUP BY funcionario, ano
ORDER BY funcionario, ano

-- comparando com a media de venda do ano
SELECT
	ano,
	round(avg(unidades_vendidas),2) as media
FROM cap12.vendas
GROUP BY ano
ORDER BY ano

--juntando os dois como uma subquerie correlata
SELECT 
    v.funcionario,
    v.ano,
    MAX(v.unidades_vendidas) AS max_unidades,
    m.media
FROM cap12.vendas v
JOIN (
    SELECT 
        ano,
        ROUND(AVG(unidades_vendidas),2) AS media
    FROM cap12.vendas
    GROUP BY ano
) m ON v.ano = m.ano
GROUP BY v.funcionario, v.ano, m.media
ORDER BY v.funcionario, v.ano;

-- subquerie com agregação
SELECT
	v.funcionario, ano, mes, unidades_vendidas,
	ROUND((unidades_vendidas / total_vendas) * 100, 2) AS percentual_do_total
FROM
	cap12.vendas AS v,
	(SELECT funcionario, SUM(unidades_vendidas) AS total_vendas
	FROM cap12.vendas
	GROUP BY funcionario) AS vendas_totais
WHERE
	v.funcionario = vendas_totais.funcionario
ORDER BY v.funcionario, ano, CASE
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
	END;
