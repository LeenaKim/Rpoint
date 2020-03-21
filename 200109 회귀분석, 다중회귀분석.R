### 회귀분석과 다중공선성 ###
# 단순회귀분석 #
sales<-read.csv("sales.csv", header=TRUE)
sales.lm<-lm(sales~rd, data=sales)
summary(sales.lm)
plot(sales~rd, data=sales)
abline(sales.lm)

# 다중회귀분석 #
sales.lm2<-lm(profit~rd+ad+promotion, data=sales)
summary(sales.lm2)

install.packages("car")
library(car)
# 독립변수들간 다중공선성을 보기 위해 vif 사용.
vif(sales.lm2)
#-> rd와 promotion의 계수가 10보다 크므로 둘 중 하나 빼야함.

sales.lm3<-lm(profit~promotion+ad, data=sales)
vif(sales.lm3)
#-> rd를 빼고 다중공선성을 보니 모두 2.xx로 작아짐.
summary(sales.lm3)
#-> rd 빼고 다시 다중회귀분석 기술통계량을 보니 R스퀘어 설명값이 좀 더 줄으며 설명력이 떨어졌다.

### 고객 이탈 여부 예측 분석 ###
result<-read.csv("mytelecom.csv", header=TRUE)

# 다중회귀분석 : 연속형 변수끼리만 가능함.
result2<-lm(churn~tenure+income+age, data=result)
result2
summary(result2) # 이 모델의 전체에 대한 설명력이 14%정도다. (R스퀘어)


### grape 회귀분석 ###
grape<-read.csv("grape.csv", header=TRUE)
grape.lm<-lm(price~size+period, data=grape)
vif(grape.lm)
summary(grape.lm)
#-> p<0.05이여서 size와 period가 포도의 값에 영향을 미치고, 설명력도 88%로 높다. 
# size와 period 모두 클수록 가격이 높아진다.

