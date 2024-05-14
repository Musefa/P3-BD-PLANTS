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

DELIMITER //
CREATE TRIGGER min_2_exemplars
BEFORE INSERT ON exemplars_plantes
FOR EACH ROW
BEGIN
    IF 2 > (SELECT COUNT(*)
            FROM exemplars_plantes
            WHERE nom_planta = new.nom_planta) 
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Empra el procediment insereix_exemplar per poder introduir-los.";
    ELSE
        insert into exemplars_plantes(nom_planta) values (new.nom_planta);
    END IF;
END
//  

CREATE PROCEDURE insereix_exemplar(IN nom_plant char(50), IN num_exemplars int)
BEGIN
    IF num_exemplars < 2
    THEN    
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim ha d'haver 2 exemplars per cada planta.";
    ELSE
        SET @disable_trigger = "ALTER TABLE exemplars_plantes DISABLE TRIGGER min_2_exemplars";
        SET @enable_trigger = "ALTER TABLE exemplars_plantes ENABLE TRIGGER min_2_exemplars";
        PREPARE disable_trigger FROM @disable_trigger;
        EXECUTE disable_trigger;

        FOR i IN 1..num_exemplars DO
            insert into exemplars_plantes(nom_planta) values (nom_planta);
        END FOR;
        PREPARE enable_trigger FROM @enable_trigger;
        EXECUTE enable_trigger;
        
    END IF;
END
//

DELIMITER ;