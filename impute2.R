#Complementaria 1
#Marlon Angulo Ramos
##Impute 2

#Imputación por regresión lineal múltiple

#Modelo de regresión
modelo <- lm(y_salary_m ~ maxEducLevel + sex + oficio + clase, 
             df)
summary(modelo)

df$y_salary_m_imp_reg <- df$y_salary_m
valores_imputados <- predict(modelo, df[is.na(df$y_salary_m), ])
df$y_salary_m_imp_reg[is.na(df$y_salary_m)] <- valores_imputados
skim(df$y_salary_m_imp_reg)

#La regresión nos da como resultado salarios negativos, lo cuál no tiene sentido
#Dichos valores se reemplazarán por el valor de 0 (no tendrían trabajo)

df <- df %>%
  mutate(y_salary_m_imp_reg = ifelse(y_salary_m_imp_reg < 0, 0, y_salary_m_imp_reg))

skim(df$y_salary_m_imp_reg)

#1.336.585 salario promedio
#1.518.566 desviación
#Mediana: 1.000.000
#Min: 0
#Max: 30.000.000

#Distribución con imputación por regresión lineal múltiple

#Variable en miles para graficar

df <- df %>%
  dplyr::mutate(y_salary_m_imp_reg_k = y_salary_m_imp_reg / 1000)

# Gráfica
ggplot(df, aes(x = y_salary_m_imp_reg_k)) +
  geom_histogram(bins = 30, fill = "purple", na.rm = TRUE) +
  labs(title = "Distribución de Salario Imputado por Regresión (miles)",
                x = "Salario (miles)",
                y = "Frecuencia") +
  scale_x_continuous(labels = scales::comma) +
  geom_vline(aes(xintercept = mean(y_salary_m_imp_reg_k, na.rm = TRUE)),
                      color = "green", linetype = "dashed", linewidth = 1) +
  scale_x_continuous(labels = scales::comma, breaks = c(pretty(df$y_salary_m_imp_reg_k),
                     mean(df$y_salary_m_imp_reg_k, na.rm = TRUE)))
