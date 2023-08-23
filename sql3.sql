/*---------------------------------------------*/
/* Projet - M1 INFO- Bases de Données Avancées */
/* Juste Prescription des Médicaments en SQL3  */
/*---------------------------------------------*/

/*-------------------------------------------------------------*/
/* Ressources :                                                */
/* Générateur de données : www.mockaroo.com                    */
/* Données : https://base-donnees-publique.medicaments.gouv.fr */
/*-------------------------------------------------------------*/

CLEAR screen;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';
-- Console
SET SERVEROUTPUT ON;
SET SERVEROUTPUT SIZE 30000;

SELECT TO_CHAR(SYSDATE, '"SQL2 " : DAY, DD MONTH YYYY HH:MM:SS') FROM DUAL;

DROP TABLE medecin;
DROP TABLE patient;
DROP TABLE traitement;
DROP TABLE consultation;
DROP TABLE laboratoire_pharmaceutique;
DROP TABLE observation;
DROP TABLE maladie;
DROP TABLE symptome;
DROP TABLE medicament;
DROP TABLE indication;
DROP TABLE contre_indication;
DROP TABLE effet_indesirable;
DROP TABLE substance_active;
DROP TABLE classe_chimique;
DROP TABLE classe_pharmacologique;

DROP TYPE type_medecin FORCE;
DROP TYPE type_patient FORCE;
DROP TYPE type_utilisateur FORCE;
DROP TYPE type_medicament FORCE;
DROP TYPE type_traitement FORCE ;
DROP TYPE type_consultation FORCE;
DROP TYPE type_recommandation FORCE;
DROP TYPE type_laboratoire_pharmaceutique_medecin FORCE;
DROP TYPE type_laboratoire_pharmaceutique FORCE;
DROP TYPE type_observation FORCE;
DROP TYPE type_symptome FORCE;
DROP TYPE type_maladie FORCE;
DROP TYPE type_indication FORCE;
DROP TYPE type_contre_indication FORCE;
DROP TYPE type_effet_indesirable FORCE;
DROP TYPE type_substance_active FORCE;
DROP TYPE type_classe_chimique FORCE;
DROP TYPE type_classe_pharmacologique FORCE;

DROP TYPE type_nested_table_patient FORCE;
DROP TYPE type_nested_table_medecin FORCE;
DROP TYPE type_nested_table_medicament FORCE;
DROP TYPE type_nested_table_traitement FORCE;
DROP TYPE type_nested_table_consultation FORCE;
DROP TYPE type_nested_table_recommandation FORCE;
DROP TYPE type_nested_table_laboratoire_pharmaceutique FORCE;
DROP TYPE type_nested_table_observation FORCE;
DROP TYPE type_nested_table_symptome FORCE;
DROP TYPE type_nested_table_maladie FORCE;
DROP TYPE type_nested_table_indication FORCE;
DROP TYPE type_nested_table_contre_indication FORCE;
DROP TYPE type_nested_table_effet_indesirable FORCE;
DROP TYPE type_nested_table_substance_active FORCE;
DROP TYPE type_nested_table_classe_chimique FORCE;
DROP TYPE type_nested_table_classe_pharmacologique FORCE;

DROP TYPE type_table_patient FORCE;
DROP TYPE type_table_traitement FORCE;
DROP TYPE type_table_consultation FORCE;
DROP TYPE type_table_laboratoire_pharmaceutique FORCE;
DROP TYPE type_table_observation FORCE;
DROP TYPE type_table_maladie FORCE;
DROP TYPE type_table_symptome FORCE;
DROP TYPE type_table_medicament FORCE;
DROP TYPE type_table_indication FORCE;
DROP TYPE type_table_contre_indication FORCE;
DROP TYPE type_table_effet_indesirable FORCE;
DROP TYPE type_table_substance_active FORCE;
DROP TYPE type_table_classe_chimique FORCE;
DROP TYPE type_table_classe_pharmacologique FORCE;

