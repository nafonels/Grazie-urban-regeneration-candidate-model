
# 데이터를 정제하기 위해 경기도를 제외한 나머지 지역의 도시쇠퇴 읽기
drest <- read.csv("도시쇠퇴나머지.csv")

# 필요한 열 뽑기
drest <- drest[,c(2,3,7,8,9,10,11,12,13)]

# 종속변수의 값을 "O" = '1'로 "X" = '0'으로 바꾸는 작업
x <- c(0)
for (var in c(1:nrow(drest))) {
  if(drest[var,9] == "O") x <- append(x,1)
  else if(drest[var,9] == "X") x <- append(x,0)
}
x <- x[-1]

drest$X2개.부문.이상.부합여부 <- as.numeric(drest$X2개.부문.이상.부합여부)

drest$X2개.부문.이상.부합여부 <- x

# 정제한 데이터를 csv파일로 저장
write.csv(drest,"도시쇠퇴나머지정제.csv")

#------------------------- 경기도거 --------------

dk <- read.csv("도시쇠퇴경기도.csv")
dk <- dk[,c(2,3,7,8,9,10,11,12,13)]

x <- c(0)
for (var in c(1:nrow(dk))) {
  if(dk[var,9] == "O") x <- append(x,1)
  else if(dk[var,9] == "X") x <- append(x,0)
}
x <- x[-1]

dk$X2개.부문.이상.부합여부 <- as.numeric(dk$X2개.부문.이상.부합여부)

dk$X2개.부문.이상.부합여부 <- x

write.csv(dk,"도시쇠퇴경기도정제.csv")
