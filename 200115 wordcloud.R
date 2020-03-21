### 텍스트 마이닝 ###
## 1절. 텍스트마이닝 ##
## 01. 시작 ##

#(1) 데이터 준비

install.packages("tm")
library(tm)

setwd("C:/R Leena/data(f)")

txt<-system.file("texts", package="tm")
txt

#(2) getReaders()
getReaders()
  # txt 파일을 UTF-8로 인코딩 하고, 언어는 영어로 Corpus 형식으로 korea라는 변수에 지정.
korea<-Corpus(DirSource(txt, encoding="UTF-8"), readerControl=list(language="en"))
korea
  # cf) UTF-8로 인코딩하면 한글 사용시 한글 텍스트마이닝이 가능함.
  # cf) corpus: tm에서 문서를 관리하는 기본구조. 문장을 가져와서 묶는.

#(3) korea[[1]] : 2개의 문서 중 첫 번째 문서를 출력
korea[[1]]

  # 벡터 소스로 읽어들이기
korea<-VCorpus(VectorSource(korea))

#----------------------------------------------------------------------------------------------------#

## 02. 데이터 정제 ##
  # tm_map() : 텍스트 파일 내 공백, 숫자, 구두점, 특수기호, 대소문자 구별 등 요인 제거 

korea<-tm_map(korea, stripWhitespace)
korea[[1]]  # content가 정제되어 452개에서 412로 바뀜.
  # tolower 옵션: 대문자를 소문자로
korea<-tm_map(korea, tolower)
korea[[1]]

  # removeWords, stopwords: korea 변수에 저장된 데이터의 stopword를 제거함.
korea<-tm_map(korea, removeWords, stopwords("english"))
korea[[1]]

  # removePunctuation: 글 안의 구두점 제거
korea<-tm_map(korea, removePunctuation)
korea[[1]]

  # removeNumbers: 숫자 제거
korea<-tm_map(korea, removeNumbers)
korea[[1]]

  # SnowballC: 동적인 언어(어근)만을 추출해주는 패키지
install.packages("SnowballC")
library(SnowballC)

  # stemDocument: 어근만 추출 (단어중 실질적 의미를 나타내는 중심이 되는 부분)
korea<-tm_map(korea, stemDocument)
korea[[1]]

#----------------------------------------------------------------------------------------------------#

## 03. TermDocumentMatrix
  # : 문서번호와 단어간의 사용여부 또는 빈도수를 이용하여 matrix를 만들기
  
  # PlainTextDocument: korea변수를 PlainTextDocument로 변환
korea<-tm_map(korea, PlainTextDocument)
korea[[1]]

  # korea 변수를 matrix로 변환하여 kdtm 변수에 저장
kdtm<-DocumentTermMatrix(korea)
kdtm

  # findFreqTerms(변수, 횟수 범위~횟수 범위)
findFreqTerms(kdtm, 10)

#----------------------------------------------------------------------------------------------------#

## 04. Wordcloud(시각화하기)
  # Term document matrix를 작성하는데 단어의 최소 길이는 1에서 최대는 무한대로 mykdtm이라는 변수에 저장
mykdtm<-TermDocumentMatrix(korea, control=list(wordLength=c(1, Inf)))

install.packages("wordcloud")
library(wordcloud)

  # mykdtm 변수를 matrix 형태로 변환하여 w변수에 지정
w<-as.matrix(mykdtm)

  # w 변수에 포함된 텍스트들을 내림차순으로 정렬하여 wordFreq에 저장
wordFreq<-sort(rowSums(w), decreasing=TRUE)

  # 빈도수가 높은 것을 순서로 회색의 찐함정도를 설정한 것을 grayLevels에 저장
grayLevels<-gray((wordFreq+0)/max(wordFreq)+0)

  # 워드클라우드 출력
wordcloud(words=names(wordFreq), freq=wordFreq, min.freq=3, random.order=F, random.color=T)

#====================================================================================================#

## 2절. 워드클라우드 ##
  # KoNLP: 한글로 이뤄진 텍스트를 R을 사용하여 텍스트 마이닝 하는 패키지.
  # RColorBrewer: 시각화할 때의 색 관리를 더해주는 패키지.
