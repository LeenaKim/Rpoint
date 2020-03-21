### 파이썬 프로젝트 데이터를 R로 돌려보기 ###

setwd("C:/R Leena")
library(ggplot2)
library(ggmap)
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap")
register_google(key='AIzaSyDXQvPXUY1bNZvttOsx0x_LDFesJpDyCcU')
library(devtools)
library(dplyr)

Toff<-read.csv("1911_Tmoney_offboard(2).csv", header=T)
head(Toff)


Toff$rushH<-round((Toff$X18+Toff$X19+Toff$X20)/3, digit=0)

Toff$rushH<-ifelse(Toff$rushH==0, NA, Toff$rushH)
Toff2<-na.omit(Toff)


View(Toff2$rushH)
View(Toff2)

df=data.frame(Toff2$Line, Toff2$Station, Toff2$Longitude, Toff2$Latitude, Toff2$rushH)

seoul<-ggmap(get_map("seoul", zoom=11, maptype="roadmap"))
print(seoul)

print(Tmap)
View(Toff2)
View(df)
seoul+geom_point( data=df,aes(x=Toff2.Longitude, y=Toff2.Latitude,colour=Toff2.Line,size=Toff2.rushH))

ggsave("Toff.png", scale=1, width=7, height=4, dpi=1000)                
