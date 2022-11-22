# Postwork Sesión 3

#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo

library(DescTools)
library(ggplot2)

"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."

df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")
df$Categoria <- factor(df$Categoria)
df$Grupo <- factor(df$Grupo)
summary(df)
df <- na.omit(df)
summary(df)

#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`
# Calculadas anteriormente mediante summary. Se repite aquí.
Mode(df$Mediciones)
median(df$Mediciones)
mean(df$Mediciones)

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?
#   Aparenta sesgo a la derecha

#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`
sd(df$Mediciones)
quantile(df$Mediciones, c(0.25, 0.5, 0.75))
# La desviación estándar es de 53.8 (comparada con una media de 62.9)
# Los cuartiles son 23.45, 49.30 y 82.85

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"
ggplot(df, aes(x = Mediciones, color = Categoria)) +
  geom_histogram(fill = "white", alpha = 0.5, position = "identity") +
  facet_grid(Categoria ~ .)
# No, las tres categorías presentan sesgo a la derecha.


"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? ¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"
ggplot(df, aes(y = Mediciones, x = Categoria, color = Grupo)) +
  geom_boxplot()

# No parece haber diferencias significativas entre las categorías, sus "cajas"
# (intervalos [q1, q3]) se traslapan.
# La categoría C1 es la que menor diferencia presenta ente grupos.
# Las otras dos categorías muestran una tendencia a mediciones menores en el grupo 1,
# más marcada en C3, en donde la mediana del grupo 1 está por debajo de la caja del 
# grupo 0, y la mediana del grupo 0, por encima de la caja del grupo 1.
# En C2, la mediana del grupo 1 no se traslapa con la caja del grupo 0, pero la
# mediana del grupo 0 sí se traslapa con la caja del grupo 1.
