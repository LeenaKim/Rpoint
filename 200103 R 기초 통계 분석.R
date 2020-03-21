
install.packages("sampling")
library(sampling)

x<-strata(c("Species"), size=c(3,3,3), method="srswor", data=iris)  # 비복원 단순 임의 추출
x
  # iris 데이터 불러오기
data("iris")
head(iris)
str(iris)

getdata(iris,x)

strata(c("Species"), size=c(3,1,1), method="srswr", data=iris)  # 층별로 다른 수의 표본 추출 가능

  # Species2라는 변수를 추가
iris$Species2<-rep(1:2, 75) # 1과 2를 75개씩 넣기.
  # Speicies와 Species2의 각 층마다 1개씩 표본 추출
y<-strata(c("Species", "Species2"), size=c(1,1,1,1,1,1), method="srswr", data=iris) # 다수의 층을 기준으로 데이터 추출
getdata(iris,y)       
    
  ### 범주형 자료 분석 ###

#(1) 적합도 검정(goodness of fit test) : 관측값들이 어떤 이론적 분포를 따르고 있는지를 검정. 한 개의 요인을 대상으로 함 

#(2) 독립성 검정(test of independence) : 서로 다른 요인들에 의해 분할되어 있는 경우 그 요인들이 관찰값에 영향을 주고 있는지 아닌지, 요인들이 서로 연관이 있는지 없는지를 검정. 두 개의 요인을 대상으로 함.

#(3) 동질성 검정(test of homogeneity) : 관측값들이 정해진 범주 내에서 서로 비슷하게 나타나고 있는지를 검정. 속성 A, B를 가진 부모집단(subpopulation) 각각으로부터 정해진 표본의 크기만큼 자료를 추출하는 경우에 분할표에서 부모집단의 비율이 동일한가를 검정. 두 개의 요인을 대상으로 함.


  # 학생들의 성별에 따른 운동량에 차이가 있는지 독립성 검정을 수행      
install.packages("MASS")
library(MASS)
data(survey)
str(survey)
    # 성별, 운동량 변수를 첫 6행 보여주기
head(survey[c("Sex", "Exer")])
    # Exer값은 Freq, Some, None의 3가지 레벨로 구성된 Factor. 성별과 운동이 독립인지 확인 위해 분할표를 만듦
xtabs(~Sex+Exer, data=survey)
table(survey$Sex, survey$Exer)
chisq.test(xtabs(~Sex+Exer, data=survey))
chisq.test(table(survey$Sex, survey$Exer))

    # 왼손잡이와 박수와 독립인지
xtabs(~W.Hnd+Clap, data=survey)
chisq.test(xtabs(~W.Hnd+Clap, data=survey)) # 샘플 수가 작거나 계산식 내에서 조건 만족 안해서 chisq.test()는 경고메세지를 보냄
    # 이 때, fisher.test (피셔검정)을 사용하면 해결이 됨. 
fisher.test(xtabs(~W.Hnd+Clap, data=survey))
    # 독립이라는 귀무가설을 기각하고 의존관계가 있다는 대립가설을 채택
    # 어차피 p값은 0.05보다 작아서 대립가설 채택한다는 결론은 변함이 없지만, 좀 더 정확한 카이제곱값 볼 수 있음.


  # 분할표
table(c("a", "b", "b", "b", "c", "c", "d"))
d<-data.frame(x=c("1", "2", "2", "1"))
d
              
  # 적합도 검정 : 명목형 변수간 차이를 볼 때.
  # 귀무가설(null): 왼손잡이 오른손잡이는 30% : 70%
table(survey$W.Hn)
chisq.test(table(survey$W.Hnd), p=c(.3, .7))  # p값이 0에 수렴하므로 귀무가설 기각.
                                              # p=c(.3, .7)은 여기서 확률을 정해주는 함수. (30%, 70%)
