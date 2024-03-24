INSERT INTO schema_work.national_id_ano
SELECT 
	idpersonne,
	id_ano,
	'YY'
FROM 
	schema_work.idpersonne_unifiee_dYY
;