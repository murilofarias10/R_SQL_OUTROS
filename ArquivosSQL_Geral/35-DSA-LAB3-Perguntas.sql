--Crie uma query que identifique o total de valores susentes em todas as colunas
SELECT 
	SUM(CASE WHEN id IS NULL THEN 1 ELSE 0 END) as ID,
	SUM(CASE WHEN nome_campanha IS NULL THEN 1 ELSE 0 END) as nome_campanha,
	SUM(CASE WHEN data_fim IS NULL THEN 1 ELSE 0 END) as data_fim,
	SUM(CASE WHEN orcamento IS NULL THEN 1 ELSE 0 END) as orcamento,
	SUM(CASE WHEN publico_alvo IS NULL THEN 1 ELSE 0 END) as publico_alvo,
	SUM(CASE WHEN canais_divulgacao IS NULL THEN 1 ELSE 0 END) as canais_divulgacao,
	SUM(CASE WHEN tipo_campanha IS NULL THEN 1 ELSE 0 END) as tipo_campanha,
	SUM(CASE WHEN publico_alvo IS NULL THEN 1 ELSE 0 END) as publico_alvo,
	SUM(CASE WHEN taxa_conversao IS NULL THEN 1 ELSE 0 END) as taxa_conversao,
	SUM(CASE WHEN impressoes IS NULL THEN 1 ELSE 0 END) as impressoes
FROM cap15.dsa_campanha_marketing

--Identifique se a o caracter "?"
SELECT * FROM cap15.dsa_campanha_marketing WHERE 1 = 0

SELECT * 
FROM cap15.dsa_campanha_marketing
WHERE
	nome_campanha LIKE '%?%' OR
	CAST(data_inicio AS VARCHAR) LIKE '%?%' OR
	CAST(data_fim AS VARCHAR) LIKE '%?%' OR
	CAST(orcamento AS VARCHAR) LIKE '%?%' OR
	publico_alvo LIKE '%?%' OR
	canais_divulgacao LIKE '%?%' OR
	tipo_campanha LIKE '%?%' OR
	CAST(taxa_conversao AS VARCHAR) LIKE '%?%' OR
	CAST(impressoes AS VARCHAR) LIKE '%?%'


SELECT * FROM cap15.dsa_campanha_marketing 
-- identifique duplicadas, sem considerar a coluna ID
--Data inicio
SELECT 
	data_inicio,
	COUNT(data_inicio) as total
FROM cap15.dsa_campanha_marketing 
GROUP BY data_inicio
HAVING COUNT(data_inicio) > 1
ORDER BY total DESC

--Data fim
SELECT 
	data_fim,
	COUNT(data_fim) as total
FROM cap15.dsa_campanha_marketing 
GROUP BY data_fim
HAVING COUNT(data_fim) > 1
ORDER BY total DESC

--Publico Alvo
SELECT 
	publico_alvo,
	COUNT(publico_alvo) as total_publico_alvo
FROM cap15.dsa_campanha_marketing 
GROUP BY publico_alvo
ORDER BY publico_alvo ASC

--Canais divulgacao
SELECT 
	canais_divulgacao,
	COUNT(CASE WHEN canais_divulgacao IS NULL THEN 1 ELSE 0 END) as total
FROM cap15.dsa_campanha_marketing 
GROUP BY canais_divulgacao
ORDER BY total DESC

SELECT 
	SUM(CASE WHEN canais_divulgacao IS NULL THEN 1 ELSE 0 END) AS NULL,
	SUM(CASE WHEN canais_divulgacao = 'Sites de Notícias' THEN 1 ELSE 0 END) AS Sites_de_Notícias,
	SUM(CASE WHEN canais_divulgacao = 'Google' THEN 1 ELSE 0 END) AS Google,
	SUM(CASE WHEN canais_divulgacao = 'Redes Sociais' THEN 1 ELSE 0 END) AS Redes_Sociais
