DROP TABLE IF EXISTS schema_work.idpersonne_unifiee_dYY;

CREATE TABLE schema_work.idpersonne_unifiee_dYY(
	idpersonne character(8) UNIQUE,
	dqualp varchar(3),
	dnomlp varchar,
	dprnlp varchar,
	jdtatnss varchar(10)
	)
;
