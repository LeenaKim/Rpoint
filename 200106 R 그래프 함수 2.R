    #### 산점도 ####
    methods("plot")
install.packages("mlbench")    
library(mlbench)
data(Ozone)
plot(Ozone$V8, Ozone$V9)  # plot(): 데이터를 보고 R이 가장 맞다고 생각하는 그래프를 그려줌.

plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperature", ylab="El Monte Temperature")

plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperature", ylab="El Monte Temperature", main="Ozone")  #main: 차트 이름

plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperature", ylab="El Monte Temperature", main="Ozone", pch=20)  

plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperature", ylab="El Monte Temperature", main="Ozone", pch="+") 

plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperature", ylab="El Monte Temperature", main="Ozone", cex=.1) 

plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperature", ylab="El Monte Temperature", main="Ozone", col="#FF0000") 
max(Ozone$V8) # 데이터에 결측값이 있으니 NA로 나옴.
max(Ozone$V8, na.rm=TRUE) # 결측값이 있으니 그걸 유의하고 그려라. "이 데이터에 결측값이 있어요!"
max(Ozone$V9, na.rm=TRUE) 
plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperature", ylab="El Monte Temperature", main="Ozone", xlim=c(0,100), ylim=c(0,90)) # xlim, ylim: x축 y축 범위 지정 

    #### 그래프 활용 ####
data(cars)
str(cars)
head(cars)
plot(cars)

plot(cars, type="l")
plot(cars, type="o", cex=0.5)

plot(tapply(cars$dist, cars$speed, mean), type="o", cex=0.5, xlab="speed", ylab="dist")
tapply(cars$dist, cars$speed, mean)


opar<-par(mfrow=c(1,2)) # c(행의 수, 열의 수) 만큼 그래프를 보여줌.
plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperatue", ylab="El Monte Temperature", main="Ozone")
plot(Ozone$V8, Ozone$V9, xlab="Sandburg Temperatue", ylab="El Monte Temperature", main="Ozone2")
par(opar)

    ## jijtter: 같은 위치에 찍혀있는 점일 경우 살짝 빗겨가게 표시
head(Ozone)
plot(Ozone$V6, Ozone$V7, xlab="Windspeed", ylab="Humidity", main="Ozone", pch=20, cex=.5)
plot(jitter(Ozone$V6), jitter(Ozone$V7), xlab="Windspeed", ylab="Humidity", main="Ozone", pch=20, cex=.5)

plot(iris$Sepal.Width, iris$Sepal.Length, cex=.5, pch=20, xlab="width", ylab="length", main="iris")
points(iris$Petal.Width, iris$Petal.Length, cex=.5, pch="+", col="#FF0000") # points: 이미 생성된 plot에 점을 추가로 그려주기

    ## attach: 해당 데이터를 메모리에 물려서 쓸때마다 불러오지 않아도 되지만, 후에 다른 데이터와 충돌 일어날수 있으니 끝내도 detach 해줘야.
attach(iris)
plot(Sepal.Width, Sepal.Length, cex=.5, pch=20, xlab="width", ylab="length", main="iris") # plot 생성
points(Petal.Width, Petal.Length, cex=.5, pch="+", col="#FF0000") # 그 후 다른 변수 점 추가
with(iris, {plot(Sepal.Width, Sepal.Length, cex=.5, pch=20, xlab="width", ylab="length", main="iris") # with로 이 둘을 한꺼번에 하는법 
  points(Petal.Width, Petal.Length, cex=.5, pch="+", col="#FF0000")})


with(iris, {plot(NULL, xlim=c(0,5), ylim=c(0,10), xlab="width", ylab="length", main="iris", type="n") # x축 y축 범위 정해주기
  points(Sepal.Width, Sepal.Length, cex=.5, pch=20)
  points(Petal.Width, Petal.Length, cex=.5, pch="+", col="#FF0000")})

    #### 그래프의 활용 ####
    # lines(): points()와 마찬가지로 plot에 새로운 그래프를 그린 뒤 선을 그리는 목적
x<-seq(0, 2*pi, 0.1) # sequence
y<-sin(x) # 싸인
plot(x, y, cex=.5, col="red")
lines(x,y)  # 꺾은선 가능

data(cars)
head(cars)

    # abline(): 근사가 얼마나 잘 이루어졌는지 시각화