FROM cap15.dsa_campanha_marketing 

--tipo de campanha
SELECT 
	tipo_campanha,
	COUNT(CASE WHEN tipo_campanha IS NULL THEN 1 ELSE 0 END) as total
FROM cap15.dsa_campanha_marketing 
GROUP BY tipo_campanha
ORDER BY total DESC

--identificar se todo o restante esta duplicado
WITH firsttable AS (SELECT nome_campanha, publico_alvo, canais_divulgacao FROM cap15.dsa_campanha_marketing ),
secondtable AS (SELECT nome_campanha, publico_alvo, canais_divulgacao FROM firsttable)
SELECT f.nome_campanha, f.publico_alvo, f.canais_divulgacao
FROM cap15.dsa_campanha_marketing f
INNER JOIN secondtable s
ON f.nome_campanha = s.nome_campanha

-- verificando se existe duplicatas
SELECT
	nome_campanha, data_inicio, data_fim, orcamento, publico_alvo, canais_divulgacao,
	tipo_campanha, taxa_conversao, impressoes,
	COUNT(*) as duplicadas
FROM cap15.dsa_campanha_marketing
GROUP BY
	nome_campanha, data_inicio, data_fim, orcamento, publico_alvo, canais_divulgacao,
	tipo_campanha, taxa_conversao, impressoes
HAVING COUNT(*) > 1
ORDER BY nome_campanha ASC

SELECT
	COUNT(*) as duplicadas, nome_campanha, data_inicio, publico_alvo, canais_divulgacao
FROM cap15.dsa_campanha_marketing
GROUP BY
	nome_campanha, data_inicio, publico_alvo, canais_divulgacao
HAVING COUNT(*) > 1
ORDER BY nome_campanha, data_inicio, publico_alvo, canais_divulgacao

--subquerie another way to do
SELECT *
FROM cap15.dsa_campanha_marketing
	WHERE (nome_campanha, data_inicio, publico_alvo, canais_divulgacao) IN (
	SELECT
		nome_campanha, data_inicio, publico_alvo, canais_divulgacao
		FROM cap15.dsa_campanha_marketing
	GROUP BY
		nome_campanha, data_inicio, publico_alvo, canais_divulgacao
	HAVING COUNT(*) > 1
)

--filtrando nao outliers
-- Crie uma querie que identifique outliers nas 3 colunas numericas
--media -1,5 * desvio padrão
WITH original AS (
SELECT orcamento, taxa_conversao, impressoes FROM cap15.dsa_campanha_marketing
WHERE orcamento IS NOT NULL AND taxa_conversao IS NOT NULL AND impressoes IS NOT NULL
),
filtera AS (
SELECT 
	ROUND(AVG(orcamento) - (1.5 * STDDEV(orcamento)),2) AS orcamento_outmin,
	ROUND(AVG(orcamento) + (1.5 * STDDEV(orcamento)),2) AS orcamento_outmxn,
	ROUND(AVG(taxa_conversao) - (1.5 * STDDEV(taxa_conversao)),2) AS taxa_conversao_outmin,
	ROUND(AVG(taxa_conversao) + (1.5 * STDDEV(taxa_conversao)),2) AS taxa_conversao_outmxn,
	ROUND(AVG(impressoes) - (1.5 * STDDEV(impressoes)),2) AS impressoes_outmin,
	ROUND(AVG(impressoes) + (1.5 * STDDEV(impressoes)),2) AS impressoes_outmxn
FROM cap15.dsa_campanha_marketing
)
SELECT o.orcamento, o.taxa_conversao, o.impressoes
FROM original o
CROSS JOIN filtera f
WHERE 
	o.orcamento > f.orcamento_outmin AND o.orcamento < f.orcamento_outmxn
	AND o.taxa_conversao > f.taxa_conversao_outmin AND o.taxa_conversao < f.taxa_conversao_outmxn
	AND o.impressoes > f.impressoes_outmin AND o.impressoes < f.impressoes_outmxn
