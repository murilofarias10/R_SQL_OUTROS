# SQL Para Análise de Dados e Data Science - Capítulo 05

-- Criando a tabela 'fornecedores'
CREATE TABLE cap05.fornecedores (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    cidade VARCHAR(255),
    estado VARCHAR(2),
    email VARCHAR(255),
    data_registro DATE
);

-- Inserindo registros na tabela 'funcionarios'
INSERT INTO cap05.fornecedores (nome, cidade, estado, email, data_registro) VALUES
('Fornecedor 1', 'São Paulo', 'SP', 'fornecedor1@exemplo.dsa.com', '2023-09-01'),
('Fornecedor 2', 'Rio de Janeiro', 'RJ', 'fornecedor2@exemplo.dsa.com', '2023-09-02'),
('Fornecedor 3', 'Belo Horizonte', 'MG', 'fornecedor3@exemplo.dsa.com', '2023-09-03'),
('Fornecedor 4', 'Porto Alegre', 'RS', 'fornecedor4@exemplo.dsa.com', '2023-09-04'),
('Fornecedor 5', 'Curitiba', 'PR', 'fornecedor5@exemplo.dsa.com', '2023-09-05'),
('Fornecedor 6', 'Recife', 'PE', 'fornecedor6@exemplo.dsa.com', '2023-09-06'),
('Fornecedor 7', 'Salvador', 'BA', 'fornecedor7@exemplo.dsa.com', '2023-10-07'),
('Fornecedor 8', 'Fortaleza', 'CE', 'fornecedor8@exemplo.dsa.com', '2023-10-08'),
('Fornecedor 9', 'Goiânia', 'GO', 'fornecedor9@exemplo.dsa.com', '2023-10-09'),
('Fornecedor 10', 'Manaus', 'AM', 'fornecedor10@exemplo.dsa.com', '2023-10-10');

--18/10/2024
# Use SQL para responder às perguntas abaixo:
-- Pergunta 1: Qual é a quantidade de fornecedores por estado?
SELECT 
	estado,
	COUNT(*) as quantidade_total
FROM cap05.fornecedores
GROUP BY estado;
	
-- Pergunta 2: Qual é o estado com o maior número de fornecedores?
SELECT 
	estado,
	COUNT(nome) as quantidade_total
FROM cap05.fornecedores
GROUP BY estado
ORDER BY quantidade_total DESC

-- Pergunta 3: Quantos fornecedores foram registrados no mês de Setembro de 2023?
SELECT 
	COUNT(EXTRACT(MONTH FROM data_registro)) as total_registro_mes_9
	FROM cap05.fornecedores
	WHERE EXTRACT(MONTH FROM data_registro) = 9

SELECT SUM(total_registros) as total_mes_9
FROM(
		SELECT
			EXTRACT(MONTH FROM data_registro) as mes,
			COUNT(nome) as total_registros
			FROM cap05.fornecedores
		WHERE EXTRACT(MONTH FROM data_registro) = 09
		GROUP BY data_registro
) AS SUBQUERY

-- Pergunta 4: Qual é a média de registros de fornecedores por mês?
SELECT
	ROUND(SUM(contagem)/COUNT(contagem),2) as media_por_mes
	FROM(
		SELECT
			EXTRACT(MONTH FROM data_registro),
			COUNT(nome) as contagem
		FROM cap05.fornecedores
		GROUP BY EXTRACT(MONTH FROM data_registro)
	) as SUBQUERY

SELECT
	ROUND(AVG(contagem),2) as media
	FROM(
		SELECT
			EXTRACT(MONTH FROM data_registro),
			COUNT(nome) as contagem
		FROM cap05.fornecedores
		GROUP BY EXTRACT(MONTH FROM data_registro)
	) as SUBQUERY
	
-- Pergunta 5: Qual é o fornecedor mais recente registrado?
SELECT nome, data_registro 
FROM cap05.fornecedores
ORDER BY data_registro DESC LIMIT 1;

SELECT nome, data_registro
FROM cap05.fornecedores
WHERE data_registro = (SELECT MAX(data_Registro) FROM cap05.fornecedores)

-- Pergunta 1: Qual é a quantidade de fornecedores por estado?
SELECT
	estado,
	COUNT(estado) as quantidade_fornecedores
FROM cap05.fornecedores
GROUP BY estado
ORDER BY quantidade_fornecedores DESC;

-- Pergunta 2: Qual é o estado com o maior número de fornecedores?

SELECT
	estado,
	COUNT(estado) as quantidade_fornecedores
FROM cap05.fornecedores
GROUP BY estado
ORDER BY quantidade_fornecedores DESC;

-- Pergunta 3: Quantos fornecedores foram registrados no mês de Setembro de 2023?
SELECT
	COUNT(nome) AS registrados_set
FROM cap05.fornecedores
WHERE 
	EXTRACT(MONTH FROM data_registro) = 09
	AND
	EXTRACT(YEAR FROM data_registro) = 2023

-- Pergunta 4: Qual é a média de registros de fornecedores por mês?
--SOMATORIA DA CONTAGEM DE FORNECEDOR POR MES/CONTAGEM DISTINTA DE MES

SELECT * FROM cap05.fornecedores;
	
SELECT
	ROUND(SUM(contagem_mes)/COUNT(mes),0)
	FROM(
		SELECT
			DISTINCT EXTRACT(MONTH FROM data_registro) as mes,
    		COUNT(nome) AS contagem_mes
			FROM cap05.fornecedores
			GROUP BY DISTINCT EXTRACT(MONTH FROM data_registro)
		) AS subquerie;

-- Pergunta 5: Qual é o fornecedor mais recente registrado?

SELECT
    nome,
    data_registro,
    CURRENT_DATE AS data_atual,
	CURRENT_DATE - data_registro as diferença
FROM cap05.fornecedores
ORDER BY data_registro DESC
LIMIT 1;

SELECT
    nome,
	data_registro,
	diferença
FROM (
    SELECT
        nome,
        data_registro,
        CURRENT_DATE AS data_atual,
        CURRENT_DATE - data_registro as diferença
    FROM cap05.fornecedores
    ORDER BY data_registro DESC
) AS subconsulta
WHERE diferença = (
    SELECT MIN(diferença) FROM (
        SELECT
            CURRENT_DATE - data_registro as diferença
        FROM cap05.fornecedores
    ) AS subconsulta2
);
