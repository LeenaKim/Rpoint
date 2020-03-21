#################### R활용 빅데이터 분석 #######################
Sys.setlocale("LC_ALL", "korean")
# 모두 실행: shit+control+enter
# 한줄씩 실행: control+enter

### 제 2장. R Programming 기초 ###

### 제 1절. 변수 ###

A = 3
B = 3
A + B

# 진리값 
TRUE & TRUE
TRUE & FALSE
TRUE | TRUE
TRUE | FALSE
!TRUE
!FALSE

# 요인(Factor): 범주형 변수로 취급.
gender <- factor("f", c("m", "f"))  
    # gender에 m과 f라는 수준(levels)의 범주 중에서 f를 저장한다.
    # c(): 벡터를 표현하는 방식
gender

levels(gender)[1]
levels(gender)[2]
    # R에서 벡터의 색인값(index)은 1부터 시작.

gender
levels(gender) <- c("male", "female")
gender

# 명목형 변수의 level을 순서형 변수로 만들기
ordered(c("a", "b", "c", "d"))
    # 값이 순서가 있는 경우, 순서형 변수로 만들기 위해 ordered() 사용.
factor(c("a", "b", "c", "d"), ordered=TRUE)
    # factor() 호출시 ordered=TRUE로 지정해야 함.

#--------------------------------------------------------------------------------------------#

### 제 2절. 벡터 ###
# 01. 벡터란 무엇인가?

    # 벡터: 가장 기본적인 데이터 셋의 형태. 하나 이상의 문자, 숫자 등의 집합.
    # 벡터: character, numeric, integer, logical etc.
    # c(): 벡터를 만드는 함수. 같은 종류의 데이터 여러개를 묶어 벡터 형식으로.
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
x
x <- c("1", "2", "3")
x
c(1,2,3,4,5)
    # 벡터는 중첩되어 사용할 수 없음. 벡터 안의 벡터는 단일 차원의 벡터로 변경. 중첩된 구조가 필요하면 list 사용.
c(1,2,3,4,5,c(1,2,3,4,5))

# 시작값:끝값(start:end): 숫자형 데이터에만 사용하는 벡터 만드는 법.
x<-1:5  # 1부터 5까지의 정수 저장.
x
x<-2:4
x
    # seq(from, to, by)
seq(1,5,2)

    # seq_along(): () 안의 인자의 길이만큼 숫자로 벡터를 반환. 
seq_along(c("a", "b", "c", "d"))
    # seq_len(N): 1부터 N까지 정수 벡터 반환.
seq_len(4)

   #names(): () 벡터의 각 셀에 이름 붙이기
x<-c(1,3,5,7)
names(x)<-c("noh", "kim", "park", "baek")
x

# 02. 벡터 내에서 데이터 사용하기
  
x<-c("a", "b", "c", "d")
x[2]
x[4]
    # 음수 인덱스를 사용하여 특정 요소 제거
x[-3] # c 제거
    # x[c( , )]: 벡터의 여러 위치에 저장된 값 가져오기
x<-c("a", "b", "c", "d")
x[c(1,3)]
x[c(2,4)]
    # x[c( : )]: 범주로 특정 벡터 가져오는 다른 방법 (시작값:끝값)
x[c(1:3)]
x[c(1:4)]
    
    # NROW(), length(): 벡터의 길이 반환.
length(x)
NROW(x)
    # nrow(): 행렬(Matrix)에 사용하는 함수.
    # NROW(): 벡터를 n행 1열의 행렬로 취급.
nrow(x)
    
    # cf) 다른 타입의 element를 c() 벡터로 함께 만들려고 한다면 자동변환이 발생하여 하나의 타입으로 모두 바뀌게 됨. = 강제변환.

# 03. 벡터의 연산

    # %in%: 벡터에 포함되어 값이 무엇인지를 알려줄 때. ~가 있니?
"c"%in% c("a", "b", "c", "d")
"e"%in%x

    # setequal(): 두 집합을 비교할 때
x = 1:4 # 1부터 4까지 정수 저장.
y = c(1,3,5)
z = c(1,2,3,3,4)
    
setequal(x,z) # x = 1,2,3,4라서 z와 같기 때문에 True
setequal(y,z) # y와 z는 다르기 때문에 False

# 04. seq(): 연속된 값을 생성하는 함수.
    # seq(시작, 끝)
    # seq(시작, 끝, 증가하고자 하는 수)
seq(1,10)
seq(1, 10, 2)
1:10  #같은 결과.

# 05. rep(): 일정한 패턴들을 반복하여 벡터를 생성하는 함수.
    
rep(1:3, 5) # 1부터 3까지 다섯번 반복
rep(1:3, each = 3)  # 각각의 벡터 3번씩 반복
sequence(c(2,5,3))

