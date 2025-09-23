SELECT * FROM cap19.clientes
SELECT * FROM cap19.interacoes
SELECT * FROM cap19.vendas

--retorne id, nome e cidade dos clientes que tiveram interação por email e que moram na RUA A
CREATE VIEW cap19.clientes_interacao_email_rua_a AS
SELECT c.cliente_id as id, c.nome, c.cidade, c.endereco, i.tipo_interacao 
FROM cap19.clientes c
INNER JOIN cap19.interacoes i
ON c.cliente_id = i.cliente_id
WHERE i.tipo_interacao = 'Email'
AND c.endereco LIKE '%Rua A%'

SELECT * FROM cap19.clientes_interacao_email_rua_a