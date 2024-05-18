-- INSERCIONS A LA BASE DE DADES DE LES TUPLES DE L'ANNEX.

-- -- Mètodes de reproducció.
-- insert into metodes_reproduccio(nom) values ("Llavors");
-- insert into metodes_reproduccio(nom) values ("Esqueix");
-- insert into metodes_reproduccio(nom) values ("Estaques");
-- insert into metodes_reproduccio(nom) values ("Bulbs");
-- insert into metodes_reproduccio(nom) values ("Capficats");
-- insert into metodes_reproduccio(nom) values ("Estolons");

-- Estacions
insert into estacions(nom) values ("Primavera");
insert into estacions(nom) values ("Estiu");
insert into estacions(nom) values ("Tardor");
insert into estacions(nom) values ("Hivern");

-- -- Plantes d'interior
-- insert into plantes_interior(nom_planta, ubicacio_adient, temperatura_adient) values ("Potus", "Llum directa", 15.0);
-- insert into plantes_interior(nom_planta, ubicacio_adient, temperatura_adient) values ("Poinsetia", "Llum indirecta", 18.0);
-- insert into plantes_interior(nom_planta, ubicacio_adient, temperatura_adient) values ("Ficus Benjamina", "Llum indirecta", 19.0);
-- insert into plantes_interior(nom_planta, ubicacio_adient, temperatura_adient) values ("Croton", "No corrents", 17.0);

-- Paisos (per tal de poder fer insercions a origens).
insert into paisos(nom) values("Espanya"), ("Alemanya"), ("EUA"), ("Marroc");

-- PLANTES D'INTERIOR AMB PROCEDIMENT DISSENYAT (informació de recs i origens inventada donada la mancança en l'annex).
call insereix_planta_interior("Potus", "Philodendron", "Capficats", "Mitjà", "Llum directa", 15.0, "Primavera", 10, "Espanya");
call insereix_planta_interior("Poinsetia", "Euphorbia", "Llavors", "Baix", "Llum indirecta", 18.0, "Estiu", 10, "Alemanya");
call insereix_planta_interior("Poinsetia", "Euphorbia", "Esqueix", "Baix", "Llum indirecta", 18.0, "Estiu", 10, "Marroc");
call insereix_planta_interior("Ficus Benjamina ", "Ficus", "Estaques", "Baix", "Llum indirecta", 19.0, "Tardor", 10, "EUA");
call insereix_planta_interior("Ficus Benjamina ", "Ficus", "Capficats", "Baix", "Llum directa", 17.0, "Hivern", 15, "EUA"); /* Informació modificada s'ha d'ignorar */
call insereix_planta_interior("Croton", "Codiaeum", "Esqueix", "Baix", "No corrents", 17.0, "Hivern", 15, "EUA");
call insereix_planta_interior("Croton", "Codiaeum", "Capficats", "Baix", "No corrents", 17.0, "Tardor", 10, "Espanya");

-- -- Plantes
-- insert into plantes(nom_popular, nom_llati) values ("Gerani", "Pelargonium");
-- insert into plantes(nom_popular, nom_llati) values ("Begònia", "Begonia rex");
-- insert into plantes(nom_popular, nom_llati) values ("Camèlia", "Camellia");
-- insert into plantes(nom_popular, nom_llati) values ("Ciclamen", "Cyclamen");
-- insert into plantes(nom_popular, nom_llati) values ("Roser", "Rosa");
-- insert into plantes(nom_popular, nom_llati) values ("Falguera", "Polystichum");
-- insert into plantes(nom_popular, nom_llati) values ("Tulipa", "Tulipa");
-- insert into plantes(nom_popular, nom_llati) values ("Crisantem", "Chrysanthemum");
-- insert into plantes(nom_popular, nom_llati) values ("Potus", "Philodendron");
-- insert into plantes(nom_popular, nom_llati) values ("Cintes", "Chlorophytum");
-- insert into plantes(nom_popular, nom_llati) values ("Poinsetia", "Euphorbia");
-- insert into plantes(nom_popular, nom_llati) values ("Heura", "Hedera");
-- insert into plantes(nom_popular, nom_llati) values ("Ficus Benjamina ", "Ficus");
-- insert into plantes(nom_popular, nom_llati) values ("Croton", "Codiaeum");