#--------------------------------------------------------------------------------------------#

### 제 3절. 모드(mode) ###
# 01. mode의 종류
    # mode: R의 객체가 어떻게 메모리에 저장되었는지를 가리키는 것.
    # (1) 숫자형  :   c(), numeric(), integer(), factor(), ordered() etc
    # (2) 논리형  :   logical() etc
    # (3) 문자형  :   character() etc
    # (4) 복소수형  :   (a+bi)처럼 실수와 허수로 구성됨.

mode(3.1415)
mode(c(2.7182, 3.1415))
mode("big")
mode(list("big", "data"))

x=1:7; x
x<7
x>3
x>1 && x<7  # R에서 &&는 앞에거가 True이면 뒤에것 보지 않음.
x>1 | x<7   # 각 벡터 하나씩 T/F 보여줌.
x>1 || x<7  # 모든 벡터 기준.
x==5
x!=5
!x==5

# 02. mode의 확인: mode()
mode(pi); typeof(pi); storage.mode(pi)
mode(5>8)
mode(T); mode(TRUE); mode(FALSE)
mode(1+5i)

# 03. 특수한 형태의 값
    # (1) NA: 값이 없음. 손실된 값. 결측치. 결측치라는 하나의 요소.
one <- 100
two<-90
three<-80
four<-70
five<-NA
is.na(five) #five가 na니?

    # (2) NULL: 데이터의 값이 존재하지 않는다. NULL 객체라는 정의되지 않은 상태로 만들 떄. 객체를 의미.
x<-NULL
is.null(x)
is.null(y)
is.na(NULL)

# 04. 형의 변환
    # (1) 자동변환 : 논리형<수치형<복소수형<문자형 순으로 우선순위.
    # (2) 형 변환연산자
a=as.numeric("3.14159"); as.integer("3.14159")
as.integer(pi)
as.logical(1)
as.complex(4)
as.character(pi)

# 05. 형의 검증
    # (1) is: 형을 검증하고 일치하면 true, 일치하지 않으면 false 반환
is.numeric(pi);
is.double(pi);
is.integer(pi);
is.logical(T)
is.complex(4i)
is.character("abc")
is.function(pi)

    # (2) 데이터 구조 사용: R은 데이터 저장시 '객체' 사용.
typeof() # R객체의 type
mode() # R object mode
storage.type()

    # (3) R 객체 형태
    # vector, array, matrix
    # factor
    # Data frame
    # Function
    # List

#--------------------------------------------------------------------------------------------#

### 제 4절. 자료구조 ###
# 01. Array(배열): vector(벡터), matrix(행렬)
  # dim(): 배열 선언
  # dim()<-c(행의 수, 열의 수, 행렬 차원)
A <- 1:12
dim(A)<-c(2,3,2)
A
  # ncol: 열의 개수
matrix (1:20, ncol=5) # matrix: 차원 생성 불가능
array(1:20, dim=c(4,5)) # array: 차원 생성 가능

array(1:20, dim=c(4,4,3)) # 3차원 array
x<-array(1:20, dim=c(4,4,3))
x        

# 02. 배열의 생성 방법
    # (1) vector(벡터)
v <- c(10,20,30,40,50,60,70)
names(v)<-c("a","b","c","d","e","f","g")
v
v["c"] # 해당 원소 선택

    # (2) matrix(행렬)
    # dim() 설정을 하면 벡터에 차원이 주어지게 됨
A<-1:9
dim(A)
A
dim(A)<-c(3,3)  # 3 x 3의 2차원 행렬
A

B<-list(1,2,3,4,5,6,7,8,9)
dim(B)
dim(B)<-c(3,3)  # 리스트에서도 3 x 3의 2차원 행렬
B

C<-list(1,2,3,4,5,6,"a","b","c","d","e","f")  # 리스트는 다른 모드의 벡터 묶기 가능.
C
dim(C)<-c(3,4)
C

    # (3) List: 숫자, 문자 등 다양한 데이터 형태 들어갈 수 있음.
    # But, 층이 다르니까 서로 연산 불가능.
    # 리스트에서 인덱스는 대괄호 두 쌍. list[[5]]
    # 하위리스트: 대괄호 한 쌍. list[c(4,7)]
lst<-list(c(1,2), c(3,4), c(5,6), c(7,8))
lst
lst[["Moe"]] # 리스트에 이름 붙이기기

      # 리스트 생성
lst<-list(0.1,1,10,100,1000)
lst
lst<-list(12.345,"Sun", c(2,3), mean) # 리스트에서는 층이 모두 다르므로 mean이라는 연산 불가능.
lst
      # 원소에 이름붙이기
lst<-list(mid=0.52, right=0.723, far.right=0.999)
lst

      # 위치로 리스트의 원소 선택
      # 리스트는 인덱스 0부터 시작.
