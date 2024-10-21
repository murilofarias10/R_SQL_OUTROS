# SQL Para Análise de Dados e Data Science - Capítulo 06


-- Cria o schema no banco de dados
CREATE SCHEMA cap06 AUTHORIZATION dsa;


-- Cria a tabela
CREATE TABLE cap06.dsa_pacientes (
    classe VARCHAR(255),
    idade VARCHAR(255),
    menopausa VARCHAR(255),
    tamanho_tumor VARCHAR(255),
    inv_nodes VARCHAR(255),
    node_caps VARCHAR(255),
    deg_malig INT,
    seio VARCHAR(255),
    quadrante VARCHAR(255),
    irradiando VARCHAR(255)
);


-- Inserindo registros na tabela 
INSERT INTO cap06.dsa_pacientes (classe, idade, menopausa, tamanho_tumor, inv_nodes, node_caps, deg_malig, seio, quadrante, irradiando) VALUES
('sem-recorrencia-eventos', '30-39', 'pré-menopausa', '30-34', '2-4', 'não', 3, 'esquerdo', 'esquerdo_inferior', 'não'),
('sem-recorrencia-eventos', '40-49', 'pré-menopausa', '20-24', '0-2', 'sim', 2, 'direito', 'direito_superior', 'não'),
('com-recorrencia-eventos', '40-49', 'pré-menopausa', '20-24', '0-2', 'não', 2, 'esquerdo', 'esquerdo_inferior', 'não'),
('sem-recorrencia-eventos', '60-69', 'acima_de_40', '15-19', '0-2', 'sim', 2, 'direito', 'esquerdo_superior', 'não'),
('sem-recorrencia-eventos', '40-49', 'pré-menopausa', '0-4', '0-2', 'não', 2, 'direito', 'direito_inferior', 'não'),
('sem-recorrencia-eventos', '60-69', 'acima_de_40', '15-19', '0-2', 'não', 2, 'esquerdo', 'esquerdo_inferior', 'sim'),
('sem-recorrencia-eventos', '50-59', 'pré-menopausa', '25-29', '0-2', 'não', 2, 'esquerdo', 'esquerdo_inferior', 'não'),
('com-recorrencia-eventos', '60-69', 'acima_de_40', '20-24', '0-2', 'sim', 1, 'esquerdo', 'esquerdo_inferior', 'não'),
('sem-recorrencia-eventos', '40-49', 'pré-menopausa', '50-54', '0-2', 'não', 2, 'esquerdo', 'esquerdo_inferior', 'sim'),
('sem-recorrencia-eventos', '40-49', 'pré-menopausa', '20-24', '0-2', 'não', 2, 'direito', 'esquerdo_superior', 'não'),
('com-recorrencia-eventos', '40-49', 'pré-menopausa', '0-4', '0-2', 'não', 3, 'esquerdo', 'central', 'sim'),
('sem-recorrencia-eventos', '50-59', 'acima_de_40', '25-29', '0-2', 'não', 2, 'esquerdo', 'esquerdo_inferior', 'não'),
('sem-recorrencia-eventos', '60-69', 'abaixo_de_40', '10-14', '0-2', 'não', 1, 'esquerdo', 'direito_superior', 'não'),
('com-recorrencia-eventos', '50-59', 'acima_de_40', '25-29', '0-2', 'não', 3, 'esquerdo', 'direito_superior', 'sim'),
('com-recorrencia-eventos', '60-69', 'pré-menopausa', '0-4', '2-4', 'não', 3, 'esquerdo', 'central', 'não'),
('sem-recorrencia-eventos', '40-49', 'pré-menopausa', '30-34', '0-2', 'sim', 3, 'esquerdo', 'esquerdo_superior', 'não'),
('sem-recorrencia-eventos', '60-69', 'abaixo_de_40', '30-34', '0-2', 'não', 1, 'esquerdo', 'esquerdo_inferior', 'não'),
('sem-recorrencia-eventos', '40-49', 'pré-menopausa', '15-19', '0-2', 'não', 2, 'esquerdo', 'esquerdo_inferior', 'sim'),
('sem-recorrencia-eventos', '50-59', 'pré-menopausa', '30-34', '0-2', 'não', 3, 'esquerdo', 'esquerdo_inferior', 'não'),
('sem-recorrencia-eventos', '60-69', 'acima_de_40', '30-34', '0-2', 'não', 3, 'esquerdo', 'esquerdo_inferior', 'não');


