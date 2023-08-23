/*---------------------------------------------*/
/* Projet - M1 INFO- Bases de Données Avancées */
/* Juste Prescription des Médicaments en SQL2  */
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

ALTER TABLE patient                                  DROP CONSTRAINT fk_patient_utilisateur_id;
ALTER TABLE medicament_medecin                       DROP CONSTRAINT fk_medicament_medecin_medicament_id;
ALTER TABLE medicament_medecin                       DROP CONSTRAINT fk_medicament_medecin_medecin_id;
ALTER TABLE medicament_traitement                    DROP CONSTRAINT fk_medicament_traitement_medicament_id;
ALTER TABLE medicament_traitement                    DROP CONSTRAINT fk_medicament_traitement_traitement_id;
ALTER TABLE medicament_patient                       DROP CONSTRAINT pk_medicament_patient_medicament_id_patient_id;
ALTER TABLE medicament_patient                       DROP CONSTRAINT fk_medicament_patient_medicament_id;
ALTER TABLE medicament_patient                       DROP CONSTRAINT fk_medicament_patient_patient_id;
ALTER TABLE traitement                               DROP CONSTRAINT fk_traitement_medecin_id;
ALTER TABLE traitement                               DROP CONSTRAINT fk_traitement_patient_id;
ALTER TABLE recommandation_traitement                DROP CONSTRAINT fk_recommandation_traitement_traitement_id;
ALTER TABLE recommandation_traitement                DROP CONSTRAINT fk_recommandation_traitement_recommandation_id;
ALTER TABLE medecin                                  DROP CONSTRAINT fk_medecin_utilisateur_id;
ALTER TABLE laboratoire_pharmaceutique_medecin       DROP CONSTRAINT fk_laboratoire_pharmaceutique_medecin_laboratoire_pharmaceutique_id;
ALTER TABLE laboratoire_pharmaceutique_medecin       DROP CONSTRAINT fk_laboratoire_pharmaceutique_medecin_medecin_id;
ALTER TABLE consultation                             DROP CONSTRAINT fk_consultation_medecin_id;
ALTER TABLE consultation                             DROP CONSTRAINT fk_consultation_patient_id;
ALTER TABLE observation                              DROP CONSTRAINT fk_observation_consultation_id;
ALTER TABLE maladie_symptome                         DROP CONSTRAINT fk_maladie_symptome_maladie_id;
ALTER TABLE maladie_symptome                         DROP CONSTRAINT fk_maladie_symptome_symptome_id;
ALTER TABLE maladie_medicament                       DROP CONSTRAINT fk_maladie_medicament_maladie_id;
ALTER TABLE maladie_medicament                       DROP CONSTRAINT fk_maladie_medicament_medicament_id;
ALTER TABLE maladie_observation                      DROP CONSTRAINT fk_maladie_observation_maladie_id;
ALTER TABLE maladie_observation                      DROP CONSTRAINT fk_maladie_observation_observation_id;
ALTER TABLE medicament_indication                    DROP CONSTRAINT fk_medicament_indication_medicament_id;
ALTER TABLE medicament_indication                    DROP CONSTRAINT fk_medicament_indication_indication_id;
ALTER TABLE medicament_contre_indication             DROP CONSTRAINT fk_medicament_contre_indication_medicament_id;
ALTER TABLE medicament_contre_indication             DROP CONSTRAINT fk_medicament_contre_indication_contre_indication_id;
ALTER TABLE medicament_effet_indesirable             DROP CONSTRAINT fk_medicament_effet_indesirable_medicament_id;
ALTER TABLE medicament_effet_indesirable             DROP CONSTRAINT fk_medicament_effet_indesirable_effet_indesirable_id;
ALTER TABLE medicament_substance_active              DROP CONSTRAINT fk_medicament_substance_active_medicament_id;
ALTER TABLE medicament_substance_active              DROP CONSTRAINT fk_medicament_substance_active_substance_active_id;
ALTER TABLE effet_indesirable_substance_active       DROP CONSTRAINT fk_effet_indesirable_substance_active_effet_indesirable_id;
ALTER TABLE effet_indesirable_substance_active       DROP CONSTRAINT fk_effet_indesirable_substance_active_substance_active_id;
ALTER TABLE effet_indesirable_classe_chimique        DROP CONSTRAINT fk_effet_indesirable_classe_chimique_effet_indesirable_id;
ALTER TABLE effet_indesirable_classe_chimique        DROP CONSTRAINT fk_effet_indesirable_classe_chimique_classe_chimique_id;
ALTER TABLE effet_indesirable_classe_pharmacologique DROP CONSTRAINT fk_effet_indesirable_classe_pharmacologique_effet_indesirable_id;
ALTER TABLE effet_indesirable_classe_pharmacologique DROP CONSTRAINT fk_effet_indesirable_classe_pharmacologique_classe_pharmacologique_id;
ALTER TABLE substance_active_classe_chimique         DROP CONSTRAINT fk_substance_active_classe_chimique_substance_active_id;
ALTER TABLE substance_active_classe_chimique         DROP CONSTRAINT fk_substance_active_classe_chimique_classe_chimique_id;
ALTER TABLE substance_active_classe_pharmacologique  DROP CONSTRAINT fk_substance_active_classe_pharmacologique_substance_active_id;
ALTER TABLE substance_active_classe_pharmacologique  DROP CONSTRAINT fk_substance_active_classe_pharmacologique_classe_pharmacologique_id;

