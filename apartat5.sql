-- Consulta número 5
SELECT DISTINCT P_I.nom_planta, P_I.ubicacio_adient
FROM plantes_interior P_I
WHERE P_I.nom_planta NOT IN (SELECT R.nom_planta
                             FROM reproduccions R
                             WHERE R.grau_exit <> "Baix")
AND P_I.nom_planta IN (SELECT D.nom_planta
                       FROM dosis_adobs D
                       GROUP BY D.nom_planta
                       HAVING COUNT(DISTINCT D.nom_adob) = 1);