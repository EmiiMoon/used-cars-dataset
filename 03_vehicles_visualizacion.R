summary(cars$price)

# Basandonos en los cuartiles de la distribución de precios
# creamos cuatro categorias y una categoria extra para aquellos vehiculos
# destacan por tener un precio muy por encima del rango de valores normales
cars$category = "S"
cars[cars$price < 50000,]$category = "A"
cars[cars$price < 17000,]$category = "B"
cars[cars$price < 9000,]$category = "C"
cars[cars$price < 5000,]$category = "D"

# Se factoriza el atributo que hemos creado
cars$category = as.factor(cars$category)

library(C50)

# Con este arbol podemos observar que los vehiculos con traccion 4x4 o trasera
# se venden mas caros que los vehiculos de traccion delantera
model_C50 = C5.0(category ~
                   drive,
                 data = cars)

plot(model_C50)

# Por otra parte los vehiculos menos comunes son los que tienen traccion 
# trasera, mientras que los 4x4 y los fwd se encuentran igualados en frecuencia
plot(cars$drive, col=c('blue','red','yellow'))

barplot(table(cars$drive, cars$category), 
        col=c('blue','red','yellow'), 
        beside = T,
        legend.text = T)

# Si nos centramos unicamente en la categoria "S" (la gama mas alta), vemos 
# sin embargo como el numero de vehiculos de traccion delantera es inferior
# a los de traccion trasera. Puede ser debido a que la traccion trasera es mas
# comun en deportivos. 
# La traccion 4x4 parece ser la mas valorada en Estados Unidos.
plot(cars[cars$category == "S",]$drive, col=c('blue','red','yellow'))

# Segun bajamos de categoria incrementa el numero de coches con traccion fwd
# y disminuyen los 4x4 y la traccion trasera.
plot(cars[cars$category == "D",]$drive, col=c('blue','red','yellow'))


# Los vehiculos mas caros son los diesel y electricos
model_C50 = C5.0(category ~
                   fuel,
                 data=cars)
plot(model_C50)

# El tipo de combustible mas comun es la gasolina
plot(cars$fuel, col=c('blue','red','yellow','green','grey'))

fuel_frec = table(cars$category, cars$fuel)
barplot(fuel_frec, 
        beside = T, 
        col=c('blue','red','yellow','green', 'black'), 
        legend.text = T)


plot(cars[cars$category == "S",]$fuel, col=c('blue','red','yellow'))
plot(cars[cars$category == "D",]$fuel, col=c('blue','red','yellow'))


# Los tipos de coches mas comunes son los sedan, suv, camiones y camionetas
type_freq = table(cars$type)
barplot(type_freq[type_freq > 5000], col=c('blue','red','yellow','green'))

# Los vehiculos automaticos predominan sobre los manuales
plot(cars$transmission, col=c('blue','red','yellow'))


# Las marcas mas populares son Ford y Chevrolet
plot(cars$manufacturer, col=c('blue','red','yellow'))
manuf_freq = table(cars$manufacturer)
barplot(manuf_freq[manuf_freq > 5000], col=c('blue','red','yellow','green'))
