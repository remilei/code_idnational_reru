DROP TABLE IF EXISTS schema_work.dYY_passage_idprodroit_idpersonne;

CREATE TABLE schema_work.dYY_passage_idprodroit_idpersonne(
	idpersonne character(8),
	idprodroit character(13),
	annee_naissance varchar(4),
	sexe varchar(3),
	CONSTRAINT unicite_dYY UNIQUE(idprodroit,idpersonne)
	)
;