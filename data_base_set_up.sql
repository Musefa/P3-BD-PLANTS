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
    nom_planta CHAR(50),
    nom_estacio CHAR(50),
    nom_adob CHAR(50),
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
    nom_planta CHAR(50),
    numero INT(2),
    CONSTRAINT pk_exemplars_plantes PRIMARY KEY (nom_planta, numero),
    CONSTRAINT fk_exemplars_plantes_to_plantes FOREIGN KEY (nom_planta) REFERENCES plantes(nom_popular) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB;

DELIMITER //
CREATE VIEW plantes_exterior_metodes AS
    SELECT P.nom_popular, P.nom_llati, COUNT(EP.numero)
    FROM plantes P
        LEFT OUTER JOIN exemplars_plantes EP ON (P.nom_popular = EP.nom_planta)
    WHERE P.nom_popular in (SELECT PE.nom_planta
                            FROM plantes_exterior PE)
    AND P.nom_popular IN (SELECT R.nom_planta
                          FROM reproduccions R
                          GROUP BY R.nom_planta
                          HAVING COUNT(R.nom_metode) >= 2) /* Emprem subconsultes per evitar triple join */
    GROUP BY P.nom_popular, P.nom_llati
//

CREATE VIEW temperatura_plantes_interior AS
    SELECT PI.nom_planta, PI.ubicacio_adient, PI.temperatura_adient
    FROM plantes_interior PI
    WHERE PI.temperatura_adient > 16.0
WITH CHECK OPTION
//

/* FUNCIONS + CONTROLS */
CREATE PROCEDURE insereix_exemplar(IN nom_plant type of plantes.nom_popular, IN num_exemplars type of exemplars_plantes.numero)
BEGIN
    DECLARE last_exemplar TYPE OF exemplars_plantes.numero;

    SELECT min(numero) /* Obtenim els exemplars que no tenen nombre consecutiu assignat i escollim el mínim (si tots tenen consecutiu, s'escull l'últim). */
    INTO last_exemplar
    FROM exemplars_plantes
    WHERE nom_planta = nom_plant
    AND numero + 1 NOT IN (SELECT numero
                           FROM exemplars_plantes
                           WHERE nom_planta = nom_plant); /* Llistat de números d'exemplars */    

    IF num_exemplars < 2 AND  2 > (SELECT COUNT(*)
                                   FROM exemplars_plantes
                                   WHERE nom_planta = nom_plant)
    THEN    
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim hi ha d'haver 2 exemplars per cada planta.";
    ELSE
        IF last_exemplar IS NULL
        THEN 
            SET last_exemplar = 1; 
        END IF; /* Si no hi ha cap tupla de plantes, és el primer exemplar, el 0 */

        FOR i IN 1..num_exemplars 
        DO
            WHILE last_exemplar IN (SELECT numero FROM exemplars_plantes WHERE nom_planta = nom_plant)
            DO
                SET last_exemplar = last_exemplar + 1; /* Incrementem el nombre d'exemplar en 1 mentre estigui dins de la taula */
            END WHILE;
            insert into exemplars_plantes(nom_planta, numero) values (nom_plant, last_exemplar);
            SET last_exemplar = last_exemplar + 1; /* Següent nombre d'exemplar */
        END FOR;
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim hi ha d'haver 2 exemplars per cada planta.";
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
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "Com a minim hi ha d'haver 2 exemplars per cada planta.";
    END IF;
END
//

/* INSERTAR EN DOCU */
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

CREATE PROCEDURE insereix_planta(IN nom_popu_planta type of plantes.nom_popular, IN nom_llati_planta type of plantes.nom_llati, IN nom_metode_reproduccio type of metodes_reproduccio.nom, IN grau_exit_intr type of reproduccions.grau_exit)
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
        insert into metodes_reproduccio(nom) values (nom_metode_reproduccio); /* Insertem si el mètode de reproducció no existeix en la BD encara */
    END IF;
    insert into reproduccions(nom_planta, nom_metode, grau_exit) values (nom_popu_planta, nom_metode_reproduccio, grau_exit_intr);