shapiro.test(rnorm(1000))  # shapiro.test의 p값이 0.05보다 크므로 정규분포를 따름.

  # 비모수검정 : 
  # 귀무가설: '주어진 두 데이터가 동일한 분포로부터 추출된 표본'
  # ks.test(): 두 데이터가 같은 정규분포를 따르는지 검정. P<0.05시 같은 분포가 아니다.
ks.test(rnorm(100), rnorm(100))
ks.test(rnorm(100), runif(100))
  # 귀무가설: '주어진 데이터가 평균 0, 분산 1인 정규분포로부터 뽑은 표본'
ks.test(rnorm(1000), "pnorm", 0,1)


  ###### 신차 색상 고객 선호도 분석 ######
  # header=TRUE: 맨 윗 행은 제목이나 항목이다.
setwd("/Users/air/Leena R/data(f)")  # 파일 저장된 공간 설정
getwd() # 설정폴더 확인
mycar<-read.csv("mycar.csv", header = TRUE) # 파일 불러오기

install.packages("prettyR") # prettyR: 빈도분석 중심의 기술통계량 분석을 한번에 해주는 패키지
library(prettyR)  # prettyR 패키지 적용

table(mycar$color)
table(mycar[2]) # 두 분할표 모두 같은 값이지만, 데이터가 많을 땐 []로 직접 행을 써주는것보다, $로 변수 바로 불러오는게 나음.

prop.table(table(mycar$color))  # 분할표의 색깔별 확률 확인
prop.table(table(mycar[2])) 
prop.table(table(mycar[2]))*100 # 확률에 100을 곱해서 %로 표현
round(prop.table(table(mycar[2]))*100, 1) # 소수점 1의자리에서 반올림

surveyFreq<-c(table(mycar$color)) # 빈도 결과를 변수에 저장
surveyProp<-c(round(prop.table(table(mycar$color))*100,1))  # 확률 결과를 변수에 저장
surveytable<-data.frame(Freq=surveyFreq, Prop=surveyProp) # 빈도와 확률을 가지고 새로운 분할표 작성
surveytable

describe(mycar) # 기술통계량 확인 (mean, median, var, sd, valid.n)
describe(mycar$color) 

freq(mycar)
freq(mycar$color) # color에 대한 항목별 빈도 및 백분율에 대한 빈도분석 테이블 출력
                  # ??? R 프로젝트에서 장노년층의 디지털수업 수요 확률 구할때 쓰면 쉽지 않았을까 ???
chisq.test(surveyFreq)  # '항목별 차이가 있다'는 대립가설 검정 -> p값이 0.01보다 작으므로 대립가설 채택.


    ##### 상관관계 #####
    # 피어슨 상관계수 (cor)
    # cf) [1,] 숫자 뒤에 오는 콤마: 행 전체
    #     [,1] 숫자 앞에 오는 콤마: 열 전체
cor(iris$Sepal.Width, iris$Sepal.Length)
cor(iris[,1:4])
symnum(cor(iris[,1:4]))

install.packages("corrgram")
library(corrgram)
corrgram(cor(iris[,1:4]), type="corr", upper.panel=panel.conf)

cor(1:10, 1:10)
cor(1:10., 1:10*2)  # 1부터 10까지 상승, 1부터 10*2까지도 상승하니 상관계수는 1.

    # 스피어만 상관계수 (rcorr) : 두 연속형 변수의 분포가 정규분포를 벗어나거나 두 변수가 순위 척도 자료일 때
x <- c(3,4,5,3,2,1,7,5)
x
rank(sort(x)) # x 내의 데이터를 오름차순으로 정렬 후 순위를 매기면 3위와 6위가 둘씩이므로 이들 순위인 3, 4위의 평균인 3.5 둘, 6, 7의 평균인 6.5 둘이 나옴.

