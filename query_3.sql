-- Consulta número 3
SELECT A.nom, A.tipus /* adobs - combinacions no existents -> atributs resultants */
FROM adobs A
WHERE A.nom NOT IN (SELECT A.nom /* plantes x adobs - dosis_adobs -> combinacions no existents */
                    FROM adobs A, plantes P
                    WHERE (P.nom_popular, A.nom) NOT IN (SELECT D.nom_planta, D.nom_adob
                                                         FROM dosis_adobs D));