plot(cars)
lines(lowess(cars))
plot(cars, xlim=c(0,25))
abline(a=-5, b=3.5, col="red")  # ax+b=0 의 a 기울기, b y절편 대입한 직선 그리기
abline(h=mean(cars$dist), lty=2, col="blue")  # h가 dist의 평균인 수평선 그리기
abline(v=mean(cars$speed), lty=2, col="green")  # v가 speed의 평균인 수직선 그리기

curve(sin, 0, 2*pi)

m<-lm(dist ~speed, data=cars)      
m
abline(m)
p<-predict(m, interval="confidence")  # predict: 앞에서 했던 모형을 가지고 예측해보라.
head(p)
head(cars)
x<-c(cars$speed, tail(cars$speed, 1), rev(cars$speed), cars$speed[1]) # tail: 뒤에서 첫번째 데이터, cars$speed[1]: 첫 번째 변수, rev: 변수 순서 거꾸로
y<-c(p[, "lwr"], tail(p[, "upr"],1), rev(p[,"upr"]), p[,"lwr"][1])

m<-lm(dist ~speed, data=cars)
p<-predict(m, interval="confidence")
plot(cars)
abline(m)

x<-c(cars$speed, tail(cars$speed, 1), rev(cars$speed), cars$speed[1])
y<-c(p[, "lwr"], tail(p[, "upr"],1), rev(p[,"upr"]), p[,"lwr"][1])
polygon(x, y, col=rgb(.7,.7,.7,.5)) # polygon(): 다각형을 그리는데 사용하는 함수
# predict를 이용하여 선형회귀함수의 신뢰도를 포함한 예측 범위를 다각형으로 그린 것.

    #### 그래프 활용 ####
plot(cars, cex=.5)
    # text(x, y, labels): 그래프에 문자를 그리는데 사용. labels는 각 좌표에 표시할 문자들.
text(cars$speed, cars$dist, pos=4, cex=.5)

    # identify(): 그래프상에서 특정 점을 클릭하면 클릭된 점과 가장 가까운 데이터를 알려줌.
    # 클릭 후 finish 누르면 text 함수가 적용된 상태이기 때문에 클릭한 점의 데이터값이 그래프에 뜸.
plot(cars, cex=.5)
identify(cars$speed, cars$dist)

    # legend()는 범례를 표시하는데 사용.
plot(iris$Sepal.Width, iris$Sepal.Length, cex=.5, pch=20, xlab="width", ylab="length", main="iris")
points(iris$Petal.Width, iris$Petal.Length, cex=.5, pch="+", col="#FF0000")
legend("topright", legend=c("Sepal", "Petal"), pch=c(20, 43), cex=.8, col=c("black", "red"), bg="gray")

    # matplot(), matlines(), matpoints(): plot(), lines(), points() 함수와 유사하지만 행렬 형태로 주어진 데이터를 그래프에 그림
x<-seq(-2*pi, 2*pi, 0.01)
x
y<-matrix(c(cos(x), sin(x)), ncol=2)
matplot(x, y, col=c("red", "black"), cex=.2)  # 그냥 plot으로 안나오는 그래프라서 행렬형태로.
abline(h=0, v=0)
    # iris$Sepal.Width에 대해 상자 그림
boxplot(iris$Sepal.Width)
boxstats<-boxplot(iris$Sepal.Width)
boxstats
    # iris의 outlier 옆에 데이터 번호를 표시
boxstats<-boxplot(iris$Sepal.Width, horizontal=TRUE)
text(boxstats$out, rep(1, NROW(boxstats$out)), labels=boxstats$out, pos=1, cex=.5)

sv<-subset(iris, Species=="setosa" | Species=="versicolor")
sv$Species<-factor(sv$Species)
boxplot(Sepal.Width~Species, data=sv, notch=TRUE)

    # 히스토그램
hist(iris$Sepal.Width)
hist(iris$Sepal.Width, freq=FALSE)
x<-hist(iris$Sepal.Width, freq=FALSE)
x
y<-sum(x$density)*0.2
y
    # bin의 경계에서 분포가 확연히 달라지지 않는 kernel density estimation에 의한 밀도 그림
plot(density(iris$Sepal.Width)) # 밀도는 %나 분포.
hist(iris$Sepal.Width, freq=FALSE)  # 빈도 위주로 나타냄
lines(density(iris$Sepal.Width))  # 그래프 곂쳐 그리기
plot(density(iris$Sepal.Width))
rug(jitter(iris$Sepal.Width))

    # 막대그림은 barplot() 함수
