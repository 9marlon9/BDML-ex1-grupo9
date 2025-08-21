# Instructions

Con el objetivo de imputar las 2286 observaciones faltantes para la variable y_salary_m se utilizó el método de la mediana (debido a la asimetría positiva en la distribución de la variable) y una regresión lineal múltiple con las variables maxEducLevel,sex, oficio y clase como variables independientes.  

La distribución original presentaba asimetría positiva, con: media de $1.383.433, desviación estándar de $1.878.727 y una mediana de $860.000, evidenciando concentración en valores bajos y una cola larga hacia valores extremos (mínimo: $40.000, máximo: $30.000.000). 

La imputación por mediana redujo la media ($1.011.567), preservó la mediana ($860.000) y redujo la desviación ($1.037.688). Por otra parte, la imputación por regresión lineal generó distorsiones significativas: aumentó tanto la media ($1.336.585) como la mediana ($1.000.000), e introdujo valores negativos (en el contexto del salario no tienen sentido económico) que posteriormente fueron reemplazados con cero.

El método de imputación por mediana parece ser el más adecuado. Este enfoque preserva las características esenciales de la distribución original, manteniendo intacta la mediana ($860.000) y ajustando coherentemente la media ($1.011.567) sin introducir distorsiones artificiales. La imputación por regresión lineal, generó alteraciones significativas en la estructura de los datos al inflar tanto la media como la mediana e introducir valores negativos (ceros), lo que compromete la validez inferencial en un contexto económico.
