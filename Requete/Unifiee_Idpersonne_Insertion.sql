INSERT INTO schema_work.idpersonne_unifiee_dYY
SELECT 
	idpersonne,
	dqualp,
	dnomlp,
	dprnlp,
	jdatnss
FROM 
	ff_proprietaire_non_anonyme.dYY_AAAA_proprietaire_droit_non_ano
WHERE 
	dqualp IS NOT NULL
GROUP BY 
	idpersonne,
	dqualp,
	dnomlp,
	dprnlp,
	jdatnss
ON CONFLICT (idpersonne) DO NOTHING;