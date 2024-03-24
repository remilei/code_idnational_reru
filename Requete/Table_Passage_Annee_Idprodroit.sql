DROP TABLE IF EXISTS schema_work.table_passage_final_dYY;

DROP INDEX IF EXISTS schema_work_dYY_iprodroit_temp;

CREATE INDEX schema_work_dYY_iprodroit_temp ON schema_work.table_passage_anonyme_dYY USING BTREE(idprodroit);

CREATE TABLE schema_work.table_passage_final_dYY AS 
SELECT
	t1.idprodroit,
	t1.id_ano,
	t1.annee_naissance,
	t1.sexe,
	CASE WHEN t20.ccodro IS NOT NULL THEN t20.ccodro ELSE NULL END AS presence_2020,
	CASE WHEN t19.ccodro IS NOT NULL THEN t19.ccodro ELSE NULL END AS presence_2019,
	CASE WHEN t18.ccodro IS NOT NULL THEN t18.ccodro ELSE NULL END AS presence_2018,
	CASE WHEN t17.ccodro IS NOT NULL THEN t17.ccodro ELSE NULL END AS presence_2017,
	CASE WHEN t16.ccodro IS NOT NULL THEN t16.ccodro ELSE NULL END AS presence_2016,
	CASE WHEN t15.ccodro IS NOT NULL THEN t15.ccodro ELSE NULL END AS presence_2015,
	CASE WHEN t14.ccodro IS NOT NULL THEN t14.ccodro ELSE NULL END AS presence_2014,
	CASE WHEN t13.ccodro IS NOT NULL THEN t13.ccodro ELSE NULL END AS presence_2013,
	CASE WHEN t12.ccodro IS NOT NULL THEN t12.ccodro ELSE NULL END AS presence_2012,
	CASE WHEN t11.ccodro IS NOT NULL THEN t11.ccodro ELSE NULL END AS presence_2011,
	CASE WHEN t09.ccodro IS NOT NULL THEN t09.ccodro ELSE NULL END AS presence_2009
FROM 
	schema_work.table_passage_anonyme_dYY AS t1
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2020_proprietaire_droit_non_ano AS t20
ON 
	t1.idprodroit = t20.idprodroit AND t1.idpersonne = t20.idpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2019_proprietaire_droit_non_ano AS t19
ON 
	t1.idprodroit = t19.idprodroit AND t1.idpersonne = t19.idpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2018_proprietaire_droit_non_ano AS t18
ON 
	t1.idprodroit = t18.idprodroit AND t1.idpersonne = t18.idpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2017_proprietaire_droit_non_ano AS t17
ON 
	t1.idprodroit = t17idprodroit AND t1.idpersonne = t417dpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2016_proprietaire_droit_non_ano AS t16
ON 
	t1.idprodroit = t16idprodroit AND t1.idpersonne = t516dpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2015_proprietaire_droit_non_ano AS t15
ON 
	t1.idprodroit = t15idprodroit AND t1.idpersonne = t615dpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2014_proprietaire_droit_non_ano AS t14
ON 
	t1.idprodroit = t14idprodroit AND t1.idpersonne = t714dpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2013_proprietaire_droit_non_ano AS t13
ON 
	t1.idprodroit = t13idprodroit AND t1.idpersonne = t813dpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2012_proprietaire_droit_non_ano AS t12
ON 
	t1.idprodroit = t12idprodroit AND t1.idpersonne = t912dpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2011_proprietaire_droit_non_ano AS t11
ON 
	t1.idprodroit = t11.idprodroit AND t1.idpersonne = t11.idpersonne
LEFT JOIN
	ff_proprietaire_non_anonyme.dYY_2009_proprietaire_droit_non_ano AS t09
ON 
	t1.idprodroit = t09.idprodroit AND t1.idpersonne = t09.idpersonne

; 
