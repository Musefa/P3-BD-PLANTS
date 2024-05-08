DELETE FROM adobs
WHERE nom_firma_comercial = "URVADOB"
AND nom NOT IN (SELECT nom_adob
                FROM dosis_adobs
                WHERE nom_estacio = "Hivern");