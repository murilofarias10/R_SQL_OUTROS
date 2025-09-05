CREATE TABLE cap16.dsa_campanha_marketing (
    id SERIAL,
    nome_campanha VARCHAR(255),
    data_inicio DATE,
    data_fim DATE,
    orcamento DECIMAL(10, 2),
    publico_alvo VARCHAR(255),
    canais_divulgacao VARCHAR(255), 
    tipo_campanha VARCHAR(255), 
    taxa_conversao DECIMAL(5, 2),
    impressoes BIGINT
);

CREATE OR REPLACE PROCEDURE cap16.inserir_dados_campanha()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT := 1;
    randomTarget INT;
    randomConversionRate DECIMAL(5, 2);
    randomImpressions BIGINT;
    randomBudget DECIMAL(10, 2);
    randomChannel VARCHAR(255);
    randomCampaignType VARCHAR(255);
    randomStartDate DATE;
    randomEndDate DATE;
    randomPublicTarget VARCHAR(255);
BEGIN
    LOOP
        EXIT WHEN i > 1000;
        
        -- Gerar valores aleatórios
        randomTarget := 1 + (i % 5);
        randomConversionRate := ROUND((RANDOM() * 30)::numeric, 2);
        randomImpressions := (1 + FLOOR(RANDOM() * 10)) * 1000000;

        -- Valores condicionais
        randomBudget := CASE WHEN RANDOM() < 0.8 THEN ROUND((RANDOM() * 100000)::numeric, 2) ELSE NULL END;

        -- Canais de divulgação
        randomChannel := CASE
            WHEN RANDOM() < 0.8 THEN
                CASE FLOOR(RANDOM() * 3)
                    WHEN 0 THEN 'Google'
                    WHEN 1 THEN 'Redes Sociais'
                    ELSE 'Sites de Notícias'
                END
            ELSE NULL
        END;

        -- Tipo de campanha
        randomCampaignType := CASE
            WHEN RANDOM() < 0.8 THEN
                CASE FLOOR(RANDOM() * 3)
                    WHEN 0 THEN 'Promocional'
                    WHEN 1 THEN 'Divulgação'
                    ELSE 'Mais Seguidores'
                END
            ELSE NULL
        END;

        -- Definir datas aleatórias dos últimos 4 anos
        randomStartDate := CURRENT_DATE - (1 + FLOOR(RANDOM() * 1460)) * INTERVAL '1 day';
        randomEndDate := randomStartDate + (1 + FLOOR(RANDOM() * 30)) * INTERVAL '1 day';

        -- Publico Alvo aleatório com possibilidade de "?"
        randomPublicTarget := CASE WHEN RANDOM() < 0.2 THEN '?' ELSE 'Publico Alvo ' || randomTarget END;

        -- Inserir registro
        INSERT INTO cap16.dsa_campanha_marketing 
        (nome_campanha, data_inicio, data_fim, orcamento, publico_alvo, canais_divulgacao, tipo_campanha, taxa_conversao, impressoes)
        VALUES 
        ('Campanha ' || i, randomStartDate, randomEndDate, randomBudget, randomPublicTarget, randomChannel, randomCampaignType, randomConversionRate, randomImpressions);

        i := i + 1;
    END LOOP;
END;
$$;


-- Executa a SP
call cap16.inserir_dados_campanha();

SELECT * FROM cap16.dsa_campanha_marketing 


--Tratamento de dados coluna publico_alvo
--trocando '?' por 'Outros' coluna publico_alvo
SELECT DISTINCT publico_alvo
FROM cap16.dsa_campanha_marketing
ORDER BY publico_alvo ASC;

UPDATE cap16.dsa_campanha_marketing
SET publico_alvo = 'Outros'
WHERE publico_alvo = '?'

SELECT DISTINCT publico_alvo
FROM cap16.dsa_campanha_marketing
ORDER BY publico_alvo ASC;



--updating canais de divulgação
SELECT DISTINCT canais_divulgacao FROM cap16.dsa_campanha_marketing
UPDATE cap16.dsa_campanha_marketing
SET canais_divulgacao = (
SELECT
	canais_divulgacao
FROM cap16.dsa_campanha_marketing
GROUP BY canais_divulgacao
ORDER BY COUNT(canais_divulgacao) DESC LIMIT 1
)
WHERE canais_divulgacao IS NULL


