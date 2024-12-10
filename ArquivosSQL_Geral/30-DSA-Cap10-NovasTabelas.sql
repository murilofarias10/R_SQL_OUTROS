# SQL Para Análise de Dados e Data Science - Capítulo 10


-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS cap10.dsa_vendas (
    ano INT NULL,
    pais VARCHAR(50) NULL,
    produto VARCHAR(50) NULL,
    faturamento INT NULL
);


-- Insere registros
INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Brasil', 'Geladeira', 1130);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Brasil', 'TV', 980);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Argentina', 'Geladeira', 2180);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Argentina', 'TV', 2240);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Portugal', 'Smartphone', 2310);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Portugal', 'TV', 1900);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2021, 'Inglaterra', 'Notebook', 1800);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Brasil', 'Geladeira', 1400);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Brasil', 'TV', 1345);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Argentina', 'Geladeira', 2180);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Argentina', 'TV', 1390);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Portugal', 'Smartphone', 2480);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Portugal', 'TV', 1980);

INSERT INTO cap10.dsa_vendas (ano, pais, produto, faturamento)
VALUES (2024, 'Inglaterra', 'Notebook', 2300);

-- Lista os dados
SELECT * FROM cap10.dsa_vendas;

--Estudando operadores ROLLUP
-- Faturamento total por ano
SELECT ANO, sum(faturamento) AS FATURAMENTO_TOTAL 
FROM cap10.DSA_vendas
GROUP BY ano
ORDER BY ano DESC

-- Faturamento total por ano e total geral
SELECT ano, SUM(faturamento) AS faturamento_total
FROM cap10.dsa_vendas
GROUP BY ROLLUP(ano);



-- Faturamento total por ano e total geral, ordenado por ano
SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    SUM(faturamento) AS faturamento_total
FROM cap10.dsa_vendas
GROUP BY ROLLUP(ano)
ORDER BY  ano;


-- Faturamento total por ano e pais e total geral (ROLLUP)
SELECT 
	CASE WHEN pais IS NULL THEN 'Total' ELSE pais END AS Pais,
	COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ANO,
	SUM(faturamento)
FROM cap10.dsa_vendas
GROUP BY ROLLUP(pais, ano)
ORDER BY pais, ano, sum







SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    COALESCE(pais, 'Total') AS pais,
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, pais)
ORDER BY
  ano, pais;


-- Faturamento total por ano e pais e 
-- total geral do ano e do pais (CUBE)
SELECT 
    COALESCE(TO_CHAR(ano, '9999'), 'Total') AS ano,
    COALESCE(pais, 'Total') AS pais,
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    CUBE(ano, pais)
ORDER BY 
    ano, pais;


-- Faturamento total por ano e produto e total geral
SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, produto);


-- Faturamento total por ano e produto e total geral, 
-- ordenado por produto, ano e faturamento_total
SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, produto)
ORDER BY 
    produto, ano, faturamento_total;


-- Faturamento total por ano e produto e total geral, 
-- ordenado pelo agrupamento de produto
-- A função GROUPING em SQL é usada para determinar se uma coluna ou expressão em uma consulta 
-- está sendo agrupada ou se está em uma linha de subtotal ou total
-- Podemos usar a função GROUPING para fazer a ordenação do resultado
SELECT 
    CASE 
        WHEN ano IS NULL THEN 'Total Geral' 
        ELSE CAST(ano AS VARCHAR)
    END AS ano, 
    CASE 
        WHEN produto IS NULL THEN 'Todos os Produtos' 
        ELSE produto
    END AS produto, 
    SUM(faturamento) AS faturamento_total
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, produto)
ORDER BY 
    GROUPING(produto), ano, faturamento_total;


-- A função GROUPING em SQL é usada para determinar se uma coluna ou expressão em uma consulta 
-- está sendo agrupada ou se está em uma linha de subtotal ou total
-- Faturamento total por ano e país e total geral com agrupamento do resultado
SELECT
    CASE 
        WHEN GROUPING(ano) = 1 THEN 'Total de Todos os Anos'
        ELSE CAST(ano AS VARCHAR)
    END AS ano,
    CASE 
        WHEN GROUPING(pais) = 1 THEN 'Total de Todos os Países'
        ELSE pais
    END AS pais,
    CASE 
        WHEN GROUPING(produto) = 1 THEN 'Total de Todos os Produtos'
        ELSE produto
    END AS produto,
    SUM(faturamento) AS faturamento_total 
FROM 
    cap10.dsa_vendas
GROUP BY 
    ROLLUP(ano, pais, produto)
ORDER BY 
    GROUPING(produto, ano, pais), faturamento_total;


-- STRING_AGG
-- Faturamento total por país em 2024 mostrando todos os produtos vendidos como uma lista
SELECT 
    pais,
    STRING_AGG(produto, ', ') AS produtos_vendidos,
    SUM(faturamento) AS faturamento_total 
FROM 
    cap10.dsa_vendas
WHERE ano = 2024
GROUP BY 
    pais;
















