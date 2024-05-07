-- Consulta número 2
SELECT P.nom_popular, P.nom_llati
FROM plantes P JOIN floracio F ON (P.nom_popular = F.nom_planta)
WHERE F.nom_estacio = "Estiu"
AND P.nom_popular NOT IN (SELECT P_I.nom_planta
                          FROM plantes_interior P_I)
AND P.nom_popular NOT IN (SELECT D.nom_planta
                          FROM dosis_adobs D
                          WHERE D.nom_estacio = "Primavera"
                          AND D.nom_adob IN (SELECT A.nom
                                             FROM adobs A
                                             WHERE A.nom_firma_comercial = "TIRSADOB"));