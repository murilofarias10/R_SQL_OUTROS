-- DIO Usando DBeaver
-- Alterado comando global para executar script com F5
-- Arquivo > Propriedades > Conf. Globais > Interface Usuario > Chaves


SELECT AlbumId, Column1  FROM Album
WHERE  Column1 IS NOT NULL

SELECT AlbumId, Title, Column1  FROM Album
WHERE  Column1 IS NULL

SELECT 
	(SELECT COUNT(*) FROM Album) AS TOTAL_REGISTROS,
    (SELECT COUNT(*) FROM Album WHERE Column1 IS NULL) AS TOTAL_NULOS,
    (SELECT COUNT(*) FROM Album WHERE Column1 IS NOT NULL) AS TOTAL_NAO_NULOS
    
    SELECT * FROM Album
    SELECT * FROM Artist
    

       
   SELECT 
   	Album.ArtistId , Album.Title, Album.Column1, 
   	Artist.Name, Artist.ArtistId 
   FROM Album Album, Artist Artist
   WHERE Album.ArtistId = Artist.ArtistId 
   AND Album.Column1 IS NULL

--Qual a quantidade distintas de registros por artistas que esteja NULL Column1 ? 
   -- Com duplicados 344 | Distintos 203 
 
 SELECT COUNT(Name) AS TOTAL_LINHAS, COUNT(DISTINCT Name) AS TOTAL_DISTINTOS
 	FROM(
		 SELECT 
		 	Album.ArtistId, Album.Title, Album.Column1,
		 	Artist.Name
		 FROM Album Album, Artist Artist
		 WHERE Album.ArtistId = Artist.ArtistId 
		 AND Album.Column1 IS NULL
)

 SELECT Name, Title, Column1
 	FROM(
		 SELECT 
		 	Album.ArtistId, Album.Title, Album.Column1,
		 	Artist.Name
		 FROM Album Album, Artist Artist
		 WHERE Album.ArtistId = Artist.ArtistId 
		 AND Album.Column1 IS NULL
)
GROUP BY Name
ORDER BY Name ASC 

--Qual a quantidade de registros por artistas que não esteja NULL Column1 ? 
   --Com duplicados 3 | Distintos 2

 SELECT COUNT(Name) AS TOTAL_LINHAS, COUNT(DISTINCT Name) AS TOTAL_DISTINTOS
 	FROM(
		 SELECT 
		 	Album.ArtistId, Album.Title, Album.Column1,
		 	Artist.Name
		 FROM Album Album, Artist Artist
		 WHERE Album.ArtistId = Artist.ArtistId 
		 AND Album.Column1 IS NOT NULL
)

 SELECT Name, Title, Column1
 	FROM(
		 SELECT 
		 	Album.ArtistId, Album.Title, Album.Column1,
		 	Artist.Name
		 FROM Album Album, Artist Artist
		 WHERE Album.ArtistId = Artist.ArtistId 
		 AND Album.Column1 IS NOT NULL
)
GROUP BY Name
ORDER BY Name ASC


 SELECT COUNT(Name) AS TOTAL_LINHAS, COUNT(DISTINCT Name) AS TOTAL_DISTINTOS
 	FROM(
		 SELECT 
		 	Album.ArtistId, Album.Title, Album.Column1,
		 	Artist.Name
		 FROM Album Album, Artist Artist
		 WHERE Album.ArtistId = Artist.ArtistId 
		 AND Album.Column1 IS NULL
)


--Analisando Custumer and Invoice
SELECT COUNT(*) AS TOTAL_LINHAS FROM Customer c 

--Analisando países
SELECT * FROM Customer c 
WHERE Country  = 'Brazil'

SELECT State, COUNT(State) FROM Customer c 
WHERE Country  = 'Brazil'
GROUP BY State
ORDER BY State 

SELECT Country, COUNT(Country) AS TOTAL FROM Customer c 
GROUP BY Country
ORDER BY TOTAL DESC

--Analisando por estado
SELECT State, COUNT(*) AS TOTAL FROM Customer c 
GROUP BY State
ORDER BY TOTAL DESC