-- DROP après car il y a les tables d'associations utilisent ces clés primaires (sinon il faut utiliser le mot clé CASCADE)
ALTER TABLE utilisateur                              DROP CONSTRAINT pk_utilisateur_id;
ALTER TABLE medecin                                  DROP CONSTRAINT pk_medecin_id;
ALTER TABLE patient                                  DROP CONSTRAINT pk_patient_id;
ALTER TABLE medicament                               DROP CONSTRAINT pk_medicament_id;
ALTER TABLE medicament_medecin                       DROP CONSTRAINT pk_medicament_medecin_medicament_id_medecin_id;
ALTER TABLE medicament_traitement                    DROP CONSTRAINT pk_medicament_traitement_medicament_id_traitement_id;
ALTER TABLE traitement                               DROP CONSTRAINT pk_traitement_id;
ALTER TABLE recommandation                           DROP CONSTRAINT pk_recommandation_id;
ALTER TABLE recommandation_traitement                DROP CONSTRAINT pk_recommandation_traitement_recommandation_id_traitement_id;
ALTER TABLE medecin                                  DROP CONSTRAINT pk_medecin_id;
ALTER TABLE laboratoire_pharmaceutique               DROP CONSTRAINT pk_laboratoire_pharmaceutique_id;
ALTER TABLE laboratoire_pharmaceutique_medecin       DROP CONSTRAINT pk_laboratoire_pharmaceutique_medecin_laboratoire_pharmaceutique_id_medecin_id;
ALTER TABLE consultation                             DROP CONSTRAINT pk_consultation_id;
ALTER TABLE observation                              DROP CONSTRAINT pk_observation_id;
ALTER TABLE maladie                                  DROP CONSTRAINT pk_maladie_id;
ALTER TABLE symptome                                 DROP CONSTRAINT pk_symptome_id;
ALTER TABLE maladie_symptome                         DROP CONSTRAINT pk_maladie_symptome_maladie_id_symptome_id;
ALTER TABLE maladie_medicament                       DROP CONSTRAINT pk_maladie_medicament_maladie_id_medicament_id;
ALTER TABLE maladie_observation                      DROP CONSTRAINT pk_maladie_observation_maladie_id_observation_id;
ALTER TABLE medicament_indication                    DROP CONSTRAINT pk_medicament_indication_medicament_id_indication_id;
ALTER TABLE medicament_contre_indication             DROP CONSTRAINT pk_medicament_contre_indication_medicament_id_contre_indication_id;
ALTER TABLE medicament_effet_indesirable             DROP CONSTRAINT pk_medicament_effet_indesirable_medicament_id_effet_indesirable_id;
ALTER TABLE medicament_substance_active              DROP CONSTRAINT pk_medicament_substance_active_medicament_id_substance_active_id;
ALTER TABLE effet_indesirable_substance_active       DROP CONSTRAINT pk_effet_indesirable_substance_active_effet_indesirable_id_substance_active_id;
ALTER TABLE effet_indesirable_classe_chimique        DROP CONSTRAINT pk_effet_indesirable_classe_chimique_effet_indesirable_id_classe_chimique_id;
ALTER TABLE effet_indesirable_classe_pharmacologique DROP CONSTRAINT pk_effet_indesirable_classe_pharmacologique_effet_indesirable_id_classe_pharmacologique_id;
ALTER TABLE substance_active_classe_chimique         DROP CONSTRAINT pk_substance_active_classe_chimique_substance_active_id_classe_chimique_id;
ALTER TABLE substance_active_classe_pharmacologique  DROP CONSTRAINT pk_substance_active_classe_pharmacologique_substance_active_id_classe_pharmacologique_id;
ALTER TABLE indication                               DROP CONSTRAINT pk_indication_id;
ALTER TABLE contre_indication                        DROP CONSTRAINT pk_contre_indication_id;
ALTER TABLE effet_indesirable                        DROP CONSTRAINT pk_effet_indesirable_id;
ALTER TABLE substance_active                         DROP CONSTRAINT pk_substance_active_id;
ALTER TABLE classe_chimique                          DROP CONSTRAINT pk_classe_chimique_id;
ALTER TABLE classe_pharmacologique                   DROP CONSTRAINT pk_classe_pharmacologique_id;

DROP TABLE utilisateur;
DROP TABLE patient;
DROP TABLE medecin;
DROP TABLE medicament;
DROP TABLE medicament_medecin;
DROP TABLE medicament_traitement;
DROP TABLE medicament_patient;
DROP TABLE traitement;
DROP TABLE recommandation;
DROP TABLE recommandation_traitement;
DROP TABLE laboratoire_pharmaceutique;
DROP TABLE laboratoire_pharmaceutique_medecin;
DROP TABLE consultation;
DROP TABLE observation;
DROP TABLE maladie;
DROP TABLE symptome;
DROP TABLE maladie_symptome;
DROP TABLE maladie_medicament;
DROP TABLE maladie_observation;
DROP TABLE indication;
DROP TABLE contre_indication;
DROP TABLE effet_indesirable;
DROP TABLE substance_active;
DROP TABLE classe_chimique;
DROP TABLE classe_pharmacologique;
DROP TABLE medicament_indication;
DROP TABLE medicament_contre_indication;
DROP TABLE medicament_effet_indesirable;
DROP TABLE medicament_substance_active;
DROP TABLE effet_indesirable_substance_active;
DROP TABLE effet_indesirable_classe_chimique;
DROP TABLE effet_indesirable_classe_pharmacologique;
DROP TABLE substance_active_classe_chimique;
DROP TABLE substance_active_classe_pharmacologique;

CREATE TABLE utilisateur (
	id INTEGER,
	nom VARCHAR2(32) NOT NULL,
	prenom VARCHAR2(32) NOT NULL,
	age INTEGER NOT NULL,
	genre CHAR NOT NULL,
	telephone CHAR(14)
);

CREATE TABLE medecin (
	id INTEGER,
	diplome VARCHAR2(64),
	date_diplome DATE,
	utilisateur_id INTEGER
);

CREATE TABLE patient (
	id INTEGER,
	num_carte_vitale VARCHAR2(64),
	utilisateur_id INTEGER
);

CREATE TABLE medicament (
	id INTEGER,
	nom VARCHAR2(64),
	url VARCHAR2(255)
);

CREATE TABLE medicament_medecin (
	medicament_id INTEGER,
	medecin_id INTEGER
);

CREATE TABLE medicament_traitement (
	medicament_id INTEGER,
	traitement_id INTEGER
);

CREATE TABLE medicament_patient (
	medicament_id INTEGER,
	patient_id INTEGER
);

CREATE TABLE traitement (
	id INTEGER,
	date_debut DATE,
	date_fin DATE,
	medecin_id INTEGER,
	patient_id INTEGER
);

CREATE TABLE recommandation (
	id INTEGER,
	nom VARCHAR2(128) -- arreter de fumer et se reposer, prendre ses gélules à l’heure
);

CREATE TABLE recommandation_traitement (
	recommandation_id INTEGER,
	traitement_id INTEGER
);

