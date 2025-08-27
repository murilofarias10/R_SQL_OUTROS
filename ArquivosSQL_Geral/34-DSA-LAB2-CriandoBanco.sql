CREATE TABLE cap13.lancamentosdsacontabeis (
    id INT PRIMARY KEY,
    data_lancamento DATE,
    conta_debito VARCHAR(50),
    conta_credito VARCHAR(50),
    valor DECIMAL(15, 2),
    documento VARCHAR(255),
    natureza_operacao VARCHAR(255),
    centro_custo VARCHAR(50),
    impostos TEXT,
    moeda VARCHAR(3),
    taxa_conversao DECIMAL(10, 6) NULL
);



CREATE OR REPLACE PROCEDURE cap13.carregar_dados_contabeis()
LANGUAGE plpgsql
AS $$
DECLARE
    i INT;
    naturezas_operacao TEXT[] := ARRAY['Venda', 'Compra', 'Serviço', 'Transferência'];
    centros_custo TEXT[] := ARRAY['Vendas', 'Compras', 'Administrativo', 'RH'];
    moedas TEXT[] := ARRAY['BRL', 'USD', 'EUR'];
    valor_random DECIMAL;
    taxa_conversao_random DECIMAL;
BEGIN
    FOR i IN 1..1000 LOOP
        IF RANDOM() < 0.01 THEN
            valor_random := ROUND((RANDOM() * 100000)::NUMERIC, 2);
            taxa_conversao_random := ROUND((RANDOM() * 100)::NUMERIC, 6);
        ELSE
            valor_random := ROUND((RANDOM() * 10000)::NUMERIC, 2);
            taxa_conversao_random := CASE WHEN RANDOM() < 0.5 THEN NULL ELSE ROUND((RANDOM() * 10)::NUMERIC, 6) END;
        END IF;

        IF valor_random > 5000 THEN
            centros_custo := ARRAY['Vendas', 'Compras'];
        ELSE
            centros_custo := ARRAY['Administrativo', 'RH'];
        END IF;

        INSERT INTO cap13.lancamentosdsacontabeis (
            id, 
            data_lancamento, 
            conta_debito, 
            conta_credito, 
            valor, 
            documento, 
            natureza_operacao, 
            centro_custo, 
            impostos, 
            moeda, 
            taxa_conversao
        )
        VALUES (
            i, 
            CURRENT_DATE - (RANDOM() * 365)::INT,
            'Conta Debito ' || (RANDOM() * 100)::INT,
            'Conta Credito ' || (RANDOM() * 100)::INT,
            valor_random,
            'Documento ' || LPAD(i::TEXT, 5, '0'),
            naturezas_operacao[1 + FLOOR(RANDOM() * 4)::INT],
            centros_custo[1 + FLOOR(RANDOM() * 2)::INT],
            '', 
            moedas[1 + FLOOR(RANDOM() * 3)::INT], 
            taxa_conversao_random
        );
    END LOOP;
END;
$$;

-- Executa a SP
call cap13.carregar_dados_contabeis();

SELECT * FROM cap13.lancamentosdsacontabeis LIMIT 100