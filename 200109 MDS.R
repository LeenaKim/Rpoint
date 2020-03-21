### 의사결정나무 ###
install.packages("party")
library(party)
result<-read.csv("myhuman.csv", header=TRUE)
set.seed(1234)# set.seed: 난수 발생할때 고정시키기 위해
resultsplit<-sample(2,nrow(result), replace=TRUE, prob=c(0.7, 0.3))# result를 1과 2라는 두 가지 정수로 result의 행의 갯수를 기준으로 0.7과 0.3의 확률로 각각 1과 2를 부여함. 
# 공을 다시 뽑을떄 뺐던 공을 다시 넣고 뽑기 때문에 replace=TRUE.
resultsplit

trainD<-result[resultsplit==1,]
# resultsplit이 1인 result데이터의 값을 trainD에 저장.
trainD

testD<-result[resultsplit==2,]
# resultsplit이 2인 result데이터의 값을 testD에 저장.
# => 보통 계층트리 만들 것 70%, 후에 테스트하며 결과를 비교할 30%정도를 남겨놓음.
testD
rawD<-Group~Sociability+Rating+Career+Score
#rawD: 식이 저장되고, 그 식을 ctree에 적용.
trainModel<-ctree(rawD, data=trainD)

table(predict(trainModel), trainD$Group)

print(trainModel)
plot(trainModel)
plot(trainModel, type="simple")

testModel<-predict(trainModel, newdata=testD)
table(testModel, testD$Group)



### 패키지 추천 상품의 연관성 분석 (장바구니 분석) ###
install.packages("arules")
library(arules)
# 준비된 파일에서 콤마 단위로 저장되어있는 데이터를 읽어 들여 result라는 객체에 저장
result<-read.transactions("mybasket.csv", format="basket", sep=",")
result
summary(result)
# result에 들어있는 개괄적인 데이터 현황을 플로팅을 통한 그림 형태로 보여줌.
image(result)

# 알고리즘 적용
# result에 들어있는 데이터를 테이블구조로 변환시킴.
as(result, "data.frame")
# result에 들어있는 데이터를 가지고 apriori 알고리즘을 적용한 결과를 rules라는 객체에 저장.
# - supp: 지지도로, X아이템 발생 트랜잭션이 전체 트랜잭션 수에서 차지하는 비율
# - conf: 신뢰도로, X아이템이 발생할 때 동시에 Y아이템이 발생할 확률
rules<-apriori(result, parameter=list(supp=0.3, conf=0.1))
# rules에 들어있는 apriori 알고리즘 적용결과에서 도출된 127개의 연관규칙을 세부적으로 보여줌.
# - lhs: left-hand side로, 조건(X아이템)을, rhs는 right-hand side로 결과(Y아이템)를 의미한다.
# - lift: 개선도(향상도)로, Y아이템이 단독으로 발생하는 것에 비해 X아이템과 연계하여 발생할 가능성의 상대적 비율을 의미.
inspect(rules)
# supp값 0.1 상황에서 127개 연관규칙이 도출됨.
rules<-apriori(result, parameter=list(supp=0.1, conf=0.1))
# 가장 발생확률이 높은 아이템: 의류(0.49)
# 가장 발생확률이 낮은 아이템: 우유(0.18)
inspect(rules)

# 시각화 #
install.packages("arulesViz")
library(arulesViz)
plot(rules)
plot(rules, method="grouped")
plot(rules, method="graph", control=list(type="items"))


### 음료들의 유사성 분석; 다차원 척도 분석(MDS) ###
install.packages("XLConnect")
library(XLConnect)
mystudy<-loadWorkbook("mystudy.xlsx", creat=TRUE)
# mystudy 파일 내 mydrink 시트에서 첫 행부터 시작하여 첫번째 열부터 세번째 열까지의 데이터를 불러와 mydrink0에 저장.
mydrink0<-readWorksheet(mystudy, sheet="mydrink", startRow=1, startCol=1, endRow=11, endCol=3)
mydrink0

a1<-mydrink0$d1
a2<-mydrink0$d2
a3<-mydrink0$d3

z1<-mean(a1)
z2<-mean(a2)
z3<-mean(a3)
z1; z2; z3

mystudy<-loadWorkbook("mystudy.xlsx", creat=TRUE)
# mystudy 파일 내 mydrink 시트에서 14번쨰 행에서 시작해서  첫번째 열부터 세번째 열까지의 데이터를 불러와 mydrink0에 저장.
mydrink<-readWorksheet(mystudy, sheet="mydrink", startRow=14, startCol=1, endCol=4)
mydrink

# 첫번째 열 삭제 [행, 열]
mydrink2<-mydrink[,-1]
mydrink2
# 유사성의 정도를 행렬 형식으로 보여준다.
fitdrink<-cmdscale(mydrink2, eig=TRUE, k=2)
fitdrink
# fitdrinnk의 points 항목 첫 번쨰 열을 x로 지정
x<-fitdrink$points[,1]
# fitdrink의 points 항목 두 번째 열을 y로 지정
y<-fitdrink$points[,2]

plot(x, y, pch=19, xlim=c(-4, 4), ylim=c(-2,2))
mydrinknames=c("콜라", "포카리", "게토레이")
text(x, y, pos=3, labels=mydrinknames)
abline(h=0, v=0)