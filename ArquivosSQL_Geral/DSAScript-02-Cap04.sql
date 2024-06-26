# SQL Para Análise de Dados e Data Science - Capítulo 04


-- FILTROS DE COLUNA

-- Selecione todas as linhas e colunas da tabela
SELECT * 
FROM cap04.estudantes;

-- Selecione nome e sobrenome de todos os estudantes
SELECT nome, sobrenome
FROM cap04.estudantes;

-- Selecione tipo de sistema operacional, nota no exame 1 e nota no exame 2 de todos os estudantes
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2
FROM cap04.estudantes;

-- Selecione tipo de sistema operacional, nota no exame 1, nota no exame 2, nome e sobrenome de todos os estudantes.
-- Nome e sobrenome devem estar em uma única coluna no resultado mostrando o nome completo.
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2, nome || ' ' || sobrenome
FROM cap04.estudantes;

-- Selecione tipo de sistema operacional, nota no exame 1, nota no exame 2, nome e sobrenome de todos os estudantes.
-- Nome e sobrenome devem estar em uma única coluna no resultado mostrando o nome completo.
-- Crie um alias para a nova coluna de nome completo
SELECT tipo_sistema_operacional, nota_exame1, nota_exame2, nome || ' ' || sobrenome AS nome_completo
FROM cap04.estudantes;


select 
CONCAT(nome,' ',sobrenome) as nome_completo,
tipo_sistema_operacional, nota_exame1, nota_exame2 
from cap04.estudantes;


-- FILTROS DE LINHA

-- Selecione os 10 primeiros estudantes da tabela
SELECT *
FROM cap04.estudantes
LIMIT 10;

-- Selecione todos os estudantes que conseguiram nota igual a 90 em nota_exame1
SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 = 90;

-- Selecione todos os estudantes que conseguiram nota maior do que 90 em nota_exame1
SELECT * 
FROM cap04.estudantes
WHERE nota_exame1 > 90;

-- Selecione somente os nomes dos estudantes que conseguiram nota maior do que 90 em nota_exame1
SELECT nome
FROM cap04.estudantes
WHERE nota_exame1 > 90;

-- Selecione somente os nomes dos estudantes que conseguiram nota menor do que 90 em nota_exame1
-- Ordene o resultado
select nome, sobrenome, nota_exame1 
from cap04.estudantes where nota_exame1 < 90
order by nome, nota_exame1 desc;

-- Observe no resultado anterior que um mesmo nome aparece mais de uma vez
-- Retorne somente um nome se houver duplicidade de nome
SELECT DISTINCT nome
FROM cap04.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;

SELECT DISTINCT ON (nome) nome, sobrenome, nota_exame1 
FROM cap04.estudantes 
WHERE nota_exame1 < 90
ORDER BY nome, nota_exame1 DESC;

-- Agora queremos valores distintos por nome e sobrenome, ordenado por nome
-- Observe a diferença
SELECT DISTINCT nome, sobrenome
FROM cap04.estudantes
WHERE nota_exame1 < 90
ORDER BY nome;

SELECT DISTINCT nome || ' ' || sobrenome AS nome_completo, nota_exame1
FROM cap04.estudantes
WHERE nota_exame1 < 90
ORDER BY nome_completo, nota_exame1 DESC;


--trabalhando com os nomes
SELECT nome,COUNT(*) AS quantidade
from cap04.estudantes
GROUP BY nome
order by quantidade desc;

SELECT nome || ' ' || sobrenome AS nome_completo, COUNT(*) AS quantidade
FROM cap04.estudantes
GROUP BY nome || ' ' || sobrenome;


SELECT SUM(quantidade) AS soma
FROM (
    SELECT nome, COUNT(*) AS quantidade
    FROM cap04.estudantes
    GROUP BY nome
) AS subquery;