/*------------------*/
/* Types classiques */
/*------------------*/

CREATE OR REPLACE TYPE type_utilisateur AS OBJECT (
    id INTEGER,
    nom VARCHAR2(32),
    prenom VARCHAR2(32),
    age INTEGER,
    genre CHAR,
    telephone CHAR(14)
) NOT INSTANTIABLE NOT FINAL;
/

CREATE OR REPLACE TYPE type_medecin UNDER type_utilisateur (
    diplome VARCHAR2(64),
    date_diplome DATE
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_patient UNDER type_utilisateur (
    num_carte_vitale VARCHAR2(64)
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_medicament AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64),
    url VARCHAR2(255)
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_traitement AS OBJECT (
    id INTEGER,
    date_debut DATE,
    date_fin DATE
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_consultation AS OBJECT (
    id INTEGER,
    date_debut DATE,
    date_fin DATE
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_recommandation AS OBJECT (
    id INTEGER,
    nom VARCHAR2(128)
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_laboratoire_pharmaceutique AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64)
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_observation AS OBJECT (
    id INTEGER,
    commentaire VARCHAR2(128) --  toux rauque, tache noire sur la radio des poumons, ...
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_symptome AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64) -- fatigue, vomissement, ...
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_maladie AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64), -- diabètete, hypertension, asthme, ...
    idsup INTEGER -- CONNECT BY Prior nsup = id
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_indication AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64)
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_contre_indication AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64)
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_effet_indesirable AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64),
    idsup INTEGER
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_substance_active AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64)
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_classe_chimique AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64),
    idsup INTEGER
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_classe_pharmacologique AS OBJECT (
    id INTEGER,
    nom VARCHAR2(64),
    idsup INTEGER
) INSTANTIABLE FINAL;
/

/*
	Ci-dessous, il s'agit ici des associations
	Pour certain, il n'ya que le type classique
	Et pour d'autre, il y a des associations n aire avec des attributs spéficiques (ex: type_laboratoire_pharmaceutique_medecin)
	donc pour chaque association du modèle, il faut avoir un type de nouveau créer
	mais donc mon cas, j'ai choisi d'utiliser un type pour plusieurs associations car il y'a pas d'attributs spécifique dans la plupart des 
	associations du modèle
*/
CREATE OR REPLACE TYPE type_nested_table_medecin AS TABLE OF type_medecin;
/
CREATE OR REPLACE TYPE type_nested_table_patient AS TABLE OF type_patient;
/
CREATE OR REPLACE TYPE type_nested_table_medicament AS TABLE OF type_medicament;
/
CREATE OR REPLACE TYPE type_nested_table_traitement AS TABLE OF type_traitement;
/
CREATE OR REPLACE TYPE type_nested_table_consultation AS TABLE OF type_consultation;
/
CREATE OR REPLACE TYPE type_nested_table_recommandation AS TABLE OF type_recommandation;
/
-- L'association entre laboratoire_pharmaceutique et medecin
CREATE OR REPLACE TYPE type_laboratoire_pharmaceutique_medecin AS OBJECT (
	date_embauche DATE,
	laboratoire_pharmaceutique type_laboratoire_pharmaceutique
) INSTANTIABLE FINAL;
/
CREATE OR REPLACE TYPE type_nested_table_laboratoire_pharmaceutique AS TABLE OF type_laboratoire_pharmaceutique_medecin;
/
CREATE OR REPLACE TYPE type_nested_table_observation AS TABLE OF type_observation;
/
CREATE OR REPLACE TYPE type_nested_table_symptome AS TABLE OF type_symptome;
/
CREATE OR REPLACE TYPE type_nested_table_maladie AS TABLE OF type_maladie;
/
CREATE OR REPLACE TYPE type_nested_table_indication AS TABLE OF type_indication;
/
CREATE OR REPLACE TYPE type_nested_table_contre_indication AS TABLE OF type_contre_indication;
/
CREATE OR REPLACE TYPE type_nested_table_effet_indesirable AS TABLE OF type_effet_indesirable;
/
CREATE OR REPLACE TYPE type_nested_table_substance_active AS TABLE OF type_substance_active;
/
CREATE OR REPLACE TYPE type_nested_table_classe_chimique AS TABLE OF type_classe_chimique;
/
CREATE OR REPLACE TYPE type_nested_table_classe_pharmacologique AS TABLE OF type_classe_pharmacologique;
/