install.packages("Hmisc")
library(Hmisc)
m<-matrix(c(1:10, (1:10)^2), ncol=2)  # matrix: 1부터 10까지의 열1, 1부터 100까지 제곱수들로 이뤄진 열2라는 2차원 데이터 생성
m
rcorr(m, type="pearson")$r  # (1:10)과 (1:10)^2 둘의 상관관계: 둘 다 상승하니 상관관계 높음.
rcorr(m, type="spearman")$r

    # 등분산검정 만족시 -> 티테스트 #
View(sleep)
sleep2<-sleep[, -3] # 3번째 열 제거
sleep2

    # tapply (벡터, 요인, 함수)
tapply(sleep2$extra, sleep2$group, mean)  # extra 벡터를 group 요인으로 평균을 나눈다 -> 요인별 벡터 평균
                                          # R 프로젝트에서 describeBy 대신 이걸로 세대별 디지털정보화수준 평균을 볼 수 있지 않았을까?
install.packages("doBy")
library(doBy)
summaryBy(extra ~group, sleep2) # summaryBy: 원하는 컬럼의 값을 특정 조건에 따라 요약
                                # A ~B: 독립변수 B가 영향을 미치는 종속변수 A
var.test(extra ~group, sleep2)  # var.test (등분산검정): p>0.05 일때 두 변수의 분산이 동질적이다 -> 모수통계다 -> t.test
                                # p<0.05 일때 두 변수의 분산이 동질적이지 않다 -> 비모수통계다 -> wilcox.test
                                # But, 대부분의 경우 t.test 돌림.
t.test(extra ~group, data=sleep2, paired=FALSE, var.equal=TRUE) # p>0.05 => '두 수면제 사이에 효과의 차이가 없다' 귀무가설 채택.

boxplot(sleep2$extra ~sleep2$group)

  ##### ANOVA #####
a <- c(100,98,85,90,88,80)
b <- c(73,80,80,75,67,57)
c <- c(110, 104, 91, 109, 85, 95)

life<-data.frame(a,b,c) # data.frame은 열별로 묶어줌.
life
b.life=stack(life)  # R에선 .은 아무 의미 없음. b.life는 변수 이름일 뿐.
                    # stack(): a,b,c 안에 있는 값을 한줄로 모두 쌓아버림.
b.life

op = par(mfrow=c(1,2))  # par(): 그래프 만들기 전에 초기화해줌. 1행 2열. 
boxplot(values ~ ind, data = b.life)

stripchart(life) # stripchart(): ind와 value x와y축을 뒤집은 그래프.

par(op) # par(): 그래프 설정 초기화
dev.off() # dev.off(): R이 더 이상 그래프를 다시 보내지(redirect) 못하게 정지

oneway.test(values~ind, data=b.life, var.equal=TRUE)  # t.test는 그냥 해본거고, 세집단 비교라서 p값이 정확한 값은 아님.

type=c(rep('a',6), rep('b',6), rep('c',6))  # rep(): type 변수에 a 6개, b 6개, c 6개 입력.
y = c(100, 98, 85, 90, 88, 80, 73, 80, 80, 75, 67, 57, 110, 104, 91, 109, 85, 95)
type
y

ty=as.factor(type)  # as.factor(): 문자형(character)를 요인형(factor)로 전환. a와 b와 c라는 세 개의 층이 생김.
ty

life.aov=aov(y~ty)  # aov: ANOVA -> 종속변수 y와 독립변수 ty간의 분산분석.
                    # y의 첫 여섯 수가 a로, 그 뒤의 여섯 수가 b로, 마지막 여섯 수가 c로 대입됨.
summary(life.aov) # p값이 0.05보다 작으므로 집단간 차이가 있으나, 정확히 보기 힘드므로 사후검정 해야함.

