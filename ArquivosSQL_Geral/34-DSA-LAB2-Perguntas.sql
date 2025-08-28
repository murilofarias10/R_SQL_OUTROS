--Crie uma query mostrando diversas métricas por centro de custo
--A query deve mostrar: contagem_lançamentos, total_valores_lançamentos,
--media_valores_lançamento, maior_valor, menor_valor,
--soma_valores_usd, soma_valores_eur, soma_valores_brl, media_taxa_conversao e mediana_valores
SELECT 
	centro_custo,
	COUNT(*) AS contagem_lançamentos,
	SUM(valor) AS total_valores_lançamentos,
	ROUND(AVG(valor),2) AS media_valores_lançamentos,
	MAX(valor) AS maior_valor, MIN(valor) AS menor_valor,
	SUM(CASE WHEN moeda = 'USD' THEN valor ELSE 0 END) AS soma_valores_usd,
	SUM(CASE WHEN moeda = 'BRL' THEN valor ELSE 0 END) AS soma_valores_brl,
	SUM(CASE WHEN moeda = 'EUR' THEN valor ELSE 0 END) AS soma_valores_eur,
	ROUND(AVG(CASE WHEN taxa_conversao IS NULL THEN 0 ELSE taxa_conversao END),2) AS taxa_conversao_sem_null,
	PERCENTILE_CONT(0.5) WITHIN GROUP (ORDER BY valor) as mediana_valores
FROM cap13.lancamentosdsacontabeis
GROUP BY centro_custo
ORDER BY total_valores_lançamentos DESC


--Distribuição de dados
--Crie uma query para mostrar a distribuição de dados na tabela
--Estamos interessandos na columa valor.
-- O relatório deve mostrar: quantidade_lancamentos, media_valor, desvio_padrão_valor, menor_valor
--maior_valor e priemiro, segunda e terceiro quartil
-- faça tudo isso por centro de custo e por moeda
SELECT 
	centro_custo, moeda, 
	count(valor) as quantidade_lancamentos,
	ROUND(STDDEV(valor)::NUMERIC, 2) as std,
	ROUND(AVG(valor),2) as media,
	MIN(valor) as menor_valor,
	MAX(valor) as maior_valor,
	ROUND(PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY valor)::NUMERIC, 2) as first_quatile,
	ROUND(PERCENTILE_CONT(0.50) WITHIN GROUP (ORDER BY valor)::NUMERIC, 2) as second_quatile,
	ROUND(PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY valor)::NUMERIC, 2) as third_quatile
FROM cap13.lancamentosdsacontabeis
GROUP BY centro_custo, moeda
ORDER BY centro_custo, quantidade_lancamentos DESC


--Calcule valor total dos lançamentos
--Calcule a meédia dos lançamentos
--Calcule a contagem dos lançamentos
--Calcule a média do valor de taxa de conversão somente se a moeda for diferente de BRL
--Crie ranking por valor total dos lançamentos, por média do valor dos lançamentos e por média da taxa de conversão
--queremos o resultado somente se o centro de custo for compras ou RH
SELECT centro_custo, moeda, 
	total_lancamentos, RANK() OVER (ORDER BY total_lancamentos DESC) AS rank_valor_lancamento,
	media_lancamento, RANK() OVER (ORDER BY media_lancamento DESC) AS rank_media_lancamentos,
	media_conversao, RANK() OVER (ORDER BY media_conversao ASC) AS rank_media_conversao