/*-----------------*/
/* Types complexes */
/*-----------------*/

-- Les types pour les tables d'association
-- Dans le type_table_nom se trouve que les associations 0/1..n et pas 0/1..1

-- Pour la table patient avec ses associations
CREATE OR REPLACE TYPE type_table_medecin AS OBJECT (
    medecin type_medecin,
    nested_consultation type_nested_table_consultation,
    nested_laboratoire_pharmaceutique type_nested_table_laboratoire_pharmaceutique,
    nested_traitement type_nested_table_traitement,
    nested_medicament type_nested_table_medicament
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_patient AS OBJECT (
    patient type_patient,
    nested_consultation type_nested_table_consultation,
    nested_medicament type_nested_table_medicament,
    nested_traitement type_nested_table_traitement
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_traitement AS OBJECT (
    traitement type_traitement,
    nested_medicament type_nested_table_medicament,
    nested_recommandation type_nested_table_recommandation
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_consultation AS OBJECT (
    consultation type_consultation,
    nested_observation type_nested_table_observation
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_laboratoire_pharmaceutique AS OBJECT (
    laboratoire_pharmaceutique type_laboratoire_pharmaceutique,
    nested_medecin type_nested_table_medecin
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_observation AS OBJECT (
    observation type_observation,
    nested_maladie type_nested_table_maladie
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_maladie AS OBJECT (
    maladie type_maladie,
    nested_medicament type_nested_table_medicament,
    nested_observation type_nested_table_observation,
    nested_symptome type_nested_table_symptome
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_symptome AS OBJECT (
    symptome type_symptome,
    nested_maladie type_nested_table_maladie
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_medicament AS OBJECT (
    medicament type_medicament,
    nested_patient type_nested_table_patient,
    nested_traitement type_nested_table_traitement,
    nested_medecin type_nested_table_medecin,
    nested_maladie type_nested_table_maladie,
    nested_type_substance_active type_nested_table_substance_active,
    nested_effet_indesirable type_nested_table_effet_indesirable,
    nested_contre_indication type_nested_table_contre_indication,
    nested_indication type_nested_table_indication
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_indication AS OBJECT (
    indication type_indication,
    nested_medicament type_nested_table_medicament
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_contre_indication AS OBJECT (
    contre_indication type_contre_indication,
    nested_medicament type_nested_table_medicament
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_effet_indesirable AS OBJECT (
    effet_indesirable type_effet_indesirable,
    nested_medicament type_nested_table_medicament,
    nested_substance_active type_nested_table_substance_active,
    nested_classe_chimique type_nested_table_classe_chimique,
    nested_classe_pharmacologique type_nested_table_classe_pharmacologique
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_substance_active AS OBJECT (
    substance_active type_substance_active,
    nested_medicament type_nested_table_medicament,
    nested_effet_indesirable type_nested_table_effet_indesirable,
    nested_classe_chimique type_nested_table_classe_chimique,
    nested_classe_pharmacologique type_nested_table_classe_pharmacologique
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_classe_chimique AS OBJECT (
    classe_chimique type_classe_chimique,
    nested_effet_indesirable type_nested_table_effet_indesirable,
    nested_substance_active type_nested_table_substance_active
) INSTANTIABLE FINAL;
/

CREATE OR REPLACE TYPE type_table_classe_pharmacologique AS OBJECT (
    classe_pharmacologique type_classe_pharmacologique,
    nested_effet_indesirable type_nested_table_effet_indesirable,
    nested_substance_active type_nested_table_substance_active
) INSTANTIABLE FINAL;
/

-- Pas de dépendance, chaque table


-- Donc patient à un champ ENS medicmanet

/**
 * Il faut que le patient est sa liste des traitements (date, medecin ref)
*/

-- Pour les associations 1..n....1
-- Tables imbriqués

CREATE TABLE medecin OF type_table_medecin
    NESTED TABLE nested_consultation               STORE AS medecin_consultations,
    NESTED TABLE nested_laboratoire_pharmaceutique STORE AS medecin_laboratoire_pharmaceutiques,
    NESTED TABLE nested_traitement                 STORE AS medecin_traitements,
    NESTED TABLE nested_medicament                 STORE AS medecin_medicaments;
CREATE TABLE patient OF type_table_patient
    NESTED TABLE nested_consultation               STORE AS patient_consultations,
    NESTED TABLE nested_medicament                 STORE AS patient_medicaments,
    NESTED TABLE nested_traitement                 STORE AS patient_traitements;
CREATE TABLE traitement OF type_table_traitement
    NESTED TABLE nested_medicament                 STORE AS traitement_medicaments,
    NESTED TABLE nested_recommandation             STORE AS traitement_recommandations;
CREATE TABLE consultation OF type_table_consultation
    NESTED TABLE nested_observation                STORE AS consultation_observations;
CREATE TABLE laboratoire_pharmaceutique OF type_table_laboratoire_pharmaceutique
    NESTED TABLE nested_medecin                    STORE AS laboratoire_pharmaceutique_medecins;
CREATE TABLE observation OF type_table_observation
    NESTED TABLE nested_maladie                    STORE AS observations_maladies;
CREATE TABLE maladie OF type_table_maladie
    NESTED TABLE nested_medicament                 STORE AS maladie_medicaments,
    NESTED TABLE nested_observation                STORE AS maladie_observations,
    NESTED TABLE nested_symptome                   STORE AS maladie_symptome;
CREATE TABLE symptome OF type_table_symptome
    NESTED TABLE nested_maladie                    STORE AS symptome_maladies;
CREATE TABLE medicament OF type_table_medicament
    NESTED TABLE nested_patient                    STORE AS medicament_patients,
    NESTED TABLE nested_traitement                 STORE AS medicament_traitements,
    NESTED TABLE nested_medecin                    STORE AS medicament_medecins,
    NESTED TABLE nested_maladie                    STORE AS medicament_maladies,
    NESTED TABLE nested_type_substance_active      STORE AS medicament_substances_actives,
    NESTED TABLE nested_effet_indesirable          STORE AS medicament_effets_indesirables,
    NESTED TABLE nested_contre_indication          STORE AS medicament_contre_indications,
    NESTED TABLE nested_indication                 STORE AS medicament_indications;
CREATE TABLE indication OF type_table_indication
	NESTED TABLE nested_medicament                 STORE AS indication_medicaments;
CREATE TABLE contre_indication OF type_table_contre_indication
	NESTED TABLE nested_medicament                 STORE AS contre_indication_medicaments;
CREATE TABLE effet_indesirable OF type_table_effet_indesirable
	NESTED TABLE nested_medicament                 STORE AS effet_indesirable_medicaments,
    NESTED TABLE nested_substance_active           STORE AS effet_indesirable_substance_actives,
    NESTED TABLE nested_classe_chimique            STORE AS effet_indesirable_classe_chimiques,
    NESTED TABLE nested_classe_pharmacologique     STORE AS effet_indesirable_classe_pharmacologiques;
CREATE TABLE substance_active OF type_table_substance_active
	NESTED TABLE nested_medicament                 STORE AS substance_active_medicaments,
    NESTED TABLE nested_effet_indesirable          STORE AS substance_active_effet_indesirables,
    NESTED TABLE nested_classe_chimique            STORE AS substance_active_classe_chimiques,
    NESTED TABLE nested_classe_pharmacologique     STORE AS substance_active_classe_pharmacologiques;
CREATE TABLE classe_chimique OF type_table_classe_chimique
    NESTED TABLE nested_effet_indesirable          STORE AS classe_chimique_effet_indesirables,
    NESTED TABLE nested_substance_active           STORE AS classe_chimique_substance_actives;
CREATE TABLE classe_pharmacologique OF type_table_classe_pharmacologique
    NESTED TABLE nested_effet_indesirable          STORE AS classe_pharmacologique_effet_indesirables,
    NESTED TABLE nested_substance_active           STORE AS classe_pharmacologique_substance_actives;

-- CREATE TABLE medicament OF type_medicament;

/*------------*/
/* Insertions */
/*------------*/
	/*nested_consultation type_nested_table_consultation,
	nested_medicament type_nested_table_medicament,
	nested_traitement type_nested_table_traitement*/

INSERT INTO medecin (medecin, nested_consultation, nested_laboratoire_pharmaceutique, nested_traitement, nested_medicament) VALUES (
    type_medecin(4, 'Louise', 'Collis', 60, 'F', '07.92.92.82.92', 'Faculté de médecine de Rouen', TO_DATE('1970-DEC-25','YYYY-MON-DD','NLS_DATE_LANGUAGE=AMERICAN')),
    type_nested_table_consultation(
        type_consultation(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_consultation(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-26 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    ),
    type_nested_table_laboratoire_pharmaceutique(
        type_laboratoire_pharmaceutique_medecin(
            TO_DATE('1998-DEC-15 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),
            type_laboratoire_pharmaceutique(1, 'Laboratoire de Rouen')
        ),
        type_laboratoire_pharmaceutique_medecin(
            TO_DATE('1998-DEC-18 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),
            type_laboratoire_pharmaceutique(1, 'Laboratoire de Paris')
        )
    ),
    type_nested_table_traitement(
        type_traitement(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_traitement(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-28 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    ),
    NULL
);

INSERT INTO medecin (medecin, nested_consultation, nested_laboratoire_pharmaceutique, nested_traitement, nested_medicament) VALUES (
    type_medecin(5, 'Kippar', 'Steven', 44, 'M', '06.42.92.82.72', 'Faculté de médecine de Paris', TO_DATE('1971-DEC-25','YYYY-MON-DD','NLS_DATE_LANGUAGE=AMERICAN')),
    type_nested_table_consultation(
        type_consultation(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_consultation(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-26 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    ),
    type_nested_table_laboratoire_pharmaceutique(
        type_laboratoire_pharmaceutique_medecin(
            TO_DATE('1998-DEC-15 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),
            type_laboratoire_pharmaceutique(1, 'Laboratoire de Rouen')
        ),
        type_laboratoire_pharmaceutique_medecin(
            TO_DATE('1998-DEC-18 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),
            type_laboratoire_pharmaceutique(1, 'Laboratoire de Paris')
        )
    ),
    type_nested_table_traitement(
        type_traitement(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_traitement(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-28 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    ),
    NULL
);

INSERT INTO medecin (medecin, nested_consultation, nested_laboratoire_pharmaceutique, nested_traitement, nested_medicament) VALUES (
    type_medecin(6, 'Bendick', 'Goffe', 74, 'M', '06.32.62.32.12', 'Faculté de médecine de Marseille', TO_DATE('1972-DEC-25','YYYY-MON-DD','NLS_DATE_LANGUAGE=AMERICAN')),
    type_nested_table_consultation(
        type_consultation(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_consultation(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-26 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    ),
    type_nested_table_laboratoire_pharmaceutique(
        type_laboratoire_pharmaceutique_medecin(
            TO_DATE('1998-DEC-15 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),
            type_laboratoire_pharmaceutique(1, 'Laboratoire de Rouen')
        ),
        type_laboratoire_pharmaceutique_medecin(
            TO_DATE('1998-DEC-18 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'),
            type_laboratoire_pharmaceutique(1, 'Laboratoire de Paris')
        )
    ),
    type_nested_table_traitement(
        type_traitement(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_traitement(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-28 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    ),
    NULL
);

INSERT INTO patient (patient, nested_consultation, nested_medicament, nested_traitement) VALUES (
    type_patient(1, 'Glen', 'Bilbrook', 69, 'M', '07.82.12.92.52', '2 94 03 75 120 005 01'),
    type_nested_table_consultation(
        type_consultation(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_consultation(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-26 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    ),
    type_nested_table_medicament(
        type_medicament(1, 'blabla', 'www.blabla.com'),
        type_medicament(2, 'alibi', 'www.alibi.com')
    ),
    type_nested_table_traitement(
        type_traitement(1, TO_DATE('1998-DEC-25 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-25 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
        type_traitement(2, TO_DATE('1999-DEC-26 10:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-28 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'))
    )
);
INSERT INTO patient (patient, nested_medicament) VALUES (
    type_patient(2, 'Town', 'Cosyns', 57, 'M', '07.32.42.52.32', '2 94 03 75 120 005 02'),
    type_nested_table_medicament(
        type_medicament(1, 'blabla', 'www.blabla.com')
    )
);
INSERT INTO patient (patient, nested_medicament) VALUES (
    type_patient(3, 'Joly', 'Judron', 38, 'F', '06.32.32.52.72', '2 94 03 75 120 005 03'),
    type_nested_table_medicament(
        type_medicament(1, 'blabla', 'www.blabla.com')
    )
);

INSERT INTO traitement (traitement, nested_medicament, nested_recommandation) VALUES (
    type_traitement(1, TO_DATE('1998-DEC-14 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-15 09:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
    type_nested_table_medicament(
        type_medicament(1, 'ibuprobèfene', 'www.ibuprobèfene.com'),
        type_medicament(2, 'doliprane', 'www.doliprane.com')
    ),
    type_nested_table_recommandation(
        type_recommandation(1, 'ne pas faire de sport avec température < 5 degrés'),
        type_recommandation(2, 'faire du sport')
    )
);

INSERT INTO traitement (traitement, nested_medicament, nested_recommandation) VALUES (
    type_traitement(2, TO_DATE('1998-DEC-16 09:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-20 10:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
    type_nested_table_medicament(
        type_medicament(1, 'sirop', 'www.sirop.com'),
        type_medicament(2, 'pastille', 'www.pastille.com')
    ),
    type_nested_table_recommandation(
        type_recommandation(1, 'bien se couvrir'),
        type_recommandation(1, 'porter des gants')
    )
);

INSERT INTO consultation (consultation, nested_observation) VALUES (
    type_consultation(1, TO_DATE('1998-DEC-18 08:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-18 08:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
    type_nested_table_observation(
        type_observation(1, 'toux rauque'),
        type_observation(2, 'taches noirs sur les poumons')
    )
);

INSERT INTO consultation (consultation, nested_observation) VALUES (
    type_consultation(2, TO_DATE('1998-DEC-18 08:30','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN'), TO_DATE('1998-DEC-18 08:40','YYYY-MON-DD HH24:MI','NLS_DATE_LANGUAGE=AMERICAN')),
    type_nested_table_observation(
        type_observation(1, 'toux sèche'),
        type_observation(2, 'courbatures')
	)
);

-- TO DO :
-- INSERT laboratoire_pharmaceutique
-- INSERT observation
-- INSERT maladie
-- INSERT symptome
-- INSERT INTO medicament
-- INSERT INTO indication
-- INSERT INTO contre_indication

-- On crée chaque type et on inclut dans l'autre type mais sans ses clé etrangère
-- Donc pour patient, il inclut traitement(id,nom, duree, mais pas medecin_id ou de ref vers medecin) car c'est à rechercher dans la table medecin qui inclut

/*-------------*/
/* Contraintes */
/*-------------*/
-- Oracle : Les tables imbriquées ne peuvent pas contenir des conditions sur les contraintes
-- source : Cours 3 diapo 59/89 ou https://docs.oracle.com/en/database/oracle/oracle-database/18/sqlrf/constraint.html
/*
ALTER TABLE medecin MODIFY medecin.nom CONSTRAINT nn_medecin_nom NOT NULL;
ALTER TABLE medecin	MODIFY medecin.prenom  CONSTRAINT nn_medecin_prenom NOT NULL;
ALTER TABLE medecin	MODIFY medecin.age  CONSTRAINT nn_medecin_age NOT NULL;
ALTER TABLE medecin	MODIFY medecin.genre  CONSTRAINT nn_medecin_genre NOT NULL;
ALTER TABLE patient MODIFY patient CONSTRAINT nn_patient_nom NOT NULL;
ALTER TABLE patient	MODIFY patient.prenom  CONSTRAINT nn_patient_prenom NOT NULL;
ALTER TABLE patient	MODIFY patient.age  CONSTRAINT nn_patient_age NOT NULL;
ALTER TABLE patient	MODIFY patient.genre  CONSTRAINT nn_patient_genre NOT NULL;
*/

ALTER TABLE medecin                    ADD CONSTRAINT ck_medecin_genre                 CHECK       (medecin.genre IN ('M', 'F'));
ALTER TABLE patient                    ADD CONSTRAINT ck_patient_genre                 CHECK       (patient.genre IN ('M', 'F'));
ALTER TABLE medecin                    ADD CONSTRAINT pk_medecin_id                    PRIMARY KEY (medecin.id);
ALTER TABLE patient                    ADD CONSTRAINT pk_patient_id                    PRIMARY KEY (patient.id);
ALTER TABLE traitement                 ADD CONSTRAINT pk_traitement_id                 PRIMARY KEY (traitement.id);
ALTER TABLE consultation               ADD CONSTRAINT pk_consultation_id               PRIMARY KEY (consultation.id);
ALTER TABLE laboratoire_pharmaceutique ADD CONSTRAINT pk_laboratoire_pharmaceutique_id PRIMARY KEY (laboratoire_pharmaceutique.id);
ALTER TABLE observation                ADD CONSTRAINT pk_observation_id                PRIMARY KEY (observation.id);
ALTER TABLE symptome                   ADD CONSTRAINT pk_symptome_id                   PRIMARY KEY (symptome.id);
ALTER TABLE medicament                 ADD CONSTRAINT pk_medicament_id                 PRIMARY KEY (medicament.id);
ALTER TABLE indication                 ADD CONSTRAINT pk_indication_id                 PRIMARY KEY (indication.id);
ALTER TABLE contre_indication          ADD CONSTRAINT pk_contre_indication_id          PRIMARY KEY (contre_indication.id);
ALTER TABLE effet_indesirable          ADD CONSTRAINT pk_effet_indesirable_id          PRIMARY KEY (effet_indesirable.id);
ALTER TABLE substance_active           ADD CONSTRAINT pk_substance_active_id           PRIMARY KEY (substance_active.id);
ALTER TABLE classe_chimique            ADD CONSTRAINT pk_classe_chimique_id            PRIMARY KEY (classe_chimique.id);
ALTER TABLE classe_pharmacologique     ADD CONSTRAINT pk_classe_pharmacologique_id     PRIMARY KEY (classe_pharmacologique.id);

-- 1. une fonction/procédure qui déduit une ou plusieurs maladies à partir d’un symptôme, classées de la plus spécifique à la plus générique.
CREATE OR REPLACE PROCEDURE maladieParSymptome(symptome_id INTEGER) IS
	tntm type_nested_table_maladie;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Maladie(s) pour le symptôme '||symptome_id||':');
    SELECT s.nested_maladie INTO tntm FROM symptome s WHERE s.symptome.id = symptome_id;
    FOR i IN tntm.first..tntm.last
    LOOP
        DBMS_OUTPUT.PUT_LINE(tntm(i).nom);
    END LOOP;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Aucune maladie trouvée pour ce symptôme');
END maladieParSymptome;
/
-- Jeu de données
INSERT INTO symptome (symptome, nested_maladie) VALUES (
    type_symptome(1, 'toux'),
    type_nested_table_maladie(
        type_maladie(1, 'infections virales', NULL),
	    type_maladie(2, 'grippe saisonnière', 1),
	    type_maladie(3, 'angine', 1)
    ) 
);
INSERT INTO symptome (symptome, nested_maladie) VALUES (
    type_symptome(2, 'boutons'),
    type_nested_table_maladie(
        type_maladie(1, 'dermatologie', NULL),
	    type_maladie(2, 'acné', 1),
	    type_maladie(3, 'eczéma', 1)
    ) 
);
-- Execution
EXECUTE maladieParSymptome(1);
EXECUTE maladieParSymptome(2);

-- 2. une fonction/procédure qui permet de proposer une liste de médicaments à partir d'une maladie.
-- Si un lien maladie-médicament n'existe pas, il faudra remonter dans la hiérarchie des maladies jusqu'à trouver un médicament à proposer.
-- Pour chaque médicament, l'url d'accès à la notice sera également fournie en sortie.
CREATE OR REPLACE PROCEDURE selectProposerMedicament(maladie_id INTEGER) AS
    TYPE table_type_nested_medicament IS TABLE OF maladie.nested_medicament%ROWTYPE;
	table_nested_medicament table_type_nested_medicament;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Liste de médicament(s) pour la maladie ' || maladie_id || ' : ');
    SELECT DISTINCT m.table_nested_medicament.* BULK COLLECT INTO table_medicament FROM maladie m WHERE m.maladie.id = maladie_id;
    FOR i IN 1..table_nested_medicament.COUNT
	LOOP
		nom := table_nested_medicament(i).nom;
		url := table_nested_medicament(i).url;
		DBMS_OUTPUT.PUT_LINE('Médicament : ' || nom || ' : ' || url);
	END LOOP i;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Aucun médicament à proposer pour la maladie ' || maladie_id);
END selectProposerMedicament;
/


/*
 3. une fonction/procédure qui permet de sauvegarder le patient, son traitement
 (l'ensemble du ou des médicaments et/ou recommandations) et la ou les maladies diagnostiquées par un médecin.
 Pour contrôler les prescriptions, le système ne doit pas autoriser un médecin à prescrire un médicament pour lequel
 il a participé l'élaboration. Lancez les messages d'erreurs adéquats à l'utilisateur.
*/
CREATE OR REPLACE PROCEDURE sauvegarderPatientInfo IS
BEGIN
    NULL;
END sauvegarderPatientInfo;
/
EXECUTE sauvegarderPatientInfo();

/*
 4. une fonction/procédure qui détermine pour un médicament la liste des effets 
 indésirables connus et possibles qui seront déduits à partir des hiérarchies des
 classes chimiques et des classes pharmacologiques des substances actives.
*/
CREATE OR REPLACE PROCEDURE selectEffetIndesirableMedicament IS
BEGIN
    NULL;
END selectEffetIndesirableMedicament;
/
EXECUTE selectEffetIndesirableMedicament();

-- 5. une fonction/procédure qui permet pour chaque médecin de connaître la liste de tous les médicaments qu'il a prescrits.
CREATE OR REPLACE PROCEDURE selectMedicamentMedecin IS
BEGIN
    NULL;
END selectMedicamentMedecin;
/
EXECUTE selectMedicamentMedecin();