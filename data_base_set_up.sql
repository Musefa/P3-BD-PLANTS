-- BORRADO Y CREACION DE LA BASE DE DATOS
DROP SCHEMA IF EXISTS PLANTS;
CREATE SCHEMA PLANTS;
USE PLANTS;

-- Variables de la sessió
SET @control = 0;

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
    CONSTRAINT fk_adobs_to_firma_comercial FOREIGN KEY (nom_firma_comercial) REFERENCES firmes_comercials(nom) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE estacions
(
    nom CHAR(50),
    CONSTRAINT pk_estacions PRIMARY KEY (nom) 
) ENGINE = InnoDB;

CREATE TABLE plantes
(
    nom_popular CHAR(50),
    nom_llati CHAR(50) UNIQUE NOT NULL, /* Clau alternativa */
    CONSTRAINT pk_plantes PRIMARY KEY (nom_popular)
) ENGINE = InnoDB;

CREATE TABLE floracio
(
    nom_planta CHAR(50),
    nom_estacio CHAR(50),
    CONSTRAINT pk_floracio PRIMARY KEY (nom_planta, nom_estacio),
    CONSTRAINT fk_floracio_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE, 
    CONSTRAINT fk_floracio_to_estacions FOREIGN KEY (nom_estacio) REFERENCES estacions(nom) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE dosis_adobs
(
    nom_planta CHAR(20),
    nom_estacio CHAR(20),
    nom_adob CHAR(20),
    quantitat_adob FLOAT(5,2),
    CONSTRAINT pk_dosis_adobs PRIMARY KEY (nom_planta, nom_estacio, nom_adob),
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
    CONSTRAINT pk_plantes_interior PRIMARY KEY (nom_planta), 
    CONSTRAINT fk_plantes_interior_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE plantes_exterior
(
    nom_planta CHAR(50),
    cicle_de_vida CHAR(1),
    CONSTRAINT pk_plantes_exterior PRIMARY KEY (nom_planta),
    CONSTRAINT fk_plantes_exterior_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE

) ENGINE = InnoDB;

CREATE TABLE rec_plantes
(
    nom_planta_interior CHAR(50),
    nom_estacio CHAR(50),
    quantitat_aigua FLOAT(5,2),
    CONSTRAINT pk_rec_plantes PRIMARY KEY (nom_planta_interior, nom_estacio),
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
    CONSTRAINT pk_origen_plantes PRIMARY KEY (nom_planta_interior, nom_pais),
    CONSTRAINT fk_origen_plantes_to_paisos FOREIGN KEY (nom_pais) REFERENCES paisos(nom) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE exemplars_plantes
(
    numero INT(2) auto_increment,
    nom_planta CHAR(50),
    CONSTRAINT pk_exemplars_plantes PRIMARY KEY (numero, nom_planta),
    CONSTRAINT fk_exemplars_plantes_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

DROP VIEW IF EXISTS plantes_exterior_metodes;

CREATE VIEW plantes_exterior_metodes AS
    SELECT PE.nom_planta, P.nom_llati, COUNT(EP.numero)
    FROM plantes_exterior PE
        JOIN plantes P ON (PE.nom_planta = P.nom_popular)
        JOIN exemplars_plantes EP ON (P.nom_popular = EP.nom_planta)
        JOIN reproduccions R ON (P.nom_popular = R.nom_planta)
    GROUP BY PE.nom_planta, P.nom_llati
HAVING COUNT(R.nom_metode) >= 2;

DROP VIEW IF EXISTS temperatura_plantes_interior;

CREATE VIEW temperatura_plantes_interior AS
    SELECT nom_planta, ubicacio_adient, temperatura_adient
    FROM plantes_interior
    WHERE temperatura_adient > 16.0;

DELIMITER //
CREATE TRIGGER min_2_exemplars_insert
BEFORE INSERT ON exemplars_plantes
FOR EACH ROW
BEGIN
    IF @control <> 1
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Empra el procediment insereix_exemplar per poder introduir-los.";
    END IF;
END
//  

CREATE TRIGGER min_2_exemplars_update
AFTER UPDATE ON exemplars_plantes
FOR EACH ROW
BEGIN
    IF 1 in (SELECT COUNT(*) /* Sintaxis estàndard no respectada */
             FROM exemplars_plantes
             GROUP BY nom_planta) /* 2 o més és correcte, 0 és correcte */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim ha d'haver 2 exemplars per cada planta.";
    END IF;
END
//

CREATE TRIGGER min_2_exemplars_delete
AFTER DELETE ON exemplars_plantes
FOR EACH ROW
BEGIN
    IF 1 in (SELECT COUNT(*) /* Sintaxis estàndard no respectada */
             FROM exemplars_plantes
             GROUP BY nom_planta) /* 2 o més és correcte, 0 és correcte */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim ha d'haver 2 exemplars per cada planta.";
    END IF;
END
//

CREATE PROCEDURE insereix_exemplar(IN nom_plant char(50), IN num_exemplars int)
BEGIN
    IF num_exemplars < 2 AND  2 > (SELECT COUNT(*)
                                   FROM exemplars_plantes
                                   WHERE nom_planta = nom_plant)
    THEN    
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim ha d'haver 2 exemplars per cada planta.";
    ELSE
        SET @control = 1;
        FOR i IN 1..num_exemplars DO
            insert into exemplars_plantes(nom_planta) values (nom_plant);
        END FOR;
        SET @control = 0;
    END IF;
END
//

DELIMITER ;