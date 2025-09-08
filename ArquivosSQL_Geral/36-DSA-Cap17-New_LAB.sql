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

SELECT * FROM cap17.clientes
SELECT * FROM cap17.produtos
SELECT * FROM cap17.vendas


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

5. Quais Clientes Fizeram 6 ou Mais Transações de Compra?
6. Qual o Total de Transações Comerciais Por Mês no Ano de 2024? Apresente os Nomes dos Meses no Resultado, Que Deve Ser Ordenado Por Mês
7. Quantas Vendas de Notebooks Ocorreram em Junho e Julho de 2023?
8. Qual o Total de Vendas Por Mês e Por Ano ao Longo do Tempo?
9. Quais Produtos Tiveram Menos de 100 Transações de Venda?
10. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch?
11. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook?
12. Quais Clientes Compraram Smartphone e Também Compraram Smartwatch, Mas Não Compraram Notebook em Maio/2024?
13.  Qual  a  Média  Móvel  de  Quantidade  de  Unidades  Vendidas  ao  Longo  do  Tempo? Considere Janela de 7 Dias
14. Qual a Média Móvel e Desvio Padrão Móvel de Quantidade de Unidades Vendidas ao Longo do Tempo? Considere Janela de 7 Dias
15. Quais Clientes Estão Cadastrados, Mas Ainda Não Fizeram Transação?