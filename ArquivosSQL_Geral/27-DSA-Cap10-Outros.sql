# SQL Para Análise de Dados e Data Science - Capítulo 10

-- Altera a tabela de produtos e acrescenta uma coluna
ALTER TABLE IF EXISTS cap10.dsa_produtos 
ADD COLUMN custo DECIMAL(10, 2) NULL;

SELECT * FROM cap10.dsa_produtos;

-- Atualiza a coluna
UPDATE cap10.dsa_produtos
SET custo = 43 + (id_prod - 1) * 5.1
WHERE id_prod BETWEEN 10101 AND 10108;

-- Custo total dos pedidos por estado
SELECT cli.estado_cliente AS ESTADO, SUM(pro.custo) AS TOTAL 
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
GROUP BY ESTADO
ORDER BY TOTAL DESC

SELECT 
    cli.estado_cliente,
    SUM(prod.custo) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;

-- Você foi informado que a tabela de dados está desatualizada e os produtos vendidos para os clientes do estado de SP
-- tiveram aumento de custo de 10%.
-- Demonstre isso no relatório sem modificar os dados na tabela.

--Versão Murilo
SELECT 
	cli.estado_cliente AS ESTADO, SUM(pro.custo) AS TOTAL, 
	CASE 
		WHEN cli.estado_cliente = 'SP' THEN ROUND(SUM(pro.custo+(pro.custo*0.10)),2) 
		ELSE SUM(pro.custo) 
	END AS "COM AUMENTO 10 %"
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
GROUP BY ESTADO
ORDER BY "COM AUMENTO 10 %" DESC

--Versão DSA
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
SELECT * FROM cap10.dsa_pedidos -- usar id_produto
SELECT * FROM cap10.dsa_produtos --custo e nome produto vinculando id_prod
SELECT * FROM cap10.dsa_clientes --usar estado_cliente vinculando id_cli

--trazendo os nomes dos produtos
SELECT pro.nome_produto, cli.estado_cliente, SUM(pro.custo) AS CUSTO_TOTAL
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
GROUP BY pro.nome_produto, cli.estado_cliente
HAVING pro.nome_produto LIKE '%Análise%' OR pro.nome_produto LIKE '%Apache%'
ORDER BY cli.estado_cliente ASC, SUM(pro.custo) DESC

--criando subquery para trazer somente o estado
SELECT estado_cliente, SUM(custo_total) AS TOTAL FROM (
SELECT pro.nome_produto, cli.estado_cliente, SUM(pro.custo) AS CUSTO_TOTAL
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
GROUP BY pro.nome_produto, cli.estado_cliente
HAVING pro.nome_produto LIKE '%Análise%' OR pro.nome_produto LIKE '%Apache%'
ORDER BY cli.estado_cliente ASC, SUM(pro.custo) DESC
) AS SUBQUERY
GROUP BY estado_cliente
ORDER BY TOTAL DESC

SELECT cli.estado_cliente, SUM(pro.custo) AS CUSTO_TOTAL
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
WHERE pro.nome_produto LIKE '%Análise%' OR pro.nome_produto LIKE '%Apache%'
GROUP BY cli.estado_cliente
ORDER BY custo_total DESC

--professor DSA
SELECT 
    cli.estado_cliente,
    SUM(prod.custo) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
ORDER BY 
    custo_total DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total for menor do que 120.000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP
SELECT * FROM cap10.dsa_clientes
SELECT * FROM cap10.dsa_pedidos
SELECT * FROM cap10.dsa_produtos

--Murilo usando SUBQUERI
SELECT TOTAL_COM_ACRESCIMO, ESTADO FROM (
SELECT 
	CASE WHEN cli.estado_cliente = 'SP' THEN SUM(pro.custo)*1.1 ELSE SUM(pro.custo) END AS TOTAL_COM_ACRESCIMO,
	cli.estado_cliente AS ESTADO
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
WHERE NOME_PRODUTO LIKE '%Análise%' OR NOME_PRODUTO LIKE '%Apache%'
GROUP BY ESTADO
ORDER BY TOTAL_COM_ACRESCIMO DESC
) AS SUBQUERIE
WHERE TOTAL_COM_ACRESCIMO < 120000

--Murilo usando having
SELECT 
	CASE WHEN cli.estado_cliente = 'SP' THEN SUM(pro.custo)*1.1 ELSE SUM(pro.custo) END AS TOTAL_COM_ACRESCIMO,
	cli.estado_cliente AS ESTADO
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
WHERE NOME_PRODUTO LIKE '%Análise%' OR NOME_PRODUTO LIKE '%Apache%'
GROUP BY ESTADO
HAVING (SUM(pro.custo)*1.1) < 120000
ORDER BY TOTAL_COM_ACRESCIMO DESC

