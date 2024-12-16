# SQL Para Análise de Dados e Data Science - Capítulo 10

-- Lista os pedidos
SELECT * FROM cap10.dsa_pedidos;

-- Soma (total) do valor dos pedidos
SELECT SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos;

-- Soma (total) do valor dos pedidos por cidade
SELECT 
	cli.cidade_cliente AS CIDADE, 
	CASE WHEN SUM(pe.valor_pedido) IS NULL THEN 0 ELSE SUM(pe.valor_pedido) END AS TOTAL
FROM cap10.dsa_pedidos pe
RIGHT JOIN cap10.dsa_clientes cli ON pe.id_cliente = cli.id_cli
GROUP BY CIDADE
ORDER BY TOTAL DESC

SELECT cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P, cap10.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente
ORDER BY 2;

-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula WHERE)
SELECT cli.estado_cliente AS ESTADO, cli.cidade_cliente AS CIDADE, SUM(pe.valor_pedido) AS SOMA
FROM cap10.DSA_clientes cli, cap10.dsa_pedidos pe 
WHERE cli.id_cli = pe.id_cliente
GROUP BY ESTADO, CIDADE
ORDER BY SOMA DESC

SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P, cap10.dsa_clientes C
WHERE P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;

-- Soma (total) do valor dos pedidos por estado e cidade (com cláusula JOIN)
SELECT cli.estado_cliente AS ESTADO, cli.cidade_cliente AS CIDADE, SUM(pe.valor_pedido) AS SOMA
FROM cap10.DSA_clientes cli
LEFT JOIN cap10.dsa_pedidos pe ON cli.id_cli = pe.id_cliente
GROUP BY ESTADO, CIDADE
ORDER BY SOMA DESC

SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P
INNER JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;

-- Soma (total) do valor dos pedidos por estado e cidade. Retornar cidades sem pedidos.
SELECT * FROM cap10.dsa_pedidos;
SELECT * FROM cap10.dsa_clientes;

--trazendo so o nulo
SELECT cli.estado_cliente AS ESTADO, cli.cidade_cliente AS CIDADE, SUM(pe.valor_pedido) AS SOMA
FROM cap10.DSA_clientes cli
LEFT JOIN cap10.dsa_pedidos pe ON cli.id_cli = pe.id_cliente
GROUP BY ESTADO, CIDADE
HAVING SUM(pe.valor_pedido) IS NULL

--trazendo todo a tabela
SELECT estado_cliente, cidade_cliente, SUM(valor_pedido) AS total
FROM cap10.dsa_pedidos P
RIGHT JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;

--utilizando coalesce
SELECT estado_cliente, cidade_cliente, COALESCE(SUM(valor_pedido),0) AS total
FROM cap10.dsa_pedidos P
RIGHT JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;

-- Soma (total) do valor dos pedidos por estado e cidade. Mostrar zero se não houve pedido.
SELECT 
    estado_cliente,
    cidade_cliente,
    CASE 
        WHEN FLOOR(SUM(valor_pedido)) IS NULL THEN 0
        ELSE FLOOR(SUM(valor_pedido))
    end AS total
FROM cap10.dsa_pedidos P 
RIGHT JOIN cap10.dsa_clientes C
ON P.id_cliente = C.id_cli
GROUP BY cidade_cliente, estado_cliente
ORDER BY total DESC;
