### 분산분석 (ANOVA) ###
jobedu<-read.csv("jobedu.csv", header=TRUE)
# ANOVA는 정규성, 독립성, 등분산성을 모두 만족해야 사용 가능.
# 1. 정규성 검증
tapply(jobedu$performance, jobedu$method, shapiro.test)
#-> p<0.05이므로 정규성을 만족하지 않음. 과연 그럴까? 결측값 확인해보기.
install.packages("dplyr")
library(dplyr)

is.na(jobedu)
table(is.na(jobedu$performance))
#-> 결측값이 없네? 좀 더 정확히 찾아보기 위해 결측값을 99로 설정하고 다시 봐보자.
jobedu$performance<-ifelse(jobedu$performance==99, NA, jobedu$performance)
is.na(jobedu)
#-> 이렇게 하니 결측값이 10개 나옴.
table(is.na(jobedu$performance))
jobedu2<-jobedu %>% filter(!is.na(performance))
# 필터로 결측값 제거해라.

tapply(jobedu2$performance, jobedu2$method, shapiro.test)
# 새로 만든 결측값 제거한 변수로 다시 샤피로 테스트 돌려보자. p>0.05라 정규성 만족 하네?

# 2. 등분산성 검정
bartlett.test(jobedu2$performance, jobedu2$method, data=jobedu2)  # p>0.05
var.test(jobedu2$performance, jobedu2$method, data=jobedu2) # p<0.05
# var.test는 샘플이 500개 미만일 때. bartlett은 샘플이 그 이상일 때 쓰지만,
# 대부분 아노바에선 집단이 세개 이상이기 때문에 var.test보단 bartlett을 씀.
# bartlett.test 결과 p>0.05이므로 등분산을 만족한다.
# 등분산과 정규성을 만족하므로 => ANOVA 를 쓸 수 있다.

# 3. 아노바
jobedu.lm<-lm(performance~method, data=jobedu2)
anova(jobedu.lm)  # 회귀식처럼 돌리는 anova 방법.
# p<0.05이므로 method가 1, 2, 3일때 각 performance가 평균이 차이가 남. 하지만 어떻게 나는지는 모름. 이 때 사후검정!
install.packages("agricolae")
library(agricolae)
model<-aov(performance~method, jobedu2)
comparison<-LSD.test(model, "method", p.adj="bonferroni", group=T)
comparison
# bonferroni의 단점은 turkey와 다르게 a-b, b-c, a-c간 각각의 p값을 보여주지 않는다는 것.
# 하지만 performance 평균의 차가 a-c 가 가장 크기 때문에 후에 a와 c로 t.test 하면 됨.
# => a,b,c간 차이가 있다.
method1<-subset(jobedu2, method==1)
method2<-subset(jobedu2, method==2)
method3<-subset(jobedu2, method==3)

t.test(method1$performance, method3$performance, alter="less", conf.int=TRUE, conf.level=0.95)
# p<0.05이므로 method1의 performance 평균이 method3의 performance 평균보다 작다.  