CREATE TABLE laboratoire_pharmaceutique (
	id INTEGER,
	nom VARCHAR2(64)
);

CREATE TABLE laboratoire_pharmaceutique_medecin (
	laboratoire_pharmaceutique_id INTEGER,
	medecin_id INTEGER,
	date_embauche DATE
);

CREATE TABLE consultation (
	id INTEGER,
	date_debut DATE,
	date_fin DATE,
	medecin_id INTEGER,
	patient_id INTEGER
);

CREATE TABLE observation (
	id INTEGER,
	commentaire VARCHAR2(128), --  toux rauque, tache noire sur la radio des poumons, ...
	consultation_id INTEGER
);

CREATE TABLE symptome (
	id INTEGER,
	nom VARCHAR2(64) -- fatigue, vomissement, ...
);

CREATE TABLE maladie (
	id INTEGER,
	nom VARCHAR2(64), -- diabètete, hypertension, asthme, ...
	idsup INTEGER -- CONNECT BY Prior nsup = id
);

CREATE TABLE maladie_medicament (
	maladie_id INTEGER,
	medicament_id INTEGER
);

CREATE TABLE maladie_observation (
	maladie_id INTEGER,
	observation_id INTEGER
);

CREATE TABLE maladie_symptome (
	maladie_id INTEGER,
	symptome_id INTEGER
);

CREATE TABLE indication (
	id INTEGER,
	nom VARCHAR2(64)
);

CREATE TABLE contre_indication (
	id INTEGER,
	nom VARCHAR2(64)
);

CREATE TABLE effet_indesirable (
	id INTEGER,
	nom VARCHAR2(64),
	idsup INTEGER
);

CREATE TABLE substance_active (
	id INTEGER,
	nom VARCHAR2(64)
);

CREATE TABLE classe_chimique (
	id INTEGER,
	nom VARCHAR2(64),
	idsup INTEGER
);

CREATE TABLE classe_pharmacologique (
	id INTEGER,
	nom VARCHAR2(64),
	idsup INTEGER
);

CREATE TABLE medicament_indication (
	medicament_id INTEGER,
	indication_id INTEGER
);

CREATE TABLE medicament_contre_indication (
	medicament_id INTEGER,
	contre_indication_id INTEGER
);

CREATE TABLE medicament_effet_indesirable (
	medicament_id INTEGER,
	effet_indesirable_id INTEGER
);

CREATE TABLE medicament_substance_active (
	medicament_id INTEGER,
	substance_active_id INTEGER
);

CREATE TABLE effet_indesirable_classe_chimique (
	effet_indesirable_id INTEGER,
	classe_chimique_id INTEGER
);

CREATE TABLE effet_indesirable_classe_pharmacologique (
	effet_indesirable_id INTEGER,
	classe_pharmacologique_id INTEGER
);

CREATE TABLE effet_indesirable_substance_active (
	effet_indesirable_id INTEGER,
	substance_active_id INTEGER
);

CREATE TABLE substance_active_classe_chimique (
	substance_active_id INTEGER,
	classe_chimique_id INTEGER
);

CREATE TABLE substance_active_classe_pharmacologique (
	substance_active_id INTEGER,
	classe_pharmacologique_id INTEGER
);

/*---------------------------------------------------------------------------------------------------------*/
/* Insertions                                                                                              */
/* Données : https://base-donnees-publique.medicaments.gouv.fr                                             */
/* La liste des pathologies (maladies) : https://base-donnees-publique.medicaments.gouv.fr/pathologies.php */
/*---------------------------------------------------------------------------------------------------------*/

INSERT INTO utilisateur (id, nom, prenom, age, genre, telephone) VALUES (1, 'Glen', 'Bilbrook', 69, 'M', '07.82.12.92.52');
INSERT INTO utilisateur (id, nom, prenom, age, genre, telephone) VALUES (2, 'Town', 'Cosyns', 57, 'M', '07.32.42.52.32');
INSERT INTO utilisateur (id, nom, prenom, age, genre, telephone) VALUES (3, 'Joly', 'Judron', 38, 'F', '06.32.32.52.72');
INSERT INTO utilisateur (id, nom, prenom, age, genre, telephone) VALUES (4, 'Louise', 'Collis', 60, 'F', '07.92.92.82.92');
INSERT INTO utilisateur (id, nom, prenom, age, genre, telephone) VALUES (5, 'Kippar', 'Steven', 44, 'M', '06.42.92.82.72');
INSERT INTO utilisateur (id, nom, prenom, age, genre, telephone) VALUES (6, 'Bendick', 'Goffe', 74, 'M', '06.32.62.32.12');


INSERT INTO medecin (id, diplome, date_diplome, utilisateur_id) VALUES (1, 'Faculté de médecine de Rouen', TO_DATE('1970-DEC-25','YYYY-MON-DD','NLS_DATE_LANGUAGE=AMERICAN'), 1);
INSERT INTO medecin (id, diplome, date_diplome, utilisateur_id) VALUES (2, 'Faculté de médecine de Paris', TO_DATE('1971-DEC-25','YYYY-MON-DD','NLS_DATE_LANGUAGE=AMERICAN'), 2);
INSERT INTO medecin (id, diplome, date_diplome, utilisateur_id) VALUES (3, 'Faculté de médecine de Marseille', TO_DATE('1972-DEC-25','YYYY-MON-DD','NLS_DATE_LANGUAGE=AMERICAN'), 3);


INSERT INTO patient (id, num_carte_vitale, utilisateur_id) VALUES (1, '2 94 03 75 120 005 01', 4);
INSERT INTO patient (id, num_carte_vitale, utilisateur_id) VALUES (2, '2 94 03 75 120 005 02', 5);
INSERT INTO patient (id, num_carte_vitale, utilisateur_id) VALUES (3, '2 94 03 75 120 005 03', 6);

-- https://base-donnees-publique.medicaments.gouv.fr/pathologies.php
INSERT INTO maladie (id, nom, idsup) VALUES (1, 'dermatologie', NULL);
	INSERT INTO maladie (id, nom, idsup) VALUES (2, 'acné', 1);
	INSERT INTO maladie (id, nom, idsup) VALUES (3, 'eczéma ', 1);
		INSERT INTO maladie (id, nom, idsup) VALUES (4, 'eczéma atopique', 3);
		INSERT INTO maladie (id, nom, idsup) VALUES (5, 'eczéma de contact', 3);
	INSERT INTO maladie (id, nom, idsup) VALUES (6, 'gale', 1);
	INSERT INTO maladie (id, nom, idsup) VALUES (7, 'vitiligo', 1);
