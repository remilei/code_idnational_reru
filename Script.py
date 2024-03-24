import os 
import psycopg2 as psy
import numpy as np

disclaimer = """
*******************************************************
* MESSAGE :
* Script qui génère un identifiant unique propriétaire
* AVANT DE VOUS CONNCETER
* Il faut spécifier la base sur laquelle le script est 
* appliqué. Il faut spécifier aussi le schéma dans le-
* quel se trouve les données foncières. Il faut enfin 
* spécifier le schéma de travail dans lequel travailler
* MESSAGE:
* Le script est actuellement prévu pour les années 2020
* à 2009. Il faut a priori ajouter les dernières années
* en préambule. Il faut veiller à ce que les noms de va-
* riables soient les mêmes sur chaque millésime (y com-
* pris le nom des tables).
* Ceci est le code de base utilisé dans la création de
* l'identifiant propriétaire tel que décrit dans l'ar-
* ticle de la RERU.
* AUTEUR : Rémi Lei
*******************************************************
"""

print(disclaimer)

username = input("Username: ")
password = getpass.getpass()
port = input("Port: ")
host = input("Host: ")
dbname = input("Database: ")



try:
	conn = psy.connect(dbname= dbname, user= username,port = port,host = host,password = password) ## CONNEXION VIA SSH
	cur = conn.cursor()
	print("Connexion réussie !")
except:
	print("Connexion échouée")

departement = ["%.2d" % i for i in range(1,20)]
departement += ["%.2d" % i for i in range(21,96)]
departement += ["2A","2B"]

schema_work = input("Schema de destination :")

annee = ["2020","2019","2018","2017","2016","2015","2014","2013","2012","2011","2009"]
## CREATION FONCTIONS
## Création des fonctions permettant de générer l'identifiant national. 
## Contient des fonctions de nettoyages et de construction d'identifiant
## basées sur la concaténation, suppression de tirets, etc.
## Ces fonctions sont nécessaires pour exécuter le script.

with open("Fonctions/FUN_Identifiant.sql","r") as fichier:
	requete = fichier.read()
cur.execute(requete)
conn.commit()
print("Création Fonctions")

with open("Fonctions/FUN_Nettoyage.sql","r") as fichier:
	requete = fichier.read()
cur.execute(requete)
conn.commit()
print("Création Fonctions")

## TABLE UNIFIEE IDPERSONNE
## Dans cette phase, l'objectif est de compiler dans une table unique
## les états civils uniques associés à chaque idpersonne depuis 2011.
## Pour chaque idpersonne existant dans les données fiscales, nous
## retenons le dernier état civil disponible. L'objectif est ainsi de 
## conserver l'état civil le plus récent, afin de prendre en compte
## d'éventuelles mises à jour. En travaillant sur les idpersonne uniques, 
## on s'assure de l'invariance de l'identifiant dans le temps.

