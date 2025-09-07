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