install.packages("KoNLP")
install.packages("wordcloud")
library(KoNLP)
library(wordcloud)

useSejongDic() # 한글사전 등록 (KoNLP 패키지 안에 있는 기능)
install.packages("bit")

mergeUserDic(data.frame("빅데이터", "ncn")) # 사전에 빅데이터라는 명사가 들어있지 않기 때문에 위와 같이 수동으로 추가.

txt<-file("bigdata.txt", encoding="UTF-8")
text<-readLines(txt)  # 한줄씩 읽기
close(txt)
text
big<-sapply(text, extractNoun, USE.NAMES=F) # 읽은 텍스트중에서 단어별로 자르기
big

  # extractNoun: 주어진 데이터에서 명사만 골라주는 역할. text파일에서 공백을 기준으로 조사해서 명사만 찾아 big변수에 다시 저장.
head(unlist(big), 30) # big의 명사들에서 30개만 출력하라
f<-unlist(big)

  # 필터링을 위해 unlist 작업(리스트를 벡터로 변환)을 하여 'f' 변수에 저장.
big<-Filter(function(x) {nchar(x)>=3}, f)

#----------------------------------------------------------------------------------------------------#

# (2) 세 글자 이상 되는 것만 필터링하여 big 변수에 저장한다.
  # gsub("변경전 글자", "변경후 글자", 원본데이터의 변수명): big 변수 출력할 때 원하지 않는 단어나 내용 걸러내기
big <- gsub("같은경우는", "", big)
big <- gsub("어느정도", "", big)
big <- gsub("우리나라", "", big)
big <- gsub("찌르는거", "", big)
big <- gsub("생각들어보고싶습니다", "", big)
big <- gsub("그자체로", "", big)
big <- gsub("어마어마", "", big)
big <- gsub("하여", "", big)
big <- gsub("것들이", "", big)
big <- gsub("관심을받", "", big)
big <- gsub("다양한분석기술들도", "", big)
big <- gsub("을", "", big)
big <- gsub("에서", "", big)
big <- gsub("28기가바이트밖에", "", big)
big <- gsub("난감'한", "", big)
big <- gsub("어려워질경우", "", big)
big <- gsub("그러한정보를", "", big)
big <- gsub("어느곳보다", "", big)
big <- gsub("같은데요", "", big)
big <- gsub("여러분들이", "", big)
big <- gsub("잘알고", "", big)
big <- gsub("잘된곳이", "", big)
big <- gsub("있는곳을", "", big)
big <- gsub("안녕하세요~세상을바꾼퓨터천재입니다", "", big)
big <- gsub("B간단히", "", big)
big <- gsub("무엇인지좀", "", big)
big <- gsub("잘봤구요", "", big)
big <- gsub("아직에서는", "", big)
big <- gsub("이라는", "", big)
big <- gsub("사용하는곳이", "", big)
big <- gsub("꼭필요한", "", big)
big <- gsub("하실려면", "", big)
big <- gsub("이라는", "", big)
big <- gsub("카톡으로", "", big)
big <- gsub("가능할꺼같습니다", "", big)
big <- gsub("이다", "", big)
big <- gsub("대략", "", big)
big <- gsub("대략적", "", big)
big <- gsub("으로", "", big)
big <- gsub("너저분", "", big)
big <- gsub(" ", "", big)
  #=> 3글자 이상의 명사만 추출, 필요없는 내요요 제거 후 big 변수들에 지정된 텍스트들만 남음.

  # 파일로 저장
write(unlist(big), "bigdata_2.txt")
  # 테이블 형식으로 변환 후 파일 읽기
re<-read.table("bigdata_2.txt")
  # 행의 갯수는?
nrow(re)
  # re 변수에 데이터가 몇건인가?
textcount<-table(re)
  # 빈도수가 많은 순으로 텍스트를 정렬하여 상위 30개 추출
head(sort(textcount, decreasing=T), 30)

#----------------------------------------------------------------------------------------------------#

## (3) 글자 색상 지정하기
library(RColorBrewer)
palete<-brewer.pal(9, "Set1")

#----------------------------------------------------------------------------------------------------#

