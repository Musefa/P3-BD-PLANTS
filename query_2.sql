-- Consulta número 2
SELECT P.nom_popular, P.nom_llati
FROM plantes P
WHERE nom_estacio_floracio = "Estiu"
AND P.nom_popular NOT IN (SELECT P_I.nom_planta
                          FROM plantes_interior P_I)
AND P.nom_popular NOT IN (SELECT D.nom_planta
                          FROM dosis_adobs D
                          WHERE D.nom_estacio = "Primavera"
                          AND D.nom_adob IN (SELECT A.nom
                                             FROM adobs A
                                             WHERE A.nom_firma_comercial = "TIRSADOB"));