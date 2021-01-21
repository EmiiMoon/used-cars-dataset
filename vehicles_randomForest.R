summary(cars$price)

# Para poder hacer arboles de decision se necesita que la variable a predecir
# sea categorica. Basandonos en los cuartiles de la distribución de precios
# creamos cuatro categorias.
cars$category = "A"
cars[cars$price < 17000,]$category = "B"
cars[cars$price < 9000,]$category = "C"
cars[cars$price < 5000,]$category = "D"

# Se factoriza el atributo que hemos creado
cars$category = as.factor(cars$category)

# tamaño de la muestra de entrenamiento (75% del total)
smp_size = floor(0.75 * nrow(cars))

# obtenemos smp_size filas aleatorias sin repetición
train_ind = sample(seq_len(nrow(cars)), size = smp_size)

# Asignamos las filas obtenidas al conjunto de entrenamiento y el resto al de
# test
train = cars[train_ind,]
test = cars[-train_ind,]

library(randomForest)

modelo_RF = randomForest(price ~ . - X - model - region, data=train)
summary(cars$region)
