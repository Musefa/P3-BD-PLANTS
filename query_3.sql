-- Consulta número 3
-- NOT IN
SELECT A.nom, A.tipus /* adobs - combinacions no existents -> atributs resultants */
FROM adobs A
WHERE A.nom NOT IN (SELECT A.nom /* plantes x adobs - dosis_adobs -> combinacions no existents */
                    FROM adobs A, plantes P
                    WHERE (P.nom_popular, A.nom) NOT IN (SELECT D.nom_planta, D.nom_adob
                                                         FROM dosis_adobs D));

-- NOT EXISTS
SELECT A.nom, A.tipus
FROM adobs A                                                           /* Per cada combinació d'adob */
WHERE NOT EXISTS (SELECT *
                  FROM plantes P                                       /* i de planta possible */
                  WHERE NOT EXISTS (SELECT *
                                    FROM dosis_adobs D
                                    WHERE D.nom_planta = P.nom_popular /* anar comprovant que en dosis_adobs no es dona el cas en què */
                                    AND A.nom = D.nom_adob));          /* una combinació planta - adob no està en dosis_adobs */

-- COMPTAT DE TUPLES
SELECT A.nom, A.tipus
FROM adobs A
WHERE A.nom IN (SELECT D.nom_adob
                FROM dosis_adobs D
                GROUP BY D.nom_adob
                HAVING COUNT(DISTINCT D.nom_planta) = (SELECT COUNT(*)
                                                       FROM plantes)); /* Es comprova si el nombre de tuples existents per l'adob coincideix amb el nombre de plantes */
                                                                       /* (això vol dir que està associat a totes les plantes) */
                                                                       /* Cal posar el distinct perquè poden haver-hi diverses tuples d'adob i planta (en estacions diferents). */