--identifique o total de registro de cada valor da tipo_campanha
SELECT COUNT(*) as contagem, tipo_campanha
FROM cap16.dsa_campanha_marketing
GROUP BY tipo_campanha
ORDER BY contagem DESC

--delete os registros onde tipo_campanha IS NULL
DELETE FROM cap16.dsa_campanha_marketing
WHERE tipo_campanha IS NULL

--confirming
SELECT COUNT(*) as contagem, tipo_campanha
FROM cap16.dsa_campanha_marketing
GROUP BY tipo_campanha
ORDER BY contagem DESC

SELECT * FROM cap16.dsa_campanha_marketing WHERE 0 = 1
SELECT 
	SUM(CASE WHEN nome_campanha IS NULL THEN 1 ELSE 0 END) AS nome_campanha,
	SUM(CASE WHEN data_inicio IS NULL THEN 1 ELSE 0 END) AS data_inicio,
	SUM(CASE WHEN data_fim IS NULL THEN 1 ELSE 0 END) AS data_fim,
	SUM(CASE WHEN orcamento IS NULL THEN 1 ELSE 0 END) AS orcamento,
	SUM(CASE WHEN publico_alvo IS NULL THEN 1 ELSE 0 END) AS publico_alvo,
	SUM(CASE WHEN canais_divulgacao IS NULL THEN 1 ELSE 0 END) AS canais_divulgacao,
	SUM(CASE WHEN tipo_campanha IS NULL THEN 1 ELSE 0 END) AS tipo_campanha,
	SUM(CASE WHEN taxa_conversao IS NULL THEN 1 ELSE 0 END) AS taxa_conversao,
	SUM(CASE WHEN impressoes IS NULL THEN 1 ELSE 0 END) AS impressoes
FROM cap16.dsa_campanha_marketing

-- 1. valores ausente coluna orcamento
SELECT * FROM cap16.dsa_campanha_marketing
WHERE orcamento IS NULL

--2. remova registros se a coluna orcamento tiver valor ausente e a coluna publico_alvo tiver o valor "Outros"
--179 registro and 37 is outros
DELETE FROM cap16.dsa_campanha_marketing
WHERE orcamento IS NULL AND publico_alvo = 'Outros'

-- 3. preencha orcamento com a média da coluna interpolacao, mas segmentado pela coluna canais_divulgacao

SELECT DISTINCT(canais_divulgacao) FROM cap16.dsa_campanha_marketing

SELECT ROUND(AVG(orcamento),2) as avg_orc FROM cap16.dsa_campanha_marketing WHERE canais_divulgacao = 'Sites de Notícias'
SELECT ROUND(AVG(orcamento),2) as avg_orc FROM cap16.dsa_campanha_marketing WHERE canais_divulgacao = 'Redes Sociais'
SELECT ROUND(AVG(orcamento),2) as avg_orc FROM cap16.dsa_campanha_marketing WHERE canais_divulgacao = 'Google'

--update
UPDATE cap16.dsa_campanha_marketing AS c
SET orcamento = d.media_orcamento
FROM (
	SELECT canais_divulgacao, AVG(orcamento) as media_orcamento
	FROM cap16.dsa_campanha_marketing
	GROUP BY canais_divulgacao
) as d
WHERE c.canais_divulgacao = d.canais_divulgacao AND c.orcamento IS NULL

SELECT canais_divulgacao, orcamento, RANK()OVER(ORDER BY orcamento) FROM cap16.dsa_campanha_marketing 
SELECT canais_divulgacao, orcamento, COUNT(orcamento) FROM cap16.dsa_campanha_marketing 
GROUP BY canais_divulgacao, orcamento
ORDER BY COUNT(orcamento) DESC

SELECT *
FROM cap16.dsa_campanha_marketing
WHERE orcamento IS NULL