life.tukey=TukeyHSD(life.aov, "ty", ordered=TRUE) # 사후검정. ty 대신 type로 하면 factor형으로 변환되지 않았으므로 실행 안됨.
life.tukey   # TukeyHSD는 각 집단간의 평균의 차이와 p값을 보여줌.


  # 이요인 분산분석 (이원분산분석) #
    # 관측값이 두개 이상일 경우의 이원분산분석에서는 두 개의 요인 수준별 주 효과(main effect)와 더불어 
    # 두 요인이 서로 상호간에 영향을 주고 받으면서 나타나는 반응효과인 교호작용 효과(interaction effect)를 추가로 분석하는 것이 
    # 관측값이 하나인 경우와의 차이점

pressure=as.factor(c(320, 340, 360, 310, 330, 350, 300, 320, 340, 310, 330, 350))

temp=as.factor(c(rep('low',6), rep('high',6)))
y=c(130.5, 120.2, 150.8, 
    +170.2, 157.1, 164.7,
    +102.6, 181.6, 160.5,
    +189.5, 165.3, 176.5)
data.frame(temp, y)
data.frame(pressure, y)

op=par(mfrow=c(2,2)) # mfrow=c(x, y): 한 창에 그래프를 x * y 개 보여주고 싶다.
plot(y~temp)
plot(y~pressure)
stripchart(y~temp, vertical=TRUE, xlab="temperature")
stripchart(y~pressure, vertical=TRUE, xlab="pressure")
par(op)

  # interaction.plot():  데이터의 상호 작용을 살펴보는 그림은 상호 작용 그래프
  # interaction.plot( x.factor, trace.factor, response )
op=par(mfrow=c(1,2))
interaction.plot(temp, pressure, y, bty='l', main='interaction plot')
interaction.plot(pressure, temp, y, bty='o')
par(op)

aov_pt=aov(y~temp+pressure+temp:pressure) # 독립변수가 한개 이상일땐 +로 연결. (이원분산분석)
                                          # temp:pressure : temp와 pressure를 합쳐서 교호작용 효과를 볼 때.
aov_pt

summary(aov_pt) # 원랜 p값이 나와야 하는데 왜 안나오는지 모르겠음.
                # temp:pressure의 p가 <0.05라면 교호효과가 있기 때문에, temp와 pressure이 각각 y에 미치는 영향을 정확히 파악할 수 없으므로 둘을 따로 하던가 하나를 빼던가 해야 함.


  ##### 군집분석 ######
    # 군집분석이란 데이터가 속해 있는 군집을 모르는 상태에서(Y값 label 없음) 
    # 유사한 혹은 동질의 데이터끼리 군집(cluster)로 묶어 주는 분석기법

    # 그렇다면 군집분석에서 모델 생성, 평가는 무슨 기준으로 하는 것일까 하는 의문이 들 것입니다. 
    # 군집분석에서는 주로 응집도(cohesion)과 분리도(separation) 척도를 많이 사용하는 편인데요, 
    # 군집분석을 컴퓨터가 이해하도록 수식, 척도를 가지고 군집화의 원리를 나타내보면
      # (1) 군집 內 응집도를 최대화하고, (maximizing cohesion within cluster, i.e. minimizing sum of distance b/w x and y) 
      # (2) 군집 間 분리도를 최대화하도록 (maximizing separation between clusters) 군집을 형성한다는 것입니다.

    # 응집형(Agglomerative) 방법에는 군집간 거리 척도와 연결법에 따라서 
    # 단일(최단) 연결법 (Single Linkage Method), 완전(최장) 연결법 (Complete Linkage Method), 평균 연결법 (Average Linkage Method), 중심 연결법 (Centroid Linkage Method), Ward 연결법 (Ward Linkage Method)이 있습니다.
    # 분리형(Divisive) 방법에는 DIANA 방법(DIANA algorithm)이 있습니다.

    # 데이터 간의 비유사성(Dis-similarity)은 거리(Distance)를 가지고 주로 측정하며, 유사성(Similarity)은 비유사성과 반비례의 관계에 있다고 보면 됩니다.


    # 최단연결법(method="single") : 군집간 최단거리 기준으로 유사성 판단
