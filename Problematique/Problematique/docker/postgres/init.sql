-- DROP TABLE if exists CAMPUS cascade;
-- DROP TABLE if exists STATUT cascade;
-- DROP TABLE if exists CARACTERISTIQUE cascade;
-- DROP TABLE if exists FONCTION cascade;
-- DROP TABLE if exists STATUT_Privilege cascade;
-- DROP TABLE if exists PAVILLON cascade;
-- DROP TABLE if exists DEPARTEMENT cascade;
-- DROP TABLE if exists MEMBRE cascade;
-- DROP TABLE if exists StatutMembre cascade;
-- DROP TABLE if exists LOCAL cascade;
-- DROP TABLE if exists RESERVATION cascade;
-- DROP TABLE if exists LOG cascade;
-- DROP TABLE if exists CaractLocal cascade;
Drop schema if exists App2S3 cascade;
Create schema App2S3;
set search_path = App2S3, pg_catalog;

CREATE TABLE CAMPUS
(
    CampusID INT NOT NULL,
    CampusNom VARCHAR(64) NOT NULL,
    PRIMARY KEY (CampusID)
);

CREATE TABLE STATUT
(
    StatutId INT NOT NULL,
    StatutNom VARCHAR(64) NOT NULL,
    PRIMARY KEY (StatutId)
);

CREATE TABLE CARACTERISTIQUE
(
    CaractID INT NOT NULL,
    CaractNom VARCHAR(64) NOT NULL,
    PRIMARY KEY (CaractID)
);

CREATE TABLE FONCTION
(
    FonctionId INT NOT NULL,
    FonctionNom VARCHAR(64) NOT NULL,
    PRIMARY KEY (FonctionId)
);

CREATE TABLE STATUT_Privilege
(
    Privilege VARCHAR(64) NOT NULL,
    StatutId INT NOT NULL,
    PRIMARY KEY (Privilege, StatutId),
    FOREIGN KEY (StatutId) REFERENCES STATUT(StatutId)
);

CREATE TABLE PAVILLON
(
    PavillonId VARCHAR(16) NOT NULL,
    PavillonNom VARCHAR(64) NOT NULL,
    CampusID INT NOT NULL,
    PRIMARY KEY (PavillonId),
    FOREIGN KEY (CampusID) REFERENCES CAMPUS(CampusID)
);

CREATE TABLE DEPARTEMENT
(
    DepatementId INT NOT NULL,
    DepartementNom VARCHAR(64) NOT NULL,
    PavillonId VARCHAR(16) NOT NULL,
    PRIMARY KEY (DepatementId),
    FOREIGN KEY (PavillonId) REFERENCES PAVILLON(PavillonId)
);

CREATE TABLE MEMBRE
(
    Cip VARCHAR(8) NOT NULL,
    Nom VARCHAR(32) NOT NULL,
    Prenom VARCHAR(32) NOT NULL,
    DepatementId INT NOT NULL,
    PRIMARY KEY (Cip),
    FOREIGN KEY (DepatementId) REFERENCES DEPARTEMENT(DepatementId)
);

CREATE TABLE StatutMembre
(
    Cip VARCHAR(8) NOT NULL,
    StatutId INT NOT NULL,
    PRIMARY KEY (Cip, StatutId),
    FOREIGN KEY (Cip) REFERENCES MEMBRE(Cip),
    FOREIGN KEY (StatutId) REFERENCES STATUT(StatutId)
);

CREATE TABLE LOCAL
(
    LocalNo INT NOT NULL,
    NbCubicule INT NOT NULL,
    Capacite INT NOT NULL,
    Note VARCHAR(1024),
    PavillonId VARCHAR(16) NOT NULL,
    FonctionId INT NOT NULL,
    Compose_LocalNo INT,
    PRIMARY KEY (LocalNo, NbCubicule, PavillonId),
    FOREIGN KEY (PavillonId) REFERENCES PAVILLON(PavillonId),
    FOREIGN KEY (FonctionId) REFERENCES FONCTION(FonctionId),
    FOREIGN KEY (Compose_LocalNo, NbCubicule, PavillonId) REFERENCES LOCAL(LocalNo, NbCubicule, PavillonId)
);

CREATE TABLE RESERVATION
(
    Description VARCHAR(256),
    DateDebut DATE NOT NULL,
    DateFin DATE NOT NULL,
    ReservationId INT NOT NULL,
    LocalNo INT NOT NULL,
    NbCubicule INT NOT NULL,
    PavillonId VARCHAR(16) NOT NULL,
    Cip VARCHAR(8) NOT NULL,
    PRIMARY KEY (ReservationId),
    FOREIGN KEY (LocalNo, NbCubicule, PavillonId) REFERENCES LOCAL(LocalNo, NbCubicule, PavillonId),
    FOREIGN KEY (Cip) REFERENCES MEMBRE(Cip)
);

