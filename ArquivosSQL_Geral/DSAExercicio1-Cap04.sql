# SQL Para Análise de Dados e Data Science - Capítulo 04

-- Criando a tabela 'funcionarios'
CREATE TABLE cap04.funcionarios (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(50),
    sobrenome VARCHAR(50),
    salario DECIMAL(10, 2),
    departamento VARCHAR(50),
    data_contratacao DATE
);


-- Inserindo registros na tabela 'funcionarios'
INSERT INTO cap04.funcionarios (nome, sobrenome, salario, departamento, data_contratacao) VALUES
('Alice', 'Martins', 6000, 'Engenharia', '2021-06-15'),
('Bob', 'Oliveira', 5500, 'Marketing', '2020-03-21'),
('Carol', 'Ferreira', 7000, 'Engenharia', '2023-01-01'),
('Josias', 'Silva', 5000, 'RH', '2019-11-05'),
('Kevin', 'Santos', 7500, 'Engenharia', '2021-05-20'),
('Frank', 'Oliveira', 4800, 'Marketing', '2022-04-15'),
('Grace', 'Costa', 7200, 'Finanças', '2021-08-10'),
('Helen', 'Rodrigues', 6300, 'Finanças', '2020-07-01'),
('Janaina', 'Oliveira', 5100, 'RH', '2021-09-05'),
('Jack', 'Barbosa', 5800, 'Marketing', '2019-01-10'),
('Karen', 'Nunes', 6100, 'Engenharia', '2023-05-01'),
('Helen', 'Oliveira', 6500, 'Finanças', '2022-02-01'),
('Mallory', 'Almeida', 5200, 'RH', '2019-10-15'),
('Nina', 'Pereira', 6900, 'Engenharia', '2021-12-01'),
('Oscar', 'Oliveira', 5700, 'Marketing', '2020-06-30'),
('Paul', 'Siqueira', 7400, 'Finanças', '2021-04-15'),
('Quincy', 'Teixeira', 5300, 'RH', '2019-09-20'),
('Rita', 'Moreira', 5600, 'Marketing', '2017-10-15'),
('Steve', 'Moraes', 7800, 'Engenharia', '2021-07-25'),
('Keila', 'Sousa', 6400, 'Finanças', '2022-03-01');

--select * from cap04.funcionarios where 1=0;
--select * from cap04.funcionarios limit 10;

# Use SQL para responder às perguntas abaixo:

# 1- Quem são os funcionários do departamento de Engenharia? Retorne nome e sobrenome.
select nome || ' ' || sobrenome as nome_completo, departamento 
from cap04.funcionarios 
where departamento = 'Engenharia' or departamento = 'engenharia'
order by nome_completo;

# 2- Quais funcionários foram contratados em 2021 ou depois? Retorne nome, sobrenome e data_contratacao.
SELECT nome || ' ' || sobrenome AS nome_completo, data_contratacao 
FROM cap04.funcionarios
WHERE EXTRACT(YEAR FROM data_contratacao) >= 2021
order by data_contratacao asc;

SELECT COUNT(*) AS total_funcionarios_contratados_desde_2021
FROM cap04.funcionarios
WHERE EXTRACT(YEAR FROM data_contratacao) >= 2021;

# 3- Quais funcionários recebem salário entre 5000 e 6000? Retorne nome, sobrenome, salario e departamento.
SELECT nome || ' ' || sobrenome AS nome_completo, salario, departamento 
FROM cap04.funcionarios
where salario BETWEEN 5000 and 6000
order by salario desc;

--select * from cap04.funcionarios where 1=0;
# 4- Quais funcionários têm nome começando com a letra J ou com a letra B? Retorne nome, sobrenome e departamento.
SELECT nome || ' ' || sobrenome AS nome_completo, departamento
FROM cap04.funcionarios
WHERE nome LIKE 'j%' OR nome LIKE 'J%' OR nome LIKE 'b%' OR nome LIKE 'B%';

SELECT nome, sobrenome, departamento
FROM cap04.funcionarios
WHERE (nome LIKE 'j%' OR nome LIKE 'J%' OR nome LIKE 'b%' OR nome LIKE 'B%')
AND sobrenome = 'Oliveira';


# 5- Há algum funcionário cujo sobrenome tenha as letras 've', seja do departamento de Marketing e o salário seja maior do que 5500?
select * from cap04.funcionarios 
where salario > 5500
AND (departamento = 'Marketing' or departamento = 'marketing')
AND sobrenome like '%ira%';

select COUNT (*) as resultado
from cap04.funcionarios 
where salario > 5500
AND (departamento = 'Marketing' or departamento = 'marketing')
AND sobrenome like '%ira%'; 