year <- list(1975, 1978, 1980, 2010, 2019)
year
year[[3]] # 하나의 원소 반환
year[c(2,5)]  # 해당 하위 리스트 반환

class(year[[3]]) # 원소의 타입
class(year[3]) # 리스트 타입

      # 리스트 구조를 벡터로 만들기
iq.score<-list(c(110, 130, 145, 160))
mean(iq.score) # iq.score는 숫자로만 구성이 된 리스트이기 때문에 평균을 바로 구할 수 없음.

mean(unlist(iq.score)) # unlist로 리스트 구조를 없애고 벡터로 만든 다음, 평균 구하기. 리스트에선 연산 사용 못하기 때문.

      # NULL 원소를 리스트에서 제거
lst<-list(NULL, 1,2,3,4,5)
lst
lst[sapply(lst, is.null)]<-NULL # sapply를 통해 NULL값 위치를 알아내고, 찾아낸 위치에 NULL을 대입
lst


# 03. 데이터 프레임
    # 데이터 프레임: 행렬과 달리 서로 다른 형태의 자료를 가질 수 있음.
a<-data.frame(x=c(1,3,5), y=c(2,4,6)) # x와 y라는 열을 가진 데이터프레임 생성
a

a<-data.frame(x=c(1,3,5), y=c(2,4,6), z=c("P","S","T")) # Z열 추가
a              

capital <- c("Seoul", "rome", "vienna", "bern")
values<-1:4
nal<-data.frame(capital, values)
nal
names(nal)  # 데이터 프레임에서 열의 이름 확인
names(nal)<-c("city", "rank") # 열 이름 바꿔주기
names(nal)

      # 데이터프레임에 열 추가.
      # 데이터 이름$변수이름 : 데이터에 변수 이름이라는 변수를 만들어라.
vec<-c("100", "95", "90", "85")
nal$ncol<-vec
nal
      # subset: 열 삭제
nal<-subset(nal, select=-ncol)
nal

      # 행과 열의 이름 확인
rownames(nal)
colnames(nal)


a1<-1:5
a2<-6:10
a1
a2
my1<-list(data1=a1, data2=a2) # 리스트 1층에 a1 데이터를 사용한 data1이라는 층, 2층에 a2 데이터를 사용한 data2라는 층 생성.
my1
data.frame(my1) # 데이터프레임화하면 리스트의 층 이름이 열 이름으로, 데이터가 열 별로 들어가게 됨.
mydata<-data.frame(my1)
rownames(mydata)
colnames(mydata)
rownames(mydata)<-c("one", "two", "three", "four", "five")
mydata

#################### 교수님 유인물 #######################

w<-c(1,2,3)
e<-c(4,5,6)

# rbind(a, b): a, b를 행 두개의 행렬로 합침
z=rbind(w,e)
z
# cbind(a, b): a, b를 열 두개의 행렬 합침
zz=cbind(w,e)
zz
# z의 첫번째 행 출력
z[1,]
# z의 두번째 열 출력
z[,2]
# z의 2행 3열에 해당하는 벡터 출력
z[2,3]
# z의 첫 번째 행 삭제
z[-1,]
zlist<-z[2,3]
zlist

a<-c(10,11,12)
b<-c(13,14,15)
ab<-rbind(a,b)
ab

#--------------------------------------------------------------------------------------------#

# x를 1부터 20으로 이루어진, 행이 4개인 행렬로 만들기
x<-matrix(1:20, nrow=4)
x
z
# apply: 배열 또는 행렬에 주어진 함수 적용 후 그 결과를 벡터, 배열 또는 리스트로 변환
# apply(쓰고자 하는 벡터값이 저장된 곳, 1 or 2, 함수)
# apply에서 1은 각 행마다의 평균, 2는 각 열마다의 평균
row<-apply(x, 1, mean)
row
col<-apply(x, 2, mean)
col

#--------------------------------------------------------------------------------------------#
# head(): 첫 6행만 출력
head(iris)
# tail(): 
tail(iris)
summary(iris)
order(iris$Sepal.Length)
sort(iris$Sepal.Length)
tem<-iris[order(iris$Sepal.Width),] 
# Sepal.Width를 오름차순으로 정렬하고, 같은 숫자가 있을경우 +
# Sepal.Width 다음에 오는 열(Petal.Length)로 정렬 후 iris data frame을 tem에 저장.
# 복수 정렬시 order(a, b,) : a로 먼저 정렬하고, 같은 숫자가 있을시 b를 기준으로 정렬해라.
head(tem)

#--------------------------------------------------------------------------------------------#

score<-data.frame(name=c("Seoul", "Busan", "Daegu", "Kwangju"), population=c(1500, 200, 150, 70))
score