barplot(tapply(iris$Sepal.Width, iris$Species, mean))

    # pie(): 파이그래프. 데이터의 비율을 알아보는데 적합.
cut(1:10, breaks=c(0,5,10)) # cut(): 연속형 변수를 범주형 변수로 변환 (후엔 ifelse를 더 많이 씀.)
cut(1:10, breaks=3)
cut(iris$Sepal.Width, breaks=10)

rep(c("a", "b", "c"), 1:3)
table(cut(iris$Sepal.Width, breaks=10)) # Sepal.Width가 너비니까 연속형 변수이기 때문에 10씩 잘라서 범주형 변수로 만들어 줌.
pie(table(cut(iris$Sepal.Width, breaks=10)), cex=.7)

    # 모자이크 플롯: 범주형 다변량 데이터를 표현하는데 적합. mosaicplot()
str(Titanic)
plot(Titanic, color=TRUE)
mosaicplot(~Class+Survived, data=Titanic, color=TRUE) # 종속변수가 없는 이유: 두 독립변수의 독립성 검정이기 때문에.

mosaicplot(Titanic, main="Titanic Data, Class, Sex, Age, Survival", col=TRUE)

    # 산점도 행렬은 다변량 데이터에서 변수 쌍간의 산점도 행렬을 그린 그래프
pairs(~Sepal.Width+Sepal.Length+Petal.Width+Petal.Length, data=iris, col=c("red", "green", "blue")[iris$Species]) # 종속변수가 없는 이유: 상관관계를 볼땐 종속변수, 독립변수의 관계가 없음.
levels(iris$Species)
as.numeric(iris$Species)

    # 투시도는 3차원 데이터를 마치 투시한것처럼 그린 그림으로 persp() 함수

    # 두 종류의 그래프 조합
x<-c(1,2,1,4,5,4,5,2,3,5,2,6,7,3,7,8,6,5,4,7,7,6,5,7,8,9,8)
par(mfrow=c(1,2))
hist(x)
hist(x, probability=T, main="Histogram with density line")
lines(density(x))

    #### ggplot2 ####
    # 기본 점찍기
install.packages("ggplot2")
library(ggplot2)
test.data<-data.frame(length=c(3,2,5,8), width=c(4,3,6,9), depth=c(5,2,16,80), trt=c("a","a","b","b"))
ggplot(test.data, aes(x=length, y=width))+geom_point(aes(colour=trt)) # aes: 미적 매핑  # geom_point: 각각의 점들을 기하 객체에 맞게 찍는다. # colour=trt: trt에 속한 a와 b에 따라 분류한다.

    # 흐름 그래프 (smooth())      
ggplot(test.data, aes(x=length, y=width))+geom_point(aes(colour=trt))+geom_smooth()

    # 다이아몬드 그리기
ggplot(data=diamonds, aes(x=carat, y=price))+geom_point(aes(colour=clarity))

    # 회귀곡선 그리기 +goem_smooth() (실제론 회귀분석을 다 돌리고 그려야 함. 이건 그냥 그래프 참고용.)
ggplot(data=diamonds, aes(x=carat, y=price))+geom_point(aes(colour=clarity))+geom_smooth()
ggplot(data=diamonds, aes(x=carat, y=price,colour=clarity))+geom_point()+geom_smooth()

    # 회귀곡선 Group 매핑요소
ggplot(data=diamonds, aes(x=carat, y=price))+geom_smooth()
ggplot(data=diamonds, aes(x=carat, y=price))+geom_smooth(aes(group=clarity))

    # 그래프 색 변경
ggplot(data=diamonds, aes(x=price))+geom_bar()
ggplot(diamonds, aes(x=price))+stat_bin(geom="bar", fill="gold", col="hotpink") # stat_bin: 그래프의 디자인적 요소.

    # 누적 히스토그램 그리기
ggplot(diamonds, aes(clarity, fill=cut))+geom_bar() # 그래프를 다이아몬드가 깎인 정도에 따라 stack으로 표현

    # ggplot2 VS qplot
qplot(clarity, data=diamonds, fill=cut, geom="bar")
ggplot(diamonds, aes(clarity, fill=cut))+geom_bar()
# => 모양은 차이가 없다. 단지 문법에 차이가 있을 뿐.

    # 크기 조절
qplot(log(wt), mpg-10, data=mtcars, color=qsec, size=3)

    # qplot: 나중에 시간나면 해보기.

    ## ggplot2 diamond
diamonds
g<-diamonds[order(diamonds$table),] # order + ,
head(g)
tail(g)

    # 그래프 색 변경 : Size, shape, color, stroke
