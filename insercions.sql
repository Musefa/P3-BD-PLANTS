-- INSERCIONS A LA BASE DE DADES DE LES TUPLES DE L'ANNEX.

-- Mètodes de reproducció.
insert into metodes_reproduccio(nom) values ("Llavors");
insert into metodes_reproduccio(nom) values ("Esqueix");
insert into metodes_reproduccio(nom) values ("Estaques");
insert into metodes_reproduccio(nom) values ("Bulbs");
insert into metodes_reproduccio(nom) values ("Capficats");
insert into metodes_reproduccio(nom) values ("Estolons");

-- Estacions
insert into estacions(nom) values ("Primavera");
insert into estacions(nom) values ("Estiu");
insert into estacions(nom) values ("Tardor");
insert into estacions(nom) values ("Hivern");

-- Plantes
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Gerani", "Pelargonium", "Primavera");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Begònia", "Begonia rex", "Estiu");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Camèlia", "Camellia", "Primavera");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Ciclamen", "Cyclamen", "Hivern");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Roser", "Rosa", "Primavera");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Falguera", "Polystichum", NULL);
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Tulipa", "Tulipa", "Primavera");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Crisantem", "Chrysanthemum", "Estiu");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Potus", "Philodendron", NULL);
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Cintes", "Chlorophytum", "Primavera");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Poinsetia", "Euphorbia", "Hivern");
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Heura", "Hedera", NULL);
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Ficus Benjamina ", "Ficus", NULL);
insert into plantes(nom_popular, nom_llati, nom_estacio_floracio) values ("Croton", "Codiaeum", NULL);

-- Plantes d'interior
insert into plantes_interior(nom_planta, ubiacio_adient, temperatura_adient) values ("Potus", "Llum directa", 15.0);
insert into plantes_interior(nom_planta, ubiacio_adient, temperatura_adient) values ("Poinsetia", "Llum indirecta", 18.0);
insert into plantes_interior(nom_planta, ubiacio_adient, temperatura_adient) values ("Ficus Benjamina ", "Llum indirecta", 19.0);
insert into plantes_interior(nom_planta, ubiacio_adient, temperatura_adient) values ("Croton", "No corrents", 17.0);

-- Plantes d'exterior
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Gerani", "P");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Begònia", "P");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Camèlia", "P");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Ciclamen", "P");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Roser", "P");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Falguera", "P");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Tulipa", "T");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Crisantem", NULL);
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Cintes", "P");
insert into plantes_exterior(nom_planta, cicle_de_vida) values ("Heura", "P"); /* LES PLANTES D'INTERIOR TAMBÉ TENEN TIPUS DE PLANTA, ERROR */

-- Exemplars plantes

-- Firmes comercials
insert into firmes_comercials(nom) values ("URVADOB");
insert into firmes_comercials(nom) values ("TIRSADOB");
insert into firmes_comercials(nom) values ("PRISADOB");
insert into firmes_comercials(nom) values ("CIRSADOB");

-- Adobs
insert into adobs(nom, nom_firma_comercial, tipus) values ("Plantavit", "URVADOB", "LLD");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Vitaplant", "TIRSADOB", "AI");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Nutreplant", "CIRSADOB", "LLD");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Creixplant", "PRISADOB", "AI");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Casadob", "TIRSADOB", "AI");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Plantadob", "PRISADOB", "LLD");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Superplant", "CIRSADOB", "AI");
insert into adobs(nom, nom_firma_comercial, tipus) values ("Sanexplant", "URVADOB", "LLD");

-- Dosis d'adobs
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Gerani", "Primavera", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Gerani", "Hivern", "Vitaplant", 20.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Begònia", "Estiu", "Casadob", 25.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Camèlia", "Hivern", "Plantavit", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Camèlia", "Primavera", "Casadob", 75.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Ciclamen", "Tardor", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Crisantem", "Primavera", "Casadob", 45.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Begònia", "Primavera", "Nutreplant", 50.0);
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
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values ("Ficus benjamina", "Primavera", "Casadob", 50.0);

-- Reproduccions
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Gerani", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Begònia", "Esqueix", "Alt"); /* A l'enunciat posa Exqueix, error o posat a propòsit? */
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Begònia", "Capficats", "Alt"); 
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Begònia", "Llavors", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Roser", "Estaques", "Mitjà");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Cintes", "Estolons", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ciclamen", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ciclamen", "Capficats", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Potus", "Capficats", "Mitjà");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Potus", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Tulipa", "Bulbs", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ficus Benjamina", "Estaques", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Ficus Benjamina", "Capficats", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Croton", "Esqueix", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Croton", "Capficats", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Falguera", "Esqueix", "Mitjà");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Heura", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Crisantem", "Bulbs", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Camèlia", "Estaques", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Heura", "Capficats", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Poinsetia", "Llavors", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) values ("Poinsetia", "Esqueix", "Baix");
