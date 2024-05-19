-- Esborrat demanat
DELETE FROM adobs
WHERE nom_firma_comercial = "URVADOB"
AND nom NOT IN (SELECT nom_adob
                FROM dosis_adobs
                WHERE nom_planta IN (SELECT nom_planta
                                     FROM floracio
                                     WHERE nom_estacio = "Hivern"));