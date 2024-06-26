# SQL Para Análise de Dados e Data Science - Capítulo 05


-- Cria o schema no banco de dados
CREATE SCHEMA cap05 AUTHORIZATION dsa;


-- Cria a tabela
CREATE TABLE cap05.dsa_vendas (
    ID_Venda SERIAL PRIMARY KEY,
    Data_Venda DATE NOT NULL,
    Nome_Produto VARCHAR(255) NOT NULL,
    Categoria_Produto VARCHAR(255) NOT NULL,
    Unidades_Vendidas INT NOT NULL,
    Valor_Unitario_Venda DECIMAL(10, 2) NOT NULL
);


-- Carrega os dados
INSERT INTO cap05.dsa_vendas (Data_Venda, Nome_Produto, Categoria_Produto, Unidades_Vendidas, Valor_Unitario_Venda) VALUES
('2023-08-01', 'Produto A', 'Categoria 1', 5, 10.50),
('2023-08-01', 'Produto B', 'Categoria 1', 3, 15.00),
('2023-09-01', 'Produto C', 'Categoria 2', 4, 12.75),
('2023-09-02', 'Produto D', 'Categoria 3', 2, 20.00),
('2023-09-02', 'Produto E', 'Categoria 3', 6, 18.50),
('2023-09-10', 'Produto A', 'Categoria 1', 7, 10.50),
('2023-10-01', 'Produto B', 'Categoria 1', 2, 15.00),
('2023-10-03', 'Produto C', 'Categoria 2', 5, 12.75),
('2023-10-04', 'Produto D', 'Categoria 3', 3, 20.00),
('2023-11-01', 'Produto C', 'Categoria 3', 3, 21.00),
('2023-11-07', 'Produto D', 'Categoria 3', 3, 20.00),
('2023-11-11', 'Produto A', 'Categoria 2', 1, 17.50),
('2023-11-12', 'Produto B', 'Categoria 1', 5, 19.50),
('2023-11-14', 'Produto A', 'Categoria 2', 5, 12.50),
('2023-11-16', 'Produto E', 'Categoria 3', 7, 14.50);



