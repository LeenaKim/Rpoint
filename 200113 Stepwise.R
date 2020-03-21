### Stepwise regression analysis: 종속변수에 영향을 주는 많은 독립변수 중에서 회귀모형에 사용할 변수를 축소하거나 선택하거나 제거하여 가장 좋은 회귀모형을 선택.
# 독립변수가 너무 많아서 다 넣어볼 수 없을때 하는 분석 방법. 단계별로 내가 필요한것들을 해보고 이게 좋은지 저게 좋은지. 
# glm(Status~, data=colon1) 처럼, 독립변수를 안써주면 스텝와이즈 실행하여 전진, 후진, both 각각 실행.
# AIC값이 낮을수록 가장 최적화된 모델.
# 1. 전진선택법 : 반응변수와 상관관계가 가장 큰 설명변수부터 선택
# 2. 후진제거법 : 완전모형에서 설명력이 작은 변수부터 하나씩 제거
# 3. 단계적 선택법 : 전진선택법의 각 단계의 선택된 변수들의 중요도를 다시 검사하여 변수를 제거

library(survival)
attach(colon)
data(colon)

f.model=glm(status~., data=colon)

r.model1=step(f.model, direction="backward") # 전체 독립변수 쫙 분석하고 설명력 적은 변수를 하나씩 자동으로 빼봄.
r.model2=step(f.model, direction="forward") # 처음부터 설명력 큰 변수를 선택하여 보여줌.
r.model3=step(f.model, direction="both")

mol1<-glm(status~ study+rx+sex+age+obstruct+perfor+adhere+nodes+differ+extent+surg+node4, family=binomial, data=colon)
mol2<-glm(status~ age+obstruct+adhere+nodes+differ+surg, family=binomial, data=colon)
summary(mol1)
summary(mol2)

AIC(mol1, mol2)


