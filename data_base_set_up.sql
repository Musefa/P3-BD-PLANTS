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
    nom CHAR(50) DEFAULT "default_adob",
    tipus CHAR(50),
    nom_firma_comercial CHAR(50) NOT NULL,
    CONSTRAINT pk_adobs PRIMARY KEY (nom),
    CONSTRAINT fk_adobs_to_firma_comercial FOREIGN KEY (nom_firma_comercial) REFERENCES firmes_comercials(nom) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE TABLE estacions
(
    nom CHAR(50),
    CONSTRAINT pk_estacions PRIMARY KEY (nom) 
) ENGINE = InnoDB;

CREATE TABLE plantes
(
    nom_popular CHAR(50) DEFAULT "planta_default",
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
    nom CHAR(50) DEFAULT "metode_default",
    CONSTRAINT pk_metodes_reproduccio PRIMARY KEY (nom)
) ENGINE = InnoDB;

CREATE TABLE reproduccions (
    nom_planta CHAR(50) DEFAULT "planta_default",
    nom_metode CHAR(50) DEFAULT "metode_default",
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
    numero INT(2),
    nom_planta CHAR(50),
    CONSTRAINT pk_exemplars_plantes PRIMARY KEY (numero, nom_planta),
    CONSTRAINT fk_exemplars_plantes_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

CREATE VIEW plantes_exterior_metodes AS
    SELECT P.nom_popular, P.nom_llati, COUNT(EP.numero)
    FROM plantes P
        JOIN exemplars_plantes EP ON (P.nom_popular = EP.nom_planta)
    WHERE P.nom_popular in (SELECT PE.nom_planta
                            FROM plantes_exterior PE)
    AND (SELECT R.nom_planta
         FROM reproduccions R
         GROUP BY R.nom_planta
         HAVING COUNT(R.nom_metode) >= 2); /* Emprem subconsultes per evitar triple join */

CREATE VIEW temperatura_plantes_interior AS
    SELECT PI.nom_planta, PI.ubicacio_adient, PI.temperatura_adient
    FROM plantes_interior PI
    WHERE PI.temperatura_adient > 16.0;

DELIMITER //
-- CREATE TRIGGER min_2_exemplars_update
-- AFTER UPDATE ON exemplars_plantes
-- FOR EACH ROW
-- DECLARE 
--     CURSOR exemplars_invalids FOR (SELECT nom_planta
--                                   FROM exemplars_plantes
--                                   GROUP BY nom_planta
--                                   HAVING COUNT(*) = 1); /* 2 o + correcte, 0 correcte, 1 IMPOSSIBLE */
--     temp exemplars.nom_planta;
-- BEGIN
--     OPEN exemplars_invalids;
--     IF exemplars_invalids IS NOT NULL
--     THEN
--         FOR i IN exemplars_invalids 
--         DO
--             fetch exemplars_invalids into temp;
--             insert into exemplars(nom_planta) values (temp); /* Insertem tuples per tal d'evitar problemes */

--         END FOR;
--     END IF;
-- END
-- //

-- CREATE TRIGGER min_2_exemplars_delete
-- AFTER DELETE ON exemplars_plantes
-- FOR EACH ROW
-- BEGIN
--     IF 1 in (SELECT COUNT(*) /* Sintaxis estàndard no respectada */
--              FROM exemplars_plantes
--              GROUP BY nom_planta) /* 2 o més és correcte, 0 és correcte */
--     THEN
--         SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim hi ha d'haver 2 exemplars per cada planta.";
--     END IF;
-- END
-- //

CREATE PROCEDURE insereix_exemplar(IN nom_plant char(50), IN num_exemplars int)
BEGIN
    DECLARE last_exemplar TYPE OF exemplars_plantes.numero;

    SELECT min(numero) /* Obtenim els exemplars que no tenen nombre consecutiu assignat i escollim el mínim (si tots tenen consecutiu, s'escull l'últim). */
    INTO last_exemplar
    FROM exemplars_plantes
    WHERE nom_planta = nom_plant
    AND numero + 1 NOT IN (SELECT numero
                           FROM exemplars_plantes
                           WHERE nom_planta = nom_plant); /* Llistat de números de exemplars */    

    IF num_exemplars < 2 AND  2 > (SELECT COUNT(*)
                                   FROM exemplars_plantes
                                   WHERE nom_planta = nom_plant)
    THEN    
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim hi ha d'haver 2 exemplars per cada planta.";
    ELSE
        IF last_exemplar IS NULL
        THEN 
            SET last_exemplar = 0; 
        END IF; /* Si no hi ha cap tupla de plantes, és el primer exemplar, el 0 */

        FOR i IN 1..num_exemplars 
        DO
            WHILE last_exemplar IN (SELECT numero FROM exemplars_plantes WHERE nom_planta = nom_plant)
            DO
                SET last_exemplar = last_exemplar + 1; /* Incrementem el nombre d'exemplar en 1 mentre estigui dins de la taula */
            END WHILE;
            insert into exemplars_plantes(numero, nom_planta) values (last_exemplar, nom_plant);
            SET last_exemplar = last_exemplar + 1; /* Següent nombre d'exemplar */
        END FOR;
    END IF;
END
//

-- CREATE TRIGGER plantes_to_reproduccions
-- AFTER INSERT ON plantes
-- FOR EACH ROW
-- BEGIN
--     IF NOT EXISTS (SELECT *
--                    FROM reproduccions R
--                    WHERE R.nom_planta = new.nom_popular)
--     THEN
--         insert into reproduccions(nom_planta, nom_metode, grau_exit) values (new.nom_popular, DEFAULT, DEFAULT); /* Inserció brossa, per complir obligatorietat */
--     END IF;
-- END
-- //

-- CREATE TRIGGER metodes_to_reproduccions
-- AFTER INSERT ON metodes_reproduccio
-- FOR EACH ROW
-- BEGIN
--     IF NOT EXISTS (SELECT *
--                    FROM reproduccions R
--                    WHERE R.nom_metode = new.nom)
--     THEN
--         insert into reproduccions(nom_planta, nom_metode, grau_exit) values (DEFAULT, nom, DEFAULT); /* Inserció brossa, per complir obligatorietat */
--     END IF;
-- END
-- //

-- CREATE TRIGGER reproduccions /* Permet controlar que no s'emmagatzemin tuples brossa per complir obligatorietats */
-- BEFORE INSERT ON reproduccions
-- FOR EACH ROW
-- BEGIN
--     delete from reproduccions R where (R.nom_metode = DEFAULT(R.nom_metode) AND R.nom_planta = new.nom_planta) 
--     OR (R.nom_metode = new.nom_metode AND R.nom_planta = DEFAULT(R.nom_planta)); /* Esborrem tuples brossa dels valors inserits (si existeixen) */
-- END
-- //

CREATE PROCEDURE insereix_planta_i_reproduccio(IN nom_popu_planta CHAR(50), IN nom_llati_planta CHAR(50), IN nom_metode_reproduccio CHAR(50), IN grau_exit_intr CHAR(50))
BEGIN
    IF NOT EXISTS (SELECT *
                   FROM plantes P
                   WHERE P.nom_popular = nom_popu_planta)
    THEN
        insert into plantes(nom_popular, nom_llati) values (nom_popu_planta, nom_llati_planta); /* Insertem si la planta no existeix en la BD encara */
    END IF;

    IF NOT EXISTS (SELECT *
                   FROM metodes_reproduccio MR
                   WHERE MR.nom = nom_metode_reproduccio)
    THEN
        insert into metodes_reproduccio(nom) values (nom_metode_reproduccio); /* Insertem si la planta no existeix en la BD encara */
    END IF;
    insert into reproduccions(nom_planta, nom_metode, grau_exit) values (nom_popu_planta, nom_metode_reproduccio, grau_exit_intr);
END
//

CREATE PROCEDURE inicialitza_firma_comercial(IN nom_firma CHAR(50), IN nom_adob_intr CHAR (50), IN tipus_adob_intr CHAR(50))
BEGIN
    insert into firmes_comercials(nom) values (nom_firma);
    IF NOT EXISTS (SELECT *
                   FROM adobs A
                   WHERE A.nom = nom_adob_intr)
    THEN
        insert into adobs(nom, tipus, nom_firma_comercial) values (nom_adob_intr, tipus_adob_intr, nom_firma); /* Insertar en adobs si l'adob no està introduit. Si l'usuari introdueix informació errònia de l'adob (nova firma, nou tipus, no es modificarà) */
    END IF;
END
//

DELIMITER ;