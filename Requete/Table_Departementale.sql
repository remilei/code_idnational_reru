DROP TABLE IF EXISTS schema_work.dYY_anonyme_idpersonne;

CREATE TABLE schema_work.dYY_anonyme_idpersonne AS
SELECT 
	idpersonne,
	id_ano
FROM 
	schema_work.national_anonyme_idpersonne
WHERE
	dept = 'YY'
;