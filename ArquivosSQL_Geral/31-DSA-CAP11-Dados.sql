# SQL Para Análise de Dados e Data Science - Capítulo 11

-- Verifica os dados
SELECT * FROM cap11.vendas

--1Total geral de unidades vendidas
SELECT sum(unidades_vendidas) AS "Total Unidades Vendidas"
FROM cap11.vendas

--2Total de unidades vendidas por ano
SELECT ano, sum(unidades_vendidas) AS "Total Unidades Vendidas"
FROM cap11.vendas
GROUP BY ano

--3Total de unidades vendidar por funcionario
SELECT funcionario, sum(unidades_vendidas) AS "Total Unidades Vendidas"
FROM cap11.vendas
GROUP BY funcionario

--4Total de unidades vendidas por ano e por funcionario
SELECT ano, funcionario, sum(unidades_vendidas) AS "Total Unidades Vendidas"
FROM cap11.vendas
GROUP BY funcionario, ano
ORDER BY funcionario, ano

--5Unidads vendidas por ano, mes e por funcionario
SELECT unidades_vendidas, ano, mes, funcionario FROM cap11.vendas
GROUP BY ano, mes, funcionario
ORDER BY ano, mes, funcionario

SELECT unidades_vendidas, ano, mes, funcionario, sum(unidades_vendidas) as total FROM cap11.vendas
GROUP BY ano, mes, funcionario
ORDER BY ano, mes, funcionario

-- Unidades vendidas por ano, mes e por funcionário e total de unidades vendidas do ano
SELECT ano, 
       mes,
       funcionario,
       unidades_vendidas,
       SUM(unidades_vendidas) OVER (PARTITION BY ano) AS unidades_vendidas_ano
FROM cap11.vendas
ORDER BY ano, mes, funcionario;

--Utilizando conceito Window
SELECT ano, 
       mes,
       funcionario,
       unidades_vendidas,
       SUM(unidades_vendidas) OVER (PARTITION BY ano) AS unidades_vendidas_ano,
	   ROUND((unidades_vendidas/SUM(unidades_vendidas) OVER (PARTITION BY ano))*100,2) AS percentual
FROM cap11.vendas
ORDER BY ano, mes, funcionario;


-- Unidades vendidas por ano, mes e por funcionário e valor máximo de unidades vendidas do ano e mes

SELECT ano, 
       mes,
       funcionario,
       unidades_vendidas,
       MAX(unidades_vendidas) OVER (PARTITION BY ano, mes) AS MAX_unidades_vendidas_ano
FROM cap11.vendas
ORDER BY ano, mes, unidades_vendidas DESC

-- Relatório geral utilizando função WINDOW com OVER PARTITION
SELECT ano, 
       mes,
       funcionario,
       unidades_vendidas AS unidades_vendidas_deste_vendedor,
       MIN(unidades_vendidas) OVER (PARTITION BY ano) AS min_geral_unidades_vendidas_ano,
       MAX(unidades_vendidas) OVER (PARTITION BY ano) AS max_geral_unidades_vendidas_ano,
       ROUND(AVG(unidades_vendidas) OVER (PARTITION BY ano), 2) AS media_geral_unidades_vendidas_ano,
       SUM(unidades_vendidas) OVER (PARTITION BY ano) AS total_unidades_vendidas_ano
FROM cap11.vendas
ORDER BY ano, mes, funcionario;

--mudando por funcionario
SELECT ano, 
       mes,
       funcionario,
       unidades_vendidas AS unidades_vendidas_deste_vendedor,
       MIN(unidades_vendidas) OVER (PARTITION BY funcionario) AS min_pessoa,
       MAX(unidades_vendidas) OVER (PARTITION BY funcionario) AS max_pessoa,
       ROUND(AVG(unidades_vendidas) OVER (PARTITION BY funcionario), 2) AS media_pessoa,
       SUM(unidades_vendidas) OVER (PARTITION BY funcionario) AS total_pessoa
FROM cap11.vendas
ORDER BY funcionario

