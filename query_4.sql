-- Consulta número 4
SELECT DISTINCT R.nom_planta, F.nom_estacio /* Cal distinct per evitar seleccionar diverses plantes per igual */
FROM reproduccions R LEFT OUTER JOIN floracio F ON (R.nom_planta = F.nom_planta) /* Sobre reduccions per reduir tamany relacions. */
WHERE R.nom_planta NOT IN (SELECT F1.nom_planta        
                           FROM floracio F1
                           WHERE F1.nom_estacio = "Primavera") /* Com és una M:N, cal fer la resta */
AND R.grau_exit = "Alt"
GROUP BY R.nom_planta, F.nom_estacio /* Nom estació es posa per sintaxi, però s'ordena per nom de planta */
HAVING COUNT(*) >= 2;