getwd()
setwd("C:/Users/user/Desktop/Leena Kim/R/data(f)")
practice <- read.csv("practice.csv", header=TRUE)
  # psych: 기술통계량 보는 패키지. describe를 쓰려면 받아야 하는 패키지
install.packages("psych")
library(psych)
describe(practice)  # describe: 기술통계량을 보는 가장 흔한 방법.
  # pastecs: 기술통계량 보는 패키지
install.packages("pastecs")
library(pastecs)
stat.desc(practice)

mycar <- read.csv("mycar.csv", header=TRUE)
describe(mycar)
head(mycar)
stat.desc(mycar)
  ## 적합성검정: 변수가 항상 하나. 카이스퀘어값은 color변수 내의 요인들끼리 서로 연관이 있는지.
chisq.test(mycar$color)
View(mycar) # 데이터뷰

service <- read.csv("service.csv", header=TRUE)
service # 말그대로 service의 모든 행과 데이터를 보여줌.
table(service)  # service 내의 요인별 빈도를 보여줌.
table(service[1]) # service의 첫번째 열의 빈도.
serviceFreq<-c(table(service))
  # prop.table: 앞에서 구한 빈도를 0.0x의 비율로 나타내고, 100을 곱하고 1의자리에서 반올림해서 %값으로 나타냄.
serviceProp<-c(round(prop.table(table(service[1]))*100,1))
servicetable<-data.frame(Freq=serviceFreq,Prop=serviceProp)
servicetable

describe(servicetable)
describe(service)
chisq.test(serviceProp) # serviceProp의 적합도검정: 0.05보다 크므로 날짜별로 차이가 없다.

satisf <- read.csv("satisf_theater.csv", header=TRUE) 
satisf
table(satisf$sif)
prop.table(satisf$sif)
satisfSifFreq <-c(table(satisf$sif))
satisfSifProp<-c(round(prop.table(table(satisf$sif))*100,1))
satisfTable<-data.frame(Freq=satisfSifFreq,Prop=satisfSifProp)
satisfTable

chisq.test(satisfSifFreq)
chisq.test(satisfSifProp)

satisf$sex2[satisf$sex==1]<-"man"
satisf$sex2[satisf$sex==2]<-"woman"
chisq.test(satisf$sex,satisf$sif)
fisher.test(satisf$sex,satisf$sif)


edu_smoking <- read.csv("edu_smoking.csv", header=TRUE)
edu_smoking
table(edu_smoking$education,edu_smoking$smoking)

edu_smoking$education2[edu_smoking$education==1] <-"university"
edu_smoking$education2[edu_smoking$education==2] <-"highschool"
edu_smoking$education2[edu_smoking$education==3] <-"middleschool"
edu_smoking$smoking2[edu_smoking$smoking==1] <-"many"
edu_smoking$smoking2[edu_smoking$smoking==2] <-"middle"
edu_smoking$smoking2[edu_smoking$smoking==3] <-"none"

install.packages("plyr")
library(plyr)
edu_smoking$education3 <-mapvalues(edu_smoking$education, from =c(1,2,3), to=c("university","highschool","middleschool"))
edu_smoking$smoking3 <-mapvalues(edu_smoking$smoking, from =c(1,2,3), to=c("many","middle","none"))
edu_smoking
chisq.test(edu_smoking$education3,edu_smoking$smoking3)

sex_poli<-read.csv("poli.csv", header=TRUE)
sex_poli
table(sex_poli$gender,sex_poli$politics)
sex_poli$gender2<-mapvalues(sex_poli$gender, from=c(1,2), to=c("man","woman"))
sex_poli$politics2<-mapvalues(sex_poli$politics, from=c(1,2), to=c("보수","진보"))
sex_poli
chisq.test(sex_poli$gender2,sex_poli$politics2)

carS<- read.csv("carS.csv", header=TRUE)
carS
carS$family2<-mapvalues(carS$family, from=c(1,2,3), to=c("1~2명","3~4명","5명이상"))
carS$carsize2<-mapvalues(carS$carsize, from=c(1,2,3), to=c("소형","중형","대형"))
carS
chisq.test(carS$family2,carS$carsize2)

library(ggplot2)
data("diamonds")
dia_Cut_Freq<- c(table(diamonds$cut))
dia_Cut_Prop<- c(round(prop.table(table(diamonds$cut)),1))
dia_Cut_Table<- data.frame(Freq=dia_Cut_Freq,Prop=dia_Cut_Prop)
dia_Cut_Table
chisq.test(dia_Cut_Freq)


dia_Color_Freq<- c(table(diamonds$color))
dia_Color_Prop<- c(round(prop.table(table(diamonds$color)),1))
dia_Color_Table<- data.frame(Freq=dia_Color_Freq,Prop=dia_Color_Prop)
dia_Color_Table
chisq.test(dia_Color_Freq)

dia_Clarity_Freq<- c(table(diamonds$clarity))
dia_Clarity_Prop<- c(round(prop.table(table(diamonds$clarity)),1))
dia_Clarity_Table<- data.frame(Freq=dia_Clarity_Freq,Prop=dia_Clarity_Prop)
dia_Clarity_Table
chisq.test(dia_Clarity_Freq)

chisq.test(diamonds$cut,diamonds$clarity)
chisq.test(diamonds$cut,diamonds$color)
chisq.test(diamonds$color,diamonds$clarity)

