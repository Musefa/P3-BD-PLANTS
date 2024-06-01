-- INSERCIONS A LA BASE DE DADES DE LES TUPLES DE L'ANNEX.
-- Paisos (per tal de poder fer insercions a origens).
insert into paisos(nom) values("Espanya"), ("Alemanya"), ("EUA"), ("Marroc");

-- PLANTES D'INTERIOR AMB PROCEDIMENT DISSENYAT (informació de recs i origens inventada donada la mancança en l'annex).
call insereix_planta_interior("Potus", "Philodendron", "Capficats", "Mitja", "Llum directa", 15.0, "Primavera", 10, "Espanya");
call insereix_planta_interior("Poinsetia", "Euphorbia", "Llavors", "Baix", "Llum indirecta", 18.0, "Estiu", 10, "Alemanya");
call insereix_reproduccio("Esqueix", "Poinsetia", "Baix");
call insereix_planta_interior("Ficus Benjamina ", "Ficus", "Estaques", "Baix", "Llum indirecta", 19.0, "Tardor", 10, "EUA");
call insereix_reproduccio("Capficats", "Ficus Benjamina", "Baix");
call insereix_planta_interior("Croton", "Codiaeum", "Esqueix", "Baix", "No corrents", 17.0, "Hivern", 15, "EUA");
call insereix_reproduccio("Capficats", "Croton", "Baix");

-- PLANTES D'EXTERIOR AMB PROCEDIMENT DISSENYAT
call insereix_planta_exterior("Gerani", "Pelargonium", "Esqueix", "Alt", "P");
call insereix_planta_exterior("Begonia", "Begonia rex", "Esqueix", "Alt", "P");
call insereix_reproduccio("Capficats", "Begonia", "Alt");
call insereix_reproduccio("Llavors", "Begonia", "Baix");
call insereix_planta_exterior("Camelia", "Camellia", "Estaques", "Alt", "P");
call insereix_planta_exterior("Ciclamen", "Cyclamen", "Esqueix", "Alt", "P");
call insereix_reproduccio("Capficats", "Ciclamen", "Alt");
call insereix_planta_exterior("Roser", "Rosa", "Estaques", "Mitja", "P");
call insereix_planta_exterior("Falguera", "Polystichum", "Esqueix", "Mitja", "P");
call insereix_planta_exterior("Tulipa", "Tulipa", "Bulbs", "Alt", "T");
call insereix_planta_exterior("Crisantem", "Chrysanthemum", "Bulbs", "Alt", NULL); /* Informació no proporcionada */
call insereix_planta_exterior("Cintes", "Chlorophytum", "Estolons", "Alt", "P");
call insereix_planta_exterior("Heura", "Hedera", "Esqueix", "Alt", "P");
call insereix_reproduccio("Capficats", "Heura", "Alt");

-- Exemplars plantes: ESTAN PENSADES PER REALITZAR-SE AMB EL PROCEDIMENT insereix_exemplar.
call insereix_exemplar("Gerani", 6); 
call insereix_exemplar("Begonia", 4); 
call insereix_exemplar("Roser", 4); 
call insereix_exemplar("Heura", 3); 
call insereix_exemplar("Ficus Benjamina", 2); 
call insereix_exemplar("Croton", 3); 
call insereix_exemplar("Poinsetia", 2); 

-- FIRMES COMERCIALS AMB PROCEDIMENT DISSENYAT PER INICIALITZAR FIRMES COMERCIALS
call inicialitza_firma_comercial("URVADOB", "Plantavit", "LLD");
call inicialitza_firma_comercial("TIRSADOB", "Vitaplant", "AI");
call inicialitza_firma_comercial("PRISADOB", "Creixplant", "AI");
call inicialitza_firma_comercial("CIRSADOB", "Nutreplant", "LLD");

-- ADOBS (els restants després de les inicialitzacions de firmes comercials).
insert into adobs(nom, nom_firma_comercial, tipus) values ("Sanexplant", "URVADOB", "LLD");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Casadob", "TIRSADOB", "AI");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Plantadob", "PRISADOB", "LLD");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Superplant", "CIRSADOB", "AI");


-- Dosis d'adobs (per tal de poder inserir-se, cal haver inserir totes les tuples dependents anteriorment, ja que desactivar la foreign key pot comportar problemes a posteriori).
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Gerani", "Primavera", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Gerani", "Hivern", "Vitaplant", 20.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Begonia", "Estiu", "Casadob", 25.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Camelia", "Hivern", "Plantavit", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Camelia", "Primavera", "Casadob", 75.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Ciclamen", "Tardor", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Crisantem", "Primavera", "Casadob", 45.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Begonia", "Primavera", "Nutreplant", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Roser", "Primavera", "Casadob", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Roser", "Primavera", "Creixplant", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Falguera", "Primavera", "Casadob", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Falguera", "Tardor", "Plantadob", 20.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Tulipa", "Hivern", "Casadob", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Potus", "Primavera", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Cintes", "Tardor", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Cintes", "Hivern", "Superplant", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Poinsetia", "Hivern", "Casadob", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Poinsetia", "Hivern", "Sanexplant", 45.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Heura", "Primavera", "Casadob", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Croton", "Primavera", "Casadob", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Croton", "Estiu", "Casadob", 60.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Gerani", "Estiu", "Sanexplant", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Ficus Benjamina", "Primavera", "Casadob", 50.0);

-- Floració
insert into floracio(nom_planta, nom_estacio) values ("Gerani", "Primavera");
insert into floracio(nom_planta, nom_estacio) values ("Begonia", "Estiu");
insert into floracio(nom_planta, nom_estacio) values ("Camelia", "Primavera");
insert into floracio(nom_planta, nom_estacio) values ("Ciclamen", "Hivern");
insert into floracio(nom_planta, nom_estacio) values ("Roser", "Primavera");
insert into floracio(nom_planta, nom_estacio) values ("Tulipa", "Primavera");
insert into floracio(nom_planta, nom_estacio) values ("Crisantem", "Estiu");
insert into floracio(nom_planta, nom_estacio) values ("Poinsetia", "Hivern");
