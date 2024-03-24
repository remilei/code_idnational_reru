INSERT INTO schema_work.idpersonne_unifiee_dYY
SELECT 
	idpersonne,
	dqualp,
	CASE WHEN epxnee = 'NEE' THEN dnomcp ELSE dnomlp END,
	CASE WHEN epxnee = 'NEE' THEN dprncp ELSE dprnlp END,
	jdatnss
FROM 
	ff_proprietaire_non_anonyme.dYY_AAAA_proprietaire_droit_non_ano
WHERE 
	dqualp IS NOT NULL
GROUP BY 
	1,2,3,4,5
ON CONFLICT (idpersonne) DO NOTHING;