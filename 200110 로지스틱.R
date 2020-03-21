
library(survival)
attach(colon)
data(colon)
str(colon)
colon1<-na.omit(colon)
# factor: 내가 보고싶은 범주에 속하는지, 아닌지를 1과 0으로 나눔.
# factor: factor화 하고자 하는 범주가 두개 초과할땐 transform 으로 ifelse를 써줌.
# factor(sex)의 경우 남자인 경우 1, 남자가 아닌경우 0으로 수치화해줌.
# sex의 형식이 numeric이기 때문에 factor로 바꿔주는 것이고, rx는 factor화 하지 않아도 범주별로 나눠서 나오는 이유는 rx 자체가 이미 factor 형이기 때문.
# family=binominal: 종속변수가 두가지 범주를 가질 때 사용. 이항분포형식으로 status를 두 범주로 본다.
# glm: 로그화. 로지스틱 분석의 종속변수의 범주 사이의 곡선을 보기 위해 로그를 씌우고 odd 등의 수학적 계산법을 이용해 회귀계수와 p값을 보여줌.
result1<-glm(status~rx+factor(sex)+age+obstruct+perfor+adhere+nodes+differ+extent+surg,
             family=binominal, data=colon1)
summary(result1)
# exp: 지수화. 원래 로그 씌우기 전의 독립변수의 회귀계수 확인용. glm보다 회귀계수가 커짐.
# OR이 glm 한 값의 상관계수(coef)와 신뢰계수(? confint)를 사용하여 계산한 원래 독립변수의 회귀계수값.
exp(cbind(OR=coef(result1), confint(result1)))
# 보통 glm을 통해 p값이 유의한 독립변수가 무엇인지 확인하고, exp를 통해 해당 독립변수가 종속변수에 미치는 정도를 회귀계수를 통해 알아냄.

View(result1)
colon$age

# 기준치 설정

library(car) # recode는 car에 들어있음.
colon$age_dummy<-recode(colon$age, "lo:19=10; 20:29=20; 30:39=30; 40:49=40; 50:59=50; 60:hi=60")

# 더미변수 #
cosmetics<-read.csv("cosmetics.csv", header=TRUE)

cosmetics$repurchase_re<-recode(cosmetics$repurchase, "lo:3=0; 4:hi=1; else='NA'")
logit.model<-glm(repurchase_re~factor(propensity)+factor(decision)+satisf_al, family=binomial, data=cosmetics)
summary(logit.model)