END
//

CREATE TRIGGER update_reproduccions_restrict
AFTER UPDATE ON reproduccions
FOR EACH ROW
BEGIN
    IF OLD.nom_planta NOT IN (SELECT R.nom_planta
                              FROM reproduccions R) /* Si no queden plantes després de l'actualització */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot actualitzar la reproduccio, ja que si no hi hauria plantes o metodes sense cap reproduccio assignada.";
    END IF;
    IF OLD.nom_metode NOT IN (SELECT R.nom_metode
                              FROM reproduccions R) /* Si no queden metodes després de l'actualització */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot actualitzar la reproduccio, ja que si no hi hauria plantes o metodes sense cap reproduccio assignada.";
    END IF;
END
//

CREATE TRIGGER delete_reproduccions_restrict
AFTER DELETE ON reproduccions
FOR EACH ROW
BEGIN
    IF OLD.nom_planta NOT IN (SELECT R.nom_planta
                              FROM reproduccions R) /* Si no queden plantes després de l'esborrat */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot esborrar la reproduccio, ja que si no hi hauria plantes o metodes sense cap reproduccio assignada.";
    END IF;
    IF OLD.nom_metode NOT IN (SELECT R.nom_metode
                              FROM reproduccions R) /* Si no queden metodes després de l'esborrat */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot esborrar la reproduccio, ja que si no hi hauria plantes o metodes sense cap reproduccio assignada.";
    END IF;
END
//

CREATE PROCEDURE inicialitza_firma_comercial(IN nom_firma type of firmes_comercials.nom, IN nom_adob_intr type of adobs.nom, IN tipus_adob_intr type of adobs.tipus)
BEGIN
    insert into firmes_comercials(nom) values (nom_firma);
    IF NOT EXISTS (SELECT *
                   FROM adobs A
                   WHERE A.nom = nom_adob_intr)
    THEN
        insert into adobs(nom, tipus, nom_firma_comercial) values (nom_adob_intr, tipus_adob_intr, nom_firma); /* Insertar en adobs si l'adob no està introduït. Si l'usuari introdueix informació errònia de l'adob (nova firma, nou tipus, no es modificarà) */
    ELSE
        update adobs set nom_firma_comercial = nom_firma where nom = nom_adob_intr;
    END IF;
END
//

CREATE TRIGGER actualitza_adobs
AFTER UPDATE ON adobs
FOR EACH ROW
BEGIN
    IF  0 = (SELECT COUNT(*)
             FROM adobs A
             WHERE A.nom_firma_comercial = OLD.nom_firma_comercial)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot actualitzar l'adob, ja que no hi ha cap adob associat a la firma comercial.";
    END IF;
END
//

CREATE TRIGGER elimina_adobs
AFTER DELETE ON adobs
FOR EACH ROW
BEGIN
    IF  0 = (SELECT COUNT(*)
             FROM adobs A
             WHERE A.nom_firma_comercial = OLD.nom_firma_comercial)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot eliminar l'adob, ja que no hi ha cap adob associat a la firma comercial.";
    END IF;
END
//

CREATE PROCEDURE insereix_planta_interior
    (IN nom_popu_planta type of plantes.nom_popular, IN nom_llati_planta type of plantes.nom_llati, IN nom_metode_reproduccio type of reproduccions.nom_metode, IN grau_exit_intr type of reproduccions.grau_exit, 
     IN ubicacio type of plantes_interior.ubicacio_adient, IN temp type of plantes_interior.temperatura_adient, IN nom_estacio_rec type of estacions.nom, IN qtat_aigua type of rec_plantes.quantitat_aigua, 
     IN primer_pais_obligatori type of paisos.nom) /* CAL CONTROLAR LA INTEGRITAT D'INSERSCIONS DE PLANTES D'INTERIOR AMB LA SEVA SUPERTIPUS I EXTERIORS */

    /* Com a mínim la planta ha d'estar associada a un país, que es demana en aquesta funció d'inserció */
    /* Per inserir nous origens de paísos, cal afegir-los amb un insert into */
