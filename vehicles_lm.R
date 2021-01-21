cars$model = NULL
cars$X = NULL
cars$region = NULL

# tamaño de la muestra de entrenamiento (75% del total)
smp_size = floor(0.75 * nrow(cars))

# obtenemos smp_size filas aleatorias sin repetición
train_ind = sample(seq_len(nrow(cars)), size = smp_size)

# Asignamos las filas obtenidas al conjunto de entrenamiento y el resto al de
# test
train = cars[train_ind,]
test = cars[-train_ind,]

# Modelo de regresión lineal. Sin usar la variable model, ya que hay tantos 
# modelos diferentes que el ordenador no consigue procesarlo
model_LM = lm(price ~ 
                ., 
              data = train)


# Predicción para el conjunto de test
p = predict(model_LM, newdata=test)

# Se representa en azul el precio real y en rojo la predicción
plot(test$price, type="l", col="blue")
lines(p, col="red")         

# Error absoluto
error = abs(test$price - p)
summary(error)
plot(sort(error))

summary(cars$price)

