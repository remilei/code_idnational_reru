DROP TABLE IF EXISTS schema_work.table_passage_anonyme_dYY_v2;

CREATE TABLE schema_work.table_passage_final_dYY_v2 AS
SELECT 
	idprodroit,
	id_ano,
	annee_naissance,
	CASE WHEN sexe = 'M' THEN 1 ELSE 2 END AS sexe,
	presence_2020,
	presence_2019,
	presence_2018,
	presence_2017,
	presence_2016,
	presence_2015,
	presence_2014,
	presence_2013,
	presence_2012,
	presence_2011,
	presence_2009
FROM 
	schema_work.table_passage_final_dYY
GROUP BY 
	idprodroit,
	id_ano,
	annee_naissance,
	sexe,
	presence_2020,
	presence_2019,
	presence_2018,
	presence_2017,
	presence_2016,
	presence_2015,
	presence_2014,
	presence_2013,
	presence_2012,
	presence_2011,
	presence_2009
;

DROP TABLE IF EXISTS schema_work.table_passage_final_dYY;

ALTER TABLE schema_work.table_passage_final_dYY_v2
RENAME TO table_passage_final_dYY;