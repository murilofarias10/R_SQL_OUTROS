# SQL Para Análise de Dados e Data Science - Capítulo 18

-- Crie uma Stored Procedure (SP) que gere dados aleatórios de clientes e carregue os dados na tabela de clientes
-- A SP deve permitir cadastrar qualquer número de clientes
CREATE OR REPLACE PROCEDURE cap18.inserir_clientes_aleatorios(num_clientes INT)
LANGUAGE plpgsql
AS $$ -- this is for PGadmin understand I will write on different lines
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
															--minimo 0*25 + 65 = 65
															--maximo 1*25 + 65 = 90
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
											--array inside pgadmin start 1 to 12 in this case
        -- Na linha acima nós temos:
        -- random() gera um número aleatório entre 0 (inclusive) e 1 (exclusivo).
        -- array_upper(lista_cidades, 1) retorna o maior índice válido do array lista_cidades (ou seja, o tamanho do array).
        -- Multiplicar random() pelo tamanho do array resulta em um número no intervalo de 0 até o tamanho do array (mas não incluindo o limite superior).
        -- A função trunc é usada para arredondar o número para baixo para o inteiro mais próximo, resultando em um índice entre 0 e o tamanho do array menos 1.
        -- Adicionar 1 ajusta o índice para o intervalo de 1 até o tamanho do array, que são índices válidos em PostgreSQL (os arrays começam em 1, não em 0).

        -- Insere os dados na tabela 'clientes'
        INSERT INTO cap18.clientes (nome, endereco, cidade) VALUES
        (nome_aleatorio, endereco_aleatorio, cidade_aleatoria);

    END LOOP;
END;
$$; --end of my code

-- Para executar a Stored Procedure e inserir um número específico de clientes, use:
CALL cap18.inserir_clientes_aleatorios(1000);

--checking data
SELECT * FROM cap18.clientes
WHERE endereco LIKE '%A%'

----------------------------------------
-- Cria a tabela 'interacoes'
CREATE TABLE cap18.interacoes_dois (
    interacao_id SERIAL PRIMARY KEY,
    cliente_id INT NOT NULL,
    tipo_interacao VARCHAR(50),
    descricao TEXT,
    data_hora DATE,
    FOREIGN KEY (cliente_id) REFERENCES cap18.clientes(cliente_id)
);

CREATE OR REPLACE PROCEDURE cap18.inserir_interacoes_dois(total INT DEFAULT 1000)
LANGUAGE plpgsql
AS $$
DECLARE
  i INT;
  cliente_aleatorio INT;
  tipo_interacao_aleatorio TEXT;
  descricao_aleatorio TEXT;
  data_hora_aleatorio DATE;

  lista_interacao  TEXT[] := ARRAY['Email','Telefone','Reuniao'];
  lista_descricao  TEXT[] := ARRAY[
    'Email enviado com informacoes do produto',
    'Chamada telefonica para acompanhamento',
    'Reuniao agendada para discussao de detalhes'
  ];
BEGIN
  FOR i IN 1..total LOOP  
    -- cliente_id
    cliente_aleatorio := trunc((random() * 1000) + 1)::INT;

    -- tipo_interacao
	--floor and truc does the same to get only whole number
	--floor(-2.9) → -3 || trunc(-2.9) → -2
    tipo_interacao_aleatorio :=
      lista_interacao[1 + floor(random() * array_length(lista_interacao, 1))::INT];

    -- descricao coerente com o tipo_interacao
    descricao_aleatorio := CASE tipo_interacao_aleatorio
                              WHEN 'Email'    THEN lista_descricao[1]
                              WHEN 'Telefone' THEN lista_descricao[2]
                              ELSE                 lista_descricao[3]
                           END;

    -- data_hora aleatória entre 2015-09-18 e 2025-09-18
    data_hora_aleatorio :=
      DATE '2015-09-18'
      + (floor(random() * (DATE '2025-09-18' - DATE '2015-09-18' + 1))::INT);

    -- insert row
    INSERT INTO cap18.interacoes_dois (cliente_id, tipo_interacao, descricao, data_hora)
    VALUES (cliente_aleatorio, tipo_interacao_aleatorio, descricao_aleatorio, data_hora_aleatorio);
  END LOOP;   
END;
$$;

CALL cap18.inserir_interacoes_dois(1000)

SELECT * FROM cap18.interacoes_dois
order by cliente_id
