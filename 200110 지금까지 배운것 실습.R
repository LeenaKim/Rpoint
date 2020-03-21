### <상관관계 분석 연습문제> R.point p.150 ###
#2.
getwd()
setwd("C:/Users/user/Desktop/Leena Kim/R/data(f)")
student<-read.csv("student.csv", header=TRUE)
str(student)
head(student)
is.na(student)

cor(student)

#################################################

spmall<-read.csv("spmall.csv", header=TRUE)
# 독립성, 적합성, 두집단, 세집단 비율검정, 단일집단 평균 분석(mu), 쿠폰유형별 구매금액 차이가 있는지,  t.test, anova
is.na(spmall)
# [적합성 검정]
chisq.test(spmall$choose)
  # p>0.05 => 차이가 없다.
chisq.test(spmall$discnt)
  # p>0.05 => 차이가 없다.
chisq.test(spmall$coupon)
  # p<0.05 => 쿠폰 사용 여부에 따른 차이가 있다.
chisq.test(spmall$coupon2)
  # p<0.05 => new 프로모션 사용 여부에 따른 차이가 있다.

#-----------------------------------------------------------#

# [독립성 검정]
table(spmall$discnt2, spmall$coupon2)
chisq.test(spmall$discnt2, spmall$coupon2)
  # p<0.05 => 새로운 프로모션 쿠폰 종류에 따라 new 프로모션 사용여부간 차이가 있다.
table(spmall$discnt, spmall$coupon)
chisq.test(spmall$discnt, spmall$coupon)
  # p<0.05 => 할인쿠폰 종류별 쿠폰 사용 여부간 차이가 있다.

#-----------------------------------------------------------#

# [세집단 비율검정]
prop.table(table(spmall$discnt2, spmall$coupon2))
round(prop.table(table(spmall$discnt2, spmall$coupon2))*100,1)
prop.test(c(17.7,36.4,16.3 ), c(100,100,100))
  # p<0.05 이므로 세 집단간 차이가 있다.
  # prop.test에서는 세 집단 양측검정밖에 못한다. 

#-----------------------------------------------------------#

# [단일집단 평균 분석(mu)] #
  # couamt: 쿠폰이 없는 사람은 999라는 결측값으로 입력됬으므로 이들을 빼줘야 제대로 된 평균이 나옴.
  # 1. 전체에서 couamt에 999가 입력된 모든 행을 삭제하거나,
  # 2. 분석 할 때마다 변수에서 빼주거나.
  # 1번 방법: na.omit(couamt)
  # 2번 방법:
couamt2<-subset(spmall, couamt<999)
t.test(couamt2, mu=5.0)
  # p<0.05 => 쿠폰 구매금액의 평균이 5만원이 아니다.
t.test(couamt2, mu=5.0, alter="greater")
  # p<0.05 => 쿠폰 구매금액의 평균이 5만원보다 크다.
t.test(spmall$usuamt, mu=4.0)
  # p<0.05 => 총 구매금액이 4만원이 아니다.
t.test(spmall$usuamt, mu=5.0, alter="greater")
  # p<0.05 => 총 구매금액이 5만원보다 크다.

#-----------------------------------------------------------#

# [쿠폰 유형별 총 구매 금액에 차이가 있는가?] => t.test
discnt11<-subset(spmall, discnt==1)
discnt22<-subset(spmall, discnt==2)

t.test(discnt11$totamt, discnt22$totamt, alter="two.sided", conf.level = 0.95)
  # p<0.05 => 할인쿠폰 종류별 총 구매금액의 평균에 차이가 있다.
t.test(discnt11$totamt, discnt22$totamt, alter="greater", conf.level = 0.95)
  # p<0.05 => 할인쿠폰 1을 받은 사람의 총 구매금액이 더 높다.

#-----------------------------------------------------------#

# [새로운 프로모션 쿠폰 세 종류간 프로모션 구매 금액의 차이가 있는가?] => ANOVA
  ## 결측값 없애기
library(dplyr)
spmall$couamt2<-ifelse(spmall$couamt2==999, NA, spmall$couamt2)
  ## [정규성 검정]
tapply(spmall$couamt2, spmall$discnt2,shapiro.test)
  # cf) tapply는 영향을 받는걸 첫 번째에, 구분을 짓는걸 두 번째에.
  # 둘 다 p<0.05라 정규성 만족 안하지만, 표본이 30개 이상이면 대부분 그냥 아노바 돌림.

  ## [등분산성 검정]
bartlett.test(spmall$couamt2, spmall$discnt2, data=spmall)
  # p>0.05 => 등분산성 만족.

  ## [아노바]
spmall.lm<-lm(couamt2 ~ discnt2, data=spmall)
anova(spmall.lm)
  # p<0.05 => 프로모션 쿠폰 세 개 간 사용 금액에 차이가 있다.
  
  ## [사후검정]
  # TukeyHSD는 lm이 아니라 aov로 아노바검정을 했을때만 사용 가능.
  # lm일땐 bonferroni 사용.
library(agricolae)
model<-aov(couamt2~discnt2, spmall)
comparison<-LSD.test(model, "discnt2", p.adj="bonferroni", group=T)
comparison
  # 3번 프로모션 쿠폰을 받은 사람의 사용 금액이 8.3으로 가장 높았고, 1번 프로모션 쿠폰을 받은 사람이 3.97로 가장 낮았다.

  # [1과 3번 쿠폰간의 T.Test]
discnt1<-subset(spmall, discnt==1)
discnt2<-subset(spmall, discnt==2)

t.test(discnt1$totamt, discnt2$totamt, alter="two.sided", conf.level = 0.95)
