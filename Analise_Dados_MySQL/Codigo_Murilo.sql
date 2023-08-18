-- Utilizando o MySQL durante o curso da DSA enquanto o professor esta utilizando o SQLite
-- Criando Table

CREATE TABLE TB_DSA_CLIENTES (
    ID_Cliente TEXT,
    Nome_Cliente TEXT,
    Cidade TEXT,
    Estado TEXT,
    Pais TEXT,
    Regiao TEXT,
    Mercado TEXT,
    Segmento TEXT,
    PRIMARY KEY (ID_Cliente(255))
);

DELETE FROM TB_DSA_CLIENTES;


CREATE TABLE TB_DSA_PEDIDOS (
    ID_Pedido TEXT,
    Ano INT,
    Mes TEXT,
    Dia INT,
    Modo_Envio TEXT,
    Prioridade_Pedido TEXT,
    PRIMARY KEY (ID_Pedido(255))
);

CREATE TABLE TB_DSA_PRODUTOS (
    ID_Produto VARCHAR(255),
    Nome_Produto TEXT,
    Categoria TEXT,
    SubCategoria TEXT,
    PRIMARY KEY (ID_Produto)
);

CREATE TABLE TB_DSA_VENDAS (
    Pedido VARCHAR(255),
    Produto VARCHAR(255),
    Cliente VARCHAR(255),
    Quantidade_Vendida INT,
    Valor_Venda DECIMAL(10, 3),
    Custo_Envio DECIMAL(10, 2),
    PRIMARY KEY (Pedido, Produto, Cliente)
);

drop table TB_DSA_TESTE;
-- CLIENTES 1
drop table TB_DSA_CLIENTES;
-- limpando a tabela de pedidos
DELETE FROM TB_DSA_CLIENTES;

select * from TB_DSA_CLIENTES;
select * from TB_DSA_PEDIDOS;
select * from TB_DSA_PRODUTOS;
select * from TB_DSA_VENDAS;


-- FOI CARREGADO AS PLANILHAS CSV PARA POULAR AS TABELAS
INSERT INTO TB_DSA_CLIENTES (ID_Cliente, Nome_Cliente, Cidade, Estado, Pais, Regiao, Mercado, Segmento)
VALUES
    ('AA-10315', 'Alex Avila', 'Round Rock', 'Texas', 'United States', 'Central', 'US', 'Consumidor');


SELECT COUNT(ID_Cliente) FROM TB_DSA_CLIENTES;
SELECT COUNT(ID_Pedido) FROM TB_DSA_PEDIDOS;

-- usando comando SELECT
select * from tb_dsa_clientes;
select Nome_Cliente, id_cliente, Cidade from tb_dsa_clientes;
select Cidade from tb_dsa_clientes;

-- usando o LIMIT
select * from tb_dsa_clientes 
limit 10;

-- usando o DISTINCT
select distinct segmento from tb_dsa_clientes;
select distinct mercado from tb_dsa_clientes;

select distinct Ano from tb_dsa_pedidos order by Ano;

-- usando o WHERE
select * from tb_dsa_pedidos where Ano = 2014;
select count(ID_Pedido) from tb_dsa_pedidos where Ano = 2014;

select Ano, Count(Ano) from tb_dsa_pedidos group by Ano order by Ano;
Select count(Ano) from tb_dsa_pedidos;


-- operadores de COMPARAÇÃO 
Select * from tb_dsa_vendas limit 10;
select * from tb_dsa_vendas where Quantidade_Vendida = 5;
select count(Pedido) from tb_dsa_vendas where Quantidade_Vendida = 5;

select count(Pedido) from tb_dsa_vendas where Quantidade_Vendida <=2;

select count(Pedido) from tb_dsa_vendas where Quantidade_Vendida between 2 and 5;

SELECT Quantidade_Vendida, COUNT(Quantidade_Vendida) 
FROM tb_dsa_vendas 
WHERE Quantidade_Vendida BETWEEN 2 AND 5 
GROUP BY Quantidade_Vendida 
ORDER BY Quantidade_Vendida;

select * from tb_dsa_vendas where Quantidade_Vendida = 2 and Valor_Venda > 900;

select * from tb_dsa_vendas 
where Quantidade_Vendida between 2 and 5 and Valor_Venda > 900;

