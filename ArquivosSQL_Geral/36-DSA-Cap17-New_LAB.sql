CREATE SCHEMA cap17

CREATE TABLE cap17.clientes(
	id_cliente UUID PRIMARY KEY,
	nome VARCHAR(255),
	email VARCHAR(255)
)

CREATE TABLE cap17.produtos(
	id_produto UUID PRIMARY KEY,
	nome VARCHAR(255),
	preco DECIMAL
)

CREATE TABLE cap17.vendas(
	id_vendas UUID PRIMARY KEY,
	id_clientes UUID REFERENCES cap17.clientes(id_cliente),
	id_produto UUID REFERENCES cap17.produtos(id_produto),
	quantidade INTEGER,
	data_venda DATE
)

SELECT * FROM cap17.clientes where 1 = 0

SELECT 
	SUM(CASE WHEN id_cliente IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN nome IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN email IS NULL THEN 1 ELSE 0 END)
FROM cap17.clientes

SELECT 
	SUM(CASE WHEN id_produto IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN nome IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN preco IS NULL THEN 1 ELSE 0 END)
FROM cap17.produtos

SELECT 
	SUM(CASE WHEN id_vendas IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN id_clientes IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN id_produto IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN quantidade IS NULL THEN 1 ELSE 0 END),
	SUM(CASE WHEN data_venda IS NULL THEN 1 ELSE 0 END)
FROM cap17.vendas



--1 Numero total de vendas e Média de quantidade Vendida
SELECT COUNT(*) as total_de_vendas,
SUM(quantidade)::NUMERIC AS quantidade_vendida,
	ROUND(AVG(quantidade),2) AS media_vendas
FROM cap17.vendas

--2 Numero total de produtos unicos vendidos
SELECT nome FROM cap17.produtos GROUP BY nome ORDER BY nome
SELECT COUNT(DISTINCT id_produto) as total_produtos_unicos FROM cap17.vendas


--3. Quantas Vendas Ocorreram Por Produto? Mostre o Resultado em Ordem Decrescente.

WITH first_table AS (
SELECT DISTINCT(id_produto) as produtos, COUNT(id_vendas) as qtde_vendas FROM cap17.vendas v
GROUP BY id_produto ORDER BY qtde_vendas DESC
),
second_table AS (SELECT nome, id_produto FROM cap17.produtos)
SELECT produtos, nome, qtde_vendas
FROM first_table v
CROSS JOIN second_table p
WHERE v.produtos = p.id_produto
ORDER BY qtde_vendas DESC


SELECT p.nome, COUNT(v.id_produto) AS total_num_vendas
FROM cap17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome
ORDER BY total_num_vendas DESC

--4. Quais os 5 Produtos com Maior Número de Vendas?

SELECT * FROM cap17.clientes
SELECT * FROM cap17.produtos
SELECT * FROM cap17.vendas

SELECT nome, SUM(total) as total FROM(
SELECT 
	p.nome, v.id_produto, COUNT(v.id_vendas) as total FROM cap17.vendas v
JOIN cap17.produtos p ON
v.id_produto = p.id_produto
GROUP BY v.id_produto, p.nome ORDER BY nome DESC
) AS SUB GROUP BY nome ORDER BY total DESC

SELECT nome, SUM(total) as total FROM(
SELECT 
	p.nome, COUNT(v.id_vendas) as total FROM cap17.vendas v
JOIN cap17.produtos p ON
v.id_produto = p.id_produto
GROUP BY p.nome ORDER BY COUNT(v.id_vendas) DESC
) AS SUB GROUP BY nome ORDER BY total DESC LIMIT 5

SELECT p.nome, COUNT(*) AS total_vendas
FROM cap17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY p.nome
ORDER BY total_vendas DESC
LIMIT 5

--5. Quais Clientes Fizeram 6 ou Mais Transações de Compra?
SELECT v.id_clientes as id_cliente, c.nome as nome_cliente, COUNT(*) as total FROM cap17.vendas v
JOIN cap17.clientes c
ON v.id_clientes = c.id_cliente
GROUP BY v.id_clientes, c.nome
HAVING COUNT(*) >=6
ORDER BY total DESC

SELECT c.nome, COUNT(v.id_clientes) as total_compras
FROM cap17.vendas v
JOIN cap17.clientes c ON v.id_clientes = c.id_cliente
GROUP BY c.nome
HAVING COUNT(v.id_clientes) >=6
ORDER BY total_compras DESC

--6. Qual o Total de Transações Comerciais Por Mês no Ano de 2024? 
--Apresente os Nomes dos Meses no Resultado, Que Deve Ser Ordenado Por Mês

SELECT CASE
	WHEN month_name = 1 THEN 'January' 
	WHEN month_name = 2 THEN 'February'
    WHEN month_name = 3 THEN 'March'
    WHEN month_name = 4 THEN 'April'
    WHEN month_name = 5 THEN 'May'
    WHEN month_name = 6 THEN 'June'
    WHEN month_name = 7 THEN 'July'
    WHEN month_name = 8 THEN 'August'
    WHEN month_name = 9 THEN 'September'
    WHEN month_name = 10 THEN 'October'
    WHEN month_name = 11 THEN 'November'
    WHEN month_name = 12 THEN 'December'
	END AS month_name, total_transacoes
	FROM(
SELECT year, month_name, SUM(total_transacoes) as total_transacoes FROM(
SELECT EXTRACT(YEAR FROM data_venda) AS YEAR,
	EXTRACT(MONTH FROM data_venda) AS month_name,
 	count(*) AS total_transacoes FROM cap17.vendas
GROUP BY year, data_venda ORDER BY data_venda ASC
) AS SUB
GROUP BY year, month_name 
HAVING year = 2024
ORDER BY year, month_name ASC
) AS SUB_dois

