# SQL Para Análise de Dados e Data Science - Capítulo 09

-- Cria o schema no banco de dados
CREATE SCHEMA cap09 AUTHORIZATION dsa;

-- Criação da tabela Clientes
CREATE TABLE IF NOT EXISTS cap09.dsa_clientes (
    id_cli INT PRIMARY KEY,
    nome_cliente VARCHAR(50),
    tipo_cliente VARCHAR(50),
    cidade_cliente VARCHAR(50),
    estado_cliente VARCHAR(50));

-- Cria tabela de Produtos
CREATE TABLE IF NOT EXISTS cap09.dsa_produtos (
    id_prod INT PRIMARY KEY,
    nome_produto VARCHAR(100),
    nome_formacao VARCHAR(100)
);

-- Cria tabela de Pedidos
CREATE TABLE IF NOT EXISTS cap09.dsa_pedidos (
    id_pedido INT PRIMARY KEY,
    id_produto INT REFERENCES cap09.dsa_produtos(id_prod),
    data_pedido DATE NULL,
    valor_pedido DECIMAL(10, 2) NULL,
    id_cliente INT REFERENCES cap09.dsa_clientes(id_cli)
);

-- Carrega os dados na tabela de Clientes
INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1001, 'Machado de Assis', 'Diamante', 'Campinas', 'SP');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1002, 'Isaac Asimov', 'Ouro', 'Rio de Janeiro', 'RJ');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1003, 'Mark Twain', 'Prata', 'Rio de Janeiro', 'RJ');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1004, 'Edgar Allan Poe', 'Bronze', 'Porto Alegre', 'RS');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1005, 'Miguel de Cervantes', 'Diamante', 'Fortaleza', 'CE');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1006, 'Charles Dickens', 'Ouro', 'Campinas', 'SP');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1007, 'Virginia Woolf', 'Ouro', 'Natal', 'RN');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1008, 'William Shakespeare', 'Prata', 'Campinas', 'SP');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1009, 'Jane Austen', 'Bronze', 'Fortaleza', 'CE');

INSERT INTO cap09.dsa_clientes (id_cli, nome_cliente, tipo_cliente, cidade_cliente, estado_cliente) 
VALUES (1010, 'Fiódor Dostoiévski', 'Bronze', 'Blumenau', 'SC');

-- Carrega os dados na tabela de Produtos
INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10101, 'SQL Para Análise de Dados e Data Science', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10102, 'Projetos de Análise de Dados com Linguagem Python', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10103, 'Modelagem e Análise de Dados com Power BI', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10104, 'Pipelines de Análise e Engenharia de Dados com Google BigQuery', 'FADA 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10105, 'Arquitetura de Plataforma de Dados e Modern Data Stack', 'FAD 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10106, 'Pipelines de ETL e Machine Learning com Apache Spark', 'FAD 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10107, 'Orquestração de Fluxos de Dados com Apache Airflow', 'FAD 4.0');

INSERT INTO cap09.dsa_produtos (id_prod, nome_produto, nome_formacao) 
VALUES (10108, 'Projeto e Implementação de Plataforma de Dados com Snowflake', 'FAD 4.0');

-- Carrega os dados na tabela de Pedidos
INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0001, 10105, '2023-10-27', 1224.10, 1002);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0002, 10103, '2023-10-28', 1324.31, 1004);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0005, 10106, '2023-10-28', 1389.49, 1001);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0006, 10102, '2023-10-29', 1783.23, 1007);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0008, 10102, '2023-10-30', 1549.23, 1008);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0009, 10101, '2023-10-30', 1549.23, 1004);

INSERT INTO cap09.dsa_pedidos (id_pedido, id_produto, data_pedido, valor_pedido, id_cliente) 
VALUES (0010, 10108, '2023-10-30', 1549.23, 1005);

--Qual foi o total de valor pedido por produto ?
--Qual foi a media de valor por cliente ?
--Qual dos clientes fez a maior compra (maior pedido) ?
--Qual dos clientes fez a menor compra (menor pedido) ? 
--Qual cliente fez a maior compra por dia ?
--Qual cliente comprou mais por dia e por produto ?