ORDER BY o.orcamento DESC;

--filter outliers
WITH original AS (
SELECT orcamento, taxa_conversao, impressoes FROM cap15.dsa_campanha_marketing
WHERE orcamento IS NOT NULL AND taxa_conversao IS NOT NULL AND impressoes IS NOT NULL
),
filtera AS (
SELECT 
	ROUND(AVG(orcamento) - (1.5 * STDDEV(orcamento)),2) AS orcamento_outmin,
	ROUND(AVG(orcamento) + (1.5 * STDDEV(orcamento)),2) AS orcamento_outmxn,
	ROUND(AVG(taxa_conversao) - (1.5 * STDDEV(taxa_conversao)),2) AS taxa_conversao_outmin,
	ROUND(AVG(taxa_conversao) + (1.5 * STDDEV(taxa_conversao)),2) AS taxa_conversao_outmxn,
	ROUND(AVG(impressoes) - (1.5 * STDDEV(impressoes)),2) AS impressoes_outmin,
	ROUND(AVG(impressoes) + (1.5 * STDDEV(impressoes)),2) AS impressoes_outmxn
FROM cap15.dsa_campanha_marketing
)
SELECT o.orcamento, o.taxa_conversao, o.impressoes
FROM original o
CROSS JOIN filtera f
WHERE 
	o.orcamento < f.orcamento_outmin OR o.orcamento > f.orcamento_outmxn
	OR o.taxa_conversao < f.taxa_conversao_outmin OR o.taxa_conversao > f.taxa_conversao_outmxn
	OR o.impressoes < f.impressoes_outmin OR o.impressoes > f.impressoes_outmxn
ORDER BY o.orcamento DESC;


--Teacher answer
WITH stats AS (
	SELECT
		AVG(orcamento) as avg_orcamento,
		STDDEV(orcamento) AS stdev_orcamento,
		AVG(taxa_conversao) as avg_taxa_conversao,
		STDDEV(taxa_conversao) AS stdev_taxa_conversao,
		AVG(impressoes) as avg_impressoes,
		STDDEV(impressoes) AS stdev_impressoes
FROM cap15.dsa_campanha_marketing
)
SELECT id, nome_campanha, data_inicio, data_fim, orcamento, publico_alvo, canais_divulgacao,
taxa_conversao, impressoes
FROM cap15.dsa_campanha_marketing, stats
WHERE
	orcamento < (avg_orcamento-1.5*stdev_orcamento) OR
	orcamento > (avg_orcamento+1.5*stdev_orcamento) OR
	taxa_conversao < (avg_taxa_conversao-1.5*stdev_taxa_conversao) OR
	taxa_conversao > (avg_taxa_conversao+1.5*stdev_taxa_conversao) OR
	impressoes < (avg_impressoes-1.5*stdev_impressoes) OR
	impressoes > (avg_impressoes+1.5*stdev_impressoes)
ORDER BY orcamento DESC


SELECT
	(avg_orcamento-1.5*stdev_orcamento) as min_orc,
	(avg_orcamento+1.5*stdev_orcamento) as max_orc,
	(avg_taxa_conversao-1.5*stdev_taxa_conversao) as min_taxa_conver,
	(avg_taxa_conversao+1.5*stdev_taxa_conversao) as max_taxa_conver,
	(avg_impressoes-1.5*stdev_impressoes) as min_impressoes,
	(avg_impressoes+1.5*stdev_impressoes) as max_impressoes
FROM(
SELECT
		AVG(orcamento) as avg_orcamento,
		STDDEV(orcamento) AS stdev_orcamento,
		AVG(taxa_conversao) as avg_taxa_conversao,
		STDDEV(taxa_conversao) AS stdev_taxa_conversao,
		AVG(impressoes) as avg_impressoes,
		STDDEV(impressoes) AS stdev_impressoes
FROM cap15.dsa_campanha_marketing ) AS SUB