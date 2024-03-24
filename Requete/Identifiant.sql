ALTER TABLE schema_work.idpersonne_unifiee_dYY
DROP COLUMN IF EXISTS id_ano;

ALTER TABLE schema_work.idpersonne_unifiee_dYY
ADD COLUMN id_ano varchar;

UPDATE schema_work.idpersonne_unifiee_dYY
SET id_ano = CASE WHEN NOT(jdtatnss LIKE '%0000' OR jdtatnss LIKE '%00/%' OR jdtatnss IS NULL OR jdtatnss LIKE '01/01/1900' OR jdtatnss LIKE '01/01/1850') THEN IDENTIFIANT_P(dnomlp,dprnlp,'M',jdtatnss)
ELSE idpersonne END;

