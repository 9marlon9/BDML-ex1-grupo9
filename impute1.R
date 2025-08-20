###Complementaria 1
#Marlon Angulo Ramos
##Impute 1

install.packages("pacman")
library(pacman)
p_load(rio,tidyverse,skimr,visdat, corrplot,stargazer, scales)  

df <- import("https://github.com/ignaciomsarmiento/datasets/blob/main/GEIH_sample1.Rds?raw=true")
names(df)

#Variable de interés
df_salary <- df %>% select(y_salary_m)

#salarios en miles:
df_salary <- df_salary %>%
  mutate(y_salary_k = y_salary_m / 1000)

skim(df_salary$y_salary_m)
#2286 missing 
#1.383.727 salario promedio
#1.878.433 desviación
#Mediana: 860.000
#Min: 40.000
#Max: 30.000.000

ggplot(df_salary, aes(x = y_salary_k)) +
  geom_histogram(bins = 30, fill = "steelblue", na.rm = TRUE) +
  labs(title = "Distribución de Salario (en miles)",
                x = "Salario (miles)",
                y = "Frecuencia") +
  scale_x_continuous(labels = comma)

#Media y mediana
media <- mean(df_salary$y_salary_k, na.rm = TRUE)
mediana <- median(df_salary$y_salary_k, na.rm = TRUE)

#Gráfica para decidir mejor método de imputación

ggplot2::ggplot(df_salary, aes(x = y_salary_k)) +
  ggplot2::geom_histogram(bins = 30, fill = "steelblue", na.rm = TRUE) +
  ggplot2::geom_vline(aes(xintercept = media), color = "red", linetype = "solid", linewidth = 1) +
  ggplot2::geom_vline(aes(xintercept = mediana), color = "green", linetype = "dashed", linewidth = 1) +
  # Escala personalizada para mostrar media y mediana en eje X
  ggplot2::scale_x_continuous(
    labels = scales::comma,
    breaks = sort(c(seq(0, max(df_salary$y_salary_k, na.rm = TRUE), by = 5000),
                    media, mediana))  # Agrega valores al eje
  ) +
  ggplot2::labs(title = "Distribución de Salario (en miles)",
                x = "Salario (miles)",
                y = "Frecuencia") +
  # Rotar texto para mejor visualización
  ggplot2::theme(axis.text.x = element_text(angle = 45, hjust = 1))


#Método de imputación:
#Debido a la asimetría positiva, se imputa con base a la mediana.

df_salary <- df_salary %>%
  mutate(y_salary_m_imp = ifelse(is.na(y_salary_m), 
                                        median(y_salary_m, na.rm = TRUE), 
                                        y_salary_m))
skim(df_salary$y_salary_m_imp)

#1.011.567 salario promedio
#1.037.688 desviación
#Mediana 860.000
#Min: 40.000
#Max: 30.000.000

#Nueva distribución

ggplot(df_salary, aes(x = y_salary_m_imp)) +
  geom_histogram(bins = 30, fill = "darkorange", na.rm = TRUE) +
  labs(title = "Distribución de Salario Imputado (mediana)",
                x = "Salario original (miles)",
                y = "Frecuencia") +
  scale_x_continuous(labels = scales::comma_format(scale = 0.001)) +
  geom_vline(aes(xintercept = median(y_salary_m_imp)), 
                      color = "green", linetype = "dashed", linewidth = 1)


