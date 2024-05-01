-- BORRADO Y CREACION DE LA BASE DE DATOS
DROP SCHEMA IF EXISTS PLANTS;
CREATE SCHEMA PLANTS;

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
    nom_planta VARCHAR(50),
    FOREIGN KEY (nom_planta) REFERENCES Plantes(nom_popular),
    nom_metode VARCHAR(50),
    FOREIGN KEY (nom_metode) REFERENCES Metodes_Reproduccio(nom_popular),
    grau_exit SMALLINT
);
