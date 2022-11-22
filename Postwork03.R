# Postwork Sesión 3

#### Objetivo

#- Realizar un análisis descriptivo de las variables de un dataframe

#### Requisitos

#1. R, RStudio
#2. Haber realizado el prework y seguir el curso de los ejemplos de la sesión
#3. Curiosidad por investigar nuevos tópicos y funciones de R

#### Desarrollo

"Utilizando el dataframe `boxp.csv` realiza el siguiente análisis descriptivo. No olvides excluir los missing values y transformar las variables a su
tipo y escala correspondiente."
df <- read.csv("https://raw.githubusercontent.com/beduExpert/Programacion-R-Santander-2022/main/Sesion-03/Data/boxp.csv")

df.clean <- df[complete.cases(df),]
df.clean

str(df.clean)
names(df.clean)
summary(df.clean)

df.clean$Categoria = factor(df.clean$Categoria)
df.clean$Grupo = factor(df.clean$Grupo)

summary(df.clean)


#1) Calcula e interpreta las medidas de tendencia central de la variable `Mediciones`

mean(df.clean$Mediciones) # mean = 62.88
median(df.clean$Mediciones) # median = 49.3
Mode(df.clean$Mediciones) # mode = 23.3

#2) Con base en tu resultado anterior, ¿qué se puede concluir respecto al sesgo de `Mediciones`?

# Dado que la Media > Mediana > Moda, el sesgo está a la derecha. 

#3) Calcula e interpreta la desviación estándar y los cuartiles de la distribución de `Mediciones`

sd(df.clean$Mediciones) # sd = 53.76972

cuartiles <- quantile(df.clean$Mediciones,probs = c(0.25, 0.5, 0.75))

cuartiles #25% - 23.45  50% - 49.3  75% - 82.85

"4) Con ggplot, realiza un histograma separando la distribución de `Mediciones` por `Categoría`
¿Consideras que sólo una categoría está generando el sesgo?"

#calcular el número de clases y el ancho para el histograma:

k = ceiling(sqrt(length(df.clean$Mediciones)))
ac = (max(df.clean$Mediciones)-min(df.clean$Mediciones))/k

#calcular los bins

bins <- seq(min(df.clean$Mediciones), max(df.clean$Mediciones), by = ac)

bins # bins = 26
#calcular los cortes

mediciones.clases <- cut(df.clean$Mediciones, breaks = bins, include.lowest = TRUE, dig.lab = 8)

#ceación de histograma separado por categoría

ggplot(df.clean, aes(x=Mediciones)) +
  geom_histogram(aes(color = Categoria, fill = Categoria),
                 position = "identity", bins = 26, alpha = 0.3) +
  scale_color_manual(values = c("#00AFBB", "#E7B800","#E34990")) +
  scale_fill_manual(values = c("#00AFBB", "#E7B800","#E34990")) +
  theme_classic()

# Las tres categorías están realizando el sesgo.

"5) Con ggplot, realiza un boxplot separando la distribución de `Mediciones` por `Categoría` 
y por `Grupo` dentro de cada categoría. ¿Consideras que hay diferencias entre categorías? ¿Los grupos al interior de cada categoría 
podrían estar generando el sesgo?"

ggplot(df.clean, aes(x=Mediciones, y=Categoria, fill=Grupo)) +
  geom_boxplot() +
  theme_classic()

# Si hay ligeras diferencias entre categorías, sobre todo con la C3 y sus grupos internos. En las tres se encuentran outliers que se salen mucho de la media.