--Professor Usando Having
SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) < 120000
ORDER BY 
    custo_total DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total estiver entre 150000 e 250000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP

SELECT 
	CASE WHEN cli.estado_cliente = 'SP' THEN SUM(pro.custo)*1.1 ELSE SUM(pro.custo) END AS TOTAL_COM_ACRESCIMO,
	cli.estado_cliente AS ESTADO
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
WHERE NOME_PRODUTO LIKE '%Análise%' OR NOME_PRODUTO LIKE '%Apache%'
GROUP BY ESTADO
HAVING (SUM(pro.custo)*1.1) BETWEEN 150000 AND 250000
ORDER BY TOTAL_COM_ACRESCIMO DESC

SELECT 
	CASE WHEN cli.estado_cliente = 'SP' THEN SUM(pro.custo)*1.1 ELSE SUM(pro.custo) END AS TOTAL_COM_ACRESCIMO,
	sum(pro.custo) AS TOTAL_ORIGINAL,
	cli.estado_cliente AS ESTADO
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
WHERE NOME_PRODUTO LIKE '%Análise%' OR NOME_PRODUTO LIKE '%Apache%'
GROUP BY ESTADO
ORDER BY TOTAL_COM_ACRESCIMO DESC

SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) BETWEEN 150000 AND 250000
ORDER BY 
    custo_total DESC;

-- Custo total dos pedidos por estado com produto cujo título tenha 'Análise' ou 'Apache' no nome
-- Somente se o custo total estiver entre 150000 e 250000
-- Demonstre no relatório, sem modificar os dados na tabela, o aumento de 10% no custo para pedidos de clientes de SP 
-- Inclua no relatório uma coluna chamada status_aumento com o texto 'Com Aumento de Custo' se o estado for SP e o texto
-- 'Sem Aumento de Custo' se for qualquer outro estado

SELECT 
	CASE WHEN cli.estado_cliente = 'SP' THEN SUM(pro.custo)*1.1 ELSE SUM(pro.custo) END AS TOTAL_COM_ACRESCIMO,
	cli.estado_cliente AS ESTADO,
	CASE WHEN cli.estado_cliente = 'SP' THEN 'Com aumento de Custo' ELSE 'Sem Aumento de Custo'  END AS STATUS_AUMENTO
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
WHERE NOME_PRODUTO LIKE '%Análise%' OR NOME_PRODUTO LIKE '%Apache%'
GROUP BY ESTADO
HAVING (SUM(pro.custo)*1.1) BETWEEN 150000 AND 250000
ORDER BY TOTAL_COM_ACRESCIMO DESC

SELECT 
	CASE WHEN cli.estado_cliente = 'SP' THEN SUM(pro.custo)*1.1 ELSE SUM(pro.custo) END AS TOTAL_COM_ACRESCIMO,
	sum(pro.custo) AS TOTAL_ORIGINAL,
	cli.estado_cliente AS ESTADO,
	CASE WHEN cli.estado_cliente = 'SP' THEN 'Com aumento de Custo' ELSE 'Sem Aumento de Custo'  END AS STATUS_AUMENTO
FROM cap10.dsa_pedidos pe
INNER JOIN cap10.dsa_produtos pro ON pe.id_produto = pro.id_prod
INNER JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
WHERE NOME_PRODUTO LIKE '%Análise%' OR NOME_PRODUTO LIKE '%Apache%'
GROUP BY ESTADO
ORDER BY TOTAL_COM_ACRESCIMO DESC

SELECT 
    cli.estado_cliente,
    SUM(
        CASE 
            WHEN cli.estado_cliente = 'SP' THEN prod.custo * 1.1
            ELSE prod.custo
        END
    ) AS custo_total,
    CASE 
        WHEN cli.estado_cliente = 'SP' THEN 'Com Aumento de Custo'
        ELSE 'Sem Aumento de Custo'
    END AS status_aumento
FROM 
    cap10.dsa_pedidos ped
INNER JOIN 
    cap10.dsa_clientes cli ON ped.id_cliente = cli.id_cli
INNER JOIN 
    cap10.dsa_produtos prod ON ped.id_produto = prod.id_prod
WHERE 
    nome_produto LIKE '%Análise%' OR nome_produto LIKE '%Apache%' 
GROUP BY 
    cli.estado_cliente
HAVING 
    SUM(prod.custo) BETWEEN 150000 AND 250000
ORDER BY 
    custo_total DESC;
