CREATE SCHEMA cap19 

-- Cria a tabela 'clientes'
CREATE TABLE cap19.clientes (
    cliente_id SERIAL PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    endereco VARCHAR(255),
    cidade VARCHAR(255)
);

-- Cria a tabela 'interacoes'
CREATE TABLE cap19.interacoes (
    interacao_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    tipo_interacao VARCHAR(50),
    descricao TEXT,
    data_hora DATE,
    FOREIGN KEY (cliente_id) REFERENCES cap19.clientes(cliente_id)
);

-- Cria a tabela 'vendas'
CREATE TABLE cap19.vendas (
    venda_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    quantidade INT NOT NULL,
    valor_venda DECIMAL(10, 2) NOT NULL,
    data_venda DATE,
    FOREIGN KEY (cliente_id) REFERENCES cap19.clientes(cliente_id)
);

--first stored procedure

-- Crie uma Stored Procedure (SP) que gere dados aleatórios de clientes e carregue os dados na tabela de clientes
-- A SP deve permitir cadastrar qualquer número de clientes
CREATE OR REPLACE PROCEDURE cap19.inserir_clientes_aleatorios(num_clientes INT)
LANGUAGE plpgsql
AS $$
DECLARE
    
    i INT;
    
    nome_aleatorio VARCHAR(255);
    endereco_aleatorio VARCHAR(255);
    cidade_aleatoria VARCHAR(255);

    lista_cidades TEXT[] := ARRAY['São Paulo', 
                                  'Rio de Janeiro', 
                                  'Belo Horizonte', 
                                  'Vitória', 
                                  'Porto Alegre', 
                                  'Salvador', 
                                  'Blumenau', 
                                  'Curitiba', 
                                  'Fortaleza', 
                                  'Manaus', 
                                  'Recife', 
                                  'Goiânia'
    ];
BEGIN
    FOR i IN 1..num_clientes LOOP
        
        -- Gera um nome aleatório no formato: Cliente_i_LETRA
        nome_aleatorio := 'Cliente_' || i || '_' || chr(trunc(65 + random()*25)::int);

        -- Na linha acima nós temos:
        -- random(): Gera um número aleatório entre 0 (inclusive) e 1 (exclusivo).
        -- random()*25: Multiplica o número aleatório por 25. O resultado está no intervalo de 0 a 24.999... .
        -- 65 + random()*25: Adiciona 65 ao resultado anterior. Agora, o resultado está no intervalo de 65 a 89.999... . Os números 65 a 90 correspondem aos códigos ASCII das letras maiúsculas A-Z.
        -- trunc(...): A função trunc remove a parte fracionária do número, resultando em um inteiro entre 65 e 89.
        -- ::int: É uma cast para o tipo inteiro, embora trunc já retorne um inteiro, garantindo que o resultado seja um número inteiro.
        -- chr(...): Converte o número inteiro de volta em um caractere, de acordo com a tabela ASCII. Isso resultará em uma letra maiúscula aleatória entre A e Z.

        -- Gera um endereço aleatório no formato: Rua LETRA, numero
        endereco_aleatorio := 'Rua ' || chr(trunc(65 + random()*25)::int) || ', ' || trunc(random()*1000)::text;

        -- Seleciona uma cidade aleatória
        SELECT INTO cidade_aleatoria 
            lista_cidades[trunc(random() * array_upper(lista_cidades, 1)) + 1] AS cidade;

        -- Na linha acima nós temos:
        -- random() gera um número aleatório entre 0 (inclusive) e 1 (exclusivo).
        -- array_upper(lista_cidades, 1) retorna o maior índice válido do array lista_cidades (ou seja, o tamanho do array).
        -- Multiplicar random() pelo tamanho do array resulta em um número no intervalo de 0 até o tamanho do array (mas não incluindo o limite superior).
        -- A função trunc é usada para arredondar o número para baixo para o inteiro mais próximo, resultando em um índice entre 0 e o tamanho do array menos 1.
        -- Adicionar 1 ajusta o índice para o intervalo de 1 até o tamanho do array, que são índices válidos em PostgreSQL (os arrays começam em 1, não em 0).

        -- Insere os dados na tabela 'clientes'
        INSERT INTO cap19.clientes (nome, endereco, cidade) VALUES
        (nome_aleatorio, endereco_aleatorio, cidade_aleatoria);

    END LOOP;
END;
$$;

CALL cap19.inserir_clientes_aleatorios(1000)

SELECT * FROM cap19.clientes

--creating second stored procedure
CREATE OR REPLACE PROCEDURE cap19.inserir_interacoes()
LANGUAGE plpgsql
AS $$
DECLARE
	cliente RECORD; --tipo de registro
	data_aleatoria DATE;
BEGIN
	FOR cliente IN SELECT cliente_id FROM cap19.clientes LOOP
		data_aleatoria := '2021-01-01'::DATE + (trunc(random() * (365*5))::INT); --2021 until 2025

		INSERT INTO cap19.interacoes(cliente_id, tipo_interacao, descricao, data_hora) VALUES
		(cliente.cliente_id, 'Email', 'Email enviado com informações do produto', data_aleatoria),
		(cliente.cliente_id, 'Telefone', 'Email enviado com informações do produto', data_aleatoria),
		(cliente.cliente_id, 'Reunião', 'Reunião agendada para discussão de detalhes', data_aleatoria);
	END LOOP;
END;
$$

CALL cap19.inserir_interacoes()
SELECT * FROM cap19.clientes
SELECT * FROM cap19.interacoes
SELECT * FROM cap19.vendas