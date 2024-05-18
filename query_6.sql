SELECT P_E.nom_planta, F.nom_estacio
FROM plantes_exterior P_E LEFT OUTER JOIN floracio F ON (P_E.nom_planta = F.nom_planta)
WHERE P_E.nom_planta IN (SELECT E.nom_planta 
                         FROM exemplars_plantes E
                         GROUP BY E.nom_planta
                         HAVING COUNT(*) >= ALL((SELECT COUNT(*) /* All perquè no es pot fer anar max correctament */
                                                 FROM exemplars_plantes E, plantes_interior P_I
                                                 WHERE P_I.nom_planta = E.nom_planta
                                                 GROUP BY P_I.nom_planta))); /* Nombre d'exemplars de la planta d'interior amb més exemplars */