INSERT INTO maladie (id, nom, idsup) VALUES (8, 'bactériennes', NULL);
	INSERT INTO maladie (id, nom, idsup) VALUES (9, 'tuberculose', 8);
	INSERT INTO maladie (id, nom, idsup) VALUES (10, 'impétigo', 8);
INSERT INTO maladie (id, nom, idsup) VALUES (11, 'infections virales', NULL);
	INSERT INTO maladie (id, nom, idsup) VALUES (12, 'grippe saisonnière', 11);
	INSERT INTO maladie (id, nom, idsup) VALUES (13, 'angine', 11);
		INSERT INTO maladie (id, nom, idsup) VALUES (14, 'angine poitrine', 11);
	INSERT INTO maladie (id, nom, idsup) VALUES (15, 'hépatite', 11);
		INSERT INTO maladie (id, nom, idsup) VALUES (16, 'hépatite A', 15);
		INSERT INTO maladie (id, nom, idsup) VALUES (17, 'hépatite B', 15);
		INSERT INTO maladie (id, nom, idsup) VALUES (18, 'hépatite C', 15);
	INSERT INTO maladie (id, nom, idsup) VALUES (19, 'herpès', 11);
		INSERT INTO maladie (id, nom, idsup) VALUES (20, 'herpès génital', 19);
		INSERT INTO maladie (id, nom, idsup) VALUES (21, 'herpès labial', 19);
		INSERT INTO maladie (id, nom, idsup) VALUES (22, 'herpès oculaire', 19);
INSERT INTO maladie (id, nom, idsup) VALUES (23, 'hémopathies (maladie du sang)', NULL);
	INSERT INTO maladie (id, nom, idsup) VALUES (24, 'hypercholestérolémie', 23);
		INSERT INTO maladie (id, nom, idsup) VALUES (25, 'hyperlipidémie', 24);
	INSERT INTO maladie (id, nom, idsup) VALUES (26, 'Hypertension artérielle', 23);
INSERT INTO maladie (id, nom, idsup) VALUES (27, 'psychique', NULL);
	INSERT INTO maladie (id, nom, idsup) VALUES (28, 'anxiété', 27);
		INSERT INTO maladie (id, nom, idsup) VALUES (29, 'insomnie', 28);

INSERT INTO symptome (id, nom) VALUES (1, 'fièvre');
INSERT INTO symptome (id, nom) VALUES (2, 'fatigue');
INSERT INTO symptome (id, nom) VALUES (3, 'vomissements');
INSERT INTO symptome (id, nom) VALUES (4, 'courbatures');
INSERT INTO symptome (id, nom) VALUES (5, 'essoufflement');
INSERT INTO symptome (id, nom) VALUES (6, 'toux');
INSERT INTO symptome (id, nom) VALUES (7, 'sueur');
INSERT INTO symptome (id, nom) VALUES (8, 'douleurs articulaires');
INSERT INTO symptome (id, nom) VALUES (9, 'déshydratation');

INSERT INTO maladie_symptome (maladie_id, symptome_id) VALUES (1, 2);
INSERT INTO maladie_symptome (maladie_id, symptome_id) VALUES (2, 2);
INSERT INTO maladie_symptome (maladie_id, symptome_id) VALUES (3, 2);

-- acné
INSERT INTO medicament (id, nom, url) VALUES (1, 'adapalene teva', 'https://base-donnees-publique.medicaments.gouv.fr/extrait.php?specid=65099368');
INSERT INTO maladie_medicament (maladie_id, medicament_id) VALUES (2, 1);
INSERT INTO indication (id, nom) VALUES (1, 'acné moyenne, appliqué directement sur la peau')
INSERT INTO medicament_indication(medicament_id, indication_id) VALUES (1, 1);
INSERT INTO contre_indication (id, nom) VALUES (1, 'grossesse');
INSERT INTO medicament_contre_indication(medicament_id, contre_indication_id) VALUES (1, 1);

INSERT INTO effet_indesirable(id, nom, idsup) VALUES (1, 'problème peau', NULL);
INSERT INTO effet_indesirable(id, nom, idsup) VALUES (2, 'sécheresse cutanée', 1);
INSERT INTO effet_indesirable(id, nom, idsup) VALUES (3, 'irritation cutanée', 1);
INSERT INTO medicament_effet_indesirable(medicament_id, effet_indesirable_id) VALUES (1, 1);
INSERT INTO medicament_effet_indesirable(medicament_id, effet_indesirable_id) VALUES (1, 2);
INSERT INTO medicament_effet_indesirable(medicament_id, effet_indesirable_id) VALUES (1, 3);

INSERT INTO substance_active(id, nom) VALUES (1, 'adapalène');
INSERT INTO medicament_substance_active (medicament_id, substance_active_id) VALUES (1, 1);

INSERT INTO classe_chimique (id, nom, idsup) VALUES (1, 'rétinoïde', NULL);
INSERT INTO classe_chimique (id, nom, idsup) VALUES (2, 'rétinoïde topique', 1);

INSERT INTO substance_active_classe_chimique(substance_active_id, classe_chimique_id) VALUES (1, 1);
INSERT INTO substance_active_classe_chimique(substance_active_id, classe_chimique_id) VALUES (1, 2);

INSERT INTO classe_pharmacologique (id, nom, idsup) VALUES (1, 'rétinoïde', NULL);
INSERT INTO classe_pharmacologique (id, nom, idsup) VALUES (2, 'rétinoïde anti acneique', 1);

INSERT INTO substance_active_classe_pharmacologique(substance_active_id, classe_pharmacologique_id) VALUES (1, 1);
INSERT INTO substance_active_classe_pharmacologique(substance_active_id, classe_pharmacologique_id) VALUES (1, 2);

-- genère
INSERT INTO effet_indesirable_substance_active (effet_indesirable_id, substance_active_id) VALUES (2, 1);
INSERT INTO effet_indesirable_substance_active (effet_indesirable_id, substance_active_id) VALUES (3, 1);

