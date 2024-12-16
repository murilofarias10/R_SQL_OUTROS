# SQL Para Análise de Dados e Data Science - Capítulo 08

CREATE SCHEMA cap08;

-- Criação da tabela Autores
CREATE TABLE cap08.autores (
    id_autor SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    data_nascimento DATE
);

-- Criação da tabela Livros
CREATE TABLE cap08.livros (
    id_livro SERIAL PRIMARY KEY,
    titulo VARCHAR(255) NOT NULL,
    ano_publicacao INT
);

-- Criação da tabela LivrosAutores
CREATE TABLE cap08.livros_vendidos (
    id_livro INT NOT NULL REFERENCES cap08.livros(id_livro),
    id_autor INT NOT NULL REFERENCES cap08.autores(id_autor),
    PRIMARY KEY (id_livro, id_autor)
);

-- Inserindo registros na tabela de autores
INSERT INTO cap08.autores (nome, data_nascimento) VALUES
('Yuval Noah Harari', '1976-02-24'),
('Leonard Mlodinow', '1954-11-26'),
('Dale Carnegie', '1888-11-24'),
('Stephen R. Covey', '1932-10-24');

-- Inserindo registros na tabela de livros
INSERT INTO cap08.livros (titulo, ano_publicacao) VALUES
('Sapiens - Uma breve história da humanidade', 2020),
('21 lições para o século 21', 2018),
('O andar do bêbado: Como o acaso determina nossas vidas', 2018),
('Uma breve história do tempo', 2015),
('Os 7 Hábitos das Pessoas Altamente Eficazes', 2017);

-- Inserindo registros na tabela de LivrosAutores
INSERT INTO cap08.livros_vendidos (id_livro, id_autor) VALUES
(1, 1), 
(3, 2), 
(5, 4); 

-- Responda as perguntas abaixo:
-- Exercício 1: Liste todos os livros vendidos e seus respectivos autores.
SELECT vend.id_livro, aut.nome as autor, liv.titulo as titulo
FROM cap08.livros_vendidos vend
INNER JOIN cap08.livros liv USING (id_livro)
INNER JOIN cap08.autores aut USING (id_autor)

-- Exercício 2: Liste todos os autores e seus respectivos livros, incluindo autores que não têm livros cadastrados.
SELECT 
	aut.id_autor as id,
	aut.nome as autor, 
	CASE WHEN liv.titulo IS NULL THEN 'TBD' ELSE (liv.titulo) END as titulo
FROM cap08.autores aut
LEFT JOIN cap08.livros_vendidos venda USING (id_autor)
LEFT JOIN cap08.livros liv ON liv.id_livro = venda.id_livro
ORDER BY aut.id_autor

--usando o case ou o COALESCE
SELECT aut.nome AS "nome do autor", COALESCE(liv.titulo, 'TBD') AS "nome do livro"
FROM cap08.autores aut
LEFT JOIN cap08.livros_vendidos lv ON aut.id_autor = lv.id_autor
LEFT JOIN cap08.livros liv ON liv.id_livro = lv.id_livro

-- Exercício 3: Liste todos os livros e seus respectivos autores, incluindo livros que não têm autores cadastrados.
SELECT 
	liv.id_livro,
	liv.titulo as livros,
	CASE WHEN aut.nome IS NULL THEN 'TBD' ELSE (aut.nome) END as autores
FROM cap08.livros liv
LEFT JOIN cap08.livros_vendidos venda USING(id_livro)
LEFT JOIN cap08.autores aut ON aut.id_autor = venda.id_autor

--usando o case ou o COALESCE
SELECT liv.titulo as "Nome do Livro", COALESCE (aut.nome, 'TBD') AS "Nome do Autor"
FROM cap08.autores aut
RIGHT JOIN cap08.livros_vendidos lv ON aut.id_autor = lv.id_autor
RIGHT JOIN cap08.livros liv ON liv.id_livro = lv.id_livro

-- Exercício 4: Liste os autores que nasceram antes de 1970 e os livros que eles escreveram (e que foram vendidos)
SELECT 
	aut.id_autor, aut.nome as autor, EXTRACT(YEAR FROM aut.data_nascimento) as ano_nascimento, 
	CASE WHEN lv.titulo IS NULL THEN 'TBD' ELSE (lv.titulo) END as titulo_livro
FROM cap08.autores aut
INNER JOIN cap08.livros_vendidos venda USING (id_autor)
INNER JOIN cap08.livros lv ON venda.id_livro = lv.id_livro
WHERE EXTRACT(YEAR FROM aut.data_nascimento) < '1970'

SELECT a.nome AS "Nome do Autor", l.titulo As "Nome do livro", a.data_nascimento
FROM cap08.autores a
INNER JOIN cap08.livros_vendidos la USING(id_autor)
INNER JOIN cap08.livros l USING (id_livro)
WHERE a.data_nascimento < '1970-01-01'

-- Exercício 5: Liste os livros publicados após 2017, incluindo os que não têm autores associados.
SELECT 
	lv.titulo as nome_livro, lv.ano_publicacao, 
	CASE WHEN aut.nome IS NULL THEN 'TBD' ELSE (aut.nome) END AS nome_autor
