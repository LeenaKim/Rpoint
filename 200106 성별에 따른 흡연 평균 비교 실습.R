install.packages("xlsx")
library(xlsx)
setwd("C:/Users/user/Desktop/Leena Kim/R")
data<-read.csv("NHIS_OPEN_GJ_2018.csv")

head(data)

op = par(mfrow=c(2,2)) 
chisq.test(table(data$Sex, data$Smoke))
a <- table(data$Sex, data$Smoke)
hist(a)
hist(data$Sex, data$Smoke, freq=TRUE)
plot(data$Sex, data$Smoke)

b<-data.frame(data$Height, data$Weight)
corr<-round(cor(b),1)
library(ggcorrplot)
ggcorrplot(corr,
           lab=TRUE, lab_size=3, method="circle", colors=c("tomato2", "white", "springgreen3"), title="Height Weight", ggtheme=theme_bw)

plot(b)