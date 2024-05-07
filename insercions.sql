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

-- Exemplars plantes

-- Firmes comercials
insert into firmes_comercials(nom) values in ("URVADOB");
insert into firmes_comercials(nom) values in ("TIRSADOB");
insert into firmes_comercials(nom) values in ("PRISADOB");
insert into firmes_comercials(nom) values in ("CIRSADOB");

-- Adobs
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Plantavit", "URVADOB", "LLD");
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Vitaplant", "TIRSADOB", "AI");
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Nutreplant", "CIRSADOB", "LLD");
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Creixplant", "PRISADOB", "AI");
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Casadob", "TIRSADOB", "AI");
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Plantadob", "PRISADOB", "LLD");
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Superplant", "CIRSADOB", "AI");
insert into adobs(nom, tipus, nom_firma_comercial) values in ("Sanexplant", "URVADOB", "LLD");

-- Dosis d'adobs
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Gerani", "Primavera", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Gerani", "Hivern", "Vitaplant", 20.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Begònia", "Estiu", "Casadob", 25.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Camèlia", "Hivern", "Plantavit", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Camèlia", "Primavera", "Casadob", 75.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Ciclamen", "Tardor", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Crisantem", "Primavera", "Casadob", 45.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Begònia", "Primavera", "Nutreplant", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Roser", "Primavera", "Casadob", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Roser", "Primavera", "Creixplant", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Falguera", "Primavera", "Casadob", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Falguera", "Tardor", "Plantadob", 20.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Tulipa", "Hivern", "Casadob", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Potus", "Primavera", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Cintes", "Tardor", "Casadob", 30.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Cintes", "Hivern", "Superplant", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Poinsetia", "Hivern", "Casadob", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Poinsetia", "Hivern", "Sanexplant", 45.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Heura", "Primavera", "Casadob", 50.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Croton", "Primavera", "Casadob", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Croton", "Estiu", "Casadob", 60.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Gerani", "Estiu", "Sanexplant", 40.0);
insert into dosis_adobs(nom_planta, nom_estacio, nom_adob, quantitat_adob) values in ("Ficus benjamina", "Primavera", "Casadob", 50.0);

-- Reproduccions
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Gerani", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Begònia", "Esqueix", "Alt"); /* A l'enunciat posa Exqueix, error o posat a propòsit? */
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Begònia", "Capficats", "Alt"); 
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Begònia", "Llavors", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Roser", "Estques", "Mitjà");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Cintes", "Estolons", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Ciclamen", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Ciclamen", "Capficats", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Potus", "Capficats", "Mitjà");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Potus", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Tulipa", "Bulbs", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Ficus Benjamina", "Estaques", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Ficus Benjamina", "Capficats", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Croton", "Esqueix", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Croton", "Capficats", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Falguera", "Esqueix", "Mitjà");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Heura", "Esqueix", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Crisantem", "Bulbs", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Camèlia", "Estaques", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Heura", "Capficats", "Alt");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Poinsetia", "Llavors", "Baix");
insert into reproduccions(nom_planta, nom_metode, grau_exit) insert into ("Poinsetia", "Esqueix", "Baix");
