# SQL Para Análise de Dados e Data Science - Capítulo 04

-- OPERADORES RELACIONAIS

SELECT * FROM cap04.estudantes
WHERE nota_exame1 = 90;

SELECT * FROM cap04.estudantes
WHERE nota_exame1 > 90;

SELECT * FROM cap04.estudantes
WHERE nota_exame1 >= 90;

SELECT * FROM cap04.estudantes
WHERE nota_exame2 <= 76.5;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 != 90;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 <> 90;

SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 = 90;

SELECT * 
FROM cap04.estudantes
WHERE 90 = nota_exame1;

SELECT * 
FROM cap04.estudantes
WHERE 90 = 90;

SELECT * 
FROM cap04.estudantes
WHERE nome = Xavier; --sem aspas

SELECT * 
FROM cap04.estudantes
WHERE nome = 'xavier'; --com minusculo

SELECT * 
FROM cap04.estudantes
WHERE nome = 'Xavier';


-- OPERADORES LÓGICOS
SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 > 90 AND nota_exame2 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 > 90 OR nota_exame2 > 90;

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE NOT nota_exame1 > 90;

SELECT nome, nota_exame1, nota_exame2, tipo_sistema_operacional
FROM cap04.estudantes
WHERE nota_exame1 > 90 AND nota_exame2 > 90 AND tipo_sistema_operacional = 'Windows';

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional != 'Linux';

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND NOT tipo_sistema_operacional = 'Linux'
  
SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional != 'Linux';

SELECT nome, nota_exame1, nota_exame2
FROM cap04.estudantes
WHERE (nota_exame1 > 90 OR nota_exame2 > 90) 
  AND tipo_sistema_operacional != 'Linux'
  AND NOT nome IN ('Carol', 'Grace');


-- OUTROS OPERADORES RELACIONAIS RETORNA VERDADEIRO OU FALSO
-- OPERADOR IN

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional IN ('Linux', 'Mac');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional IN ('Linux', 'FreeBSD');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional IN ('Unix');

SELECT nome, sobrenome, nota_exame1, tipo_sistema_operacional
FROM cap04.estudantes
WHERE tipo_sistema_operacional NOT IN ('Linux', 'Mac');


-- OPERADOR LIKE

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome LIKE 'a%' or nome LIKE 'A%'
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome LIKE 'A%' OR nome LIKE 'B%' 
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome NOT LIKE 'A%'
ORDER BY nome_completo;

SELECT 
	nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome NOT LIKE 'A%'
ORDER BY nome_completo;


SELECT nome_completo, nota_exame1, nota_exame2
FROM (
    SELECT nome || ' ' || sobrenome AS nome_completo, 
           nota_exame1, 
           nota_exame2
    FROM cap04.estudantes
    WHERE nome NOT LIKE 'A%'
	ORDER BY nome_completo
) AS SUBQUERIE_1
WHERE nome_completo NOT LIKE 'B%'
ORDER BY nome_completo;


SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nome NOT LIKE 'A%' AND nome NOT LIKE 'B%'
ORDER BY nome_completo;


-- OPERADOR BETWEEN
SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 NOT BETWEEN 88 AND 90
ORDER BY nome_completo;

SELECT nome || ' ' || sobrenome AS nome_completo, 
       nota_exame1, 
	   nota_exame2,
	   tipo_sistema_operacional,
	   'Aprovado' AS status --criando uma nova coluna com valor desejado
FROM cap04.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
  AND tipo_sistema_operacional IN ('Linux', 'Mac')
  AND nome LIKE 'C%' OR nome LIKE 'H%' OR nome LIKE 'J%'
  AND nota_exame2 != 80
ORDER BY nome_completo;

--LIMPAR TABELA TRUNCATE TABLE cap04.estudantes;

***************
SELECT 
    nome || ' ' || sobrenome AS nome_completo, 
    nota_exame1, 
    nota_exame2,
    CASE 
        WHEN nota_exame1 BETWEEN 88 AND 90
             AND tipo_sistema_operacional IN ('Linux', 'Mac')
             AND (nome LIKE 'C%' OR nome LIKE 'H%' OR nome LIKE 'J%')
             AND nota_exame2 != 80 THEN 'Aprovado'
        ELSE 'Reprovado'
    END AS status
FROM cap04.estudantes
ORDER BY status;




SELECT 
    nome || ' ' || sobrenome AS nome_completo, 
    nota_exame1, 
    nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
	AND tipo_sistema_operacional IN ('Linux', 'Mac')
	AND (nome LIKE 'C%' OR nome LIKE 'H%' OR nome LIKE 'J%')
	AND nota_exame2 != 80 
ORDER BY nome_completo;

SELECT 
    nome || ' ' || sobrenome AS nome_completo, 
    nota_exame1, 
    nota_exame2
FROM cap04.estudantes
WHERE nota_exame1 BETWEEN 88 AND 90
    AND tipo_sistema_operacional IN ('Linux', 'Mac')
    AND (nome LIKE 'C%' OR nome LIKE 'H%' OR nome LIKE 'J%')
    AND nota_exame2 != 80 
ORDER BY nome_completo;


-- LIMPAR A TABELA (USE COM CUIDADO)
TRUNCATE TABLE cap04.estudantes;