CREATE TABLE LOG
(
    LogId INT NOT NULL,
    Date DATE NOT NULL,
    Description VARCHAR(128) NOT NULL,
    ReservationId INT NOT NULL,
    Cip VARCHAR(8) NOT NULL,
    PRIMARY KEY (LogId),
    FOREIGN KEY (ReservationId) REFERENCES RESERVATION(ReservationId),
    FOREIGN KEY (Cip) REFERENCES MEMBRE(Cip)
);

CREATE TABLE CaractLocals
(
    Quantite INT NOT NULL,
    CaractID INT NOT NULL,
    LocalNo INT NOT NULL,
    NbCubicule INT NOT NULL,
    PavillonId VARCHAR(16) NOT NULL,
    PRIMARY KEY (CaractID, LocalNo, NbCubicule, PavillonId),
    FOREIGN KEY (CaractID) REFERENCES CARACTERISTIQUE(CaractID),
    FOREIGN KEY (LocalNo, NbCubicule, PavillonId) REFERENCES LOCAL(LocalNo, NbCubicule, PavillonId)
);

INSERT INTO CARACTERISTIQUE VALUES (0, 'Connexion à Internet');
INSERT INTO CARACTERISTIQUE VALUES (1, 'Tables fixes en U et chaises mobiles');
INSERT INTO CARACTERISTIQUE VALUES (2, 'Monoplaces');
INSERT INTO CARACTERISTIQUE VALUES (3, 'Tables fixes et chaises fixes');
INSERT INTO CARACTERISTIQUE VALUES (6, 'Tables pour 2 ou + et chaises mobiles');
INSERT INTO CARACTERISTIQUE VALUES (7, 'Tables mobiles et chaises mobiles');
INSERT INTO CARACTERISTIQUE VALUES (8, 'Tables hautes et chaises hautes');
INSERT INTO CARACTERISTIQUE VALUES (9, 'Tables fixes et chaises mobiles');
INSERT INTO CARACTERISTIQUE VALUES (11, 'Écran');
INSERT INTO CARACTERISTIQUE VALUES (14, 'Rétroprojecteur');
INSERT INTO CARACTERISTIQUE VALUES (15, 'Gradins');
INSERT INTO CARACTERISTIQUE VALUES (16, 'Fenêtres');
INSERT INTO CARACTERISTIQUE VALUES (17, '1 piano');
INSERT INTO CARACTERISTIQUE VALUES (18, '2 pianos');
INSERT INTO CARACTERISTIQUE VALUES (19, 'Autres instruments');
INSERT INTO CARACTERISTIQUE VALUES (20, 'Système de son');
INSERT INTO CARACTERISTIQUE VALUES (21, 'Salle réservée (spéciale)');
INSERT INTO CARACTERISTIQUE VALUES (22, 'Ordinateurs PC');
INSERT INTO CARACTERISTIQUE VALUES (23, 'Ordinateurs SUN pour génie électrique');
INSERT INTO CARACTERISTIQUE VALUES (24, 'PC');
INSERT INTO CARACTERISTIQUE VALUES (25, 'Ordinateurs (oscillomètre et multimètre)');
INSERT INTO CARACTERISTIQUE VALUES (26, 'Ordinateurs modélisation des structures');
INSERT INTO CARACTERISTIQUE VALUES (27, 'Ordinateurs PC');
INSERT INTO CARACTERISTIQUE VALUES (28, 'Équipement pour microélectronique');
INSERT INTO CARACTERISTIQUE VALUES (29, 'Équipement pour génie électrique');
INSERT INTO CARACTERISTIQUE VALUES (30, 'Ordinateurs et équipement pour mécatroni');
INSERT INTO CARACTERISTIQUE VALUES (31, 'Équipement métrologie');
INSERT INTO CARACTERISTIQUE VALUES (32, 'Équipement de machinerie');
INSERT INTO CARACTERISTIQUE VALUES (33, 'Équipement de géologie');
INSERT INTO CARACTERISTIQUE VALUES (34, 'Équipement pour la caractérisation');
INSERT INTO CARACTERISTIQUE VALUES (35, 'Équipement pour la thermodynamique');
INSERT INTO CARACTERISTIQUE VALUES (36, 'Équipement pour génie civil');
INSERT INTO CARACTERISTIQUE VALUES (37, 'Télévision');
INSERT INTO CARACTERISTIQUE VALUES (38, 'VHS');
INSERT INTO CARACTERISTIQUE VALUES (39, 'Hauts parleurs');
INSERT INTO CARACTERISTIQUE VALUES (40, 'Micro');
INSERT INTO CARACTERISTIQUE VALUES (41, 'Magnétophone à cassette');
INSERT INTO CARACTERISTIQUE VALUES (42, 'Amplificateur audio');
INSERT INTO CARACTERISTIQUE VALUES (43, 'Local barré');
INSERT INTO CARACTERISTIQUE VALUES (44, 'Prise réseau');