-- Número de linhas
SELECT COUNT(*) FROM cap06.dsa_pacientes;


-- Visualiza os dados
SELECT * FROM cap06.dsa_pacientes;


-- Valores distintos
SELECT DISTINCT classe FROM cap06.dsa_pacientes;


-- Binarização da variável classe (0/1)
SELECT 
  CASE 
    WHEN classe = 'sem-recorrencia-eventos' THEN 0 
    WHEN classe = 'com-recorrencia-eventos' THEN 1
  END AS classe
FROM cap06.dsa_pacientes;


-- Valores distintos
SELECT DISTINCT irradiando FROM cap06.dsa_pacientes;


-- Binarização da variável irradiando (0/1)
SELECT 
  CASE 
    WHEN irradiando = 'não' THEN 0 
    WHEN irradiando = 'sim' THEN 1
  END AS irradiando
FROM cap06.dsa_pacientes;


-- Binarização da variável node_caps (0/1)
SELECT DISTINCT node_caps FROM cap06.dsa_pacientes;

SELECT 
  CASE 
    WHEN node_caps = 'não' THEN 0 
    WHEN node_caps = 'sim' THEN 1
  END AS node_caps
FROM cap06.dsa_pacientes;


-- Valores distintos
SELECT DISTINCT seio FROM cap06.dsa_pacientes;


-- Categorização da variável seio (E/D)
SELECT 
  CASE 
    WHEN seio = 'esquerdo' THEN 'E' 
    WHEN seio = 'direito' THEN 'D'
  END AS seio
FROM cap06.dsa_pacientes;


-- Label Encoding da variável seio (1/2)
SELECT 
  CASE 
    WHEN seio = 'esquerdo' THEN '1' 
    WHEN seio = 'direito' THEN '2'
  END AS seio
FROM cap06.dsa_pacientes;


-- Valores distintos
SELECT DISTINCT tamanho_tumor FROM cap06.dsa_pacientes;
SELECT DISTINCT tamanho_tumor FROM cap06.dsa_pacientes ORDER BY tamanho_tumor;


-- Categorização da variável tamanho_tumor (6 Categorias)
SELECT 
  CASE 
    WHEN tamanho_tumor = '0-4'   OR tamanho_tumor = '5-9'   THEN 'Muito Pequeno'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Tratamento Urgente'
  END AS tamanho_tumor
FROM cap06.dsa_pacientes;


-- Label Encoding da variável tamanho_tumor (6 Categorias)
SELECT 
  CASE 
    WHEN tamanho_tumor = '0-4'   OR tamanho_tumor = '5-9'   THEN '1'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '2'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '3'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '4'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '5'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '6'
  END AS tamanho_tumor
FROM cap06.dsa_pacientes;


-- Valores distintos
SELECT DISTINCT quadrante FROM cap06.dsa_pacientes;


-- Label Encoding da variável quadrante (1,2,3,4,5)
SELECT 
  CASE 
    WHEN quadrante = 'esquerdo_inferior' THEN 1 
    WHEN quadrante = 'direito_superior' THEN 2 
    WHEN quadrante = 'esquerdo_superior' THEN 3
    WHEN quadrante = 'direito_inferior' THEN 4
    WHEN quadrante = 'central' THEN 5
    ELSE 6
  END AS quadrante
FROM cap06.dsa_pacientes;


-- Valores distintos
SELECT DISTINCT menopausa FROM cap06.dsa_pacientes;