--Updating site de noticias
UPDATE cap16.dsa_campanha_marketing
SET orcamento = (SELECT (AVG(orcamento)) FROM cap16.dsa_campanha_marketing WHERE canais_divulgacao = 'Sites de Notícias')
WHERE canais_divulgacao = 'Sites de Notícias' AND orcamento IS NULL

--Updating redes Sociais
UPDATE cap16.dsa_campanha_marketing
SET orcamento = (SELECT (AVG(orcamento)) FROM cap16.dsa_campanha_marketing WHERE canais_divulgacao = 'Redes Sociais')
WHERE canais_divulgacao = 'Redes Sociais' AND orcamento IS NULL

--Updating Google
UPDATE cap16.dsa_campanha_marketing
SET orcamento = (SELECT (AVG(orcamento)) FROM cap16.dsa_campanha_marketing WHERE canais_divulgacao = 'Google')
WHERE canais_divulgacao = 'Google' AND orcamento IS NULL

SELECT canais_divulgacao, orcamento, COUNT(*) as qtde FROM cap16.dsa_campanha_marketing
GROUP BY canais_divulgacao, orcamento
ORDER BY qtde DESC



-- 4Tratando outlier criando uma nova coluna true and false onde existe outliers
-- I have 324 rows for outliers
WITH original AS (
SELECT orcamento, taxa_conversao, impressoes FROM cap16.dsa_campanha_marketing
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
FROM cap16.dsa_campanha_marketing
)
SELECT o.orcamento, o.taxa_conversao, o.impressoes
FROM original o
CROSS JOIN filtera f
WHERE 
	o.orcamento < f.orcamento_outmin OR o.orcamento > f.orcamento_outmxn
	OR o.taxa_conversao < f.taxa_conversao_outmin OR o.taxa_conversao > f.taxa_conversao_outmxn
	OR o.impressoes < f.impressoes_outmin OR o.impressoes > f.impressoes_outmxn
ORDER BY o.orcamento DESC;




SELECT 
	ROUND(AVG(orcamento) - (1.5 * STDDEV(orcamento)),2) AS orcamento_outmin,
	ROUND(AVG(orcamento) + (1.5 * STDDEV(orcamento)),2) AS orcamento_outmxn
FROM cap16.dsa_campanha_marketing

SELECT 
	ROUND(AVG(orcamento) - (1.5 * STDDEV(orcamento)),2) AS orcamento_outmin,
	ROUND(AVG(orcamento) + (1.5 * STDDEV(orcamento)),2) AS orcamento_outmxn,
	ROUND(AVG(taxa_conversao) - (1.5 * STDDEV(taxa_conversao)),2) AS taxa_conversao_outmin,
	ROUND(AVG(taxa_conversao) + (1.5 * STDDEV(taxa_conversao)),2) AS taxa_conversao_outmxn,
	ROUND(AVG(impressoes) - (1.5 * STDDEV(impressoes)),2) AS impressoes_outmin,
	ROUND(AVG(impressoes) + (1.5 * STDDEV(impressoes)),2) AS impressoes_outmxn
FROM cap16.dsa_campanha_marketing

--first adding new colum and false for all
ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN is_outlier BOOLEAN DEFAULT FALSE


SELECT * FROM cap16.dsa_campanha_marketing
WHERE is_outlier = 'False'
ORDER BY impressoes ASC

SELECT is_outlier, count(*) FROM cap16.dsa_campanha_marketing
GROUP BY is_outlier

-- filling TRUE updating  based on orcamento, taxa_conversao, impressoes outliers
WITH stats AS (
  SELECT 
    AVG(orcamento) AS orcamento_average, STDDEV(orcamento) AS stdeviation_orcamento,
	AVG(taxa_conversao) AS taxa_conversao_average, STDDEV(taxa_conversao) AS stdeviation_taxa_conversao,
	AVG(impressoes) AS impressoes_average, STDDEV(impressoes) AS stdeviation_impressoes
FROM cap16.dsa_campanha_marketing
)
UPDATE cap16.dsa_campanha_marketing AS t
SET is_outlier = (
  (t.orcamento < s.orcamento_average - 1.5*s.stdeviation_orcamento OR t.orcamento > s.orcamento_average + 1.5*s.stdeviation_orcamento)
OR
  (t.taxa_conversao < s.taxa_conversao_average-1.5*s.stdeviation_taxa_conversao OR t.taxa_conversao > s.taxa_conversao_average+1.5*s.stdeviation_taxa_conversao)
OR
  (t.impressoes < s.impressoes_average - 1.5*s.stdeviation_impressoes OR t.impressoes > s.impressoes_average + 1.5*s.stdeviation_impressoes)
)
FROM stats s;

