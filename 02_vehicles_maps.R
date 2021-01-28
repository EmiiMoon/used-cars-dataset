library(ggmap)
library(tmaptools)

# Mapa de USA
map = ggmap(get_stamenmap(c(-126, 24, -65, 49), zoom = 4))
# Mapa incluyendo Alaska y Hawaii
map_full = ggmap(get_stamenmap(c(-168, 18, -64, 71), zoom = 4))

summary(cars[cars$price < 50000, ]$price)

# Dividimos en coches "baratos" y "caros", la mayor parte de los coches se
# encuentran en este primer grupo. En el grupo de los caros se engloban
# aquellos coches menos comunes y mas lujosos. Al haber menos de estos coches
# es preferible separarlos para medirlos en una escala a parte.
cheap_cars = cars[cars$price < 50000, ]
expensive_cars = cars[cars$price >= 50000, ]

# Paleta de color para los baratos, de verde a rojo
cheap_palette = colorRampPalette(c("green", "yellow", "red")) 
#cheap_color = cheap_palette(max(cheap_cars$price))[cheap_cars$price]
cheap_color = c(cheap_palette(10000), 
                rep("green", max(cheap_cars$price)-10000))[cheap_cars$price]

# Paleta de color para los caros, de rojo a negro. Ademas estos puntos se
# representaran con un tamaño mayor al resto para que destaquen
expensive_palette = colorRampPalette(c("red", "black")) 
expensive_color = 
  expensive_palette(max(expensive_cars$price))[expensive_cars$price]

# Los puntos se distribuyen sobre todo en la mitad este del pais y a lo largo 
# de la costa oeste, disminuyendo su densidad sobre todo en el centro, zonas
# mas rurales y desierto de Nevada.
# Donde se acumulan los puntos mas oscuros y de mayor tamaño (coches mas
# lujosos), coincide por lo general con la ubicacion de grandes ciudades.
map + 
  geom_point(data=cheap_cars, 
             aes(x=long, y=lat), 
             color=cheap_color)  + 
  geom_point(data=expensive_cars, 
             aes(x=long, y=lat), 
             color=expensive_color, 
             size=2)

# Lo mismo pero incluyendo Alaska y Hawaii, al abarcar un area tan extensa es 
# mas dificil de interpretar. A pesar del gran tamano que tiene Alaska, mas 
# de la mitad del territorio esta vacio. Hawaii no se aprecia correctamente 
# debido al zoom tan lejano.
map_full + geom_point(data=cheap_cars, aes(x=long, y=lat), color=cheap_color) +
  geom_point(data=expensive_cars, aes(x=long, y=lat), color=expensive_color, size=2)

# Mapa de densidad. Se confirma lo que hemos visto en el mapa anterior.
#  La venta de coches se acumula en la mitad este (con el mayor foco en Nueva
# York) y en la costa oeste (principalmente en California).
map +
  stat_density_2d(data=cars, 
                  aes(x=long, y=lat, fill=..level..),
                  geom = "polygon", 
                  alpha = .3, 
                  color = "red") + 
  scale_fill_gradient2("Vehículos en venta", 
                       low = "white", 
                       mid = "yellow", 
                       high = "red")

# En Alaska y Hawaii la densidad es tan pequeña que ni aparece en el mapa,
# no merece la pena sacar ese nivel de zoom
map_full +
  stat_density_2d(data=cars, 
                  aes(x=long, y=lat, fill=..level..),
                  geom = "polygon", 
                  alpha = .3, 
                  color = "red") + 
  scale_fill_gradient2("Vehículos en venta", 
                       low = "white", 
                       mid = "yellow", 
                       high = "red")

