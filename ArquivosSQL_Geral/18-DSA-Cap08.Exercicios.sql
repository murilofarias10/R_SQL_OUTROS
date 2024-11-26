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

SELECT vend.id_livro, aut.nome as autor, liv.titulo as livro_vendido
FROM cap08.livros_vendidos vend
LEFT JOIN cap08.livros liv USING (id_livro)
LEFT JOIN cap08.autores aut USING (id_autor)

-- Exercício 2: Liste todos os autores e seus respectivos livros, incluindo autores que não têm livros cadastrados.

SELECT 
	aut.nome as autor, 
	CASE WHEN liv.titulo IS NULL THEN 'TBD' ELSE (liv.titulo) END as titulo
FROM cap08.autores aut
LEFT JOIN cap08.livros_vendidos venda USING (id_autor)
LEFT JOIN cap08.livros liv ON liv.id_livro = venda.id_livro

-- Exercício 3: Liste todos os livros e seus respectivos autores, incluindo livros que não têm autores cadastrados.
SELECT 
	liv.titulo as livros,
	CASE WHEN aut.nome IS NULL THEN 'TBD' ELSE (aut.nome) END as autores
FROM cap08.livros liv
LEFT JOIN cap08.livros_vendidos venda USING(id_livro)
LEFT JOIN cap08.autores aut ON aut.id_autor = venda.id_autor

-- Exercício 4: Liste os autores que nasceram antes de 1970 e os livros que eles escreveram.
SELECT 
	aut.nome as autor, EXTRACT(YEAR FROM aut.data_nascimento) as ano_nascimento, 
	CASE WHEN lv.titulo IS NULL THEN 'TBD' ELSE (lv.titulo) END as titulo_livro
FROM cap08.autores aut
LEFT JOIN cap08.livros_vendidos venda USING (id_autor)
LEFT JOIN cap08.livros lv ON venda.id_livro = lv.id_livro
WHERE EXTRACT(YEAR FROM aut.data_nascimento) < 1970

-- Exercício 5: Liste os livros publicados após 2017, incluindo os que não têm autores associados.
SELECT 
	lv.titulo as nome_livro, lv.ano_publicacao, 
	CASE WHEN aut.nome IS NULL THEN 'TBD' ELSE (aut.nome) END AS nome_autor
FROM cap08.livros lv
LEFT JOIN cap08.livros_vendidos venda USING(id_livro)
LEFT JOIN cap08.autores aut ON aut.id_autor = venda.id_autor
WHERE lv.ano_publicacao >=2017
ORDER BY lv.ano_publicacao DESC