INSERT INTO effet_indesirable_classe_chimique (effet_indesirable_id, classe_chimique_id) VALUES (1, 1);
INSERT INTO effet_indesirable_classe_chimique (effet_indesirable_id, classe_chimique_id) VALUES (2, 2);

INSERT INTO effet_indesirable_classe_pharmacologique (effet_indesirable_id, classe_pharmacologique_id) VALUES (2, 1);
INSERT INTO effet_indesirable_classe_pharmacologique (effet_indesirable_id, classe_pharmacologique_id) VALUES (2, 2);

/*-------------*/
/* Contraintes */
/*-------------*/

ALTER TABLE utilisateur ADD CONSTRAINT ck_utilisateur_genre CHECK (genre IN ('M', 'F'));

-- Clés primaires
ALTER TABLE utilisateur                        ADD CONSTRAINT pk_utilisateur_id                                    PRIMARY KEY (id);
ALTER TABLE medecin                            ADD CONSTRAINT pk_medecin_id                                        PRIMARY KEY (id);
ALTER TABLE patient                            ADD CONSTRAINT pk_patient_id                                        PRIMARY KEY (id);
ALTER TABLE traitement                         ADD CONSTRAINT pk_traitement_id                                     PRIMARY KEY (id);
ALTER TABLE medicament                         ADD CONSTRAINT pk_medicament_id                                     PRIMARY KEY (id);
ALTER TABLE medicament_medecin                 ADD CONSTRAINT pk_medicament_medecin_medicament_id_medecin_id       PRIMARY KEY (medicament_id, medecin_id);
ALTER TABLE medicament_traitement              ADD CONSTRAINT pk_medicament_traitement_medicament_id_traitement_id PRIMARY KEY (medicament_id, traitement_id);
ALTER TABLE medicament_patient                 ADD CONSTRAINT pk_medicament_patient_medicament_id_patient_id       PRIMARY KEY (medicament_id, patient_id);
ALTER TABLE recommandation                     ADD CONSTRAINT pk_recommandation_id                                 PRIMARY KEY (id);
ALTER TABLE recommandation_traitement          ADD CONSTRAINT pk_recommandation_traitement_recommandation_id_traitement_id PRIMARY KEY (traitement_id, recommandation_id);
ALTER TABLE laboratoire_pharmaceutique         ADD CONSTRAINT pk_laboratoire_pharmaceutique_id                     PRIMARY KEY (id);
ALTER TABLE laboratoire_pharmaceutique_medecin ADD CONSTRAINT pk_laboratoire_pharmaceutique_medecin_laboratoire_pharmaceutique_id_medecin_id PRIMARY KEY (laboratoire_pharmaceutique_id, medecin_id);
ALTER TABLE consultation                       ADD CONSTRAINT pk_consultation_id                                   PRIMARY KEY (id);
ALTER TABLE observation                        ADD CONSTRAINT pk_observation_id                                    PRIMARY KEY (id);
ALTER TABLE maladie                            ADD CONSTRAINT pk_maladie_id                                        PRIMARY KEY (id);
ALTER TABLE symptome                           ADD CONSTRAINT pk_symptome_id                                       PRIMARY KEY (id);
ALTER TABLE maladie_symptome                   ADD CONSTRAINT pk_maladie_symptome_maladie_id_symptome_id           PRIMARY KEY (maladie_id, symptome_id);
ALTER TABLE maladie_medicament                 ADD CONSTRAINT pk_maladie_medicament_maladie_id_medicament_id       PRIMARY KEY (maladie_id, medicament_id);
ALTER TABLE maladie_observation                ADD CONSTRAINT pk_maladie_observation_maladie_id_observation_id     PRIMARY KEY (maladie_id, observation_id);
ALTER TABLE indication                         ADD CONSTRAINT pk_indication_id                                     PRIMARY KEY (id);
ALTER TABLE contre_indication                  ADD CONSTRAINT pk_contre_indication_id                              PRIMARY KEY (id);
ALTER TABLE effet_indesirable                  ADD CONSTRAINT pk_effet_indesirable_id                              PRIMARY KEY (id);
ALTER TABLE substance_active                   ADD CONSTRAINT pk_substance_active_id                               PRIMARY KEY (id);
ALTER TABLE classe_chimique                    ADD CONSTRAINT pk_classe_chimique_id                                PRIMARY KEY (id);
ALTER TABLE classe_pharmacologique             ADD CONSTRAINT pk_classe_pharmacologique_id                         PRIMARY KEY (id);
ALTER TABLE medicament_indication              ADD CONSTRAINT pk_medicament_indication_medicament_id_indication_id PRIMARY KEY (medicament_id, indication_id);
ALTER TABLE medicament_contre_indication       ADD CONSTRAINT pk_medicament_contre_indication_medicament_id_contre_indication_id PRIMARY KEY (medicament_id, contre_indication_id);
ALTER TABLE medicament_effet_indesirable       ADD CONSTRAINT pk_medicament_effet_indesirable_medicament_id_effet_indesirable_id PRIMARY KEY (medicament_id, effet_indesirable_id);
ALTER TABLE medicament_substance_active        ADD CONSTRAINT pk_medicament_substance_active_medicament_id_substance_active_id PRIMARY KEY (medicament_id, substance_active_id);
ALTER TABLE effet_indesirable_substance_active ADD CONSTRAINT pk_effet_indesirable_substance_active_effet_indesirable_id_substance_active_id PRIMARY KEY (effet_indesirable_id, substance_active_id);
ALTER TABLE effet_indesirable_classe_chimique  ADD CONSTRAINT pk_effet_indesirable_classe_chimique_effet_indesirable_id_classe_chimique_id PRIMARY KEY (effet_indesirable_id, classe_chimique_id);
ALTER TABLE effet_indesirable_classe_pharmacologique ADD CONSTRAINT pk_effet_indesirable_classe_pharmacologique_effet_indesirable_id_classe_pharmacologique_id PRIMARY KEY (effet_indesirable_id, classe_pharmacologique_id);
ALTER TABLE substance_active_classe_chimique ADD CONSTRAINT pk_substance_active_classe_chimique_substance_active_id_classe_chimique_id PRIMARY KEY (substance_active_id, classe_chimique_id);
ALTER TABLE substance_active_classe_pharmacologique ADD CONSTRAINT pk_substance_active_classe_pharmacologique_substance_active_id_classe_pharmacologique_id PRIMARY KEY (substance_active_id, classe_pharmacologique_id);