try:
	with open("Requete/Unifiee_Idpersonne_Creation.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))
			conn.commit()
			print("Création ok pour le département " + str(j))
except:
	print("Problème de création")

## Concernant l'état civil, nous retenons le nom et prénom de
## naissance. Nous avons identifié qu'il existe des différences 
## entre les millésimes dans le codage de la variable. Ainsi, 
## on modifie la requête de sorte à conserver les noms de 
## naissance uniquement. Les tables sont calculées au département
## au regard de l'arborescence des tables au CEREMA.

try:
	for j in departement:
		for i in annee:
			if str(i) in ['2020','2019','2018','2017','2016']:
				nom_fichier = "Requete/Unifiee_Idpersonne_Insertion.sql"
			else:
				nom_fichier = "Requete/Unifiee_Idpersonne_Insertion_2.sql"
			with open(nom_fichier,"r") as fichier:
				requete = fichier.read()
				cur.execute(requete.replace("YY",str(j)).replace("AAAA",str(i)).replace("schema_work",schema_work))
				conn.commit()
			print("Insertion réalisée pour le département " + str(j) + " - " + str(i))
except:
	print("Problème dans l'insertion")


## GENERATION IDENTIFIANT
## Dans cette étape, à partir des données d'état civil unique,
## l'identifiant national est calculé. Pour le format exact,
## nous conseillons la lecture du papier dans la RERU.

try:
	with open("Requete/Identifiant.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))	
			conn.commit()
			print("Identifiant créé pour le département " + str(j))
except:
	print("Identifiant non créé.")

## Puisque les tables identifiant idpersonne sont créées 
## au niveau départemental, nous créons une table national
## et insérons les données de chaque département.
## MESSAGE : À voir comment on anonymise le travail, 
## mais si un algorithme de hash est utilisé et renvoie
## toujours le même résultat pour le même input, alors
## ce passage n'est pas nécessaire. La montée au niveau 
## nationale permet de gérer l'anonymisation par un entier.

try:
	with open("Requete/National_Creation.sql","r") as fichier:
		requete = fichier.read()
		cur.execute(requete.replace("schema_work",schema_work))
		conn.commit()
		print("Table nationale créée")
except:
	print("Problème dans la création")

try:
	with open("Requete/National_Insertion.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))
			conn.commit()
			print("Insertion des données dans la table" + str(j))
except:
	print("Problème dans l'insertion")

try:
	with open("Requete/Anonymisation.sql","r") as fichier:
		requete = fichier.read()
		cur.execute(requete.replace("schema_work",schema_work))
		conn.commit()
		print("Anonymisation réussie.")
except:
	print("Problème dans l'anonymisation")

## Suite à l'anonymisation, il y a un retour aux tables départementales.
## Cette complication est due à l'arborescence des Fichiers Fonciers
## au CEREMA qui sont construits et produits au niveau du département.
## Il n'y avait pas de tables nationales en interne.

try:
	with open("Requete/Table_Departementale.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))
			conn.commit()
			print("Table anonyme départementale " + str(j))
except:
	print("Problème dans la création des tables départementales")

# TABLE IDPRODROIT IDPERSONNE
# Pour gérer la jointure plus facilement, on construit des tables
# de passage idpersonne idprodroit. Je ne suis pas sur que ce soit
# vraiment nécessaire, on peut travailler à une reprise du script
# pour simplification.

try:
	with open("Requete/Idprodroit_Idpersonne_Creation.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))
			conn.commit()
			print("Création table idprodroit - idpersonne pour le département " + str(j))
except:
	print("Problème dans la création")

try:
	with open("Requete/Idprodroit_Idpersonne_Insertion.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			for i in annee:
				cur.execute(requete.replace("YY",str(j)).replace("AAAA",str(i)).replace("schema_work",schema_work))
				conn.commit()
				print("Insertion réalisée pour le département  " + str(j) + " - " + str(i))
except:
	print("Problème dans l'insertion unique")

## Les informations propriétaires sont aussi ajoutées à partir
## des tables disponibles dans les Fichiers Fonciers. Là encore, 
## je pense qu'on peut optimiser le travail.

try:
	with open("Requete/Table_Passage_Idprodroit.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))
			conn.commit()
			print("Table de passage idprodroit créé pour le département " + str(j))
except:
	print("Problème dans la création des tables de passage")

## Les tables sont ensuite générées par année, afin de pouvoir
## être appariées avec l'arborescence des FF.

try:
	with open("Requete/Table_Passage_Annee_Idprodroit.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))
			conn.commit()
			print("Table Passage par année pour le département " + str(j))
except:
	print("Problème dans la table de passage annuelle")

## Dernière étape pour assurée l'unicité des tables construites.

try:
	with open("Requete/Unicite.sql","r") as fichier:
		requete = fichier.read()
		for j in departement:
			cur.execute(requete.replace("YY",str(j)).replace("schema_work",schema_work))
			conn.commit()
			print("Unicité " + str(j))
except:
	print("Problème dans l'unicité'")

## L'identifiant unique est généré pour les données FF sur l'ensemble des millésimes.
## La table de sortie est table_passage_final_dYY pour chaque département.

try:
	conn.close()
	print("Fermeture réussie")
except:
	print("Problème de fermeture")



