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

library(C50)
# Se crea el modelo de arbol de decision. Se han incluido todas las variables
# y a continuacion se han ido eliminando aquellas que son menos relevantes para
# el modelo. Se consigue un acierto del 75% en test, sin embargo al utilizar
# tantas variables el arbol generado es imposible de interpretar.
model_C50 = C5.0(category ~
                   year + 
                   manufacturer + 
                   condition + 
                   cylinders + 
                   fuel + 
                   odometer +
                   title_status +
                   transmission +
                   drive +
                   size +
                   type +
                   lat +
                   long,
                 data = train) #0.7510

summary(model_C50)
plot(model_C50)
# Prediccion y matriz de confusion
p = predict(model_C50, newdata = test)
t = table(p, test$category)

t

# Precision del modelo
(t[1,1] + t[2,2] + t[3,3] + t[4,4]) / nrow(test)