## (4) 워드클라우드 그리기
library(wordcloud)
wordcloud(names(textcount), freq=textcount, scale=c(5,1), rot.per=0.25, min.freq=3, random.order=F, random.color=T, colors=palete)
  # min.freq=1 : "한 번 이상 쓰인 단어들을 그림에 나타내줘!!!"

#====================================================================================================#

### 오바마 연설 워드클라우드 만들기 ###

obama<-file("obama.txt", encoding="UTF-8")
speech<-readLines(obama)
close(obama)  # 항상 txt 파일을 닫아야 다음에 열때 변경사항이 저장됨.
head(speech, 5)
tail(speech, 5)


## 03. 단어추출 ##
pword<-sapply(speech, extractNoun, USE.NAMES=F) # extractNoun을 사용하여 speech 변수의 명사들을 저장
pword

text<-unlist(pword) # 리스트를 벡터화해서 text 변수에 저장
head(text, 20)

## 04. 단어추출(조건지정) ##
  # text2에 Filter 함수를 사용하여 text 변수의 내용 중 두글자 이상 단어들만 저장.
text2<-Filter(function(x) {nchar(x)<=2}, text)
head(text2, 20)
  # text3에 세 글자 단어들만 저장
text3<-Filter(function(x) {nchar(x)<=3}, text)
head(text3, 20)
  # text4에 두 글자 이상 네글자 이하인 단어들만 저장
text4<-Filter(function(x) {nchar(x)>=2 & nchar(x)<=4}, text)
head(text4, 20)

## 05. 단어추출(정제)
text2 <- gsub("저", "", text2)
text2 <- gsub("한", "", text2)
text2 <- gsub("들이", "", text2)
text2 <- gsub("앞", "", text2)
text2 <- gsub("한", "", text2)
text2 <- gsub("분", "", text2)
text2 <- gsub("\\n", "", text2)
text2 <- gsub("\\d+", "", text2)
text2 <- gsub("\\.", "", text2)
  # \\n: 새로운 라인
  # \\d+: 한 번 이상의 숫자 (0~9)
  # \\.: \N 또는 줄 끝 문자를 제외한 모든 문자

write(unlist(text2), "mytext.txt")  # 새로운 파일로 저장
myword<-read.table("mytext.txt")  # 그 파일을 읽기
nrow(myword)  # 행이 몇개인지

wordcount<-table(myword)
head(sort(wordcount, decreasing=T), 20) # 빈도수 가장 높은 단어 20개를 내림차순으로


## 06. 워드클라우드 
  # 단어들에 색 부여. 
palete<-brewer.pal(9, "Set1")
  # 워드클라우드 형식의 그림 데이터 표현을 위해 별도의 그래픽 구현 창 생성
x11() 
  # wordcloud 함수의 세부 인수(옵션) 값을 조정하여 워클에서 중요 키워드 파악
wordcloud(names(wordcount),
          freq=wordcount,
          scale=c(5,1),
          rot.per=0.5,
          min.freq=5,
          random.order=F,
          random.color=T,
          colors=palete
          )


## 07. 시각화 ##
  # 최초로 작성된 워클에서 파악된 비중요 단어들을 제거.
text2 <- gsub("것", "", text2)
text2 <- gsub("들", "", text2)
text2 <- gsub("수", "", text2)
text2 <- gsub("년", "", text2)
text2 <- gsub("이", "", text2)
text2 <- gsub("국", "", text2)
text2 <- gsub("하게", "", text2)
text2 <- gsub("선", "", text2)
text2 <- gsub("나", "", text2)
  # 250행의 write부터 실행하면 먼저것보다 줄어든 워드들을 볼 수 있음.

  # 가장 많이 나온 20개 단어들을 파이차트화 하기
a<-head(sort(wordcount, decreasing=T), 20)
pie(a, col=rainbow(10), radius=1)

  # 라벨과 퍼센트값 등 넣어주기
pct<-round(a/sum(a)*100, 1)
names(a)
lab<-paste(names(a), "\n", pct, "%")
pie(a, main="Obama's speech", col=rainbow(10), cex=0.8 labels=lab)


  # 가운데 뚫어주기
par(new=T)
pie(a, radius=0.6, col="white", labels=NA, border=NA) # radius: 가운데 홀의 크기 및 색상 조정


