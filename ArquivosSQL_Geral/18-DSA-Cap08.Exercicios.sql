# SQL Para Análise de Dados e Data Science - Capítulo 08

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