ALTER TABLE patient ADD CONSTRAINT fk_patient_utilisateur_id FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id);
ALTER TABLE medecin ADD CONSTRAINT fk_medecin_utilisateur_id FOREIGN KEY (utilisateur_id) REFERENCES utilisateur(id);

-- traitement
-- un traitement est pescrit par un medecin
ALTER TABLE traitement ADD CONSTRAINT fk_traitement_medecin_id  FOREIGN KEY (medecin_id) REFERENCES medecin(id);
-- un traitement est suit(suivi) par un patient
ALTER TABLE traitement ADD CONSTRAINT fk_traitement_patient_id  FOREIGN KEY (patient_id) REFERENCES patient(id);

ALTER TABLE recommandation_traitement ADD CONSTRAINT fk_recommandation_traitement_recommandation_id FOREIGN KEY (recommandation_id) REFERENCES recommandation(id);
ALTER TABLE recommandation_traitement ADD CONSTRAINT fk_recommandation_traitement_traitement_id     FOREIGN KEY (traitement_id) REFERENCES traitement(id);

ALTER TABLE laboratoire_pharmaceutique_medecin ADD CONSTRAINT fk_laboratoire_pharmaceutique_medecin_laboratoire_pharmaceutique_id  FOREIGN KEY (laboratoire_pharmaceutique_id) REFERENCES laboratoire_pharmaceutique(id);
ALTER TABLE laboratoire_pharmaceutique_medecin ADD CONSTRAINT fk_laboratoire_pharmaceutique_medecin_medecin_id                     FOREIGN KEY (medecin_id) REFERENCES medecin(id);

ALTER TABLE consultation ADD CONSTRAINT fk_consultation_medecin_id FOREIGN KEY (medecin_id) REFERENCES medecin(id);
ALTER TABLE consultation ADD CONSTRAINT fk_consultation_patient_id FOREIGN KEY (patient_id) REFERENCES patient(id);

ALTER TABLE observation ADD CONSTRAINT fk_observation_consultation_id FOREIGN KEY (consultation_id) REFERENCES consultation(id);

ALTER TABLE maladie_medicament ADD CONSTRAINT fk_maladie_medicament_maladie_id FOREIGN KEY (maladie_id) REFERENCES maladie(id);
ALTER TABLE maladie_medicament ADD CONSTRAINT fk_maladie_medicament_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);

ALTER TABLE maladie_observation ADD CONSTRAINT fk_maladie_observation_maladie_id FOREIGN KEY (maladie_id) REFERENCES maladie(id);
ALTER TABLE maladie_observation ADD CONSTRAINT fk_maladie_observation_observation_id FOREIGN KEY (observation_id) REFERENCES observation(id);

ALTER TABLE maladie_symptome ADD CONSTRAINT fk_maladie_symptome_maladie_id FOREIGN KEY (maladie_id) REFERENCES maladie(id);
ALTER TABLE maladie_symptome ADD CONSTRAINT fk_maladie_symptome_symptome_id FOREIGN KEY (symptome_id) REFERENCES symptome(id);

ALTER TABLE medicament_medecin ADD CONSTRAINT fk_medicament_medecin_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);
ALTER TABLE medicament_medecin ADD CONSTRAINT fk_medicament_medecin_medecin_id FOREIGN KEY (medecin_id) REFERENCES medecin(id);

ALTER TABLE medicament_traitement ADD CONSTRAINT fk_medicament_traitement_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);
ALTER TABLE medicament_traitement ADD CONSTRAINT fk_medicament_traitement_traitement_id FOREIGN KEY (traitement_id) REFERENCES traitement(id);

ALTER TABLE medicament_patient ADD CONSTRAINT fk_medicament_patient_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);
ALTER TABLE medicament_patient ADD CONSTRAINT fk_medicament_patient_patient_id FOREIGN KEY (patient_id) REFERENCES patient(id);

ALTER TABLE medicament_indication ADD CONSTRAINT fk_medicament_indication_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);
ALTER TABLE medicament_indication ADD CONSTRAINT fk_medicament_indication_indication_id FOREIGN KEY (indication_id) REFERENCES indication(id);

ALTER TABLE medicament_contre_indication ADD CONSTRAINT fk_medicament_contre_indication_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);
ALTER TABLE medicament_contre_indication ADD CONSTRAINT fk_medicament_contre_indication_contre_indication_id FOREIGN KEY (contre_indication_id) REFERENCES contre_indication(id);

ALTER TABLE medicament_effet_indesirable ADD CONSTRAINT fk_medicament_effet_indesirable_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);
ALTER TABLE medicament_effet_indesirable ADD CONSTRAINT fk_medicament_effet_indesirable_effet_indesirable_id FOREIGN KEY (effet_indesirable_id) REFERENCES effet_indesirable(id);

ALTER TABLE medicament_substance_active ADD CONSTRAINT fk_medicament_substance_active_medicament_id FOREIGN KEY (medicament_id) REFERENCES medicament(id);
ALTER TABLE medicament_substance_active ADD CONSTRAINT fk_medicament_substance_active_substance_active_id FOREIGN KEY (substance_active_id) REFERENCES substance_active(id);

ALTER TABLE effet_indesirable_substance_active ADD CONSTRAINT fk_effet_indesirable_substance_active_effet_indesirable_id FOREIGN KEY (effet_indesirable_id) REFERENCES effet_indesirable(id);
ALTER TABLE effet_indesirable_substance_active ADD CONSTRAINT fk_effet_indesirable_substance_active_substance_active_id FOREIGN KEY (substance_active_id) REFERENCES substance_active(id);

ALTER TABLE effet_indesirable_classe_chimique ADD CONSTRAINT fk_effet_indesirable_classe_chimique_effet_indesirable_id FOREIGN KEY (effet_indesirable_id) REFERENCES effet_indesirable(id);
ALTER TABLE effet_indesirable_classe_chimique ADD CONSTRAINT fk_effet_indesirable_classe_chimique_classe_chimique_id FOREIGN KEY (classe_chimique_id) REFERENCES classe_chimique(id);

