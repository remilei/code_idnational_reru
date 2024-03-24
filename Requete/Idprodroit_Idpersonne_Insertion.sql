INSERT INTO dYY_passage_idprodroit_idpersonne
SELECT 
	idpersonne,
	idprodroit,
	SUBSTRING(jdatnss FROM 7 FOR 4),
	dqualp
FROM 
	ff_proprietaire_non_anonyme.dYY_AAAA_proprietaire_droit_non_ano
ON CONFLICT ON CONSTRAINT unicite_dYY
DO NOTHING;