select Quantidade_Vendida, count(Quantidade_Vendida) from tb_dsa_vendas 
where Quantidade_Vendida between 2 and 5 and Valor_Venda > 900 
group by Quantidade_Vendida
order by Quantidade_Vendida;

select * from tb_dsa_vendas
where Quantidade_Vendida = 1 OR Valor_Venda between 4799 and 4800
order by Valor_Venda desc;

SELECT distinct Valor_Venda, Quantidade_Vendida
FROM tb_dsa_vendas where Quantidade_Vendida = 2
ORDER BY Quantidade_Vendida, Valor_Venda DESC ;


SELECT COUNT(DISTINCT ID_Cliente) FROM tb_dsa_clientes;

/* OPERADORES DE COMPARAÇÂO
Igual (=): Compara se dois valores são iguais.
Diferente (<> ou !=): Compara se dois valores são diferentes.
Maior que (>): Verifica se um valor é maior do que outro.
Menor que (<): Verifica se um valor é menor do que outro.
Maior ou igual que (>=): Verifica se um valor é maior ou igual a outro.
Menor ou igual que (<=): Verifica se um valor é menor ou igual a outro.
Comparação de nulos (IS NULL e IS NOT NULL): Verifica se um valor é nulo ou não nulo.
Comparação de intervalos (BETWEEN): Verifica se um valor está dentro de um intervalo especificado.
Comparação de listas (IN): Verifica se um valor está em uma lista de valores especificada.
Negativo da comparação (NOT): Inverte o resultado da comparação

OPERADORES LOGICOS
AND: Retorna verdadeiro se todas as condições forem verdadeiras.
OR: Retorna verdadeiro se pelo menos uma das condições for verdadeira.
NOT: Inverte o valor de verdadeiro para falso e vice-versa.
XOR: Retorna verdadeiro se exatamente uma das condições for verdadeira e as outras forem falsas.
*/


SELECT ID_Cliente, COUNT(ID_Cliente) FROM tb_dsa_clientes 
GROUP BY ID_Cliente 
ORDER by ID_Cliente;


-- utilizando o LIKE
select * from tb_dsa_produtos limit 10;

select * from tb_dsa_produtos
where Nome_Produto like '%clock%' or
Nome_Produto	like '%Eldon%'
limit 10;

select * from tb_dsa_produtos 
where Nome_Produto like '%clock%';

-- operador SQL in

select distinct Categoria
from tb_dsa_produtos;

select * from tb_dsa_produtos
where Categoria IN ('Moveis', 'Tecnologia');

select * from tb_dsa_produtos
where Categoria not IN ('Moveis', 'Tecnologia');

select distinct Categoria, count(Categoria) from tb_dsa_produtos
where Categoria IN ('Moveis', 'Tecnologia')
group by Categoria;

select distinct Categoria, count(Categoria) from tb_dsa_produtos
where Categoria not IN ('Moveis', 'Tecnologia')
group by Categoria;

select count(Categoria) from tb_dsa_produtos;

select distinct Categoria, count(Categoria) from tb_dsa_produtos
group by Categoria;

-- operador oderder by
select * from tb_dsa_produtos
order by Nome_Produto desc;

-- MIN MAX AVR COUNT SUM

-- menor valor de venda 0.556
select * from tb_dsa_vendas
order by Valor_Venda;
select min(Valor_Venda) from tb_dsa_vendas;

-- maior valor de venda 22638.480
select * from tb_dsa_vendas
order by Valor_Venda desc;
select max(Valor_Venda) from tb_dsa_vendas;

-- media valor venda 279.66
select avg(Valor_Venda) from tb_dsa_vendas;
select sum(Valor_Venda) /count(Valor_Venda) from tb_dsa_vendas;

select * from tb_dsa_vendas where Pedido = 'CA-2014-127180';

-- soma total valor venda 8389639.029
select sum(Valor_Venda) from tb_dsa_vendas;

-- quantidade total  vendas 29999
select count(Valor_Venda) from tb_dsa_vendas;

-- moda 12,96
select Valor_Venda, count(Valor_Venda) from tb_dsa_vendas
group by Valor_Venda
order by count(Valor_Venda) desc;