op=par(mfrow=c(2,2))
a <- c(1,5)
b<-c(2,3)
c<-c(5,7)
d<-c(3,5)
e<-c(5,2)
data<-data.frame(a,b,c,d,e)
data
data<-t(data) # t: 행과 열 뒤집기
data          # R프로젝트 디지털수업 수요 빈도 구할때 데이터프레임으로 한 수업마다 다 열로 정하지 말고 쉽게 만들고 뒤집었으면 됬지 않을까?

(m1<-hclust(dist(data)^2, method="single"))
plot(m1)

    # 최장연결법(method="complete") : 군집간 최장거리 기준으로 유사성 판단
(m2<-hclust(dist(data)^2, method="complete"))
plot(m2)

    # 와드연결법 : 군집 간 객체들의 오차제곱합을 기준으로 유사성 판단
(m3<-hclust(dist(data)^2, method="ward.D2"))
plot(m3)

    # 평균연결법 : 크기가 다른 두 군집 사이의 거리를 개체간 거리의 합의 평균으로 판단하여 유사성 판단
(m4<-hclust(dist(data)^2, method="average"))
plot(m4)

    # K-means : 임의로 군집 생성
      # 비지도학습 : 입력값에 대한 목표치가 주어지지 않음.
      # 이번 포스팅에서 소개할 분할적 군집화는 이중에서 프로토타입 기반(Prototype-based) 기법 중에서도 K-중심군집(K-centroid Clustering) 모형이 되겠습니다.
      # 프로토타입 기반 군집화(Prototype-based Clustering)는 미리 정해놓은 각 군집의 프로토타입에 각 객체가 얼마나 유사한가 (혹은 가까운가)를 가지고 군집을 형성하는 기법입니다. 
      # K-중심군집에서는 연속형 데이터의 경우 평균(Mean)이나 중앙값(Median)을 그 군집의 프로토타입으로 하며, 이산형 데이터인 경우는 최빈값(Mode)이나 메도이드(Medoid)라고 해서 해당 군집을 가장 잘 표현할 수 있는 측도를 정해서 프로토타입으로 정하게 됩니다.
      # 보통 군집분석을 공부한다고 했을 때 가장 많이 회자되고, 가장 처음에 배우는 기법이 아마도 'K-평균 군집화(K-means Clustering)이 아닐까 싶습니다.  
      # 그런데 앞서 소개드린 것처럼 군집분석 기법에는 정말 많은 알고리즘이 있습니다. K-평균 군집은 그 중에서도 일부에 해당하는 기법일 뿐이며, 프로토타잎도 데이터 형태에 따라서 '평균(Mean)'을 쓰는 K-means Clustering, '중앙값(Median)'을 쓰는 K-median Clustering, '메도이드(Medoid)'를 쓰는 K-medoid Clustering 등으로 세분화된다는 점은 알아두시면 좋겠습니다.  
      # 이들을 모두 묶어서 'K-중심군집(K-centroid Clustering)'이라고 합니다.
      # 군집의 수인 k를 정하는 과정에서 분석가의 주관이 많이 들어가게 됨.
      # https://rfriend.tistory.com/228?category=706119
rm(list=ls(all=TRUE)) # 데이터를 모두 제거하라
data<-iris
head(data)

data$Species<-NULL
head(data)
(m<-kmeans(data,3))

table(iris$Species, m$cluster)

op=par(mfrow=c(2,2))
plot(data[c("Sepal.Length", "Sepal.Width")], main="kmeans", col=m$cluster)
plot(iris$Sepal.Length, iris$Sepal.Width, main="true", col=c(1,2,3)[unclass(iris$Species)])
    # 군집 4개로 분류해보기 
(m<-kmeans(data,4))
table(iris$Species, m$cluster)
plot(data[c("Sepal.Length", "Sepal.Width")], col=m$cluster)


