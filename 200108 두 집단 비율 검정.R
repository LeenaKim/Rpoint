# 두 집단 비율 차이 분석: 두 집단이 둘 중에 하나를 선택하는 항목으로 구성된 경우와 각 집단에서 선택한 비율이 서로 동일한지, 다른지를 비교하는 분석.
setwd("C:/Users/user/Desktop/Leena Kim/R/data(f)")
mycf<-read.csv("mycf.csv", header=TRUE)
mycf
mycf$group
mycf$interest
mycf[c("group", "interest")]

prop.table(table(mycf$group, mycf$interest))
round(prop.table(table(mycf$group, mycf$interest))*100,1)

prop.test(c(13,27), c(50,50)) # 13이 그룹 1의 관심 없는 사람 비율, 27이 그룹2의 관심 없는 사람 비율.
#-> p가 0.05보다 작으므로 귀무가설을 기각하고 대립가설 채택. 1번 집단이 2번 집단보다 관심도가 작을 것으로 가정.

  # 단측검정으로 1그룹과 2그룹중 뭐가 더 관심없는사람의 비율이 작은지를 확인.
  # p<0.05이므로 첫 번째 그룹인 1그룹이 2그룹보다 관심없는 사람의 비율이 작다.-
prop.test(c(13, 27), c(50,50), alter="less", conf.level=0.95)

museum<-read.csv("museum.csv", header=TRUE)
museum[c("group", "visit")]
table(museum$group)
table(museum$visit)
table(museum$group, museum$visit)

prop.table(table(museum$group, museum$visit))
round(prop.table(table(museum$group, museum$visit))*100, 0) # 그룹 1에 박물관 방문수가 전체 100중 30%, 그룹 2 중 박물관 방문수가 16%.

prop.test(c(30,16), c(100, 100))  # 그룹 1의 비율인 100분의 30이 그룹 2의 비율은 100분의 16과 차이가 날까?
#-> p값이 0.05보다 작으므로 차이가 있다. 얼마나 차이가 날까?

prop.test(c(30,16), c(100,100), alter="greater", conf.level=0.95)
#-> p값이 0.05보다 작으므로 그룹 1이 그룹 2보다 크다.

### 영업 사원 교육 효과 분석 : 대응표본 T-test 분석 ###
mymethod<-read.csv("mymethod.csv", header=TRUE)
mymethod$method
mymethod$performance

groupA<-subset(mymethod, method==1&performance<99)
groupB<-subset(mymethod, method==2&performance<99)
groupAcount<-length(groupA$method)
groupAmean<-round(mean(groupA$performance),2)
groupAcount;groupAmean
groupBcount<-length(groupB$method)
groupBmean<-round(mean(groupB$performance),2)
groupBcount;groupBmean

groupcount<-c(groupAcount, groupBcount)
groupmean<-c(groupAmean, groupBmean)
groupcount; groupmean
  # 교차분석표 출력
grouptable<-data.frame(Freq=groupcount, Mean=groupmean)
grouptable
  # 두 집단의 동질성 분석. p가 0.05보다 크므로 등분산 만족. -> T-test를 이용하여 두 집단 평균 비교.
  # 등분산 만족 안할땐 wilcox-test.
var.test(groupA$performance, groupB$performance)

t.test(groupA$performance, groupB$performance, alter="two.sided", conf.int=TRUE, conf.level=0.95)
  #-> p가 0.05보다 작으므로 A와 B 그룹의 퍼포먼스의 평균이 다르다. (양측검정)
t.test(groupA$performance, groupB$performance, alter="greater", conf.int=TRUE, conf.level=0.95)
  #-> p가 0.05보다 크므로 A의 퍼포먼스의 평균이 B의 퍼포먼스의 평균보다 크지 않다.
t.test(groupA$performance, groupB$performance, alter="less", conf.int=TRUE, conf.level=0.95)
  #-> p가 0.05보다 작으므로 A의 퍼포먼스의 평균이 B의 퍼포먼스의 평균보다 작다.

### 주/야간 학생들의 성적과 고등학교 종합 성적간의 관계 ###
daygrade<-read.csv("daygrade.csv", header=TRUE)
daygrade
  # 1번 주간, 2번 야간
is.na(daygrade)
  # 결측값이 없으므로 처리할 필요 없음.
day<-subset(daygrade, day==1)
day
night<-subset(daygrade, day==2)
night
dayCount<-length(day$day)
nightCount<-length(night$day)
dayCount; nightCount
dayMean<-round(mean(day$univ), 2)
nightMean<-round(mean(night$univ),2)
dayMean; nightMean
var.test(day$univ, night$univ, alter="two.sided", conf.int=TRUE, conf.level=0.95)
  #-> p가 0.05보다 크므로 등분산을 만족하고 그러므로 t-test 사용.
t.test(day$univ, night$univ, alter="greater", conf.int=TRUE, conf.level=0.95)
  #-> p가 0.05보다 작으므로 주간 대학생들이 야간 대학생들보다 학점 평균이 더 좋다.

#고등학교 성적은 어떨까?#
var.test(day$high, night$high, alter="two.sided", conf.int=TRUE, conf.level=0.95)
  #-> p가 0.05보다 작으므로 비등분산 -> 비모수 통계분석인 wilcox 사용.
wilcox.test(day$high, night$high, paired=TRUE)
  #-> p<0.05이므로 두 집단의 차이가 있다.

### 영화관 만족도 ###
satisf<-read.csv("satisf_theater.csv", header=TRUE)
satisf
satisFe$EnvMean<-round((satisFe$관람환경만족1 + satisFe$관람환경만족2 + satisFe$관람환경만족3)/3, 2)
satisMa$EnvMean<-round((satisMa$관람환경만족1 + satisMa$관람환경만족2 + satisMa$관람환경만족3)/3, 2)

satisf$EnvMean

satisFe<-subset(satisf, 성별==2)
satisMa<-subset(satisf, 성별==1)
satisFe;satisMa

var.test(satisFe$EnvMean, satisMa$EnvMean, alter="two.sided", conf.int=TRUE, conf.level=0.95)
t.test(satisFe$EnvMean, satisMa$EnvMean, alter="greater", conf.int=TRUE, conf.level=0.95)
  #-> p<0.05이니 여자의 평균이 더 크다.
  # Q. 그런데, 설문지의 환경 만족도에 관한 세 문항이 내부시설, 편안함, 쾌적함 세 가지로 나누어 물어보는데,
  # 서로 다른 세 질문을 합쳐서 평균을 내면 그게 전체 환경 만족도를 대표할 수 있을까?
  # 이 데이터의 경우, 만족 한다. 왜? 데이터 신뢰성 검정을 했을때 알파값이 0.6보다 크기 때문에 세 문항의 사람별 데이터가 같은 경향을 띔.