SELECT 
	c.CustomerId, c.FirstName, c.LastName, c.Country,
	i.InvoiceDate, i.Total 
FROM Customer c, Invoice i 
WHERE 
	c.CustomerId = i.CustomerId 
ORDER BY c.CustomerId


--Compras linha x linha
SELECT 
	c.FirstName, c.LastName, c.Country,
	i.CustomerId, i.Total 
FROM Customer c, Invoice i
WHERE 
	c.CustomerId = i.CustomerId 
ORDER BY c.CustomerId ASC

SELECT FirstName,  strftime('%m', InvoiceDate) AS MES, TOTAL
FROM(
	SELECT 
	c.CustomerId, c.FirstName, c.LastName, c.Country,
	i.InvoiceDate, SUM(i.Total) AS TOTAL 
FROM Customer c, Invoice i 
WHERE 
	c.CustomerId = i.CustomerId 
GROUP BY c.CustomerId 
) AS SUBQUERIE 


-- Compras total por usuario       
SELECT  c.CustomerId, c.FirstName, SUM(i.Total) AS TOTAL 
FROM    Customer c, Invoice i 
WHERE   c.CustomerId = i.CustomerId 
GROUP BY c.CustomerId
ORDER BY TOTAL DESC 

-- ordernador Compras dia mes ano
SELECT 
	CustomerId,
	FirstName, Total,
	strftime("%d", InvoiceDate) AS DIA, 
	strftime("%m", InvoiceDate) AS MES, 
	strftime("%Y", InvoiceDate) AS ANO
FROM(
SELECT 
	c.FirstName, c.LastName, c.Country,
	i.CustomerId, i.Total, i.InvoiceDate 
FROM Customer c, Invoice i
WHERE 
	c.CustomerId = i.CustomerId 
ORDER BY c.FirstName ASC
) AS SUBQUERIES

SELECT FirstName, COUNT(FirstName) AS QUANTIDADE FROM Customer c 
GROUP BY FirstName 
ORDER BY QUANTIDADE DESC


SELECT 
	FirstName, SUM(Total) AS TOTAL, 
	strftime("%d", InvoiceDate) AS DIA, 
	strftime("%m", InvoiceDate) AS MES, 
	strftime("%Y", InvoiceDate) AS ANO
FROM(
SELECT 
	c.FirstName, c.LastName, c.Country,
	i.CustomerId, i.Total, i.InvoiceDate 
FROM Customer c, Invoice i
WHERE 
	c.CustomerId = i.CustomerId 
ORDER BY c.CustomerId ASC
) AS SUBQUERIES
GROUP BY FirstName
ORDER BY TOTAL DESC

--Verificando tabela Employee
SELECT * FROM Customer c 
SELECT * FROM Invoice i 
SELECT * FROM Employee e 

--Nenhum de employee está em Customer, validação: Nome Completo
SELECT c.FirstName || ' ' || c.LastName  AS FULLNAME FROM Customer c
ORDER BY FULLNAME

SELECT e.FirstName || ' ' || e.LastName  AS FULLNAME FROM Employee e
ORDER BY FULLNAME

SELECT
	c.FirstName || ' ' || c.LastName AS NOME_COMPLETO_CUSTOMER,
	e.FirstName || ' ' || e.LastName AS NOME_COMPLETO_EMPLOYEE
FROM Employee e, Customer c
WHERE NOME_COMPLETO_CUSTOMER = NOME_COMPLETO_EMPLOYEE

-- Avaliando utilizando somente o first name para company null
SELECT
	c.FirstName AS FIRST_C,
	c.LastName  AS LAST_C,
	e.FirstName AS FIRST_E,
	e.LastName AS LAST_E,
	c.Company 
FROM Employee e, Customer c
WHERE FIRST_C = FIRST_E

--Validando o porque é errado utilizar somente o FIST NAME
SELECT FirstName, LastName FROM Employee e WHERE FirstName = 'Steve' OR FirstName = 'Robert'

SELECT FirstName, LastName FROM Customer c WHERE FirstName = 'Steve' OR FirstName = 'Robert'
