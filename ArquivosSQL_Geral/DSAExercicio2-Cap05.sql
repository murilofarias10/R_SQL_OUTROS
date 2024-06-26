# SQL Para Análise de Dados e Data Science - Capítulo 05


-- Criando a tabela 'clientes'
CREATE TABLE cap05.clientes (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    email VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    data_nascimento DATE
);


-- Inserindo registros na tabela 'clientes'
INSERT INTO cap05.clientes (nome, email, cidade, estado, data_nascimento) VALUES
('Carlos Silva', 'carlos.silva@exemplo.dsa.com', 'São Paulo', 'SP', '1980-05-15'),
('Maria Oliveira', 'maria.oliveira@exemplo.dsa.com', 'Rio de Janeiro', 'RJ', '1990-08-20'),
('João Pereira', 'joao.pereira@exemplo.dsa.com', 'Belo Horizonte', 'MG', '1985-11-30'),
('Ana Santos', '', 'Curitiba', 'PR', '1975-02-28'),
('Paulo Souza', 'paulo.souza@exemplo.dsa.com', 'Porto Alegre', 'RS', '1995-06-10'),
('Fernanda Barbosa', '', 'Salvador', 'BA', '1983-07-15'),
('Rodrigo Lima', 'rodrigo.lima@exemplo.dsa.com', 'Recife', 'PE', '1988-12-05'),
('Aline Teixeira', '', 'Fortaleza', 'CE', '1992-04-18'),
('Renato Gonçalves', 'renato.goncalves@exemplo.dsa.com', 'Goiânia', 'GO', '1978-09-12'),
('Patrícia Alves', 'patricia.alves@exemplo.dsa.com', 'São Luís', 'MA', '1987-03-22'),
('Ricardo Martins', 'ricardo.martins@exemplo.dsa.com', 'Natal', 'RN', '1993-01-19'),
('Sandra Ferreira', 'sandra.ferreira@exemplo.dsa.com', 'João Pessoa', 'PB', '1970-10-31'),
('Thiago Correia', 'thiago.correia@exemplo.dsa.com', 'Aracaju', 'SE', '1996-08-07'),
('Fábio Azevedo', 'fabio.azevedo@exemplo.dsa.com', 'Maceió', 'AL', '1982-05-21'),
('Juliana Castro', 'juliana.castro@exemplo.dsa.com', 'Teresina', 'PI', '1989-06-14');


# Use SQL para responder às perguntas abaixo:
-- Pergunta 1: Quantos clientes estão registrados por estado?
SELECT
	estado, COUNT(nome) as total
FROM cap05.clientes
GROUP BY estado;

-- Pergunta 2: Qual é a idade média dos clientes?
SELECT
	nome,
	EXTRACT(YEAR FROM data_nascimento),
	EXTRACT(YEAR FROM CURRENT_DATE) AS ano_atual,
	EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) as idade
FROM cap05.clientes;


SELECT
	ROUND(AVG(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento)),0) as media_idade
FROM cap05.clientes;

SELECT ROUND(AVG(EXTRACT(YEAR FROM (AGE(current_date, data_nascimento)))),0) as idade
FROM cap05.clientes;

-- Pergunta 3: Quantos clientes têm mais de 30 anos?
SELECT
	COUNT(nome)
FROM cap05.clientes
WHERE EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento) > 30;

-- Pergunta 4: Quais são as 3 cidades com o maior número de clientes?
SELECT
	cidade,
	COUNT(cidade)
FROM cap05.clientes
GROUP BY cidade
ORDER BY cidade
LIMIT 3;

-- Pergunta 5: Quantos clientes têm um endereço de e-mail registrado?
SELECT
	count(email) as total
FROM(
SELECT
    email,
    COUNT(email)
FROM cap05.clientes
WHERE 
	email IS NOT NULL AND email != ''
GROUP BY email
	) AS subquerie