ALTER TABLE effet_indesirable_classe_pharmacologique ADD CONSTRAINT fk_effet_indesirable_classe_pharmacologique_effet_indesirable_id FOREIGN KEY (effet_indesirable_id) REFERENCES effet_indesirable(id);
ALTER TABLE effet_indesirable_classe_pharmacologique ADD CONSTRAINT fk_effet_indesirable_classe_pharmacologique_classe_pharmacologique_id FOREIGN KEY (classe_pharmacologique_id) REFERENCES classe_pharmacologique(id);

ALTER TABLE substance_active_classe_chimique ADD CONSTRAINT fk_substance_active_classe_chimique_substance_active_id FOREIGN KEY (substance_active_id) REFERENCES substance_active(id);
ALTER TABLE substance_active_classe_chimique ADD CONSTRAINT fk_substance_active_classe_chimique_classe_chimique_id FOREIGN KEY (classe_chimique_id) REFERENCES classe_chimique(id);

ALTER TABLE substance_active_classe_pharmacologique ADD CONSTRAINT fk_substance_active_classe_pharmacologique_substance_active_id FOREIGN KEY (substance_active_id) REFERENCES substance_active(id);
ALTER TABLE substance_active_classe_pharmacologique ADD CONSTRAINT fk_substance_active_classe_pharmacologique_classe_pharmacologique_id FOREIGN KEY (classe_pharmacologique_id) REFERENCES classe_pharmacologique(id);

-- Contraintes d'héritage de partition
/**
    signifie qu'on ne puisse ni participer aux deux relations 
 	à la fois ni à participer à aucune (l'une, l'autre)
	Donc un médecin ne peut pas être un patient et réciproquement un patient ne peut pas être un médecin.
*/
CREATE OR REPLACE TRIGGER trigger_medecin
BEFORE INSERT OR UPDATE OF utilisateur_id ON medecin
FOR EACH ROW
DECLARE
	utilsateur_identifiant INTEGER;
	patient_utilisateur_id INTEGER;
BEGIN
	SELECT u.id INTO utilsateur_identifiant FROM utilisateur u WHERE u.id = :NEW.utilisateur_id;
	SELECT p.utilisateur_id INTO patient_utilisateur_id FROM patient p WHERE p.utilisateur_id = utilsateur_identifiant;
	RAISE_APPLICATION_ERROR(-20001, 'L''utilisateur '|| utilsateur_identifiant || ' ' || ' est déja patient et ne peut pas être médecin');
EXCEPTION
	WHEN NO_DATA_FOUND THEN NULL;
END trigger_medecin;
/
-- Test du trigger avec l'insertion d'un médecin qui est déja un patient
INSERT INTO medecin (id, diplome, date_diplome, utilisateur_id) VALUES (4, 'Faculté de médecine de Rouen', TO_DATE('1970-DEC-25','YYYY-MON-DD','NLS_DATE_LANGUAGE=AMERICAN'), 4);

CREATE OR REPLACE TRIGGER trigger_patient
BEFORE INSERT OR UPDATE OF utilisateur_id ON patient
FOR EACH ROW
DECLARE
	utilsateur_identifiant INTEGER;
	medecin_utilisateur_id INTEGER;
BEGIN
	SELECT u.id INTO utilsateur_identifiant FROM utilisateur u
		WHERE u.id = :NEW.utilisateur_id;
	SELECT m.utilisateur_id INTO medecin_utilisateur_id FROM medecin m WHERE m.utilisateur_id = utilsateur_identifiant;
	RAISE_APPLICATION_ERROR(-20001, 'L''utilisateur '|| utilsateur_identifiant || ' ' || ' est déja medecin et ne peut pas être médecin');
EXCEPTION
	WHEN NO_DATA_FOUND THEN NULL;
END trigger_medecin;
/
-- Test du trigger avec l'insertion d'un patient qui est déja un médecin
INSERT INTO patient (id, num_carte_vitale, utilisateur_id) VALUES (4, '2 94 03 75 120 005 01', 1);

/*------------*/
/* Opérations */
/*------------*/

-- 1. une fonction/procédure qui déduit une ou plusieurs maladies à partir d’un symptôme, classées de la plus spécifique à la plus générique.
CREATE OR REPLACE PROCEDURE selectMaladieParSymptome(symptome_id INTEGER) IS
	maladierow maladie%ROWTYPE;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Maladie(s) pour le symptôme '||symptome_id||':');
	FOR ml IN (
		SELECT DISTINCT m.* FROM maladie m 
		INNER JOIN maladie_symptome ms ON ms.symptome_id = symptome_id AND ms.maladie_id = m.id
		ORDER BY m.idsup DESC
	)
	LOOP
		SELECT * INTO maladierow FROM maladie m WHERE m.id = ml.id;
		DBMS_OUTPUT.PUT_LINE(maladierow.id||'-'||maladierow.nom||'-'||maladierow.idsup);
	END LOOP;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Aucune maladie trouvée pour ce symptôme');
END selectMaladieParSymptome;
/
EXECUTE selectMaladieParSymptome(2);


-- 2. une fonction/procédure qui permet de proposer une liste de médicaments à partir d'une maladie.
-- Si un lien maladie-médicament n'existe pas, il faudra remonter dans la hiérarchie des maladies jusqu'à trouver un médicament à proposer.
-- Pour chaque médicament, l'url d'accès à la notice sera également fournie en sortie.
CREATE OR REPLACE PROCEDURE selectProposerMedicament(maladie_id INTEGER) AS
	TYPE table_type_medicament IS TABLE OF medicament%ROWTYPE;
	table_medicament table_type_medicament;
	nom VARCHAR2(64);
	url VARCHAR2(255);
	tmp_maladie_id INTEGER;
	found BOOLEAN := false;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Liste de médicament(s) pour la maladie ' || maladie_id || ' : ');
	WHILE NOT found
	LOOP
		BEGIN
			SELECT mm.maladie_id INTO tmp_maladie_id FROM maladie_medicament mm WHERE mm.maladie_id = maladie_id;
			EXCEPTION
				WHEN NO_DATA_FOUND THEN
					SELECT m.id INTO tmp_maladie_id FROM maladie m WHERE ROWNUM = 1
						START WITH m.id = tmp_maladie_id
						CONNECT BY PRIOR m.idsup = m.id;
		END;
		found := true;
	END LOOP;
	SELECT m.* BULK COLLECT INTO table_medicament FROM medicament m
		INNER JOIN maladie_medicament mm ON mm.maladie_id = tmp_maladie_id;
	FOR i IN 1..table_medicament.COUNT
	LOOP
		nom := table_medicament(i).nom;
		url := table_medicament(i).url;
		DBMS_OUTPUT.PUT_LINE('-> ' || nom || ' : ' || url);
	END LOOP i;
