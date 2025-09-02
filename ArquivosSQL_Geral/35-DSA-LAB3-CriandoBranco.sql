# SQL Para Análise de Dados e Data Science - Capítulo 15


-- Cria o schema no banco de dados
CREATE SCHEMA cap15 AUTHORIZATION dsa;


-- Criação da tabela
CREATE TABLE cap15.dsa_campanha_marketing (
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


-- Stored Procedure de carga de dados
CREATE OR REPLACE PROCEDURE cap15.inserir_dados_campanha()
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
        INSERT INTO cap15.dsa_campanha_marketing 
        (nome_campanha, data_inicio, data_fim, orcamento, publico_alvo, canais_divulgacao, tipo_campanha, taxa_conversao, impressoes)
        VALUES 
        ('Campanha ' || i, randomStartDate, randomEndDate, randomBudget, randomPublicTarget, randomChannel, randomCampaignType, randomConversionRate, randomImpressions);

        i := i + 1;
    END LOOP;
END;
$$;


-- Executa a SP
call cap15.inserir_dados_campanha();


-- Verifica os dados
SELECT * FROM cap15.dsa_campanha_marketing;




