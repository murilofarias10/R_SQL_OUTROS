--retorne id, nome e cidade dos clientes que tiveram interação por email e que moram na RUA A
CREATE VIEW cap19.clientes_interacao_email_rua_a AS
SELECT c.cliente_id as id, c.nome, c.cidade, c.endereco, i.tipo_interacao 
FROM cap19.clientes c
INNER JOIN cap19.interacoes i
ON c.cliente_id = i.cliente_id
WHERE i.tipo_interacao = 'Email'
AND c.endereco LIKE '%Rua A%'

SELECT * FROM cap19.clientes_interacao_email_rua_a WHERE id > 280

--Nome, rua e cidade do cliente com a data da ultima interacao por email
SELECT * FROM cap19.clientes
SELECT * FROM cap19.interacoes
SELECT * FROM cap19.vendas

CREATE VIEW cap19.clientes_interacoes_resumo AS
SELECT c.nome, c.endereco, c.cidade, i.tipo_interacao, MAX(i.data_hora) as ultima_interacao
FROM cap19.clientes c INNER JOIN cap19.interacoes i 
ON c.cliente_id = i.cliente_id
WHERE i.tipo_interacao = 'Email'
GROUP BY c.nome, c.endereco, c.cidade, i.tipo_interacao
ORDER BY ultima_interacao DESC

SELECT * FROM cap19.clientes_interacoes_resumo

--clientes que realizaram compras nos ultimos 12 meses e tiveram mais de uma interacao no mesmo periodo
SELECT nome, count(nome) FROM (
SELECT nome, cliente, data FROM(
SELECT c.cliente_id as cliente, c.nome as nome, i.data_hora as data FROM cap19.clientes c
INNER JOIN cap19.interacoes i
ON c.cliente_id = i.cliente_id
ORDER BY data_hora DESC ) AS SUB
WHERE data >= (
	SELECT MAX(i2.data_hora) - INTERVAL '12 months' FROM cap19.interacoes i2
)) AS SUB_dois
GROUP BY nome
HAVING count(nome) > 1

SELECT c.cliente_id, c.nome, c.endereco, c.cidade, v.data_venda FROM cap19.clientes c
JOIN cap19.vendas v ON c.cliente_id = v.cliente_id
WHERE c.cliente_id IN (
SELECT
	v.cliente_id FROM cap19.vendas v WHERE v.data_venda >= DATE '2022-01-05' - INTERVAL '1year')
AND c.cliente_id IN (SELECT i.cliente_id FROM cap19.interacoes i WHERE i.data_hora >= DATE '2024-12-30' - INTERVAL '1year')
ORDER BY v.data_venda DESC