-- -- Reproduccions
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Gerani", "Esqueix", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Begònia", "Esqueix", "Alt"); /* A l'enunciat posa Exqueix, error o posat a propòsit? */
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Begònia", "Capficats", "Alt"); 
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Begònia", "Llavors", "Baix");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Roser", "Estaques", "Mitjà");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Cintes", "Estolons", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ciclamen", "Esqueix", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ciclamen", "Capficats", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Potus", "Capficats", "Mitjà");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Potus", "Esqueix", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Tulipa", "Bulbs", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ficus Benjamina", "Estaques", "Baix");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ficus Benjamina", "Capficats", "Baix");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Croton", "Esqueix", "Baix");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Croton", "Capficats", "Baix");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Falguera", "Esqueix", "Mitjà");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Heura", "Esqueix", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Crisantem", "Bulbs", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Camèlia", "Estaques", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Heura", "Capficats", "Alt");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Poinsetia", "Llavors", "Baix");
-- insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Poinsetia", "Esqueix", "Baix");

-- -- Plantes d'exterior
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Gerani", "P");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Begònia", "P");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Camèlia", "P");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Ciclamen", "P");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Roser", "P");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Falguera", "P");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Tulipa", "T");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Crisantem", NULL);
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Cintes", "P");
-- insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Heura", "P"); /* LES PLANTES D'INTERIOR TAMBÉ TENEN TIPUS DE PLANTA, ERROR */

-- PLANTES D'EXTERIOR AMB PROCEDIMENT DISSENYAT
call insereix_planta_exterior("Gerani", "Pelargonium", "Esqueix", "Alt", "P");
call insereix_planta_exterior("Begonia", "Begonia rex", "Esqueix", "Alt", "P");
call insereix_planta_exterior("Begonia", "Begonia rex", "Capficats", "Alt", "T"); /* Els canvis en tipus no es tindran en compte, s'estan realitzant insercions no modificacions */
call insereix_planta_exterior("Begonia", "Begonia rex", "Llavors", "Baix", "P");
call insereix_planta_exterior("Camelia", "Camellia", "Estaques", "Alt", "P");
call insereix_planta_exterior("Ciclamen", "Cyclamen", "Esqueix", "Alt", "P");
call insereix_planta_exterior("Ciclamen", "Capficats", "Alt", "Alt", "P");
call insereix_planta_exterior("Roser", "Rosa", "Estaques", "Mitjà", "P");
call insereix_planta_exterior("Falguera", "Polystichum", "Esqueix", "Mitjà", "P");
call insereix_planta_exterior("Tulipa", "Tulipa", "Bulbs", "Alt", "T");
call insereix_planta_exterior("Crisantem", "Chrysanthemum", "Bulbs", "Alt", NULL); /* Informació no proporcionada */ /*CANVIAR PER NULL SI QUEDA TEMPS */
call insereix_planta_exterior("Cintes", "Chlorophytum", "Estolons", "Alt", "P");
call insereix_planta_exterior("Heura", "Hedera", "Esqueix", "Alt", "P");
call insereix_planta_exterior("Heura", "Hedera", "Capficats", "Alt", "P");

-- Exemplars plantes: ESTAN PENSADES PER REALITZAR-SE AMB EL PROCEDIMENT insereix_exemplar.
call insereix_exemplar("Gerani", 6); 
call insereix_exemplar("Begonia", 4); 
call insereix_exemplar("Roser", 4); 
call insereix_exemplar("Heura", 3); 
call insereix_exemplar("Ficus Benjamina", 2); 
call insereix_exemplar("Croton", 3); 
call insereix_exemplar("Poinsetia", 2); 
-- call insereix_exemplar("Ciclamen", 1); DESCOMENTAR PER PROVAR COM FALLA L'EXECUCIÓ.

-- -- Firmes comercials
-- insert into firmes_comercials(nom) values ("URVADOB");
-- insert into firmes_comercials(nom) values ("TIRSADOB");
-- insert into firmes_comercials(nom) values ("PRISADOB");
-- insert into firmes_comercials(nom) values ("CIRSADOB");

-- -- Adobs
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Plantavit", "URVADOB", "LLD");
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Vitaplant", "TIRSADOB", "AI");
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Nutreplant", "CIRSADOB", "LLD");
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Creixplant", "PRISADOB", "AI");
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Casadob", "TIRSADOB", "AI");
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Plantadob", "PRISADOB", "LLD");
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Superplant", "CIRSADOB", "AI");
-- insert into adobs(nom, nom_firma_comercial, tipus) values ("Sanexplant", "URVADOB", "LLD");

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
