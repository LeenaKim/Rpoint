### 상관관계 분석 ###
sales<-read.csv("sales.csv", header=TRUE)
str(sales)
##1. Pearson
cor.pearson<-cor.test(~promotion+sales, method="pearson", data=sales)
cor.pearson
#-> p<0.05: promotion과 sales 사이에 상관관계가 있다.

##2. Speraman
cor.spearman<-cor.test(~promotion+sales, method="spearman", data=sales)
cor.spearman
#-> p<0.05: promotion과 sales 사이에 상관관계가 있다.

##3. kendall
cor.kendall<-cor.test(~promotion+sales, method="kendall", data=sales)
cor.kendall
#-> p<0.05: promotion과 sales 사이에 상관관계가 있다.

## 상관관계 시각화 ##
cor(sales)
plot(sales)
pairs(sales, panel=panel.smooth)

install.packages("PerformanceAnalytics")
library(PerformanceAnalytics)
chart.Correlation(sales, histogram=TRUE, pch=20)

install.packages("corrplot")
library(corrplot)

sales.cor<-cor(sales)
sales.cor

corrplot(sales.cor, method="ellipse")
corrplot(sales.cor, method="pie")
corrplot(sales.cor, method="number")
corrplot(sales.cor, method="color")
corrplot(sales.cor, method="shade")
corrplot(sales.cor, method="shade", addshade="all", shade.col=FALSE, tl.col="red", tl.srt=30, diag=FALSE, addCoef.col="white", order="FPC")
# method= 그림 내 사각형 모양
# shade.col= 상관관계 방향선
# tl.srt= 위쪽 라벨 회전 각도
# addCoef.col= 상관계수 숫자 색
# order= "FPC": First Principle Component
# addshape= 상관관계 방향선 제시
# tl.col= 라벨 색 지정
# diag= 대각선 값