BEGIN
    call insereix_planta(nom_popu_planta, nom_llati_planta, nom_metode_reproduccio, grau_exit_intr); /* En cas que la planta ja existeixi la restricció de primary key ja anularà l'execució com s'esperaria */
    IF NOT EXISTS (SELECT *
                   FROM paisos
                   WHERE nom = primer_pais_obligatori)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "El pais al qual es vol assignar la planta no existeix en la base de dades. Inserta'l primer.";
    END IF;

    IF NOT EXISTS (SELECT *
                   FROM plantes_interior P
                   WHERE P.nom_planta = nom_popu_planta)
    THEN
        insert into plantes_interior(nom_planta, ubicacio_adient, temperatura_adient) values (nom_popu_planta, ubicacio, temp); /* Insertem si la planta d'interior no existeix en la BD encara */
    END IF;

    IF NOT EXISTS (SELECT *
                   FROM estacions MR
                   WHERE MR.nom = nom_estacio_rec)
    THEN
        insert into estacions(nom) values (nom_estacio_rec); /* Insertem si l'estació no existeix en la BD encara */
    END IF;

    IF NOT EXISTS (SELECT *
                   FROM rec_plantes
                   WHERE (nom_planta_interior, nom_estacio) = (nom_popu_planta, nom_estacio_rec))
    THEN
        insert into rec_plantes(nom_planta_interior, nom_estacio, quantitat_aigua) values (nom_popu_planta, nom_estacio_rec, qtat_aigua); /* Si introdueix erròniament informació repetida, no es té en compte */
    END IF; 

    IF NOT EXISTS (SELECT *
                   FROM origen_plantes
                   WHERE (nom_planta_interior, nom_pais) = (nom_popu_planta, primer_pais_obligatori))
    THEN
        insert into origen_plantes(nom_planta_interior, nom_pais) values (nom_popu_planta, primer_pais_obligatori);
    END IF;
END
//

CREATE TRIGGER update_rec_plantes_restrict
AFTER UPDATE ON rec_plantes
FOR EACH ROW
BEGIN
    IF OLD.nom_planta_interior NOT IN (SELECT R.nom_planta_interior
                                       FROM rec_plantes R) /* Si no queden plantes d'interior després de l'actualització */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot actualitzar la informacio del rec, ja que si no hi hauria plantes d'interior o metodes sense cap rec assignat.";
    END IF;
    IF OLD.nom_estacio NOT IN (SELECT R.nom_estacio_rec
                               FROM rec_plantes R) /* Si no queden estacions després de l'actualització */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot actualitzar la informacio del rec, ja que si no hi hauria plantes d'interior o metodes sense cap rec assignat.";
    END IF;
END
//

CREATE TRIGGER delete_rec_plantes_restrict
AFTER DELETE ON rec_plantes
FOR EACH ROW
BEGIN
    IF OLD.nom_planta_interior NOT IN (SELECT R.nom_planta_interior
                                       FROM rec_plantes R) /* Si no queden plantes d'interior després de l'esborrat */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot esborrar la informacio del rec, ja que si no hi hauria plantes d'interior o metodes sense cap rec assignat.";
    END IF;
    IF OLD.nom_estacio NOT IN (SELECT R.nom_estacio
                              FROM rec_plantes R) /* Si no queden estacions després de l'esborrat */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot esborrar la informacio del rec, ja que si no hi hauria plantes d'interior o metodes sense cap rec assignat.";
    END IF;
END
//

CREATE TRIGGER update_origen_plantes_restrict
AFTER UPDATE ON origen_plantes
FOR EACH ROW
BEGIN
    IF OLD.nom_planta_interior NOT IN (SELECT R.nom_planta_interior
                                       FROM origen_plantes R) /* Si no queden plantes d'interior després de l'actualització */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot actualitzar la informacio de l'origen, ja que si no hi hauria plantes d'interior sense cap origen assignat.";
    END IF;
    /* No cal controlar-ho per països ja que és opcional a la interrelació */