END selectProposerMedicament;
/
EXECUTE selectProposerMedicament(2);

/*
 3. une fonction/procédure qui permet de sauvegarder le patient, son traitement
 (l'ensemble du ou des médicaments et/ou recommandations) et la ou les maladies diagnostiquées par un médecin.
 Pour contrôler les prescriptions, le système ne doit pas autoriser un médecin à prescrire un médicament pour lequel
 il a participé l'élaboration. Lancez les messages d'erreurs adéquats à l'utilisateur.
*/
CREATE OR REPLACE PROCEDURE sauvegarderPatientInfo(patient_id INTEGER, traitement_id INTEGER) IS
	patient_rec patient%ROWTYPE;
	utilisateur_rec utilisateur%ROWTYPE;
	traitement_rec traitement%ROWTYPE;
	TYPE table_type_medicament IS TABLE OF medicament%ROWTYPE;
	table_medicament table_type_medicament;
	TYPE table_type_recommandation IS TABLE OF recommandation%ROWTYPE;
	table_recommandation table_type_recommandation;
	TYPE table_type_maladie IS TABLE OF maladie%ROWTYPE;
	table_maladie table_type_maladie;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Sauvegarde des informations du patient ' || patient_id || ' avec le traitement ' || traitement_id);
	BEGIN
	-- patient
		SELECT p.* INTO patient_rec FROM patient p INNER JOIN traitement t ON t.patient_id = patient_id WHERE p.id = patient_id AND ROWNUM = 1;
		SELECT u.* INTO utilisateur_rec FROM utilisateur u WHERE u.id = patient_rec.utilisateur_id;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				DBMS_OUTPUT.PUT_LINE('Le patient ' || patient_id || ' n''a pas été trouvé');
				RETURN;
	END;
	DBMS_OUTPUT.PUT_LINE('Patient ' || patient_rec.id || ' - ' || utilisateur_rec.prenom || ' ' || utilisateur_rec.nom);
	BEGIN
		-- le traitement
		SELECT t.* INTO traitement_rec FROM traitement t WHERE t.id = traitement_id;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				DBMS_OUTPUT.PUT_LINE('Le traitement ' || traitement_id || ' n''a pas été trouvé');
				RETURN;
	END;
	DBMS_OUTPUT.PUT_LINE('Traitement ' || traitement_rec.id || ' - ' || traitement_rec.date_debut || '-' || traitement_rec.date_fin);
	BEGIN
		-- les médicaments pour le traitement
		SELECT m.* BULK COLLECT INTO table_medicament FROM medicament m
			INNER JOIN medicament_traitement mt ON mt.traitement_id = traitement_id;
		FOR i IN 1..table_medicament.COUNT
		LOOP
			DBMS_OUTPUT.PUT_LINE('Médicament : ' || table_medicament(i).nom || ' : ' || table_medicament(i).url);
		END LOOP i;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RETURN;
	END;
	BEGIN
		-- les recommandation pour le traitement
		SELECT r.* BULK COLLECT INTO table_recommandation FROM recommandation r
			INNER JOIN recommandation_traitement rt ON rt.traitement_id = traitement_id;
		FOR i IN 1..table_medicament.COUNT
		LOOP
			DBMS_OUTPUT.PUT_LINE('Recommandation : ' || table_recommandation(i).nom);
		END LOOP i;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RETURN;
	END;
	BEGIN
		-- les maladies diagnostiquées du patient
		SELECT m.* BULK COLLECT INTO table_maladie FROM maladie m INNER JOIN maladie_observation mo ON m.id = mo.maladie_id
		WHERE mo.observation_id IN (SELECT o.id FROM observation o INNER JOIN consultation c ON o.consultation_id = c.id AND c.patient_id = patient_id);
		FOR i IN 1..table_maladie.COUNT
		LOOP
			DBMS_OUTPUT.PUT_LINE('Maladie : ' || table_maladie(i).nom);
		END LOOP i;
		EXCEPTION
			WHEN NO_DATA_FOUND THEN
				RETURN;
	END;
END sauvegarderPatientInfo;
/

/*
 4. une fonction/procédure qui détermine pour un médicament la liste des effets 
 indésirables connus et possibles qui seront déduits à partir des hiérarchies des
 classes chimiques et des classes pharmacologiques des substances actives.
*/
CREATE OR REPLACE PROCEDURE selectEffetIndesirableMedicament(medicament_id INTEGER) AS
BEGIN
	NULL;
END selectEffetIndesirableMedicament;
/

-- 5. une fonction/procédure qui permet pour chaque médecin de connaître la liste de tous les médicaments qu'il a prescrits.
CREATE OR REPLACE PROCEDURE selectMedicamentMedecin IS
	TYPE table_type_medicament IS TABLE OF medicament%ROWTYPE;
	table_medicament table_type_medicament;
	nom VARCHAR2(64);
	url VARCHAR2(255);
BEGIN
	SELECT DISTINCT m.* BULK COLLECT INTO table_medicament FROM medicament m WHERE m.id IN (
		SELECT mt.medicament_id FROM medicament_traitement mt WHERE mt.traitement_id IN (
			SELECT t.id FROM traitement t WHERE t.medecin_id IN (
				SELECT id FROM medecin
			)
		)
	);
	FOR i IN 1..table_medicament.COUNT
	LOOP
		nom := table_medicament(i).nom;
		url := table_medicament(i).url;
		DBMS_OUTPUT.PUT_LINE('-> ' || nom || ' : ' || url);
	END LOOP i;
EXCEPTION
	WHEN NO_DATA_FOUND THEN
		DBMS_OUTPUT.PUT_LINE('Aucun médicament trouvée');
END selectMedicamentMedecin;
/
EXECUTE selectMedicamentMedecin;
