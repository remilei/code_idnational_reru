DROP TABLE IF EXISTS schema_work.national_anonyme_idpersonne;

CREATE TABLE schema_work.national_anonyme_idpersonne
AS 
SELECT
	idpersonne,
	dense_rank() OVER(ORDER BY id_ano) AS id_ano,
	dept
FROM 
	schema_work.national_id_ano
;

DROP TABLE schema_work.national_id_ano;