FROM cap08.livros lv
LEFT JOIN cap08.livros_vendidos venda USING(id_livro)
LEFT JOIN cap08.autores aut ON aut.id_autor = venda.id_autor
WHERE lv.ano_publicacao >2017
ORDER BY lv.ano_publicacao DESC

-- Usando COALESCE
SELECT lv.titulo AS "Nome do livro", COALESCE (aut.nome, 'TBD') AS "Nome do Autor"
FROM cap08.livros lv
LEFT JOIN cap08.livros_vendidos AS lvend USING(id_livro)
LEFT JOIN cap08.autores AS aut ON aut.id_autor = lvend.id_autor
WHERE lv.ano_publicacao > 2017

-- Criação da tabela Clientes
CREATE TABLE cap08.clientes (
    id_cliente SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    sobrenome VARCHAR(100) NOT NULL,
    estado VARCHAR(50) NOT NULL,
    tipo VARCHAR(20) CHECK (tipo IN ('pessoa física', 'pessoa jurídica')) NOT NULL
);


-- Criação da tabela Produtos
CREATE TABLE cap08.produtos (
    id_produto SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    categoria VARCHAR(100) NOT NULL,
    preco DECIMAL(10, 2) NOT NULL
);


-- Criação da tabela Pedidos com Integridade Referencial
CREATE TABLE cap08.pedidos (
    id_pedido SERIAL PRIMARY KEY,
    id_produto INT NOT NULL,
    id_cliente INT NOT NULL,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    data_pedido DATE NOT NULL,
    FOREIGN KEY (id_cliente) REFERENCES cap08.clientes(id_cliente),
    FOREIGN KEY (id_produto) REFERENCES cap08.produtos(id_produto)
);


-- Criação da tabela Pedidos sem Integridade Referencial
CREATE TABLE cap08.pedidos_sem_ir (
    id_pedido SERIAL PRIMARY KEY,
    id_produto INT,
    id_cliente INT,
    quantidade INT NOT NULL CHECK (quantidade > 0),
    data_pedido DATE NOT NULL
);


-- Inserindo registros na tabela de clientes
INSERT INTO cap08.clientes (nome, sobrenome, estado, tipo) VALUES
('João', 'Silva', 'SP', 'pessoa física'),
('Maria', 'Oliveira', 'RJ', 'pessoa física'),
('Empresa A', 'Ltda', 'MG', 'pessoa jurídica'),
('Empresa B', 'S.A.', 'SP', 'pessoa jurídica'),
('Lucas', 'Pereira', 'RJ', 'pessoa física'),
('Ana', 'Mendes', 'MG', 'pessoa física'),
('Carla', 'Dias', 'SC', 'pessoa física'),
('Roberto', 'Almeida', 'MT', 'pessoa física'),
('Empresa C', 'Inc.', 'SP', 'pessoa jurídica'),
('Felipe', 'Costa', 'BA', 'pessoa física');


-- Inserindo registros na tabela de produtos
INSERT INTO cap08.produtos (nome, categoria, preco) VALUES
('Produto A', 'Categoria 1', 10.99),
('Produto B', 'Categoria 1', 5.50),
('Produto C', 'Categoria 2', 7.80),
('Produto D', 'Categoria 3', 8.90),
('Produto E', 'Categoria 2', 6.40),
('Produto F', 'Categoria 1', 9.60),
('Produto G', 'Categoria 3', 11.30),
('Produto H', 'Categoria 2', 4.70),
('Produto I', 'Categoria 3', 3.20),
('Produto J', 'Categoria 1', 12.10);


-- Inserindo registros na tabela de pedidos com integridade referencial
-- (Para simplificar, estou supondo que os IDs gerados para os clientes e produtos são sequenciais a partir de 1)
INSERT INTO cap08.pedidos (id_produto, id_cliente, quantidade, data_pedido) VALUES
(1, 1, 20, '2023-10-01'),
(1, 2, 12, '2023-10-02'),
(3, 2, 15, '2023-10-03'),
(4, 4, 44, '2023-10-04'),
(3, 1, 34, '2023-10-05'),
(3, 6, 16, '2023-10-06'),
(6, 7, 21, '2023-10-07'),
(8, 7, 42, '2023-10-08'),
(1, 9, 35, '2023-10-09'),
(9, 7, 59, '2023-10-10');


-- Inserindo registros na tabela de pedidos sem integridade referencial
INSERT INTO cap08.pedidos_sem_ir (id_produto, id_cliente, quantidade, data_pedido) VALUES
(1, 1, 20, '2023-10-01'),
(1, 2, 12, '2023-10-02'),
(null, null, 15, '2023-10-03'),
(4, 4, 44, '2023-10-04'),
(null, 1, 34, '2023-10-05'),
(3, null, 16, '2023-10-06'),
(6, 7, 21, '2023-10-07'),
(8, 7, 42, '2023-10-08'),
(123, 9, 35, '2023-10-09'),
(9, 7, 59, '2023-10-10');