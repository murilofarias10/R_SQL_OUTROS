--Crie uma query mostrando diversas métricas por centro de custo
--A query deve mostrar: contagem_lançamentos, total_valores_lançamentos,
--media_valores_lançamento, maior_valor, menor_valor,
--soma_valores_usd, soma_valores_eur, soma_valores_brl, media_taxa_conversao e mediana_valores
SELECT * FROM cap13.lancamentosdsacontabeis LIMIT 10

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

	