-- One-Hot Encoding (criação de variáveis dummy)
SELECT 
    menopausa,
    CASE 
        WHEN menopausa = 'acima_de_40' THEN 1 
        ELSE 0 
    END AS acima_de_40,
    CASE 
        WHEN menopausa = 'pré-menopausa' THEN 1 
        ELSE 0 
    END AS pre_menopausa,
    CASE 
        WHEN menopausa = 'abaixo_de_40' THEN 1 
        ELSE 0 
    END AS abaixo_de_40
FROM cap06.dsa_pacientes;


-- Query com todas as transformações
SELECT 
  CASE 
    WHEN classe = 'sem-recorrencia-eventos' THEN 0 
    WHEN classe = 'com-recorrencia-eventos' THEN 1
  END as classe,
  CASE 
    WHEN tamanho_tumor = '0-4'   OR tamanho_tumor = '5-9'   THEN '1'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '2'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '3'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '4'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '5'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '6'
  END AS tamanho_tumor,
  CASE 
    WHEN node_caps = 'não' THEN 0 
    WHEN node_caps = 'sim' THEN 1
    ELSE 2
  END AS node_caps,
  deg_malig,
  CASE 
    WHEN seio = 'esquerdo' THEN '1' 
    WHEN seio = 'direito' THEN '2'
  END AS seio,
  CASE 
    WHEN quadrante = 'esquerdo_inferior' THEN 1 
    WHEN quadrante = 'direito_superior' THEN 2 
    WHEN quadrante = 'esquerdo_superior' THEN 3
    WHEN quadrante = 'direito_inferior' THEN 4
    WHEN quadrante = 'central' THEN 5
    ELSE 6
  END AS quadrante,
  CASE 
    WHEN irradiando = 'não' THEN 0 
    WHEN irradiando = 'sim' THEN 1
  END AS irradiando,
  CASE 
    WHEN menopausa = 'acima_de_40' THEN 1 
    ELSE 0 
  END AS acima_de_40,
  CASE 
    WHEN menopausa = 'pré-menopausa' THEN 1 
    ELSE 0 
  END AS pre_menopausa,
  CASE 
    WHEN menopausa = 'abaixo_de_40' THEN 1 
    ELSE 0 
  END AS abaixo_de_40
FROM cap06.dsa_pacientes;


-- Cria uma nova tabela
CREATE TABLE cap06.dsa_pacientes_resultado
AS
SELECT 
  CASE 
    WHEN classe = 'sem-recorrencia-eventos' THEN 0 
    WHEN classe = 'com-recorrencia-eventos' THEN 1
  END as classe,
  CASE 
    WHEN tamanho_tumor = '0-4'   OR tamanho_tumor = '5-9'   THEN '1'
    WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN '2'
    WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN '3'
    WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN '4'
    WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN '5'
    WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN '6'
  END AS tamanho_tumor,
  CASE 
    WHEN node_caps = 'não' THEN 0 
    WHEN node_caps = 'sim' THEN 1
    ELSE 2
  END AS node_caps,
  deg_malig,
  CASE 
    WHEN seio = 'esquerdo' THEN '1' 
    WHEN seio = 'direito' THEN '2'
  END AS seio,
  CASE 
    WHEN quadrante = 'esquerdo_inferior' THEN 1 
    WHEN quadrante = 'direito_superior' THEN 2 
    WHEN quadrante = 'esquerdo_superior' THEN 3
    WHEN quadrante = 'direito_inferior' THEN 4
    WHEN quadrante = 'central' THEN 5
    ELSE 6
  END AS quadrante,
  CASE 
    WHEN irradiando = 'não' THEN 0 
    WHEN irradiando = 'sim' THEN 1
  END AS irradiando,
  CASE 
    WHEN menopausa = 'acima_de_40' THEN 1 
    ELSE 0 
  END AS acima_de_40,
  CASE 
    WHEN menopausa = 'pré-menopausa' THEN 1 
    ELSE 0 
  END AS pre_menopausa,
  CASE 
    WHEN menopausa = 'abaixo_de_40' THEN 1 
    ELSE 0 
  END AS abaixo_de_40
FROM cap06.dsa_pacientes;


-- Consulta a tabela
SELECT * FROM cap06.dsa_pacientes_resultado;











