-- Consulta número 1
SELECT R.nom_planta, R.nom_metode, P_E.cicle_de_vida
FROM plantes_exterior P_E NATURAL JOIN reproduccions R
WHERE R.grau_exit = "Alt"
AND R.nom_planta IN (SELECT P.nom_popular
                     FROM plantes P 
                     WHERE P.nom_estacio_floracio = "Primavera");