FROM(
SELECT centro_custo, moeda, SUM(valor_total_lancamentos) total_lancamentos, 
ROUND(AVG(media_lancamentos)::NUMERIC ,2) as media_lancamento, 
ROUND(AVG(media_taxa_conversao)::NUMERIC,2) as media_conversao FROM(
		SELECT centro_custo, valor_total_lancamentos, media_lancamentos, moeda, 
			ROUND(AVG(taxa_conversao),2) AS media_taxa_conversao FROM(
					SELECT
						SUM(valor) AS valor_total_lancamentos,
						ROUND(AVG(valor),2) AS media_lancamentos,
						centro_custo, moeda,
						CASE WHEN taxa_conversao IS NULL THEN 0 ELSE taxa_conversao END AS taxa_conversao
					FROM cap13.lancamentosdsacontabeis
					GROUP BY centro_custo, moeda, taxa_conversao
		ORDER BY centro_custo) AS SUB_first
		WHERE moeda = 'EUR' OR moeda = 'USD'
		GROUP BY centro_custo, valor_total_lancamentos, media_lancamentos, centro_custo, moeda
) AS SUB_second
WHERE centro_custo = 'Compras' OR centro_custo = 'RH'
GROUP BY centro_custo, moeda
ORDER BY centro_custo, moeda
) AS SUB_third


SELECT centro_custo, moeda, 
	total_lancamentos, RANK() OVER (PARTITION BY centro_custo ORDER BY total_lancamentos DESC) AS rank_valor_lancamento,
	media_lancamento, RANK() OVER (PARTITION BY centro_custo ORDER BY media_lancamento DESC) AS rank_media_lancamentos,
	media_conversao, RANK() OVER (PARTITION BY centro_custo ORDER BY media_conversao ASC) AS rank_media_conversao
FROM(
SELECT centro_custo, moeda, SUM(valor_total_lancamentos) total_lancamentos, 
ROUND(AVG(media_lancamentos)::NUMERIC ,2) as media_lancamento, 
ROUND(AVG(media_taxa_conversao)::NUMERIC,2) as media_conversao FROM(
		SELECT centro_custo, valor_total_lancamentos, media_lancamentos, moeda, 
			ROUND(AVG(taxa_conversao),2) AS media_taxa_conversao FROM(
					SELECT
						SUM(valor) AS valor_total_lancamentos,
						ROUND(AVG(valor),2) AS media_lancamentos,
						centro_custo, moeda,
						CASE WHEN taxa_conversao IS NULL THEN 0 ELSE taxa_conversao END AS taxa_conversao
					FROM cap13.lancamentosdsacontabeis
					GROUP BY centro_custo, moeda, taxa_conversao
		ORDER BY centro_custo) AS SUB_first
		WHERE moeda = 'EUR' OR moeda = 'USD'
		GROUP BY centro_custo, valor_total_lancamentos, media_lancamentos, centro_custo, moeda
) AS SUB_second
WHERE centro_custo = 'Compras' OR centro_custo = 'RH'
GROUP BY centro_custo, moeda
ORDER BY centro_custo, moeda
) AS SUB_third

SELECT A.centro_custo, A.moeda,
	SUM(a.valor) AS total_valor_lancamento,
	DENSE_RANK() OVER (ORDER BY SUM(A.valor) DESC) AS rank_total_valor,
	ROUND(AVG(A.valor), 2) AS media_lancamento,
	DENSE_RANK() OVER (ORDER BY AVG(A.valor) DESC) AS rank_media_lancamento,
	COUNT(*) as qtd_total_lancamento
	FROM cap13.lancamentosdsacontabeis A
GROUP BY A.centro_custo, A.moeda

SELECT A.centro_custo, A.moeda,
	SUM(a.valor) AS total_Vvalor_lancamento,
	RANK() OVER (ORDER BY SUM(a.valor) DESC) AS rank_total_valor,
	ROUND(AVG(A.valor), 2) AS media_lancamento,
	RANK() OVER (ORDER BY AVG(a.valor) DESC) AS rank_media_lancamento,
	COUNT(*) as qtd_total_lancamento,
	COALESCE(ROUND(AVG(A.taxa_conversao) FILTER (WHERE A.moeda = 'USD' or  A.moeda = 'EUR'),2),0) as media_taxa_conversao,
	RANK() OVER (ORDER BY COALESCE(ROUND(AVG(A.taxa_conversao) FILTER (WHERE A.moeda = 'USD' or  A.moeda = 'EUR'),2),0)DESC) as rank_media_taxa
	FROM cap13.lancamentosdsacontabeis A
WHERE A.centro_custo = 'RH' OR A.centro_custo = 'Compras'
GROUP BY A.centro_custo, A.moeda
