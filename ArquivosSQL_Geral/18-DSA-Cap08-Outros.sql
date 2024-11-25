# SQL Para Análise de Dados e Data Science - Capítulo 08

-- Quais produtos não têm pedido associado?
-- Retorne id do produto, nome do produto, preço do produto, id do cliente associado ao pedido, quantidade e id do pedido
-- Ordene por nome do produto

SELECT * FROM cap08.produtos LIMIT 3
SELECT * FROM cap08.pedidos LIMIT 3

SELECT 
	produto.id_produto, produto.nome, produto.preco, 
	pedido.id_cliente, pedido.quantidade, pedido.id_pedido
FROM cap08.produtos produto
LEFT JOIN cap08.pedidos pedido ON produto.id_produto = pedido.id_produto
ORDER BY produto.nome;

--Somente os pedidos onde o valor é nulo: utiilizando SUBQUERIE
SELECT id_produto, nome, preco, id_cliente, quantidade, id_pedido FROM(
SELECT 
	produto.id_produto, produto.nome, produto.preco, 
	pedido.id_cliente, pedido.quantidade, pedido.id_pedido
FROM cap08.produtos produto
LEFT JOIN cap08.pedidos pedido ON produto.id_produto = pedido.id_produto
ORDER BY produto.nome
) AS SUBQUERY
WHERE id_cliente IS NULL

--outra forma mais facil: sem utilizar SUBQUERIE
SELECT 
	produto.id_produto, produto.nome, produto.preco, 
	pedido.id_cliente, pedido.quantidade, pedido.id_pedido
FROM cap08.produtos produto
LEFT JOIN cap08.pedidos pedido ON produto.id_produto = pedido.id_produto
WHERE pedido.id_pedido is NULL
ORDER BY produto.nome;

--preenchendo null com CASE
SELECT 
	produto.id_produto, produto.nome, produto.preco, 
	CASE WHEN pedido.id_cliente IS NULL THEN 'Sem pedido' ELSE CAST(pedido.id_cliente AS CHAR) END as id_cliente,
	CASE WHEN pedido.quantidade IS NULL THEN 'Sem pedido' ELSE CAST(pedido.quantidade AS CHAR) END as quantidade,
	CASE WHEN pedido.id_pedido IS NULL THEN 'Sem pedido' ELSE CAST(pedido.id_pedido AS CHAR) END as id_pedido
FROM cap08.produtos produto
LEFT JOIN cap08.pedidos pedido ON produto.id_produto = pedido.id_produto
WHERE pedido.id_pedido is NULL
ORDER BY produto.nome;

--Agora somente o que existem pedido
SELECT 
	produto.id_produto, produto.nome, produto.preco, 
	pedido.id_cliente, pedido.quantidade, pedido.id_pedido
FROM cap08.produtos produto
LEFT JOIN cap08.pedidos pedido ON produto.id_produto = pedido.id_produto
WHERE pedido.id_pedido IS NOT NULL
ORDER BY produto.nome;

-- Observe o que acontece sem integridade referencial:

-- Retorne todos os pedidos com ou sem produto associado
-- Retorne id do produto, nome do produto, preço do produto, id do cliente associado ao pedido, quantidade e id do pedido
-- Ordene por nome do produto

SELECT * FROM cap08.pedidos LIMIT 10;
SELECT * FROM cap08.produtos LIMIT 10;

SELECT pr.id_produto, pr.nome, pr.preco, pe.id_cliente, pe.quantidade, pe.id_pedido
FROM cap08.pedidos pe
LEFT JOIN cap08.produtos pr ON pe.id_produto = pr.id_produto
ORDER BY pr.nome

-- Resposta com tabelas onde a IR foi implementada
SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.produtos pr
RIGHT JOIN cap08.pedidos p ON pr.id_produto = p.id_produto
ORDER BY pr.nome;

-- Resposta com tabelas onde a IR NÃO foi implementada
SELECT pr.id_produto, pr.nome, pr.preco, p.id_cliente, p.quantidade, p.id_pedido
FROM cap08.produtos pr
RIGHT JOIN cap08.pedidos_sem_ir p ON pr.id_produto = p.id_produto
ORDER BY pr.nome;

-- FULL JOIN
-- Retorna todos os registros havendo ou não correspondência entre as tabelas

SELECT * 
FROM cap08.produtos pr
FULL JOIN cap08.pedidos p ON pr.id_produto = p.id_produto;

SELECT * 
FROM cap08.produtos pr
FULL OUTER JOIN cap08.pedidos p ON pr.id_produto = p.id_produto;

-- CROSS JOIN
-- Produto cartesiano, ou seja, retorna todas as combinações possíveis entre as tabelas
-- a primeira linha de uma tabela com todas da segunda tabela e assim por diante
SELECT * 
FROM cap08.produtos pr
CROSS JOIN cap08.pedidos p
ORDER BY pr.id_produto

-- SELF JOIN
-- Queremos listar os pares de pedidos feitos pelo mesmo cliente.
-- Ou seja, queremos todas as combinações de 2 pedidos diferentes para cada cliente.

SELECT * 
FROM cap08.pedidos
ORDER BY id_cliente; 

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p1.id_cliente 
FROM cap08.pedidos p1
JOIN cap08.pedidos p2 
ON p1.id_cliente = p2.id_cliente;

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p1.id_cliente 
FROM cap08.pedidos p1
JOIN cap08.pedidos p2 
ON p1.id_cliente = p2.id_cliente AND p1.id_pedido != p2.id_pedido;

SELECT p1.id_pedido AS Pedido1_ID, p2.id_pedido AS Pedido2_ID, p1.id_cliente 
FROM cap08.pedidos p1
JOIN cap08.pedidos p2 
ON p1.id_cliente = p2.id_cliente AND p1.id_pedido < p2.id_pedido;

