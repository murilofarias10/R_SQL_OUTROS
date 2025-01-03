# SQL Para Análise de Dados e Data Science - Capítulo 05
--11/10/2024

-- Query SQL para retornar a média de Valor_Unitario_Venda.
SELECT ROUND(AVG(valor_unitario_venda),2) as Media_Valor_Unitario_Vendas 
FROM cap05.dsa_vendas;

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

-- Query SQL para retornar a 
--contagem, valor mínimo, valor máximo e soma (total) de Valor_Unitario_Venda.
SELECT * FROM cap05.dsa_vendas where 1 = 0;

SELECT
	COUNT(*) as contagem,
	MIN(valor_unitario_venda) as valor_minimo_venda,
	MAX(valor_unitario_venda) as valor_maximo_venda,
	SUM(valor_unitario_venda) as soma_venda
FROM cap05.dsa_vendas;

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

-- Query SQL para retornar a média (com duas casas decimais) de 
--Valor_Unitario_Venda por categoria de produto.
SELECT
	ROUND(AVG(valor_unitario_venda),2) as media_vendas,
	categoria_produto
FROM cap05.dsa_vendas
GROUP BY categoria_produto
ORDER BY media_vendas DESC;

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
SELECT 
	SUM(valor_unitario_venda) as soma_vendas,
	nome_produto
FROM cap05.dsa_vendas
GROUP BY nome_produto
ORDER BY soma_vendas DESC;

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
SELECT * FROM cap05.dsa_vendas where 1 = 0;
SELECT
	SUM(valor_unitario_venda) as soma_valor_venda,
	nome_produto,
	categoria_produto
FROM cap05.dsa_vendas
GROUP BY categoria_produto, nome_produto
ORDER BY soma_valor_venda DESC;

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
GROUP BY Nome_Produto, Categoria_Produto;

-- Query SQL para retornar a soma de Valor_Unitario_Venda 
--por produto e categoria, ordenado por produto e categoria.

SELECT 
    Nome_Produto,
    Categoria_Produto,
    SUM(Valor_Unitario_Venda) AS Soma_Valor_Unitario
FROM cap05.dsa_vendas
GROUP BY Nome_Produto, Categoria_Produto
ORDER BY Nome_Produto, Categoria_Produto;

-- Query SQL para retornar a soma de Valor_Unitario_Venda por categoria e produto, 
--ordenado por categoria e produto.

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
SELECT * FROM cap05.dsa_vendas where 1 = 0;

--Trazendo quando a media é maior ou igual a 16
SELECT 	nome_produto, media_vendas
FROM(
	SELECT
		nome_produto,
		ROUND(AVG(valor_unitario_venda),2) as media_vendas
	FROM cap05.dsa_vendas
	GROUP BY nome_produto
)as subquerie
WHERE media_vendas >=16
ORDER BY media_vendas DESC;

SELECT 
    nome_produto,
    ROUND(AVG(valor_unitario_venda), 2) AS media_valor
FROM cap05.dsa_vendas 
GROUP BY nome_produto
HAVING AVG(valor_unitario_venda) >= 16
ORDER BY media_valor desc ;

--Trazendo quando a venda em si é maior ou igual a 16
SELECT
	nome_produto,
	ROUND(AVG(valor_unitario_venda),2) as media_vendas
FROM cap05.dsa_vendas
WHERE valor_unitario_venda >=16
GROUP BY nome_produto
ORDER BY media_vendas DESC;

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

--Query SQL para retornar a media de valor_unitario_venda por produto,
--Somente se a media for maior do que 5 e categoria de produtos for 1 ou 2
SELECT
	nome_produto,
	categoria_produto,
	ROUND(AVG(valor_unitario_venda),2) as media_valor_venda
FROM cap05.dsa_vendas
GROUP BY categoria_produto, nome_produto
HAVING (AVG(valor_unitario_venda)) >5 
AND (categoria_produto = 'Categoria 1' OR categoria_produto = 'Categoria 2')
ORDER BY categoria_produto, media_valor_venda DESC, nome_produto; 

SELECT
	nome_produto,
	ROUND(AVG(valor_unitario_venda),2) as media_valor_venda
FROM cap05.dsa_vendas
WHERE categoria_produto IN ('Categoria 1','Categoria 2')
GROUP BY nome_produto
HAVING (AVG(valor_unitario_venda)) >5 

--agora usando SUBQUERIE
--Query SQL para retornar a media de valor_unitario_venda por produto,
--Somente se a media for maior do que 5 e categoria de produtos for 1 ou 2
SELECT * FROM cap05.dsa_vendas where 1 = 0;

SELECT
	nome_produto,
	ROUND(AVG(valor_unitario_venda),2) as valor_medio_vendas
FROM(
	SELECT
		nome_produto, valor_unitario_venda
	FROM cap05.dsa_vendas
	WHERE categoria_produto IN ('Categoria 1', 'Categoria 2')
	) as SUBQUERIE_1
GROUP BY nome_produto
HAVING AVG(valor_unitario_venda) >5;

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

--*****************************
--Query SQL que retorne somente registros cuja media de unidades vendidas seja maior do que 2.
--Desse resultado, retorne os produtos cuja media de vendas foi maior ou igual do que 15
SELECT * FROM cap05.dsa_vendas LIMIT 10;

SELECT
	nome_produto,
	ROUND(AVG(valor_unitario_venda),2) as media_venda
	FROM(
		SELECT
		nome_produto,
		valor_unitario_venda,
		unidades_vendidas
		FROM cap05.dsa_vendas
		GROUP BY nome_produto, valor_unitario_venda, unidades_vendidas
		HAVING(AVG(unidades_vendidas)) > 2
		ORDER BY valor_unitario_venda DESC, nome_produto
		) AS SUBQUERY_1
