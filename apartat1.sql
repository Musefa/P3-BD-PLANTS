-- Consulta número 1
SELECT R.nom_planta, R.nom_metode, P_E.cicle_de_vida
FROM plantes_exterior P_E JOIN reproduccions R ON (P_E.nom_planta = R.nom_planta)
WHERE R.grau_exit = "Alt"
AND R.nom_planta IN (SELECT P.nom_planta
                     FROM floracio P 
                     WHERE P.nom_estacio = "Primavera");