-- Unidades vendidas por ano, mes e por funcionário, total de unidades vendidas do ano e 
-- proporcional de cada funcionário em relação ao total do ano
SELECT
	ano, mes, funcionario, unidades_vendidas,
	SUM(unidades_vendidas) OVER (PARTITION BY ano) AS TOTAL_ANO,
	ROUND((unidades_vendidas/SUM(unidades_vendidas) OVER (PARTITION BY ano))*100,2) AS percentual
FROM cap11.vendas
ORDER BY ano, funcionario

--Unidades venidas por ano para cada funcionario, total de unidades vendidas em cada ano e proporcional
--de cada funcionario em relação  ao total do ano

--Resposta Murilo usando SUBQUERIE
SELECT ano, funcionario, SUM(unidades_vendidas), ROUND(AVG(total_ano),2), SUM(percentual) FROM(
SELECT 
	ano, funcionario, unidades_vendidas,
	SUM(unidades_vendidas) OVER (PARTITION BY ano) AS total_ano,
	ROUND((unidades_vendidas/SUM(unidades_vendidas) OVER (PARTITION BY ano))*100,2) as percentual
FROM cap11.vendas
ORDER BY ano
) AS SUBQUERIE
GROUP BY ano, funcionario
ORDER BY ano

--Resposta professor função window e group by
SELECT 
	ano, funcionario,
	SUM(unidades_vendidas) as total,
	SUM(SUM(unidades_vendidas)) OVER (PARTITION BY ano) AS total_ano,
	ROUND((SUM(unidades_vendidas)/SUM(SUM(unidades_vendidas)) OVER (PARTITION BY ano))*100,2) as percentual
FROM cap11.vendas
GROUP BY ano, funcionario
ORDER BY ano, funcionario
--Repostas professor
-- Unidades vendidas por ano para cada funcionário, total de unidades vendidas em cada ano e 
-- proporcional de cada funcionário em relação ao total do ano

-- Opção 1 - Função Window (Nao chegou no resultado esperado)
SELECT ano, 
       funcionario,
       unidades_vendidas,
       SUM(unidades_vendidas) OVER (PARTITION BY ano) AS unidades_vendidas_ano,
       ROUND(unidades_vendidas / SUM(unidades_vendidas) OVER (PARTITION BY ano) * 100, 2) AS proporcional_func_ano
FROM cap11.vendas
ORDER BY ano, funcionario;

-- Opção 2 - Função Window + Group by (Nao chegou no resultado esperado)
SELECT ano, 
       funcionario,
       unidades_vendidas,
       SUM(unidades_vendidas) OVER (PARTITION BY ano) AS unidades_vendidas_func,
       ROUND(unidades_vendidas / SUM(unidades_vendidas) OVER (PARTITION BY ano) * 100, 2) AS proporcional_func_ano
FROM cap11.vendas
GROUP BY ano, funcionario, unidades_vendidas
ORDER BY ano, funcionario;

-- Opção 3 - CTE e Views Temporárias (chegou no resultado esperado)
WITH vendas_agregadas AS (
    SELECT ano, funcionario, SUM(unidades_vendidas) AS total_unidades_vendidas
    FROM cap11.vendas
    GROUP BY ano, funcionario
),
total_ano AS (
    SELECT ano, SUM(total_unidades_vendidas) AS total_unidades_ano
    FROM vendas_agregadas
    GROUP BY ano
)
SELECT v.ano,
       v.funcionario,
       v.total_unidades_vendidas,
       t.total_unidades_ano,
       ROUND(v.total_unidades_vendidas / t.total_unidades_ano * 100, 2) AS proporcional_func_ano
FROM vendas_agregadas v
JOIN total_ano t ON v.ano = t.ano
ORDER BY v.ano, v.funcionario;

-- Opção 4 - Função Window + Group by
SELECT 
    ano,
    funcionario,
    SUM(unidades_vendidas) AS total_unidades_vendidas,
    SUM(SUM(unidades_vendidas)) OVER (PARTITION BY ano) AS total_unidades_ano,
    ROUND((SUM(unidades_vendidas) / SUM(SUM(unidades_vendidas)) OVER (PARTITION BY ano)) * 100, 2) AS proporcional_func_ano
FROM 
    cap11.vendas
GROUP BY 
    ano, 
    funcionario
ORDER BY 
    ano, 
    funcionario;
