# SQL Para Análise de Dados e Data Science - Capítulo 09

-- Retorna todos os clientes
SELECT * FROM cap09.dsa_clientes;

-- Contagem de clientes
SELECT COUNT(*) FROM cap09.dsa_clientes;

-- Contagem de clientes 
SELECT COUNT(id_cli) FROM cap09.dsa_clientes;

-- Contagem de clientes por cidade
SELECT cidade_cliente, COUNT(id_cli)
FROM cap09.dsa_clientes
GROUP BY cidade_cliente
ORDER BY COUNT(id_cli) DESC

-- Contagem de clientes por cidade ordenado pela contagem
SELECT COUNT(id_cli), cidade_cliente
FROM cap09.dsa_clientes
GROUP BY cidade_cliente
ORDER BY COUNT(id_cli) DESC;

SELECT cidade_cliente, COUNT(id_cli)
FROM cap09.dsa_clientes
GROUP BY cidade_cliente
ORDER BY 2 DESC;

SELECT cidade_cliente, COUNT(id_cli) AS contagem
FROM cap09.dsa_clientes
GROUP BY cidade_cliente
ORDER BY contagem DESC;

-- Número de clientes únicos que fizeram
SELECT COUNT(DISTINCT id_cliente) FROM cap09.dsa_pedidos

SELECT COUNT(id_cliente) as "Total Pedidos", id_cliente FROM cap09.dsa_pedidos
GROUP BY id_cliente
ORDER BY "Total Pedidos" DESC

--Contagem de pedido de clientes do estado do RJ ou de SP
SELECT cli.estado_cliente AS Estado, COUNT(pe.id_pedido) AS "Total Clientes RJ e SP "
FROM cap09.dsa_pedidos pe
INNER JOIN cap09.dsa_clientes cli
ON pe.id_cliente = cli.id_cli
WHERE cli.estado_cliente IN ('SP', 'RJ')
GROUP BY Estado

-- Contagem de pedidos de clientes do estado do RJ ou SP (esta query está correta?)
SELECT estado_cliente, COUNT(*) AS total_pedidos
FROM cap09.dsa_pedidos AS P, cap09.dsa_clientes AS C
WHERE P.id_cliente = C.id_cli
AND estado_cliente = 'RJ' OR estado_cliente = 'SP'
GROUP BY estado_cliente;

-- Visualizar os dados
SELECT * 
FROM cap09.dsa_clientes
ORDER BY estado_cliente;

SELECT * 
FROM cap09.dsa_pedidos
ORDER BY id_cliente;

-- Contagem de pedidos de clientes do estado do RJ ou SP (agora sim!)
SELECT estado_cliente, COUNT(*) AS total_pedidos
FROM cap09.dsa_pedidos AS P, cap09.dsa_clientes AS C
WHERE P.id_cliente = C.id_cli
AND (estado_cliente = 'RJ' OR estado_cliente = 'SP')
GROUP BY estado_cliente

-- Contagem de pedidos de clientes do estado do RJ ou SP (alternativa)
SELECT C.estado_cliente, COUNT(P.id_pedido) AS total_pedidos
FROM cap09.dsa_clientes C
INNER JOIN cap09.dsa_pedidos P ON C.id_cli = P.id_cliente
WHERE C.estado_cliente IN ('RJ', 'SP')
GROUP BY C.estado_cliente;

-- Contagem de pedidos de clientes do estado do RJ ou SP por nome de cliente
SELECT * FROM cap09.dsa_clientes
SELECT * FROM cap09.dsa_pedidos
SELECT * FROM cap09.dsa_produtos

--murilo
SELECT COUNT(pe.id_pedido) as "TOTAL PEDIDOS", cli.nome_cliente, cli.estado_cliente
FROM cap09.dsa_pedidos pe
INNER JOIN cap09.dsa_clientes cli
ON pe.id_cliente = cli.id_cli
WHERE cli.estado_cliente IN ('RJ', 'SP')
GROUP BY cli.nome_cliente, cli.estado_cliente

--professor
SELECT nome_cliente, estado_cliente, COUNT(*) AS total_pedidos
FROM cap09.dsa_pedidos AS P, cap09.dsa_clientes AS C
WHERE P.id_cliente = C.id_cli
AND (estado_cliente = 'RJ' OR estado_cliente = 'SP')
GROUP BY nome_cliente, estado_cliente;

-- Maior valor 
SELECT MAX(valor_pedido) AS maximo
FROM cap09.dsa_pedidos;

SELECT MAX(data_pedido) AS maximo
FROM cap09.dsa_pedidos;

-- Menor valor 
SELECT MIN(valor_pedido) AS minimo
FROM cap09.dsa_pedidos;