gg<-ggplot(diamonds, aes(x=carat, y=price))
gg+geom_point()
gg+geom_point(size=1, shape=2, color="steelblue", stroke=1)
    # aes 활용
gg<-ggplot(diamonds, aes(x=carat, y=price))
gg+geom_point(aes(size=carat, shape=cut, color=color, stroke=carat))  # size: 포인터의 크기, stroke: 포인터의 테두리의 굵기

    # 제목과 축 이름 변경
gg1<-gg+geom_point(aes(color=color))
gg2<-gg1+labs(title="Diamonds", x="Carat Layer", y="Price Layer") # labs: 라벨붙이기
print(gg2)

    # 제목과 축 크기 변경
gg3<-gg2+theme(plot.title=element_text(size=25), axis.title.x=element_text(size=20), axis.title.y=element_text(size=20), axis.text.x=element_text(size=15), axis.text.y=element_text(size=15))
print(gg3)

    # 제목 추가
gg3+labs(title="Plot Title \nSecond Line of Plot Title") + theme(plot.title=element_text(face="bold", color="steelblue", lineheight=1.2))

    # Legend 색상 변경
gg1<-gg+geom_point(aes(color=color))
gg2<-gg1+labs(title="Diamonds", x="Carat", y="Price")
gg3<-gg2+theme(plot.title=element_text(size=25), axis.title.x=element_text(size=20), axis.title.y=element_text(size=20), axis.text.x=element_text(size=15), axis.text.y=element_text(size=15))
print(gg3)

gg3+scale_colour_manual(name='Legend', values=c('D'='grey', 'E'='red', 'F'='blue', 'G'='yellow', 'H'='black', 'I'='green', 'J'='firebrick'))

    # 축 범위 변경
gg3+coord_cartesian(xlim=c(0,3), ylim=c(0,5000))+geom_smooth()

    # x, y 축 변경
gg3+coord_flip()

    # 배경색 설정
gg3+theme(plot.background=element_rect(fill="yellowgreen"), plot.margin=unit(c(2,4,1,3), "cm")) # plot.margin: 배경과 그래프 사이의 마진값. 북동남서 방향으로 2, 4, 1, 3cm만큼의 마진을 주겠다.

    # x축 선 추가
p1<-gg3+geom_hline(yintercept=5000, size=2, linetype="dotted", color="blue")
print(p1)

    # 히스토그램 +boxplot
install.packages("ggExtra")
library(ggExtra)
library(ggplot2)
data(mpg, package="ggplot2")

    # Scatterplot
theme_set(theme_bw()) # theme_bw(): 배경을 흰색으로
    # pre-set the bw theme
mpg_select<-mpg[mpg$hwy>=35&mpg$cty>27,]  # mpg 데이터에서 hwy가 35 이상이고, cty가 27 초과인 애를 뽑아서 저장
g<-ggplot(mpg, aes(cty, hwy))+geom_count()+geom_smooth(method="lm", se=F)
g
ggMarginal(g, type="histogram", fill="transparent")
ggMarginal(g, type="boxplot", fill="transparent")

    # 상관관계
install.packages("ggcorrplot")
library(ggcorrplot)
    #Correlation matrix
data(mtcars)
corr<-round(cor(mtcars),1)

    # plot
ggcorrplot(corr, hc.order=TRUE,
type="lower", lab=TRUE, lab_size=3, method="circle", colors=c("tomato2", "white", "springgreen3"), title="Correlogram of mtcars", ggtheme=theme_bw)

    # 분열막대
library(ggplot2)
theme_set(theme_bw())

data("mtcars")
mtcars$'car name'<-rownames(mtcars)

mtcars$mpg_z<-round((mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg), 2)

mtcars$mpg_type<-ifelse(mtcars$mpg_z < 0, "below", "above")
mtcars<-mtcars[order(mtcars$mpg_z),]
mtcars$'car name'<-factor(mtcars$'car name', levels=mtcars$'car name')

ggplot(mtcars, aes(x='car name', y=mpg_z, label=mpg_z))+
  geom_bar(stat='identity', aes(fill=mpg_type), width=.5)+
  scale_fill_manual(name="Mileage", 
                    labels=c("Above Average", "Below Average"),
                    values=c("above"="#00ba38", "below"="#f8766d")) +
  labs(subtitle="Normalized mileage from 'mtcars'",
       title="Diverging Bars") +
  coord_flip()
