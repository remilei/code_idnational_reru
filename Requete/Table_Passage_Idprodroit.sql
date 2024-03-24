DROP TABLE IF EXISTS schema_work.table_passage_anonyme_dYY;

CREATE TABLE schema_work.table_passage_anonyme_dYY AS
SELECT
	t1.idprodroit,
	t1.idpersonne,
	t1.annee_naissance,
	t1.sexe,
	t2.id_ano
FROM 
	schema_work.dYY_passage_idprodroit_idpersonne AS t1
JOIN
	schema_work.dYY_anonyme_idpersonne AS t2
ON 
	t1.idpersonne = t2.idpersonne
;
	