END
//

CREATE TRIGGER delete_origen_plantes_restrict
AFTER DELETE ON origen_plantes
FOR EACH ROW
BEGIN
    IF OLD.nom_planta_interior NOT IN (SELECT R.nom_planta_interior
                                       FROM origen_plantes R) /* Si no queden plantes d'interior després de l'esborrat */
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot esborrar la informacio del rec, ja que si no hi hauria plantes d'interior o metodes sense cap rec assignat.";
    END IF;
    /* No cal controlar-ho per països ja que és opcional a la interrelació */
END
//

/* DAVANT D'INSERCIONS O MODIFICACIONS, NOMÉS ES CONTROLA ENTRE LES SUBTIPUS, LA SUPERTIPUS QUEDA CONTROLADA PER LES RESTRICCIONS DE PRIMARY KEY */
CREATE TRIGGER planta_interior_not_into_planta_exterior_insert
BEFORE INSERT ON plantes_interior /* Qualsevol modificació en aquesta relació */
FOR EACH ROW
BEGIN
    IF new.nom_planta IN (SELECT PE.nom_planta
                          FROM plantes_exterior PE)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot inserir la planta d'interior ja que es una planta d'exterior";
    END IF;
END
//

CREATE TRIGGER planta_interior_not_into_planta_exterior_update
BEFORE UPDATE ON plantes_interior /* Qualsevol modificació en aquesta relació */
FOR EACH ROW
BEGIN
    IF new.nom_planta IN (SELECT PE.nom_planta
                          FROM plantes_exterior PE)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot modificar la planta d'interior ja que es una planta d'exterior";
    END IF;
END
//

CREATE TRIGGER planta_exterior_not_into_planta_interior_insert
BEFORE INSERT ON plantes_exterior /* Qualsevol modificació en aquesta relació */
FOR EACH ROW
BEGIN
    IF new.nom_planta IN (SELECT PE.nom_planta
                          FROM plantes_interior PE)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot inserir la planta d'exterior ja que es una planta d'interior";
    END IF;
END
//

CREATE TRIGGER planta_exterior_not_into_planta_interior_update
BEFORE UPDATE ON plantes_exterior /* Qualsevol modificació en aquesta relació */
FOR EACH ROW
BEGIN
    IF new.nom_planta IN (SELECT PE.nom_planta
                          FROM plantes_interior PE)
    THEN
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = "No es pot modificar la planta d'exterior ja que es una planta d'interior";
    END IF;
END
//

CREATE TRIGGER planta_exterior_delete
AFTER DELETE ON plantes_exterior
FOR EACH ROW
BEGIN
    delete from plantes where nom_popular = old.nom_planta; /* S'elimina la planta de la base de dades també */
END
//

CREATE TRIGGER planta_interior_delete
AFTER DELETE ON plantes_interior
FOR EACH ROW
BEGIN
    delete from plantes where nom_popular = old.nom_planta; /* S'elimina la planta de la base de dades també */
END
//

CREATE PROCEDURE insereix_planta_exterior 
    (IN nom_popu_planta type of plantes.nom_popular, IN nom_llati_planta type of plantes.nom_llati, IN nom_metode_reproduccio type of reproduccions.nom_metode, IN grau_exit_intr type of reproduccions.grau_exit, IN cicle_vida type of plantes_exterior.cicle_de_vida)
BEGIN
    call insereix_planta(nom_popu_planta, nom_llati_planta, nom_metode_reproduccio, grau_exit_intr); /* En cas que la planta ja existeixi la restricció de primary key ja anularà l'execució com s'esperaria */
    IF NOT EXISTS (SELECT *
                   FROM plantes_exterior
                   WHERE nom_planta = nom_popu_planta)
    THEN
        insert into plantes_exterior(nom_planta, cicle_de_vida) values (nom_popu_planta, cicle_vida);
    END IF;
END
//

DELIMITER ;