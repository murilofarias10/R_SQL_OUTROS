# SQL Para Análise de Dados e Data Science - Capítulo 05

-- Subqueries (ou sub-consultas) são usadas em SQL quando uma consulta é aninhada dentro de outra consulta. 
-- Elas podem ser muito úteis em vários cenários, como:

-- Para Obter Valores para Filtrar
-- Operações de Agregação em Filtragem
-- Existência de Registros
-- Seleção de Colunas

SELECT 
	nome_produto,
	ROUND(AVG(valor_unitario_venda),2) as media
FROM cap05.dsa_Vendas
WHERE 
	categoria_produto = 'Categoria 1' OR
	categoria_produto = 'Categoria 2'
GROUP BY 
	nome_produto
HAVING AVG(valor_unitario_venda) > 5;

--COM SUBQUERIE
SELECT 
    nome_produto,
    media
FROM (
    SELECT 
        nome_produto,
        ROUND(AVG(valor_unitario_venda), 2) as media
    FROM cap05.dsa_Vendas
    WHERE 
        categoria_produto IN ('Categoria 1', 'Categoria 2')
    GROUP BY 
        nome_produto
) AS subconsulta
WHERE media > 5
	
-- Sem usar subquery
-- Query SQL para retornar a média de Valor_Unitario_Venda por produto, 
-- somente se a média for maior do que 5 e categoria de produtos for 1 ou 2. 
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 5;

-- Usando subquery
-- Query SQL para retornar a média de Valor_Unitario_Venda por produto, 
-- somente se a média for maior do que 5 e categoria de produtos for 1 ou 2. 
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
) AS sub_query
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 5;

-- Query SQL que retorne somente registros cuja média de unidades vendidas seja maior do que 2. 
-- Desse resultado, retorne os produtos cuja média de vendas foi maior do que 15.
-- Somente registros se categoria de produtos for 1 ou 2. 

SELECT
	nome_produto, categoria_produto,
	ROUND(AVG(valor_unitario_venda),2) as media_vendas
FROM(
	SELECT 
		nome_produto, valor_unitario_venda, categoria_produto,
		ROUND(AVG(unidades_vendidas),2) as media_unidades_vendidas
	FROM cap05.dsa_vendas
	GROUP BY nome_produto, valor_unitario_venda, categoria_produto
	HAVING AVG(unidades_vendidas) > 2
) AS sub_query
WHERE 
	categoria_produto IN ('Categoria 1', 'Categoria 2')
GROUP BY nome_produto, categoria_produto
HAVING AVG(valor_unitario_venda) > 15
ORDER BY media_vendas desc;

SELECT Nome_Produto, Valor_Unitario_Venda
FROM cap05.dsa_vendas
GROUP BY Nome_Produto, Valor_Unitario_Venda
HAVING AVG(Unidades_Vendidas) > 2;

SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    GROUP BY Nome_Produto, Valor_Unitario_Venda
    HAVING AVG(Unidades_Vendidas) > 2
) AS sub_query
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 15;

SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    GROUP BY Nome_Produto, Valor_Unitario_Venda
    HAVING AVG(Unidades_Vendidas) > 2
) AS sub_query
WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 15;

SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM (
    SELECT Nome_Produto, Valor_Unitario_Venda
    FROM cap05.dsa_vendas
    WHERE Categoria_Produto IN ('Categoria 1', 'Categoria 2')
    GROUP BY Nome_Produto, Valor_Unitario_Venda
    HAVING AVG(Unidades_Vendidas) > 2
) AS sub_query
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 15;
