setwd("C:/R Leena/data(f)")
carcinogen <- read.csv("carcinogen.csv")
name <- c("Seoul","Busan","Daegu","Incheon","Gwangju","Daejeon","Sejong", "Ulsan","Gyeonggi", "Gangwon", "Chungbuk","Chungnam","Jeonbuk","Jeoonnam","Gyeongbuk","Gyeongnam")
region <- paste("KR",c(11,26,27,28,29,30,31,32,41,42,43,44,45,46,47,48),sep="-")

Korea <- data.frame(region, carcinogen[,2], name)
colnames(Korea) <- c("region","carcinogen","name")

install.packages("googleVis")
library("googleVis")

Map <- gvisGeoChart(Korea, locationvar = "region", colorvar = "carcinogen", hovervar = "name",
                    options = list(region = "KR", displayMode = "regions", resolution = "provinces", 
                                   colorAxis="{colors:['lightgreen','red']}", backgroundColor = "darkblue",
                                   datalessRegionColor = "gray"))
plot(Map)