abroad <- read.csv("abroad.csv", header=TRUE)
abroad
abroad$sex2[abroad$sex==1]<-"man"
abroad$sex2[abroad$sex==2]<-"woman"
abroad$area2[abroad$area==1]<-"seoul"
abroad$area2[abroad$area==2]<-"chungcheong"
abroad$f_grade2[abroad$f_grade==1]<-"middleschool"
abroad$f_grade2[abroad$f_grade==2]<-"highschool"
abroad$f_grade2[abroad$f_grade==3]<-"undergraduate"
abroad$f_grade2[abroad$f_grade==4]<-"graduate"
abroad$m_grade2[abroad$m_grade==1]<-"middleschool"
abroad$m_grade2[abroad$m_grade==2]<-"highschool"
abroad$m_grade2[abroad$m_grade==3]<-"undergraduate"
abroad$m_grade2[abroad$m_grade==4]<-"graduate"

abroad$income2[abroad$income==1]<-"150-200만원"
abroad$income2[abroad$income==2]<-"201-300만원"
abroad$income2[abroad$income==3]<-"301-400만원"
abroad$income2[abroad$income==4]<-"401-500만원"
abroad$income2[abroad$income==5]<-"501만원 이상"

abroad$abroad2[abroad$abroad==1]<-"유"
abroad$abroad2[abroad$abroad==2]<-"무"

abroad$toeic1[abroad$toeic >=250 & abroad$toeic<=500] <-"1"
abroad$toeic1[abroad$toeic >=501 & abroad$toeic<=750] <-"2"
abroad$toeic1[abroad$toeic >=751 & abroad$toeic<=990] <-"3"
abroad

chisq.test(abroad$sex,abroad$toeic1)
chisq.test(abroad$abroad,abroad$toeic1)
chisq.test(abroad$area,abroad$f_grade)
chisq.test(abroad$area,abroad$m_grade)
chisq.test(abroad$f_grade,abroad$m_grade)
chisq.test(abroad$m_grade,abroad$income)
chisq.test(abroad$m_grade,abroad$abroad)
chisq.test(abroad$f_grade,abroad$income)
chisq.test(abroad$f_grade,abroad$abroad)

install.packages("gmodels")
library(gmodels)
CrossTable(abroad$abroad2, abroad$toeic1,expected=TRUE, format="SPSS")

install.packages("gmodels")
library(gmodels)
library(xlsx)
setwd("C:/Users/user/Desktop/Leena Kim/R/data(f)")
carS<-read.csv("carS.csv")
head(carS)

### 기존 데이터의 열을 새로운 열로 만들기 ###
## 1. 단순한 방법
carS$family2[carS$family==1]<-"1~2명"
carS$family2[carS$family==2]<-"3~4명"
carS$family2[carS$family==3]<-"5명 이상"

carS$carsize2[carS$carsize==1]<-"소형"
carS$carsize2[carS$carsize==2]<-"중형"
carS$carsize2[carS$carsize==3]<-"대형"
## 2. mapvalue 패키지 이용
carS$family2<-mapvalue(carS$family, from=c(1,2,3), to=c("1~2명", "3~4명", "5명 이상"))
CrossTable(carS$family2, carS$carsize2, expected=TRUE, format="SPSS")
# expected=TRUE: 카이제곱값까지 보여주기

###비율검정: 1) 단일 집단분석-이항분포검정###
smoke<-read.csv("smoke.csv", header=TRUE)
  # 빈도와 비율의 기술통계량 분석을 한번에 해주는 패키지
install.packages("Hmisc")
library(Hmisc)
library(prettyR)
library(psych)

table(smoke$success)

prop.table(table(smoke$success))
prop.table(table(smoke$success))*100
round(prop.table(table(smoke$success))*100,1)

smokeFreq<-c(table(smoke$success))
smokeProp<-c(round(prop.table(table(smoke$success))*100,1))
smoketable<-data.frame(Freq=smokeFreq, Prop=smokeProp)
smoketable

describe(smoke$success)
freq(smoke$success)

  # 특정 변수의 선택 항목이 2개 중 하나일 때 선택 비율이 동일한지를 검정하는 이항분포검증
binom.test(c(44,16), p=0.10)
    # -> 일반적인 패치의 금연 비율 10%를 기준으로 검증을 실시한다. 전체 60명중 금연 성공한 사람이 10프로가 넘는지를 보는 양측검정.
    # -> p값이 0.05보다 작으므로 10프로보다 작거나 크다.
binom.test(c(44, 16), p=0.62, alternative="greater", conf.level=0.95)
    # -> 정규분포에서 금연률이 15프로보다 큰지를 구해봄.
    # -> 0.05보다 작으므로 금연율 15프로 이상.

### T-Test ###
myheight<-read.csv("myheight.csv", header=TRUE)
library(Hmisc)
library(prettyR)

myheight$height
print(myheight$height)

mean(myheight$height)
range(myheight$height)

myheight5<-subset(myheight, height != 999, c(height)) #!=999: 결측치 지우기
myheight5

describe(myheight5)

shapiro.test(myheight5$height) # 정규성 검정 shapiro.test: 0.05보다 커야 정규.
# but, 표본 수가 30 이상이므로 30 이상이면 대부분 t-test 돌림.
t.test(myheight5$height, mu=145.0)
# -> 양측 티테스트 검정으로 p값이 0.05보다 작으므로 height의 평균이 145보다 작거나 크다. 둘의 평균이 다르다.
t.test(myheight5$height, mu=145.0, alter="greater", conf.level=0.95)
# -> 양측에서 평균이 145와 같지 않음으로 단측검정으로 145보다 큰지를 검정. p<0.05 이므로 145보다 크다.