-- 5 first adding new colum publico_alvo_encoded
ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN publico_alvo_encoded int; 

-- label encoding publico_alvo for publico_alvo_encoded
SELECT DISTINCT publico_alvo, publico_alvo_encoded FROM cap16.dsa_campanha_marketing
ORDER BY publico_alvo

UPDATE cap16.dsa_campanha_marketing
SET publico_alvo_encoded =
CASE publico_alvo
		WHEN 'Publico Alvo 1' THEN 1
		WHEN 'Publico Alvo 2' THEN 2
		WHEN 'Publico Alvo 3' THEN 3
		WHEN 'Publico Alvo 4' THEN 4
		WHEN 'Publico Alvo 5' THEN 5
		WHEN 'Outros' THEN 0
		ELSE NULL END

SELECT publico_alvo, publico_alvo_encoded FROM cap16.dsa_campanha_marketing
SELECT * FROM cap16.dsa_campanha_marketing

-- 6 label encoding for canais_divulgacao canais_divulgacao_encoded
ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN canais_divulgacao_encoded int; 

UPDATE cap16.dsa_campanha_marketing
SET canais_divulgacao_encoded = CASE
canais_divulgacao
	WHEN 'Google' THEN 1
	WHEN 'Redes Sociais' THEN 2
	WHEN 'Sites de Notícias' THEN 3
	ELSE 0
END


-- 7 label encoding for tipo_campanha  tipo_campanha_encoded
ALTER TABLE cap16.dsa_campanha_marketing
ADD COLUMN tipo_campanha_encoded INT;

UPDATE cap16.dsa_campanha_marketing
SET tipo_campanha_encoded = CASE
tipo_campanha
	WHEN 'Divulgação' THEN 1
	WHEN 'Mais Seguidores' THEN 2
	WHEN 'Promocional' THEN 3
	ELSE 0
END

-- 8 drop columns publico_alvo canais_divulgacao and tipo_campanha
SELECT publico_alvo, publico_alvo_encoded,
	canais_divulgacao, canais_divulgacao_encoded,
	tipo_campanha, tipo_campanha_encoded
FROM cap16.dsa_campanha_marketing ORDER BY publico_alvo

ALTER TABLE cap16.dsa_campanha_marketing
	DROP COLUMN publico_alvo, 
	DROP COLUMN canais_divulgacao, 
	DROP COLUMN tipo_campanha

SELECT 
	SUM(CASE WHEN nome_campanha IS NULL THEN 1 ELSE 0 END) AS nome_campanha,
	SUM(CASE WHEN data_inicio IS NULL THEN 1 ELSE 0 END) AS data_inicio,
	SUM(CASE WHEN data_fim IS NULL THEN 1 ELSE 0 END) AS data_fim,
	SUM(CASE WHEN orcamento IS NULL THEN 1 ELSE 0 END) AS orcamento,
	SUM(CASE WHEN taxa_conversao IS NULL THEN 1 ELSE 0 END) AS taxa_conversao,
	SUM(CASE WHEN impressoes IS NULL THEN 1 ELSE 0 END) AS impressoes,
	SUM(CASE WHEN publico_alvo_encoded IS NULL THEN 1 ELSE 0 END) AS publico_alvo_encoded,
	SUM(CASE WHEN canais_divulgacao_encoded IS NULL THEN 1 ELSE 0 END) AS canais_divulgacao_encoded,
	SUM(CASE WHEN tipo_campanha_encoded IS NULL THEN 1 ELSE 0 END) AS tipo_campanha_encoded
FROM cap16.dsa_campanha_marketing

SELECT * FROM cap16.dsa_campanha_marketing

