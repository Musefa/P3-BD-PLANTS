-- Consulta número 3
SELECT A.nom, A.tipus
FROM adobs A
WHERE A.nom NOT IN (SELECT A.nom
                    FROM adobs A, dosis_adobs D
                    WHERE (D.nom_planta, A.nom) NOT IN (SELECT D.nom_planta, D.nom_adob
                                                        FROM dosis_adobs D));