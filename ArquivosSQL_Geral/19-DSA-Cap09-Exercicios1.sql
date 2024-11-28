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
SELECT nome_cliente, estado_cliente, COUNT(*) AS total_pedidos
FROM cap09.dsa_pedidos AS P, cap09.dsa_clientes AS C
WHERE P.id_cliente = C.id_cli
AND (estado_cliente = 'RJ' OR estado_cliente = 'SP')
GROUP BY nome_cliente, estado_cliente;


-- Maior valor 
SELECT MAX(valor_pedido) AS maximo
FROM cap09.dsa_pedidos;


-- Menor valor 
SELECT MIN(valor_pedido) AS minimo
FROM cap09.dsa_pedidos;