score2<-data.frame(name=c("Kwangju","Daegu","Seoul", "Busan" ), HighTemp=c(35, 40, 32, 29))
score2
# 두 데이터프레임 합치기
merge(score, score2)

#--------------------------------------------------------------------------------------------#
# with{}: {} 안의 명령은 데이터를 따로 서술 안함
# 그래서 {} 안에서 iris$Sepal.Width 이렇게 iris를 굳이 다 안붙여줘도 됨.
with (iris,
      {
        print("Max of Sepal.Width\n")
        print(max(Sepal.Width))
        print("Min of Sepal.Width\n")
        print(min(Sepal.Width))
        })
# which.min: 배열 안에 가장 작은 값을 반환
which.min(iris$Sepal.Length)
# which.max: 배열 안에 가장 큰 값을 반환
which.max(iris$Sepal.Length)
# aggregate(대상변수~기준변수, 데이터, 함수): 기준변수를 중심으로 다양한 데이터를 통합 계산
aggregate(Sepal.Width~Species, iris, mean)  # Species가 기준변수니까 종을 기준으로 Sepal.Width 변수의 평군을 구해라
aggregate(Sepal.Width~Species, iris, max) # Species 기준으로 Sepal.Width 변수의 최댓값을 구해라

data(iris)

#============================================================================================#

#################### R활용 빅데이터 분석 #######################

### 제 3장. 기초 통계 ###

# 제 1절. summary 함수
    # summary(): 데이터의 요약된 통계 정보(벡터, 행렬, 요인, 데이터 프레임 등에 대한 유용한 통계량)을 보여줌.
    # lapply(): 리스트 요약
summary(iris)
lapply(as.list(iris), summary)

#--------------------------------------------------------------------------------------------#

# 제 2절. 독립성 검정(범주형 변수)
    # 두 개의 범주형 변수의 독립성 검정: 카이제곱 검정.
    # 1. table() 함수로 분할표 생성 2. summary() 함수로 카이제곱 검정
    # iris에 Species2라는 변수를 만들어라. Species는 1에서 5까지의 정수를 150번 뽑을 수 있고, 중복 허용.
iris$Species2<-as.factor(sample(1:5, 150, replace = TRUE))  # replace: 뽑은 공을 다시 넣어서 그걸 포함해서 다시 뽑겠다
str(iris)
    # 원래 있던 Species와 내가 만든 Species2의 독립성 비교
summary(table(iris$Species, iris$Species2)) # 피밸류가 0.8322로 0.05보다 크기 때문에 해당 변수들은 서로 독립적이다.

#--------------------------------------------------------------------------------------------#

# 제 3절. 정규화(Z점수)
    # scale(): 모든 데이터의 원소에 상응하는 z점수 구하기
scale(iris$Sepal.Length)
    # 결과값의 마지막 center가 평균, scale은 표준편차를 나타냄.

    # 특정값을 정규화 하고싶을 때 벡터화된 연산 사용
(3.8 - mean(iris$Sepal.Length))/sd(iris$Sepal.Length)
  
#--------------------------------------------------------------------------------------------#

# 제 4절. t 검정(한 집단 모평균검정)  
    # rnorm(n, mean, sd): 정규분포를 따르는 숫자를 임의로 생성하는 함수
x<-rnorm(40, mean = 95, sd = 10)  # 평균이 95, 표준편차가 10인 수를 무작위로 40개 뽑기
    # t.test(관측치, alternative=판별방향, mu=특정기준, conf.level=신뢰수준)
t.test(x, mu=90)  # x의 모집단의 평균이 90인지 검정
    # => p값이 0.05 미만이므로 평균이 90이라는 가설은 기각.
    # 당연히 기각인게, x를 만들때부터 평균을 95로 해서 90일수가 없음.

#--------------------------------------------------------------------------------------------#

# 제 5절. 신뢰구간
x <- rnorm(40, mean=95, se=10)
t.test(x) 

    # 모평균의 신뢰도가 0.99%를 만족하냐를 검증
t.test(x, conf.level=0.99)  # p값이 거의 0으로 수렴하므로 0.99%를 만족한다.

  # 함수
rnorm (100, 0, 10)  # 평균 0, 표준편차 10인 정규분포로부터 100개의 난수 생성
    # density: 밀도 측정 함수
plot (density (rnorm (1000000,0,10)))
    # dpois: 각각의 확률이 얼마나 뭉쳐있나
dpois (3,1)
(1^3*exp(-1))/(factorial(3))
pnorm(0)
qnorm(0.5)

mean(1:5)
var(1:5)
sum((1:5 - mean (1:5))^2)/(5-1)

    # 통계 다섯수치 요약 (중앙값, 최댓값, 최솟값, 1사분위수, 3사분위수)
fivenum(1:10)
summary(1:11)
fivenum(1:4)
summary(1:10)
