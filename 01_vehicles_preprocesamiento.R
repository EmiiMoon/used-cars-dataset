setwd("C:/Users/emili/Documents/MBD/master-big-data")

# Dataset utilizado: Used Cars Dataset                                       
# URL: https://www.kaggle.com/austinreese/craigslist-carstrucks-data 

cars = read.csv("./datasets/vehicles.csv")

# Tamaño original del dataset
num_rows_total = nrow(cars)

# Consideramos como ruido los vehiculos con un precio desorbitado.
# Una chevrolet pickup no puede costar 3 billones de dolares
cars = cars[cars$price < 1000000, ]

# Tambien aparecen muchos vehiculos por 0 dolares. Se entiende que es algun
# fallo al recoger los datos o que son vehiculos con precio negociable, lo
# cual falsearia los datos.
cars = cars[cars$price > 0, ]
cars = cars[cars$price > 1, ]

# Atributos que no resultan de interes (identificadores, urls, etc)
cars$url = NULL
cars$id = NULL
cars$region_url = NULL
cars$VIN = NULL
cars$image_url = NULL
cars$description = NULL
cars$posting_date = NULL


# Se eliminan filas con NAs en las variables NUMERICAS
# Todas estas variables tienen muy pocos valores perdidos, por lo que merece
# la pena eliminar estos valores y mantener las variables.
cars = cars[is.na(cars$year) == FALSE, ]
cars = cars[is.na(cars$odometer) == FALSE, ]
cars = cars[is.na(cars$lat) == FALSE, ]
cars = cars[is.na(cars$long) == FALSE, ]

# En las variables de tipo categorico los NA aparecen como string vacios "".
# Todas estas variables tienen muy pocos valores perdidos, por lo que merece
# la pena eliminar estos valores y mantener las variables.
cars = cars[cars$manufacturer != "", ]
cars = cars[cars$model != "", ]
cars = cars[cars$fuel != "", ]
cars = cars[cars$title_status != "", ]
cars = cars[cars$transmission != "", ]

# Se factorizan las variables categóricas
cars$state = as.factor(cars$state)
cars$region = as.factor(cars$region)
cars$manufacturer = as.factor(cars$manufacturer)
cars$model = as.factor(cars$model)
cars$fuel = as.factor(cars$fuel)
cars$title_status = as.factor(cars$title_status)
cars$transmission = as.factor(cars$transmission)

# Algunas variables tienen demasiados NAs, hay que decidir si se quitan los NAs
# o si es preferible eliminar estas variables para no quedarnos sin datos

cars = cars[cars$condition != "", ] # 42% de missing values
cars$condition = as.factor(cars$condition)

cars = cars[cars$cylinders != "", ] # 37% de missing values
cars$cylinders = as.factor(cars$cylinders)

cars = cars[cars$size != "", ] # 70% de missing values
cars$size = as.factor(cars$size)

cars = cars[cars$drive != "", ] # 29% de missing values
cars$drive = as.factor(cars$drive)

cars = cars[cars$type != "", ] # 25% de missing values
cars$type = as.factor(cars$type)

cars = cars[cars$paint_color != "", ] # 31% de missing values
cars$paint_color = as.factor(cars$paint_color)


cat("Tamaño original del dataset: ", num_rows_total, "\n",
    "Nuevo tamaño del dataset: ", nrow(cars), "\n",
    "Tras limpiar el dataset de valores NA nos queda el ", 
    nrow(cars) / num_rows_total * 100, 
    "% del dataset", sep="")


# Para poder hacer arboles de decision se necesita que la variable a predecir
# sea categorica. Basandonos en los cuartiles de la distribución de precios
# creamos cuatro categorias.
cars$category = "A"
cars[cars$price < 17000,]$category = "B"
cars[cars$price < 9000,]$category = "C"
cars[cars$price < 5000,]$category = "D"

write.csv(cars, "vehicles_clean.csv")
