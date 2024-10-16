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
--16/10/2024:
-- Pergunta 1: Quantos clientes estão registrados por estado?
SELECT
	estado,
	COUNT(nome) as contagem_total
FROM cap05.clientes
GROUP BY estado
ORDER BY contagem_total;


-- Pergunta 2: Qual é a idade média dos clientes?
SELECT
	COUNT(nome) as total_clientes,
	ROUND(AVG(idade),0) as media_idade_clientes
	FROM(
		SELECT 
			nome, 
			EXTRACT(YEAR FROM data_nascimento) as ano_nascimento, 
			EXTRACT(YEAR FROM CURRENT_DATE) as ano_atual,
			(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento))  as idade
		FROM cap05.clientes
	) as SUBQUERY

SELECT ROUND(AVG(EXTRACT(YEAR FROM AGE(current_date, data_nascimento))),0) as media_idade
FROM cap05.clientes

-- Pergunta 3: Quantos clientes têm mais de 30 anos?
SELECT
	count(nome) as clientes_com_mais_de_30_anos
	FROM(
		SELECT 
			nome, 
			(EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento))  as idade
		FROM cap05.clientes
		WHERE ((EXTRACT(YEAR FROM CURRENT_DATE) - EXTRACT(YEAR FROM data_nascimento))) >30
	) as SUBQUERY
	
	
-- Pergunta 4: Quais são as 3 cidades com o maior número de clientes?
SELECT * FROM cap05.clientes where 1 = 0;
SELECT
	cidade,
	COUNT(nome) as total_clientes
FROM cap05.clientes
GROUP BY cidade
ORDER BY total_clientes DESC

-- Pergunta 5: Quantos clientes têm um endereço de e-mail registrado?
SELECT COUNT(email) as total_geral FROM cap05.clientes

SELECT COUNT(email) as total_com_email FROM(
	SELECT 
		nome, email
	FROM cap05.clientes
	WHERE email like '%@%'
) as SUBQUERY

SELECT 
    COUNT(*) AS total_geral,
    COUNT(CASE WHEN email != '' THEN 1 END) AS total_com_email,
    COUNT(CASE WHEN email = '' THEN 1 END) AS total_sem_email
FROM cap05.clientes;
