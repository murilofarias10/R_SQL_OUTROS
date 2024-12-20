# SQL Para Análise de Dados e Data Science - Capítulo 10

-- Criação da tabela 
CREATE TABLE cap10.vendas (
    ID INT PRIMARY KEY,
    DataVenda DATE,
    Produto VARCHAR(50),
    Quantidade INT,
    ValorUnitario DECIMAL(10, 2),
    Vendedor VARCHAR(50)
);

-- Insert
INSERT INTO cap10.vendas (ID, DataVenda, Produto, Quantidade, ValorUnitario, Vendedor) VALUES
(1, '2023-11-01', 'Produto A', 10, 100.00, 'Zico'),
(2, '2023-11-01', 'Produto B', 5, 200.00, 'Romário'),
(3, '2023-11-02', 'Produto A', 7, 100.00, 'Ronaldo'),
(4, '2023-11-02', 'Produto C', 3, 150.00, 'Bebeto'),
(5, '2023-11-03', 'Produto B', 8, 200.00, 'Romário'),
(6, '2023-11-03', 'Produto A', 5, 100.00, 'Zico'),
(7, '2023-11-04', 'Produto C', 10, 150.00, 'Bebeto'),
(8, '2023-11-04', 'Produto A', 2, 100.00, 'Ronaldo'),
(9, '2023-11-05', 'Produto B', 6, 200.00, 'Romário'),
(10, '2023-11-05', 'Produto C', 4, 150.00, 'Bebeto');

SELECT * FROM cap10.vendas
-- Pergunta 1: Qual o total de vendas por produto?
SELECT produto, SUM(quantidade*valorunitario) AS TOTAL
FROM cap10.vendas
GROUP BY produto
ORDER BY TOTAL DESC

-- Pergunta 2: Qual o total de vendas por vendedor?
SELECT vendedor, SUM(quantidade*valorunitario) AS TOTAL
FROM cap10.vendas
GROUP BY vendedor
ORDER BY TOTAL DESC

-- Pergunta 3: Qual o total de vendas por dia?
SELECT datavenda, SUM(quantidade*valorunitario) AS TOTAL
FROM cap10.vendas
GROUP BY datavenda
ORDER BY datavenda DESC

-- Pergunta 4: Como as vendas se acumulam por dia e por produto (incluindo subtotais diários)?
--ROLLUP CUBE
--Solução: Murilo
SELECT 
	CASE WHEN GROUPING(datavenda) = 1 THEN 'Total Geral' ELSE  CAST(datavenda AS VARCHAR) END AS datavenda,
	CASE WHEN GROUPING (produto) = 1 THEN 'Todos os produtos' ELSE produto END AS produto,
	SUM(quantidade*valorunitario) AS TOTAL 
FROM cap10.vendas
GROUP BY CUBE(datavenda, produto)
ORDER BY (datavenda, produto)

--Solução: Professor
SELECT 
	CASE WHEN GROUPING(datavenda) = 1 THEN 'Total Geral' ELSE CAST(datavenda AS VARCHAR) END AS datavenda, 
	CASE WHEN GROUPING(produto) = 1 then 'Todos os produtos' ELSE produto END AS produto,
	SUM(Quantidade*Valorunitario) AS TotalVendas
FROM CAP10.vendas
GROUP BY ROLLUP(datavenda, produto)
ORDER BY datavenda, produto

--Outra solução utilizando COALESCE para transformar
SELECT
	COALESCE(TO_CHAR(datavenda, 'YYYY-MM-DD'), 'Total Geral') AS datavenda,
	COALESCE(Produto, 'Todos os Produtos') AS Produto,
	SUM(Quantidade*Valorunitario) AS TotalVendas
FROM cap10.vendas
GROUP BY ROLLUP(datavenda, Produto)
ORDER BY GROUPING(Produto)

-- Pergunta 5: Qual a combinação de vendedor e produto gerou mais vendas (incluindo todos os subtotais possíveis)?
--Solução: Murilo
SELECT 
	CASE WHEN GROUPING(vendedor) = 1 THEN 'Todos os vendedores' ELSE vendedor END as vendedor, 
	CASE WHEN GROUPING(produto) = 1 THEN 'Todos os produtos' ELSE produto END as produto, 
	SUM(quantidade*valorunitario) as TOTAL
FROM cap10.vendas
GROUP BY CUBE(vendedor, produto)
ORDER BY GROUPING(vendedor), produto

--Solução Professor:
SELECT 
	CASE WHEN GROUPING(vendedor) = 1 THEN 'Total Geral' ELSE vendedor END as vendedor, 
	CASE WHEN GROUPING(produto) = 1 THEN 'Total' ELSE produto END as produto,
	SUM(quantidade*valorunitario) AS TOTAL
FROM cap10.vendas
GROUP BY CUBE(Vendedor, Produto)

--Outra solução utilizando o CASE
SELECT
	CASE WHEN Vendedor IS NULL THEN 'Todos os Vendedores' ELSE Vendedor END AS Vendedor,
	CASE WHEN Produto IS NULL THEN 'Todos os Produtos' ELSE Produto END AS Produto,
	SUM(quantidade*valorunitario) AS TotalVendas
FROM cap10.vendas
GROUP BY CUBE(Vendedor, Produto)
ORDER BY GROUPING(Vendedor), Produto

-- Imagine que você queira analisar as vendas totais por Produto, por Vendedor e também o total geral de todas as vendas. 
-- Como seria a Query SQL?
SELECT 
	CASE WHEN GROUPING(vendedor) = 1 THEN 'Total Geral' ELSE vendedor END as vendedor, 
	CASE WHEN GROUPING(produto) = 1 THEN 'Total' ELSE produto END as produto, 
	SUM(quantidade*valorunitario) as valor_venda 
FROM cap10.vendas
GROUP BY CUBE(vendedor, produto)
ORDER BY GROUPING(vendedor, produto), valor_venda

--Solução Professor utilizando GROUPING SETS
SELECT
	COALESCE(Produto, 'Todos') AS Produto,
	COALESCE(Vendedor, 'Todos') AS Vendedor,
	SUM(quantidade*valorunitario) AS TotalVendas
FROM cap10.vendas
GROUP BY GROUPING SETS((Produto), (Vendedor),())
