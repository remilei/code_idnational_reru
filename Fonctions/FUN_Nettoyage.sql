CREATE OR REPLACE FUNCTION NETTOYAGE(chaine_1 varchar, OUT chaine_propre varchar) AS
$func$
BEGIN
	chaine_propre = REPLACE(REPLACE(REPLACE(REPLACE(chaine_1,'-',''),' ',''),'''',''),'/','');
END;
$func$
LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION NETTOYAGE_SAUF_ESP(chaine_1 varchar, OUT chaine_propre varchar) AS
$func$
BEGIN
	chaine_propre = REPLACE(REPLACE(REPLACE(chaine_1,'-',''),'''',''),'/','');
END;
$func$
LANGUAGE plpgsql;

SELECT NETTOYAGE('TEST DE-N''ETTOYAGE ');
SELECT NETTOYAGE_SAUF_ESP('TEST DE-N''ETTOYAGE ');
SELECT NETTOYAGE('06/07/1996');