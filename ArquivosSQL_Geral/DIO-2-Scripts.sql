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

--Qual a quantidade de registros por artistas ? 
   
     SELECT 
   	DISTINCT Artist.Name, COUNT(Artist.Name) 
   FROM Album Album, Artist Artist
   WHERE Album.ArtistId = Artist.ArtistId 

