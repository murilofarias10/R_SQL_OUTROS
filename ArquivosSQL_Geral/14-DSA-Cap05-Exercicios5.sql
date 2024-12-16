# SQL Para Análise de Dados e Data Science - Capítulo 05

-- Criando a tabela 'vendas'
CREATE TABLE cap05.vendas (
    id SERIAL PRIMARY KEY,
    data_venda DATE,
    valor DECIMAL(10, 2),
    id_produto INT
);

-- Inserindo registros na tabela 'vendas'
INSERT INTO cap05.vendas (data_venda, valor, id_produto) VALUES
('2023-01-01', 25.50, 1),
('2023-01-02', 30.00, 2),
('2023-01-03', 20.00, 3),
('2023-01-03', 40.00, 3),
('2023-01-04', 92.00, 3),
('2023-02-03', 50.00, 3),
('2023-02-03', 22.00, 3),
('2023-03-03', 20.00, 3),
('2023-04-23', 45.00, 3),
('2023-04-23', 45.00, 3),
('2023-04-23', 76.00, 3),
('2023-05-09', 15.00, 3),
('2023-05-21', 55.00, 3),
('2023-06-03', 87.00, 3),
('2023-06-04', 54.50, 3),
('2023-06-05', 65.00, 3),
('2023-06-06', 64.00, 3),
('2023-06-20', 18.75, 20);

--21/10/24
# Use SQL para responder às perguntas abaixo:
-- Pergunta 1: Qual é o total de vendas por produto?
SELECT 
	id_produto, SUM(valor) as total
FROM cap05.vendas
GROUP BY id_produto
ORDER BY id_produto

-- Pergunta 2: Quantos produtos diferentes foram vendidos?
SELECT
	COUNT(DISTINCT id_produto) as total_produtos
FROM cap05.vendas;

-- Pergunta 3: Qual é o total de vendas por dia?
SELECT 
	SUM(valor) as valor_total,
	data_venda
FROM cap05.vendas
GROUP BY data_venda
ORDER BY data_venda

-- Pergunta 4: Em quais dias o valor total de vendas foi superior a $50?
SELECT 
	SUM(valor) as valor_total,
	data_venda
FROM cap05.vendas
GROUP BY data_venda
HAVING SUM(valor) > 50

-- Pergunta 5: Quais produtos tiveram um valor total de vendas superior a $50?
SELECT 
	id_produto as numero_produto,
	SUM(valor) as valor_total
FROM cap05.vendas
GROUP BY id_produto
HAVING SUM(valor) > 50

-- Pergunta 1: Qual é o total de vendas por produto?
SELECT
	id_produto,
	SUM(valor) as total_Vendas
FROM cap05.vendas
GROUP BY id_produto;

-- Pergunta 2: Quantos produtos diferentes foram vendidos?
SELECT
	id_produto,
	COUNT(id_produto) as contagem_vendas
FROM cap05.vendas
GROUP BY id_produto;

SELECT
	COUNT(DISTINCT(id_produto)) as total_diferentes_produtos
FROM cap05.vendas

-- Pergunta 3: Qual é o total de vendas por dia?
SELECT 
	data_venda as dia,
	SUM(valor) as total
FROM cap05.vendas
GROUP BY dia
ORDER BY dia ASC;

-- Pergunta 4: Em quais dias o valor total de vendas foi superior a $100?
SELECT 
	data_venda as dia,
	SUM(valor) as total
FROM cap05.vendas
GROUP BY dia
HAVING SUM(valor) > 100;

-- Pergunta 5: Quais produtos tiveram um valor total de vendas superior a $50?
SELECT
	id_produto,
	SUM(valor)
FROM cap05.vendas
GROUP BY id_produto
HAVING SUM(valor) >50;