GROUP BY nome_produto, valor_unitario_venda
HAVING (AVG(valor_unitario_venda))>= 15
ORDER BY media_venda DESC, nome_produto;
		
--Query SQL que retorne somente registros cuja media de unidades vendidas seja maior do que 2.
--Desse resultado, retorne os produtos cuja media de vendas foi maior ou igual do que 15
--Agora somenta registros se categoria de produtos for 1 ou 2
SELECT * FROM cap05.dsa_vendas LIMIT 10;

--Murilo
SELECT
	nome_produto,
	media_Venda
FROM(
	SELECT
		nome_produto,
		ROUND(AVG(valor_unitario_venda),2) as media_venda
		FROM(
			SELECT
			nome_produto,
			Valor_Unitario_Venda
			FROM cap05.dsa_vendas
			WHERE categoria_produto IN ('Categoria 1', 'Categoria 2')
			GROUP BY nome_produto, Valor_Unitario_Venda
			HAVING(AVG(unidades_vendidas)) > 2
			ORDER BY nome_produto
			) AS SUBQUERY_1
	GROUP BY nome_produto
	HAVING (AVG(valor_unitario_venda))>= 15
	ORDER BY media_venda DESC, nome_produto
	) AS SUBQUERY_2	
GROUP BY nome_produto, media_Venda
ORDER BY media_venda DESC;

--Tutor
SELECT
	Nome_Produto,
	ROUND(AVG(Valor_Unitario_Venda), 2) AS Media_Valor_Unitario
FROM(
	SELECT Nome_Produto, Valor_Unitario_Venda
	FROM cap05.dsa_vendas
	WHERE Categoria_produto IN ('Categoria 1', 'Categoria 2')
	GROUP BY Nome_Produto, Valor_Unitario_Venda
	HAVING AVG(unidades_vendidas) > 2
	) as sub_query
GROUP BY Nome_Produto
HAVING AVG(Valor_Unitario_Venda) > 15

--Query para retornar o valor total final de vendas por dia
SELECT * FROM cap05.dsa_vendas where 1 = 0; 

SELECT
	EXTRACT(DAY FROM data_venda) as dia,
	EXTRACT(MONTH FROM data_venda) as mes,
	EXTRACT(YEAR FROM data_venda) as ano,
	SUM(valor_total)
	FROM(
SELECT
	data_venda,
	(unidades_vendidas * valor_unitario_venda) as valor_total
FROM cap05.dsa_vendas
GROUP BY data_venda, valor_total --dia, valor_total
ORDER BY data_venda DESC
)as subquery
GROUP BY data_Venda
ORDER BY data_venda DESC

SELECT
	data_venda,
	SUM(unidades_vendidas * valor_unitario_venda) as valor_total
FROM cap05.dsa_vendas
GROUP BY data_venda
ORDER BY data_venda DESC

--Query retornar a media do valor total final de vendas por mes
SELECT
	mes,
	ROUND(AVG(media_venda_mes),2) as media
		FROM(
			SELECT
			EXTRACT (MONTH FROM data_venda) as mes,
			ROUND(AVG(valor_total),2) as media_venda_mes
				FROM(
					SELECT
					data_venda,
					(unidades_vendidas * valor_unitario_Venda) as valor_total
					FROM cap05.dsa_vendas
					GROUP BY data_venda, valor_total
					ORDER BY data_venda DESC
				)as subquery
			GROUP BY data_venda
			ORDER BY data_venda 
		) as subquery2
	GROUP BY mes
	ORDER BY mes
	
SELECT
    EXTRACT(MONTH FROM data_venda) AS mes,
    ROUND(AVG(unidades_vendidas * valor_unitario_venda), 2) AS media
FROM cap05.dsa_vendas
GROUP BY mes
ORDER BY mes;

--Query para retornar a media do valor total final de venda no dia 1 de cada mes
SELECT * FROM cap05.dsa_vendas limit 10;

SELECT
	EXTRACT(MONTH FROM data_venda) as mes,
	EXTRACT(DAY FROM data_venda) as dia,
	ROUND(AVG(unidades_vendidas * valor_unitario_venda),2) as media_total_vendas,
	COUNT(*) as total_linhas
FROM cap05.dsa_vendas
WHERE EXTRACT (DAY FROM data_venda) = 1
GROUP BY dia, mes;

--Query SQL para retornar a media do valor total final de venda entra os dias 10 e 20 de cada mes
SELECT
	EXTRACT(YEAR FROM data_venda) as ano,
	EXTRACT(MONTH FROM data_venda) as mes,
	ROUND(AVG(unidades_vendidas * valor_unitario_venda),2) as media_total_vendas,
	COUNT(*) as total_linhas
FROM cap05.dsa_vendas
WHERE EXTRACT (DAY FROM data_venda) BETWEEN 10 AND 20
GROUP BY ano, mes

SELECT mes, ROUND(SUM(media_total_vendas)/COUNT(*),2) as soma_media_por_mes FROM(
SELECT
	EXTRACT(MONTH FROM data_venda) as mes,
	EXTRACT(DAY FROM data_venda) as dia,
	ROUND(AVG(unidades_vendidas * valor_unitario_venda),2) as media_total_vendas,
	COUNT(*) as total_linhas
FROM cap05.dsa_vendas
WHERE EXTRACT (DAY FROM data_venda) BETWEEN 10 AND 20
GROUP BY mes, dia
) as SUBQUERY
GROUP BY mes