-- mediana 3.13
SELECT
    IF(COUNT(*) % 2 = 1,
       SUBSTRING_INDEX(
           SUBSTRING_INDEX(
               GROUP_CONCAT(Valor_Venda ORDER BY Valor_Venda), ',', (COUNT(*) + 1) / 2
           ),
           ',', -1
       ),
       (SUBSTRING_INDEX(
            SUBSTRING_INDEX(
                GROUP_CONCAT(Valor_Venda ORDER BY Valor_Venda), ',', COUNT(*) / 2
            ),
            ',', -1
        ) + SUBSTRING_INDEX(
            SUBSTRING_INDEX(
                GROUP_CONCAT(Valor_Venda ORDER BY Valor_Venda), ',', (COUNT(*) / 2) + 1
            ),
            ',', -1
        )) / 2
    ) AS Mediana
FROM tb_dsa_vendas;

select distinct Produto, 
min(Valor_Venda) as minimo,
max(Valor_Venda) as maximo,
avg(Valor_Venda) as media,
sum(Valor_Venda) as soma,
count(Valor_Venda) as contagem
from tb_dsa_vendas
group by Produto
order by contagem desc;

select Produto, count(Produto) as contagem from tb_dsa_vendas
group by Produto
order by contagem desc;

select distinct Produto, 
min(Valor_Venda) as minimo,
max(Valor_Venda) as maximo,
avg(Valor_Venda) as media,
sum(Valor_Venda) as soma,
count(Valor_Venda) as contagem
from tb_dsa_vendas where Produto = 'FUR-ADV-10001440';

select distinct Produto, 
	round(min(Valor_Venda),2) as minimo,
	round(max(Valor_Venda),2) as maximo,
	round(avg(Valor_Venda),2) as media,
	round(sum(Valor_Venda),2) as soma,
	round(count(Valor_Venda),2) as contagem
from tb_dsa_vendas
group by Produto
order by contagem desc;

-- JOIN unir registros de tabelas
SELECT P.Nome_Produto AS NomeProduto,
       V.Produto,
       ROUND(MIN(V.Valor_Venda), 2) AS minimo,
       ROUND(MAX(V.Valor_Venda), 2) AS maximo,
       ROUND(AVG(V.Valor_Venda), 2) AS media,
       ROUND(SUM(V.Valor_Venda), 2) AS soma,
       ROUND(COUNT(V.Valor_Venda), 2) AS contagem
FROM TB_DSA_VENDAS V
JOIN TB_DSA_PRODUTOS P ON V.Produto = P.ID_Produto
GROUP BY P.Nome_Produto, V.Produto
ORDER BY contagem DESC;

Select 
	Nome_Produto, 
	Produto as Codido_Produto,
    Ano,
       ROUND(MIN(Valor_Venda), 2) AS minimo,
       ROUND(MAX(Valor_Venda), 2) AS maximo,
       ROUND(AVG(Valor_Venda), 2) AS media,
       ROUND(SUM(Valor_Venda), 2) AS soma,
       ROUND(COUNT(Valor_Venda), 2) AS contagem
from tb_dsa_produtos, tb_dsa_vendas, tb_dsa_pedidos
where tb_dsa_produtos.ID_Produto = tb_dsa_vendas.Produto and
tb_dsa_pedidos.ID_Pedido = tb_dsa_vendas.Pedido
group by Produto;

select * from tb_dsa_vendas;
select * from tb_dsa_produtos;
select * from tb_dsa_pedidos;

SELECT 
    produto.Nome_Produto, 
    produto.ID_Produto AS Codigo_Produto,
    pedidos.Ano,
    ROUND(MIN(vendas.Valor_Venda), 2) AS minimo,
    ROUND(MAX(vendas.Valor_Venda), 2) AS maximo,
    ROUND(AVG(vendas.Valor_Venda), 2) AS media,
    ROUND(SUM(vendas.Valor_Venda), 2) AS soma,
    COUNT(vendas.Valor_Venda) AS contagem
FROM tb_dsa_produtos produto
INNER JOIN tb_dsa_vendas vendas ON produto.ID_Produto = vendas.Produto
INNER JOIN tb_dsa_pedidos pedidos ON vendas.Pedido = pedidos.ID_Pedido
GROUP BY produto.Nome_Produto, produto.ID_Produto, pedidos.Ano
ORDER BY contagem desc, pedidos.Ano asc;

select * from tb_dsa_pedidos where ID_Pedido = 'AE-2011-9160';

-- update table
update  tb_dsa_pedidos
SET Ano = 2014 
where ID_Pedido = 'AE-2011-9160';