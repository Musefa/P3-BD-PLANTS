-- BORRADO Y CREACION DE LA BASE DE DATOS
DROP SCHEMA IF EXISTS PLANTS;
CREATE SCHEMA PLANTS;
USE PLANTS;

-- DEFINICION DE TABLAS DE LA BASE DE DATOS
CREATE TABLE firmes_comercials
(
    nom CHAR(50),
    PRIMARY KEY (nom)
);

CREATE TABLE adobs
(
    nom CHAR(50),
    tipus CHAR(50),
    nom_firma_comercial CHAR(50) NOT NULL,
    CONSTRAINT pk_adobs PRIMARY KEY (nom) NOT DEFERRABLE,
    FOREIGN KEY (nom_firma_comercial) REFERENCES firmes_comercials(nom) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE estacions
(
    nom CHAR(50),
    PRIMARY KEY (nom)
);

CREATE TABLE plantes
(
    nom_popular CHAR(50),
    nom_llati CHAR(50) UNIQUE NOT NULL,
    nom_estacio_floracio CHAR(50),
    PRIMARY KEY (nom_popular),
    FOREIGN KEY (nom_popular) REFERENCES estacions(nom) ON DELETE CASCADE ON UPDATE CASCADE
);

CREATE TABLE dosis_adobs
(
    nom_planta CHAR(20),
    nom_estacio CHAR(20),
    nom_adob CHAR(20),
    quantitat_adob FLOAT(5,2),
    PRIMARY KEY (nom_planta, nom_estacio, nom_adob),
    FOREIGN KEY (nom_planta) REFERENCES plantes(nom) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (nom_estacio) REFERENCES estacions(nom) ON DELETE CASCADE ON UPDATE CASCADE,
    FOREIGN KEY (nom_adob) REFERENCES adobs(nom) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT quantitat_adob CHECK (quantitat_adob >= 20 AND quantitat_adob <= 1000) NOT DEFERRABLE
);

CREATE TABLE metodes_reproduccio
(
    nom_popular CHAR(50),
    PRIMARY KEY
);

CREATE TABLE reproduccions (
    nom_planta CHAR(50),
    nom_metode CHAR(50),
    grau_exit SMALLINT,
    PRIMARY KEY (nom_planta, nom_metode),
    FOREIGN KEY (nom_planta) REFERENCES Plantes(nom_popular),
    FOREIGN KEY (nom_metode) REFERENCES Metodes_Reproduccio(nom_popular)
);