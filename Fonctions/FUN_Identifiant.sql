CREATE OR REPLACE FUNCTION identifiant_p(
    IN nom character varying,
    IN prenom character varying,
    IN sexe character varying,
    IN date_naissance character varying,
    IN lieu_naissance character varying DEFAULT NULL::character varying,
    OUT identifiant character varying)
  RETURNS character varying AS
$BODY$
BEGIN
    identifiant = 
    CASE WHEN LENGTH(SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',1)) > 2 THEN
        CASE WHEN date_naissance NOT LIKE '00/00/0000' THEN -- CAS OÃ™ LA DATE DE NAISSANCE EST BIEN REMPLIE
                        CONCAT(CASE WHEN sexe LIKE 'M' THEN 1 ELSE 2 END,
                                  NETTOYAGE(date_naissance),
                                  SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',1),
                                  SPLIT_PART(NETTOYAGE_SAUF_ESP(prenom),' ',1),
                                  CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance LIKE '99' THEN '99---'
                                    WHEN lieu_naissance SIMILAR TO '[0-9][0-9]%' THEN SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 5) 
                                    ELSE CONCAT('00',SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 3))
                                    END,
                                  CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance SIMILAR TO '75 PARIS %' THEN SUBSTRING(lieu_naissance,'[0-2][0-9]')
                                    WHEN lieu_naissance LIKE '75 PARIS'  THEN '--'
                                    WHEN lieu_naissance SIMILAR TO '69 LYON %' THEN CONCAT('0',SUBSTRING(lieu_naissance FROM 9 FOR 1))
                                    ELSE '--' END)
                    ELSE 
                        CONCAT(CASE WHEN sexe LIKE 'M' THEN 1 ELSE 2 END, -- CAS OÃ™ ABSENCE DE DATE
                                 SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',1),
                                 SPLIT_PART(NETTOYAGE_SAUF_ESP(prenom),' ',1),
                                 CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance LIKE '99' THEN '99---'
                                    WHEN lieu_naissance SIMILAR TO '[0-9][0-9]%' THEN SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 5) 
                                    ELSE CONCAT('00',SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 3)) 
                                    END,
                                 CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance SIMILAR TO '75 PARIS %' THEN SUBSTRING(lieu_naissance,'[0-2][0-9]')
                                    WHEN lieu_naissance LIKE '75 PARIS'  THEN '--'
                                    WHEN lieu_naissance SIMILAR TO '69 LYON %' THEN CONCAT(SUBSTRING(lieu_naissance FROM 9 FOR 1),'-')
                                    ELSE '--' END)
                    END
    ELSE 
        CASE WHEN date_naissance NOT LIKE '00/00/0000' THEN -- CAS OÃ™ LA DATE DE NAISSANCE EST BIEN REMPLIE
                        CONCAT(CASE WHEN sexe LIKE 'M' THEN 1 ELSE 2 END,
                                  NETTOYAGE(date_naissance),
                                  CASE WHEN SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',2) = ''
                                    THEN SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',1)
                                    ELSE SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',2) END,
                                  SPLIT_PART(NETTOYAGE_SAUF_ESP(prenom),' ',1),
                                  CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance LIKE '99' THEN '99---'
                                    WHEN lieu_naissance SIMILAR TO '[0-9][0-9]%' THEN SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 5) 
                                    ELSE CONCAT('00',SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 3))
                                    END,
                                  CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance SIMILAR TO '75 PARIS %' THEN SUBSTRING(lieu_naissance,'[0-2][0-9]')
                                    WHEN lieu_naissance LIKE '75 PARIS'  THEN '--'
                                    WHEN lieu_naissance SIMILAR TO '69 LYON %' THEN CONCAT('0',SUBSTRING(lieu_naissance FROM 9 FOR 1))
                                    ELSE '--' END)
                    ELSE 
                        CONCAT(CASE WHEN sexe LIKE 'M' THEN 1 ELSE 2 END, -- CAS OÃ™ ABSENCE DE DATE
                                 CASE WHEN SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',2) = ''
                                    THEN SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',1)
                                    ELSE SPLIT_PART(NETTOYAGE_SAUF_ESP(nom),' ',2) END,
                                 SPLIT_PART(NETTOYAGE_SAUF_ESP(prenom),' ',1),
                                 CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance LIKE '99' THEN '99---'
                                    WHEN lieu_naissance SIMILAR TO '[0-9][0-9]%' THEN SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 5) 
                                    ELSE CONCAT('00',SUBSTRING(NETTOYAGE(lieu_naissance) FROM 1 FOR 3)) 
                                    END,
                                 CASE
                                    WHEN lieu_naissance IS NULL THEN null
                                    WHEN lieu_naissance SIMILAR TO '75 PARIS %' THEN SUBSTRING(lieu_naissance,'[0-2][0-9]')
                                    WHEN lieu_naissance LIKE '75 PARIS'  THEN '--'
                                    WHEN lieu_naissance SIMILAR TO '69 LYON %' THEN CONCAT(SUBSTRING(lieu_naissance FROM 9 FOR 1),'-')
                                    ELSE '--' END)
                    END
    END;
END;
$BODY$
LANGUAGE plpgsql


