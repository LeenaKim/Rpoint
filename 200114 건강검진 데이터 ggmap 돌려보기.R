### 건강검진 프로젝트 돌려보기 ###
## 데이터를 어떻게 정제했는지 위주로 보기 ##
setwd("C:/R Leena/DATA")
library(ggplot2)
library(ggmap)
if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap")
register_google(key='AIzaSyDXQvPXUY1bNZvttOsx0x_LDFesJpDyCcU')
library(devtools)

# 전국 병원갯수 파일을 불러온 후 위도 경도 표시
health<-read.csv("checkup2_(1).csv", header=T)
head(health)
cent<-c(mean(health$lat), mean(health$lon))
attach(health)

# 대한민국 수검자 지도로 확인하기
bmap<-ggmap(get_googlemap(center=c("southkorea"), zoom=7, maptype="roadmap"))+geom_point(data=health, aes(x=lon, y=lat, size=number), shape=16, color="purple", alpha=0.5)+scale_size_area(max_size=10)
print(bmap)                                                                                          

# 위 지도와 같지만 다른 방식으로 대한민국 수검자 색깔별로
install.packages("xlsx")
library(xlsx)
people<-read.xlsx("checkup2.xlsx", sheetName="Sheet1")                                                                                      
head(people)
cent<-c(mean(people$lat), mean(people$lon))
attach(people)
fmap<-ggmap(get_googlemap(center=c("south korea"), zoom=7, maptype="roadmap"))+geom_point(data=people, aes(x=lon, y=lat, color=examinee), shape=16, alpha=0.9, size=3)
print(fmap)

# center : 중심
# zoom: 3~21 (3: 대륙, 21: 빌딩, 10: 기본)
# size : 가로세로 픽셀
# maptype : 기본값은 "terrain" 종류: roadmap, terrain, stellite, hybrid

# 직접 center값 설정 가능
lonlat<-read.csv("MF1_(1).csv", header=T)

rmap<-ggmap(get_googlemap(center=c(127.6607, 36.0068), zoom=7, maptype="roadmap"))+geom_point(data=lonlat, aes(x=LON, y=LAT, color=INCOME), size=2)
print(rmap)

# 아래에 있는 건 4개로 분리
rmap+facet_wrap(~RATE)
rmap+facet_wrap(~INCOME)
