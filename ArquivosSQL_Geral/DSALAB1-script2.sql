SELECT * FROM lab1.dsa_pacientes;
--categorização, codificação e binarização de dados

SELECT
	DISTINCT(classe) as classe, COUNT(classe) as quantidade_vezes
FROM
	lab1.dsa_pacientes
GROUP BY classe;

--binarização de classe
SELECT classe, classe_transformada, COUNT(classe_transformada) as total
FROM(   
	SELECT classe,
		CASE
			WHEN classe = 'sem-recorrencia-eventos' THEN 0
			WHEN classe = 'com-recorrencia-eventos' THEN 1
		END AS classe_transformada
	FROM
		lab1.dsa_pacientes	
) AS subquery
GROUP BY classe_transformada, classe;

--binarização de irradiando
SELECT DISTINCT(irradiando),
	CASE
		WHEN irradiando = 'não' THEN 0
		WHEN irradiando = 'sim' THEN 1
	END AS grupo_irradiando
FROM lab1.dsa_pacientes

SELECT * FROM lab1.dsa_pacientes

--binarização de node_caps
SELECT DISTINCT(node_caps),
	CASE
		WHEN node_caps = 'não' THEN 0
		WHEN node_caps = 'sim' THEN 1
	END AS grupo_node_caps
FROM lab1.dsa_pacientes

SELECT DISTINCT tamanho_tumor FROM lab1.dsa_pacientes ORDER BY tamanho_tumor

--categorização tamanho_tumor
SELECT DISTINCT tamanho_tumor,
	CASE
		WHEN tamanho_tumor = '0-4' THEN 'Muito Pequeno'
		WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
		WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
		WHEN tamanho_tumor = '30-34' THEN 'Grande'
		WHEN tamanho_tumor = '50-54' THEN 'Tratamento urgente'
	END as cat_tamanho_tumor
FROM lab1.dsa_pacientes


SELECT DISTINCT quadrante,
	CASE
		WHEN quadrante = 'direito_inferior' THEN 1
		WHEN quadrante = 'central' THEN 2
		WHEN quadrante = 'esquerdo_superior' THEN 3
		WHEN quadrante = 'direito_superior' THEN 4
		WHEN quadrante = 'esquerdo_inferior' THEN 5
		ELSE 6
	END as grupo_quadrante
FROM lab1.dsa_pacientes
ORDER BY grupo_quadrante

SELECT DISTINCT(menopausa) FROM lab1.dsa_pacientes;

SELECT 
	DISTINCT(menopausa),
	CASE
		WHEN menopausa = 'acima_de_40' THEN 1
		ELSE 0
	END AS coluna_acima_de_40,
	CASE
		WHEN menopausa = 'pré-menopausa' THEN 1
		ELSE 0
	END AS coluna_pre_menopausa,
	CASE
		WHEN menopausa = 'abaixo_de_40' THEN 1
		ELSE 0
	END AS coluna_abaixo_de_40
FROM lab1.dsa_pacientes;

SELECT * FROM lab1.dsa_pacientes
SELECT * FROM lab1.resultado

-- Query com todas as transformações
CREATE TABLE lab1.resultado
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
FROM lab1.dsa_pacientes;


--exercicio capitulo

-- Criando a tabela 
CREATE TABLE lab1.vendas_loja_online (
    id_cliente INT PRIMARY KEY,
    pais_cliente VARCHAR(255),
    visitas_ultimo_mes VARCHAR(255),
    compras_ultimo_mes VARCHAR(255),
    total_gasto_ultimo_mes DECIMAL(10,2),
    fez_compra_mes_atual BOOLEAN
);

-- Inserindo registros na tabela 
INSERT INTO lab1.vendas_loja_online (id_cliente, pais_cliente, visitas_ultimo_mes, compras_ultimo_mes, total_gasto_ultimo_mes, fez_compra_mes_atual) VALUES 
(1000, 'Brasil', 'sim', '0-5', 100.50, TRUE),
(1001, 'Canadá', 'não', '6-10', 50.25, FALSE),
(1002, 'Inglaterra', 'não', '0-5', 250.75, TRUE),
(1003, 'Canadá', 'sim', '11-15', 340.20, FALSE),
(1004, 'Canadá', 'sim', '16-20', 150.00, FALSE),
(1005, 'Brasil', 'não', '11-15', 78.00, FALSE),
(1006, 'Canadá', 'sim', '0-5', 0.00, FALSE),
(1007, 'Canadá', 'não', '0-5', 0.00, FALSE),
(1008, 'Canadá', 'sim', '11-15', 90.00, FALSE),
(1009, 'Inglaterra', 'sim', '6-10', 179.30, TRUE);

SELECT DISTINCT * FROM lab1.vendas_loja_online
SELECT * FROM lab1.resultado_murilo

CREATE TABLE lab1.resultado_murilo
AS
SELECT 
	id_cliente,
	CASE
		WHEN pais_cliente = 'Brasil' THEN 1
		ELSE 0
	END AS Coluna_Brasil,
	CASE
		WHEN pais_cliente = 'Canadá' THEN 1
		ELSE 0
	END AS Coluna_Canada,
	CASE
		WHEN pais_cliente = 'Inglaterra' THEN 1
		ELSE 0
	END AS Coluna_Inglaterra,
	CASE
		WHEN visitas_ultimo_mes = 'sim' THEN 1
		ELSE 0
	END AS Coluna_visitas_ultimo_mes,
	CASE
		WHEN compras_ultimo_mes = '0-5' THEN 0
		WHEN compras_ultimo_mes = '6-10' THEN 1
		WHEN compras_ultimo_mes = '11-15' THEN 2
		WHEN compras_ultimo_mes = '16-20' THEN 3
	END as grupo_compras_ultimo_mes,
	CASE
		WHEN fez_compra_mes_atual = true THEN 1
	ELSE 0
	END as Coluna_compras_mes_atual
FROM lab1.vendas_loja_online
