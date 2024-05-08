UPDATE dosis_adobs
SET quantitat_adob = quantitat_adob * 1.1
WHERE nom_estacio = "Hivern"
AND nom_planta IN (SELECT nom_planta
                     FROM floracio
                     WHERE nom_estacio = "Primavera");
