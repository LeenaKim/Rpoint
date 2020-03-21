### T-test, Wilcox-test ###
setwd("C:/Users/user/Desktop/Leena Kim/R/data(f)")
satisf<-read.csv("satisf_theater.csv", header=TRUE)
satisf

table(satisf$방문영화관)

satisf$Qual<-round((satisf$영화품질만족1 + satisf$영화품질만족2 + satisf$영화품질만족3)/3, 2)
satisf$service<-round((satisf$직원서비스만족1 + satisf$직원서비스만족2 + satisf$직원서비스만족3)/3, 2)

brandC<-subset(satisf, 방문영화관==1)
brandL<-subset(satisf, 방문영화관==2)
brandM<-subset(satisf, 방문영화관==3)
brandS<-subset(satisf, 방문영화관==4)
brandA<-subset(satisf, 방문영화관==5)

var.test(brandC$Qual, brandL$Qual, alter="two.sided", conf.int=TRUE, conf.level=0.95)
  #-> p<0.05 이므로 wilcox.test (등분산 비만족)
var.test(brandC$service, brandL$service, alter="two.sided", conf.int=TRUE, conf.level=0.95)
  #-> p>0.05 이므로 t.test (등분산 만족)

wilcox.test(brandC$Qual, brandL$Qual, alter="two.sided", conf.int=TRUE, conf.level=0.95)
  #-> p<0.05이므로 C와 L사의 품질만족도 평균이 다름.
wilcox.test(brandC$Qual, brandL$Qual, alter="greater", conf.int=TRUE, conf.level=0.95)
  #-> p<0.05 이므로 C사의 품질 만족도가 L사보다 더 큼.
t.test(brandC$service, brandL$service, alter="two.sided", conf.int=TRUE, conf.level=0.95)
  #-> p<0.05이므로 둘이 차이가 있음.
t.test(brandC$service, brandL$service, alter="greater", conf.int=TRUE, conf.level=0.95)
  #-> p<0.05 이므로 C사의 service 만족도가 L사보다 더 큼.


### 다이어트 식품 효과 분석: 전후비교(대응 두집단 평균차이 분석) ###
myeffect<-read.csv("myeffect.csv", header=TRUE)
myeffect

myeffect$before
myeffect$after

  # 결측값 처리법 1. 일일히 해주기
myeffect2<-subset(myeffect, after<999)
myeffect3<-subset(myeffect, after!=999)
myeffect4<-subset(myeffect, after<999, c(before, after))
myeffect5<-subset(myeffect, after!=999, c(before, after))
myeffect5
  # 결측값 처리법 2. subset
  # subset: myeffect 데이터의 before 열을 가져와 groupBE에 저장하라는게 아니라, before<999인 모든 행을 groupBE에 저장하라.
groupALL<-subset(myeffect, before<999, after<999)
  # 처음에는 책에 나온것처럼 groupBE, groupAF로 하면 after의 결측값이 반영이 안되므로, all로 비포와 애프터를 동시에 결측값 제거.
groupBE
groupAF<-subset(myeffect, after<999)
groupAF

length(myeffect5$before)
length(myeffect5$after)
length(groupBE$before)  # 258로, after의 결측값이 제거가 안된걸 확인.
length(groupAF$after)

mean(myeffect5$before)
mean(myeffect5$after)

var.test(groupALL$before, groupALL$after, paired=TRUE)
  # -> p<0.05이므로 비등분산검정 => wilcox.test

wilcox.test(groupALL$before, groupALL$after, paired=TRUE)
  # -> p<0.05이므로 before와 after 그룹간 차이가 있다.

wilcox.test(groupALL$before, groupALL$after, paired=TRUE, alter="greater", conf.int=TRUE, conf.level=0.95)
  # -> p<0.05이므로 before의 체중이 after보다 더 크다.


### 택배 서비스 고객의 군집 분석 ###
install.packages("cluster")
library(cluster)
result<-read.csv("myRFM.csv", header=TRUE)
View(result)

  # result 데이터에 계층형 군집분석 알고리즘을 적용한 결과를 result2에 저장
result2<-hclust(dist(result), method="ave") #"ave": 평균연결방법
  # result2에 저장된 계층형 군집분석 적용결과에 대한 세부내용 확인
names(result2)
result2
result2$order
  # result2에 저장된 계층형 군집분석 알고리즘 적용결과를 덴드로그램 형태로 시각화.
plot(result2, hang=-1, labels=result2$ID)

### 비계층적 군집화 알고리즘 분석 ###
result3<-kmeans(result, 3)  # 세 집단으로 군집을 나눔.
result3

  # result에 들어있는 Frequency와 Monetary 값을 X, Y 좌표값으로 사용하여 산포도 그래프 작성.
    # - Kmeans 비계층적 군집분석 결과가 담겨있는 result3의 cluster 분석내용을 참조해서 작성한 것.
plot(result[c("Frequency", "Monetary")], col=result3$cluster)
  #  X, Y 값으로 표기된 산포도에서 군집구분을 용이하게 하기 위해 각 군집의 중앙에 별도의 기호를 나타내게 함.
points(result3$centers[,c("Frequency", "Monetary")], col=1:3, pch=8, cex=2)  # result3의 center(중앙값)을 별다른 표시로 찍어줌.   


