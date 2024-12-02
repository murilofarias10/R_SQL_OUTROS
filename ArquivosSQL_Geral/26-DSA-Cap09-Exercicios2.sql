# SQL Para Análise de Dados e Data Science - Capítulo 09
-- Lista os pedidos
SELECT * FROM cap09.dsa_pedidos;

-- Média do valor dos pedidos
SELECT ROUND(AVG(valor_pedido),2) AS media
FROM cap09.dsa_pedidos;

-- Média do valor dos pedidos por cidade
SELECT ROUND(AVG(pe.valor_pedido),2) AS MEDIA, cli.cidade_cliente AS CIDADE
FROM cap09.dsa_pedidos pe
INNER JOIN cap09.dsa_clientes cli
ON cli.id_cli = pe.id_cliente
GROUP BY CIDADE
ORDER BY MEDIA DESC

--SEM UTILIZAR O INNER JOIN
SELECT cidade_cliente, ROUND(AVG(valor_pedido), 2) AS media
FROM cap09.dsa_pedidos P, cap09.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY MEDIA DESC

-- Insere um novo registro na tabela de Clientes
INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1011, 'Agatha Christie', 'Ouro', 'Belo Horizonte', 'MG');

-- Média do valor dos pedidos por cidade com INNER JOIN
SELECT ROUND(AVG(pe.valor_pedido),2) as MEDIA, cli.cidade_cliente AS CIDADE
FROM cap09.dsa_pedidos pe
INNER JOIN cap09.dsa_clientes cli
ON pe.id_cliente = cli.id_cli
GROUP BY CIDADE
ORDER BY MEDIA DESC

-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos)
SELECT 
    cidade_cliente, 
    CASE 
        WHEN AVG(valor_pedido) IS NULL THEN 'Não Houve Pedido' 
        ELSE CAST(ROUND(AVG(valor_pedido), 2) AS VARCHAR)
    END AS media
FROM 
    cap09.dsa_clientes C
    LEFT JOIN cap09.dsa_pedidos P ON C.id_cli = P.id_cliente
GROUP BY 
    cidade_cliente
ORDER BY media DESC;

-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos)
SELECT 
    cidade_cliente, 
    CASE 
        WHEN AVG(valor_pedido) IS NULL THEN 'Não Houve Pedido' 
        ELSE CAST(ROUND(AVG(valor_pedido), 2) AS VARCHAR)
    END AS media
FROM 
    cap09.dsa_clientes C
    LEFT JOIN cap09.dsa_pedidos P ON C.id_cli = P.id_cliente
GROUP BY 
    cidade_cliente
ORDER BY 
    CASE 
        WHEN AVG(valor_pedido) IS NULL THEN 1 
        ELSE 0 
    END, 
    media DESC;

-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos e com valor 0)
--professor
SELECT  
    cidade_cliente,
    CASE 
        WHEN ROUND(AVG(valor_pedido),2) IS NULL THEN 0
        ELSE ROUND(AVG(valor_pedido),2)
    end AS media
FROM cap09.dsa_pedidos P 
RIGHT JOIN cap09.dsa_clientes C ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY media DESC;

--murilo
SELECT 
	cli.cidade_cliente AS CIDADE, 
	 COALESCE((ROUND(AVG(pe.valor_pedido), 2)), 0) AS MEDIA
FROM cap09.dsa_clientes cli
LEFT JOIN cap09.dsa_pedidos pe
ON cli.id_cli = pe.id_cliente
GROUP BY CIDADE
ORDER BY MEDIA DESC

-- Média do valor dos pedidos por cidade (mostrar cidades sem pedidos)
--Foi criado uma coluna somente para ordernar e usando SUBQUERY
SELECT CIDADE, MEDIA FROM(
SELECT cli.cidade_cliente AS CIDADE, 
	 COALESCE(TO_CHAR(ROUND(AVG(pe.valor_pedido), 2), 'FM999999999.99'), 'SEM PEDIDO') AS media,
	 CASE WHEN ROUND(AVG(pe.valor_pedido), 2) IS NULL THEN 0 ELSE ROUND(AVG(pe.valor_pedido), 2) END AS media_2
FROM cap09.dsa_clientes cli
LEFT JOIN cap09.dsa_pedidos pe
ON cli.id_cli = pe.id_cliente
GROUP BY CIDADE
ORDER BY media_2 DESC) AS SUBQUERY

--Outro metodo é usando o CASE NO ORDER BY
SELECT cli.cidade_cliente AS CIDADE, 
	 COALESCE(TO_CHAR(ROUND(AVG(pe.valor_pedido), 2), 'FM999999999.99'), 'SEM PEDIDO') AS MEDIA
FROM cap09.dsa_clientes cli
LEFT JOIN cap09.dsa_pedidos pe
ON cli.id_cli = pe.id_cliente
GROUP BY CIDADE
ORDER BY 
	CASE WHEN AVG(pe.valor_pedido) IS NULL THEN 1 ELSE 0 END,
	MEDIA DESC
		