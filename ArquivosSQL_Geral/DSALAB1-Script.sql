CREATE TABLE lab1.dsa_pacientes (
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
INSERT INTO lab1.dsa_pacientes (classe, idade, menopausa, tamanho_tumor, inv_nodes, node_caps, deg_malig, seio, quadrante, irradiando) VALUES
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

SELECT * FROM lab1.dsa_pacientes;

