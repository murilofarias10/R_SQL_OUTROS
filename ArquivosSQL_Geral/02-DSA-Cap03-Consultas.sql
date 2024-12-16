# SQL Para Análise de Dados e Data Science - Capítulo 03
--09/10/2024

SELECT * FROM cap03.estudantes_dsa;

SELECT nome, sobrenome, nota_exame1
FROM cap03.estudantes_dsa;

SELECT id, nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap03.estudantes_dsa;

-- ORDER BY
SELECT id, nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap03.estudantes_dsa
ORDER BY nome;

SELECT id, nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap03.estudantes_dsa
ORDER BY nome, sobrenome;

SELECT id, nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap03.estudantes_dsa
ORDER BY tipo_sistema_operacional;

SELECT id, nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap03.estudantes_dsa
ORDER BY nota_exame1 ASC;

SELECT id, nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap03.estudantes_dsa
ORDER BY tipo_sistema_operacional DESC, nome ASC;

-- WHERE
SELECT id, nome, sobrenome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap03.estudantes_dsa
WHERE tipo_sistema_operacional = 'Linux'
ORDER BY nome;

SELECT nome, sobrenome, nota_exame1
FROM cap03.estudantes_dsa
WHERE tipo_sistema_operacional = 'Linux'
ORDER BY nome;

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap03.estudantes_dsa
WHERE nota_exame1 > 90
ORDER BY tipo_sistema_operacional DESC;

SELECT *
FROM cap03.estudantes_dsa
ORDER BY
  CASE tipo_sistema_operacional
    WHEN 'Windows' THEN 1
    WHEN 'Linux' THEN 2
    WHEN 'Mac' THEN 3
    ELSE 4  -- Caso haja algum outro valor, coloque-o em outra posição
  END;

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional,
	CASE tipo_sistema_operacional
		WHEN 'Linux' THEN 1
		WHEN 'Windows' THEN 2
		WHEN 'Mac' THEN 3
		ELSE 4
	END AS Codigo_Sistema
FROM cap03.estudantes_dsa;
