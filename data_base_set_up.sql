-- BORRADO Y CREACION DE LA BASE DE DATOS
DROP SCHEMA IF EXISTS PLANTS;
CREATE SCHEMA PLANTS;
USE PLANTS;

-- DEFINICION DE TABLAS DE LA BASE DE DATOS
CREATE TABLE firmes_comercials
(
    nom CHAR(50),
    CONSTRAINT pk_firmes_comercials PRIMARY KEY (nom)
) ENGINE = InnoDB;

CREATE TABLE adobs
(
    nom CHAR(50),
    tipus CHAR(50),
    nom_firma_comercial CHAR(50) NOT NULL,
    CONSTRAINT pk_adobs PRIMARY KEY (nom) ,
    CONSTRAINT fk_adobs FOREIGN KEY (nom_firma_comercial) REFERENCES firmes_comercials(nom) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE estacions
(
    nom CHAR(50),
    CONSTRAINT pk_estacions PRIMARY KEY (nom) 
) ENGINE = InnoDB;

CREATE TABLE plantes
(
    nom_popular CHAR(50),
    nom_llati CHAR(50) UNIQUE NOT NULL,
    nom_estacio_floracio CHAR(50),
    CONSTRAINT pk_plantes PRIMARY KEY (nom_popular),
    CONSTRAINT fk_plantes_to_estacions FOREIGN KEY (nom_estacio_floracio) REFERENCES estacions(nom) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE dosis_adobs
(
    nom_planta CHAR(20),
    nom_estacio CHAR(20),
    nom_adob CHAR(20),
    quantitat_adob FLOAT(5,2),
    CONSTRAINT pk_dosis_adobs PRIMARY KEY (nom_planta, nom_estacio, nom_adob) ,
    CONSTRAINT fk_dosis_adobs_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_dosis_adobs_to_estacions FOREIGN KEY (nom_estacio) REFERENCES estacions(nom) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_dosis_adobs_to_adobs FOREIGN KEY (nom_adob) REFERENCES adobs(nom) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT quantitat_adob CHECK (quantitat_adob >= 20 AND quantitat_adob <= 1000) 
) ENGINE = InnoDB;

CREATE TABLE metodes_reproduccio
(
    nom CHAR(50),
    CONSTRAINT pk_metodes_reproduccio PRIMARY KEY (nom)
) ENGINE = InnoDB;

CREATE TABLE reproduccions (
    nom_planta CHAR(50),
    nom_metode CHAR(50),
    grau_exit CHAR(50),
    CONSTRAINT pk_reproduccions PRIMARY KEY (nom_planta, nom_metode),
    CONSTRAINT fk_reproduccions_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_reproduccions_to_metodes_reproduccio FOREIGN KEY (nom_metode) REFERENCES metodes_reproduccio(nom) ON DELETE CASCADE ON UPDATE CASCADE 
) ENGINE = InnoDB;

CREATE TABLE plantes_interior
(
    nom_planta CHAR(50),
    ubicacio_adient CHAR(50),
    temperatura_adient FLOAT(5,2),
    CONSTRAINT pk_plantes_interior PRIMARY KEY (nom_planta) 
) ENGINE = InnoDB;

CREATE TABLE plantes_exterior
(
    nom_planta CHAR(50),
    cicle_de_vida SMALLINT,
    CONSTRAINT pk_plantes_exterior PRIMARY KEY (nom_planta)
) ENGINE = InnoDB;

CREATE TABLE rec_plantes
(
    nom_planta_interior CHAR(50),
    nom_estacio CHAR(50),
    quantitat_aigua FLOAT(5,2),
    CONSTRAINT pk_rec_plantes PRIMARY KEY (nom_planta_interior, nom_estacio) ,
    CONSTRAINT fk_rec_plantes_to_plantes_interior FOREIGN KEY (nom_planta_interior) REFERENCES plantes_interior(nom_planta) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_rec_plantes_to_estacions FOREIGN KEY (nom_estacio) REFERENCES estacions(nom) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE paisos
(
    nom CHAR(50),
    CONSTRAINT pk_paisos PRIMARY KEY (nom)
) ENGINE = InnoDB;

CREATE TABLE origen_plantes
(
    nom_planta_interior CHAR(50),
    nom_pais CHAR(50),
    CONSTRAINT pk_origen_plantes PRIMARY KEY (nom_planta_interior, nom_pais)
) ENGINE = InnoDB;

CREATE TABLE exemplars_plantes
(
    numero INT(2),
    nom_planta CHAR(50),
    CONSTRAINT pk_exemplars_plantes PRIMARY KEY (numero, nom_planta)
) ENGINE = InnoDB;