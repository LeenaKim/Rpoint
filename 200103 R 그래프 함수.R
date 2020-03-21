## 그래프 함수 활용 p. 141-161 ##
# plot(x, y, main= , sub= , xlab=, ylab=, type=, axes="", col="", pch="")
# plot(X, Y, xlim, ylim) : xlim x값 범위, ylim y값 범위
# par(): 그림 조절, 그림창 특성 지정, 여러 창으로 나눌 때
# points(): 그래프에 점을 그리는 함수. points(x, y, pch= , cex= ) pch "숫자" : 숫자에 해당되는 형태 출력, cex="숫자": 숫자가 클수록 큰 점이 출력
x<-c(2,5,6,5,7,9,11,5,7,9,13,15,17)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12,13)
z<-c(3.5, 1.5, 2.3, 6.6, 4.7)
a<-c(2,7,12)
plot(x,y,main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="n")
points(z, pch=1, cex=1)
points(z, pch=3, cex=1)
points(z, pch=5, cex=1)
points(z, pch=7, cex=1)
points(z, pch=9, cex=1)
points(z, pch=11, cex=1)
points(z, pch=13, cex=1)
points(z, pch=15, cex=1)
points(z, pch=17, cex=1)
points(z, pch=19, cex=1)

# lines() : 선의 외형을 조절하는 인자들을 지님. 선의 유형: lty, 선의 너비나 두께: lwd
op=par(mfrow=c(2,2))
par()
plot(0:8, 0:8, type="n", ylim=c(0,20))
lines(c(2,6), c(20, 20), lty=1) # (2,20)과 (6,20)를 잇는 lty=1의 선
lines(c(2,6), c(19, 19), lty=2)
lines(c(2,6), c(18, 18), lty=3)
lines(c(2,6), c(17, 17), lty=4)
lines(c(2,6), c(16, 16), lty=5)
lines(c(2,6), c(15, 15), lty=6)
lines(c(2,6), c(14, 14), lty="blank")
lines(c(2,6), c(13, 13), lty="solid")
lines(c(2,6), c(12, 12), lty="dashed")
lines(c(2,6), c(11, 11), lty="dotted")
lines(c(2,6), c(10, 10), lty="dotdash")
lines(c(2,6), c(9, 9), lty="longdash")
lines(c(2,6), c(8, 8), lty="twodash")
lines(c(2,6), c(7, 7), lty="33")
lines(c(2,6), c(6, 6), lty="24")
lines(c(2,6), c(5, 5), lty="F2")
lines(c(2,6), c(4, 4), lty="2F")
lines(c(2,6), c(3, 3), lty="3313")
lines(c(2,6), c(2, 2), lty="F252")
lines(c(2,6), c(1, 1), lty="FF29")

# text() : 자신이 원하는 위치에 표시하고 싶은 글자 입력
x<-c(2,5,6,5,7,9,11,5,7,9,13,15,17)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12,13)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p")
text(9,10,"Plotting", col="red")

# abline() : 직선그리는 함수. 새 함수 생성은 안되고, 생성함수 먼저 호출 후 abline 호출.
x<-c(2,5,6,5,7,9,11,5,7,9,13,15,17)
y<-c(1,2,3,4,5,6,7,8,9,10,11,12,13)
plot(x, y, main="PLOT", sub="Test", xlab="x-label", ylab="y-label", type="p")
abline(h=6, v=9, lty=3) # h: horizon, v: vertical. lyt=3: 점선.

# legend() : 그래프의 내용을 해독할 수 있게 해주는 작은 박스나 라벨을 붙임.
plot(x, y, type='n')
legend("center", "(x,y)", pch=1, title="center")
legend("top", "(x,y)", pch=1, title="top")
legend("left", "(x,y)", pch=1, title="left")
legend("right", "(x,y)", pch=1, title="right")
legend("bottom", "(x,y)", pch=1, title="bottom")

# curve() : 곡선을 그릴 때.
x<-rnorm(1000, mean=5, sd=1)  # 정규분포 샘플 1000개 추출
hist(x) # 빈도로 표시.
hist(x, freq=F) # 밀도로 표시. y축이 1미만임.
curve(dnorm(x, mean=5, sd=1), add=T)  # 확률밀도함수(dnorm)에 평균 5, 표준편차 1인 정규분포 곡선 추가. add=T: 겹쳐 그림 그릴때 사용.

# box plot(상자그림) : 중앙의 두꺼운 선-중앙값, 박스는 제1사분위수와 제3사분위수. 박스의 바닥이 Q1, 박사의 천장이 Q3. 박스 위 아래 '수염'은 아웃라이어를 제외한 데이터의 범위.
x<-c(2,5,6,5,7,9,11,5,7,9,13,15,17)
z<-c(3.5, 2.2, 1.5, 4.6, 6.9)
boxplot(x,z)

# 파이차트 : 원형차트
x<-c(2,5,6,5,7,9,11,5,7,9,13,15,17)
pie(x)  # x에 저장된 값이 뜨는게 아니라, 인덱스값이 숫자로 뜨고 x값이 크기로 표현됨.

# 막대그리프 그리기(Bar plot)
barplot(x)  # 얘는 인덱스가 아니라 x값 그대로 표현됨.