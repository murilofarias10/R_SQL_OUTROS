# SQL Para Análise de Dados e Data Science - Capítulo 05


-- Query SQL para retornar a média de Valor_Unitario_Venda.
SELECT AVG(Valor_Unitario_Venda) AS Media_Valor_Unitario
FROM cap05.dsa_vendas;

select 
ROUND(avg(valor_unitario_venda),2)
as media_valor_unitario_venda, 
ROUND(count (*),2) 
as contador
from cap05.dsa_vendas;

-- Query SQL para retornar a média de Valor_Unitario_Venda com duas casas decimais.
select 
ROUND(avg(valor_unitario_venda),2)
as media_valor_unitario_venda
from cap05.dsa_vendas;



SELECT ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas;


-- Query SQL para retornar a contagem, 
--valor mínimo, valor máximo e soma (total) de Valor_Unitario_Venda.

SELECT
COUNT(Valor_Unitario_Venda) as Contagem_Total,
MIN(Valor_Unitario_Venda) as Minimo_Venda,
MAX(Valor_Unitario_Venda) as Maximo_Venda,
SUM(Valor_Unitario_Venda) as Total_Venda
FROM cap05.dsa_vendas;

SELECT 
    COUNT(Valor_Unitario_Venda) AS Contagem,
    MIN(Valor_Unitario_Venda) AS Valor_Minimo,
    MAX(Valor_Unitario_Venda) AS Valor_Maximo,
    SUM(Valor_Unitario_Venda) AS Soma_Total
FROM cap05.dsa_vendas;

-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por categoria de produto.
select 
	nome_produto,
	categoria_produto,
	ROUND(avg(valor_unitario_venda),2) as media
from cap05.dsa_vendas
group by categoria_produto, nome_produto
order by categoria_produto, nome_produto;


SELECT 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;

SELECT 
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;

SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por categoria de produto, 
-- ordenado pela média em ordem decrescente.
SELECT 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto
ORDER BY Media_Valor_Unitario DESC;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto. 

select
nome_produto,
SUM(valor_unitario_venda) as soma_total
from cap05.dsa_vendas
group by nome_produto
order by soma_total desc;


SELECT 
    Nome_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por produto e categoria.
--(Leia a mensagem de erro ao executar)
select * from cap05.dsa_vendas where 1=0;

select
nome_produto,
categoria_produto,
sum(valor_unitario_venda) as soma_total
from cap05.dsa_vendas
group by categoria_produto, nome_produto
order by categoria_produto, nome_produto;

SELECT 
    Nome_Produto,
    Categoria_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda 
--por produto e categoria, ordenado por produto e categoria.

SELECT 
    Nome_Produto,
    Categoria_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto, Categoria_Produto
ORDER BY Nome_Produto, Categoria_Produto;


-- Query SQL para retornar a soma de Valor_Unitario_Venda por categoria e produto, ordenado por categoria e produto.
SELECT 
    Categoria_Produto,
    Nome_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Categoria_Produto, Nome_Produto
ORDER BY Categoria_Produto, Nome_Produto;


-- Query SQL para retornar a média (com duas casas decimais) 
--de Valor_Unitario_Venda por produto, 
-- somente se a média for maior ou igual a 16. 

SELECT 
    nome_produto,
    ROUND(AVG(valor_unitario_venda), 2) AS media_valor
FROM cap05.dsa_vendas 
GROUP BY nome_produto
HAVING AVG(valor_unitario_venda) >= 16
ORDER BY media_valor desc ;

-- Errado:
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Media_Valor_Unitario >= 16
GROUP BY Nome_Produto;

-- Correto:
SELECT 
    Nome_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16;

-- Query SQL para retornar a média (com duas casas decimais)
--de Valor_Unitario_Venda por produto e categoria, 
-- somente se a média for maior ou igual a 16 e
--unidades vendidas maior do que 4, ordenado por nome de produto.
select * from cap05.dsa_vendas where 1 = 0;


SELECT
	nome_produto,
	categoria_produto,
	ROUND(AVG(valor_unitario_venda),2) AS media_valor,
	unidades_vendidas
FROM cap05.dsa_vendas
GROUP BY nome_produto, categoria_produto, unidades_vendidas
HAVING 
	AVG(valor_unitario_venda) >=16 
		AND unidades_vendidas > 4 
ORDER BY media_valor DESC;

SELECT 
    Nome_Produto, 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario,
	unidades_vendidas
FROM cap05.dsa_vendas
WHERE unidades_vendidas > 4
GROUP BY Nome_Produto, Categoria_Produto, unidades_vendidas
HAVING AVG(Valor_Unitario_Venda) >= 16
ORDER BY Nome_Produto;


-- Query SQL para retornar a média (com duas casas decimais) de Valor_Unitario_Venda por produto e categoria, 
-- somente se a média for maior ou igual a 16 e o produto for B ou C, ordenado por categoria.

SELECT 
	nome_produto as produto,
	categoria_produto as categoria,
	ROUND(AVG(valor_unitario_venda),2) as media_venda
FROM cap05.dsa_vendas 
WHERE nome_produto = 'Produto B' OR nome_produto = 'Produto C'
GROUP BY nome_produto, categoria_produto
HAVING AVG(valor_unitario_venda) >=16
ORDER BY categoria_produto;

SELECT 
	nome_produto as produto,
	categoria_produto as categoria,
	ROUND(AVG(valor_unitario_venda),2) as media_venda
FROM cap05.dsa_vendas 
GROUP BY nome_produto, categoria_produto
ORDER BY media_venda desc;


SELECT 
    Nome_Produto, 
    Categoria_Produto,
    ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM cap05.dsa_vendas
WHERE Nome_Produto IN ('Produto B', 'Produto C')
GROUP BY Nome_Produto, Categoria_Produto
HAVING AVG(Valor_Unitario_Venda) >= 16
ORDER BY Categoria_Produto;



