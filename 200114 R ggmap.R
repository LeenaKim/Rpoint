if(!requireNamespace("devtools")) install.packages("devtools")
devtools::install_github("dkahle/ggmap")
register_google(key='AIzaSyDXQvPXUY1bNZvttOsx0x_LDFesJpDyCcU')
library(ggmap)
getwd()
setwd("C:/R Leena/data(f)")
a<-read.csv("WIFI.csv", header=T)
View(a)
head(a)

seoul<-get_map("seoul", zoom=11, maptype="roadmap") # get_map(): 구글 지도 불러오기
ggmap(seoul)

seoul2<-ggmap(seoul)+geom_point(data=a, aes(x=LON, y=LAT, color=INSTL_DIV), size=3, alpha=0.8)
seoul2
seoul2+facet_wrap(~GU_NM)

ggplot(a, aes(x=factor(1)))+geom_bar(aes(fill=GU_NM), width=1)+coord_polar(theta="y")+xlab("")+ylab("")

korea<-c(left=124, bottom=33, right=132, top=40)

get_stamenmap(korea, zoom=5, maptype="toner-lite") %>%ggmap()
get_googlemap("seoul", zoom=12) %>% ggmap()
get_googlemap("seoul", zoom=12, maptype="satellite") %>% ggmap()
get_googlemap("seoul", zoom=12, maptype="hybrid") %>% ggmap()
get_googlemap("seoul", zoom=12, maptype="roadmap") %>% ggmap()

# 서울시 로드맵
map<-get_map(location="seoul", zoom=14, maptype="roadmap", source="google")
g<-ggmap(map)
print(g)

# 서울시 위성사진
map<-get_map(location="seoul", zoom=14, maptype="satellite", source="google")
g<-ggmap(map)
print(g)

# 랜드마크 설정법
landmarks<-c("nseoul tower, seoul", "city hall, seoul")
lbls<-cbind(geocode(landmarks), text=landmarks)
g<-ggmap(map)
g<-g+geom_point(data=lbls, aes(x=lon, y=lat), size=5, colour="orange")
g<-g+geom_point(data=lbls, aes(x=lon, y=lat), size=3, colour="red")
g<-g+geom_text(data=lbls, aes(x=lon, y=lat, label=text), size=5, colour="blue", hjust=0, vjust=0)
print(g)

library(ggmap)
wifi<-read.csv("C:/R Leena/data(f)/wifi.csv")
cent<-c(mean(wifi$LON), mean(wifi$LAT))
attach(wifi)

# 서울시 지도에 wifi 표시
bmap<-ggmap(get_googlemap(center=c("seoul"), zoom=11, maptype="roadmap"))+geom_point(data=wifi, aes(x=LON, y=LAT, colour=INSTL_DIV, size=4))
print(bmap)
  
  # 통신사별 맵찍기
bmap+facet_wrap(~INSTL_DIV)

  # 원그래프
ggplot(wifi, aes(x=factor(1)))+geom_bar(aes(fill=INSTL_DIV), width=1)+coord_polar(theta="y")+xlab("")+ylab("")

  # 카테고리별 통신사가 stack된 바그래프
ggplot(wifi, aes(CATEGORY))+geom_bar(aes(fill=INSTL_DIV))

  # 통신사별 카테고리가 stack된 바그래프
ggplot(wifi, aes(INSTL_DIV))+geom_bar(aes(fill=CATEGORY))


## ggmap 활용법 - 프린트 ##
## 연습 1
setwd("C:/R Leena/Data")
pigmap<-ggmap(get_map(location='south korea', zoom=7, color='bw')) ## 흑백 지도 저장
pig15<-read.csv("map.csv", header=T, as.is=T) ## map 파일 불러오기(위도, 경도)
attach(pig15)
head(pig15)

ppp15<-subset(pig15, 년도=="15")
ppp15map<-pigmap+geom_point(data=ppp15, aes(x=lon, y=lat)) # pigmap에 위치만 추가
ppp15map
ppp15map<-ppp15map+geom_text(data=ppp15, aes(x=lon+0.01, y=lat+0.01, label=위치), size=2.5, check_overlap=T) # 위치에 텍스트 추가
ppp15map

ppp15map+geom_point(data=ppp15, aes(x=lon, y=lat, color=factor(위치)), size=2)+scale_color_discrete(name="위치") #라벨 이름 바꾸기


## 연습 2
loc<-read.csv("서울_강동구_공영주차장_위경도.csv", header=T) # 위도 경도 자료 불러오기기
loc

kd<-get_map("Amsa-dong", zoom=13, maptype="roadmap") # 구글맵 불러오기기

kor.map<-ggmap(kd)+geom_point(data=loc, aes(x=LON, y=LAT), size=3, alpha=0.7, color="red")  # alpha: 불투명도
kor.map

kor.map+geom_text(data=loc, aes(x=LON, y=LAT+0.001, label=주차장명), size=3)

ggsave("kd.png", dpi=500) # 이미지 저장. 작업파일 경로에 저장됨. dpi: 해상도


## 연습 3
pop<-read.csv("지역별인구현황_2014_4월기준.csv", header=T) # 위도 경도 자료 불러오기
pop

lon<-pop$LON # 데이터 정렬하기
lat<-pop$LAT
data<-pop$총인구수

df<-data.frame(lon, lat, data)
df

map1<-get_map("Jeonju", zoom=7, maptype='roadmap') # 구글맵 불러오기(지도유형1)
map1<-ggmap(map1)
map1+geom_point(aes(x=lon, y=lat, colour=data, size=data), data=df)

ggsave("pop.png", scale=1, width=7, height=4, dpi=1000)

map2<-get_map("Jeonju", zoom=7, maptype='terrain') # 구글맵 불러오기(지도유형2)
map2<-ggmap(map2)
map2+geom_point(aes(x=lon, y=lat, colour=data, size=data), data=df)

ggsave("pop2.png", scale=1, width=7, height=4, dpi=1000)

map3<-get_map("Jeonju", zoom=7, maptype='satellite') # 구글맵 불러오기(지도유형3)
map3<-ggmap(map3)
map3+geom_point(aes(x=lon, y=lat, colour=data, size=data), data=df)
ggsave("pop3.png", scale=1, width=7, height=4, dpi=1000)

map4<-get_map("Jeonju", zoom=7, maptype='hybrid') # 구글맵 불러오기(지도유형4)
map4<-ggmap(map4)
map4+geom_point(aes(x=lon, y=lat, colour=data, size=data), data=df)
ggsave("pop4.png", scale=1, width=7, height=4, dpi=1000)

map5<-get_map("Jeonju", zoom=7, maptype='roadmap') # 버블모양 다르게
map5<-ggmap(map5)
map5+stat_bin2d(aes(x=lon, y=lat, colour=data, fill=factor(data), size=data), data=df)
ggsave("pop5.png", scale=1, width=7, height=4, dpi=1000)
