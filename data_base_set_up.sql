-- BORRADO Y CREACION DE LA BASE DE DATOS
DROP SCHEMA IF EXISTS PLANTS;
CREATE SCHEMA PLANTS;
USE PLANTS;
-- DEFINICION DE TABLAS DE LA BASE DE DATOS
CREATE TABLE Plantes
(
    nom_popular VARCHAR(50) PRIMARY KEY,
    nom_llati VARCHAR(50) UNIQUE NOT NULL
);

CREATE TABLE Metodes_Reproduccio
(
    nom_popular VARCHAR(50) PRIMARY KEY
);

CREATE TABLE Reproduccions
(
    nom_planta VARCHAR(50) NOT NULL,
    nom_metode VARCHAR(50) NOT NULL,
    grau_exit SMALLINT,
    FOREIGN KEY (nom_planta) REFERENCES Plantes(nom_popular),
    FOREIGN KEY (nom_metode) REFERENCES Metodes_Reproduccio(nom_popular)
);

-- INSERCIONES DEFAULT
INSERT INTO Plantes (nom_popular, nom_llati) VALUES ('default_nom_popular', 'default_nom_llati');
INSERT INTO Metodes_Reproduccio (nom_popular) VALUES ('default_metode_reproduccio');
INSERT INTO Reproduccions (nom_planta, nom_metode, grau_exit) VALUES ('default_nom_popular', 'default_metode_reproduccio', 0);

-- DEFINICION DE TRIGGERS
DELIMITER //

CREATE TRIGGER after_plantes_insert
AFTER INSERT ON Plantes
FOR EACH ROW
BEGIN
    INSERT INTO Reproduccions (nom_planta, nom_metode, grau_exit)
    VALUES (NEW.nom_popular, 'default_metode_reproduccio', NULL);
END//

CREATE TRIGGER after_metodes_reproduccio_insert
AFTER INSERT ON Metodes_Reproduccio
FOR EACH ROW
BEGIN
    INSERT INTO Reproduccions (nom_planta, nom_metode, grau_exit)
    VALUES ('default_nom_popular', NEW.nom_popular, NULL);
END//

DELIMITER ;