--Teacher
SELECT
	CASE
		WHEN EXTRACT(MONTH FROM data_venda) = 1 THEN 'Janeiro'
		WHEN EXTRACT(MONTH FROM data_venda) = 2 THEN 'Fev'
		WHEN EXTRACT(MONTH FROM data_venda) = 3 THEN 'Mar'
		WHEN EXTRACT(MONTH FROM data_venda) = 4 THEN 'Abr'
		WHEN EXTRACT(MONTH FROM data_venda) = 5 THEN 'May'
		WHEN EXTRACT(MONTH FROM data_venda) = 6 THEN 'Jun'
		WHEN EXTRACT(MONTH FROM data_venda) = 7 THEN 'Julio'
		WHEN EXTRACT(MONTH FROM data_venda) = 8 THEN 'Ago'
		WHEN EXTRACT(MONTH FROM data_venda) = 9 THEN 'Sep'
		WHEN EXTRACT(MONTH FROM data_venda) = 10 THEN 'Oct'
		WHEN EXTRACT(MONTH FROM data_venda) = 11 THEN 'Novembro'
		WHEN EXTRACT(MONTH FROM data_venda) = 12 THEN 'Dec'
		END as mes,
		COUNT(*) as total_vendas
FROM cap17.vendas
WHERE EXTRACT(YEAR FROM data_venda)= 2024
GROUP BY EXTRACT(MONTH FROM data_venda)
ORDER BY EXTRACT(MONTH FROM data_venda)
		

7. Quantas Vendas de Notebooks Ocorreram em Junho e Julho de 2023?

SELECT
	p.nome as nome, SUM(v.quantidade) as total, 
	EXTRACT(YEAR FROM v.data_venda) AS YEAR,
	EXTRACT(MONTH FROM v.data_venda) AS MONTH FROM CAP17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY nome, EXTRACT(YEAR FROM v.data_venda), EXTRACT(MONTH FROM v.data_venda)
HAVING nome = 'Notebook'
ORDER BY year, month DESC

SELECT
	p.nome as nome, SUM(v.quantidade) as total FROM CAP17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY nome
HAVING nome = 'Notebook'

SELECT nome, sum(total) AS TOTAL FROM(
SELECT
	p.nome AS nome, SUM(v.quantidade) AS total, 
	EXTRACT(YEAR FROM v.data_venda) AS YEAR,
	EXTRACT(MONTH FROM v.data_venda)AS MES FROM CAP17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
GROUP BY nome, EXTRACT(YEAR FROM v.data_venda), EXTRACT(MONTH FROM v.data_venda)
HAVING nome = 'Notebook' AND EXTRACT(YEAR FROM v.data_venda)  = 2023 AND
	(EXTRACT(MONTH FROM v.data_venda) = 6 OR EXTRACT(MONTH FROM v.data_venda) = 7)
) AS SUB
GROUP BY nome

--Teacher answer there is an error
SELECT COUNT(*) as total_vendas_notebook
FROM cap17.vendas v
JOIN cap17.produtos p ON v.id_produto = p.id_produto
WHERE p.nome = 'Notebook'
	AND EXTRACT(YEAR FROM v.data_venda) = 2023
	AND EXTRACT(YEAR FROM v.data_venda) IN (6, 7)

8. Qual o Total de Vendas Por Mês e Por Ano ao Longo do Tempo?

SELECT total_vendas, year || '-' || mes AS concact_data FROM (
SELECT sum(quantidade) as total_vendas, year, mes FROM (
SELECT COUNT(*) as quantidade, EXTRACT(YEAR FROM data_venda) as year,
EXTRACT(MONTH FROM data_venda) as mes
	 FROM cap17.vendas GROUP BY data_venda
ORDER BY data_venda
) AS SUB
GROUP BY year, mes
ORDER BY year, mes
) AS SUB2

SELECT
	DATE_TRUNC('month', data_venda) as mes, COUNT(*) as total_vendas
FROM cap17.vendas
GROUP BY mes
ORDER BY mes

9. Quais Produtos Tiveram Menos de 100 Transações de Venda?
SELECT * FROM cap17.clientes
SELECT * FROM cap17.produtos
SELECT * FROM cap17.vendas

10. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch?
11. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook?
12. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook em Maio/2024?
13.  Qual  a  Média  Móvel  de  Quantidade  de  Unidades  Vendidas  ao  Longo  do  Tempo? Considere Janela de 7 Dias
14. Qual a Média Móvel e Desvio Padrão Móvel de Quantidade de Unidades Vendidas ao Longo do Tempo? Considere Janela de 7 Dias
15. Quais Clientes Estão Cadastrados, Mas Ainda Não Fizeram Transação?