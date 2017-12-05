# 각 시군구별 년도별 예산 데이터 추출 및 정제
d08 <- read.csv("./da/081.csv", sep = ",", header = T)
d09 <- read.csv("./da/091.csv", sep = ",", header = T)
d10 <- read.csv("./da/10.csv", sep = ",", header = T)
d11 <- read.csv("./da/11.csv", sep = ",", header = T)
d12 <- read.csv("./da/12.csv", sep = "\t", header = T)
d13 <- read.csv("./da/13.csv", sep = "\t", header = T)

bs14 <- GetSum("./2014/14bs.csv")
cb14 <- GetSum("./2014/14cb.csv")
cn14 <- GetSum("./2014/14cn.csv")
dg14 <- GetSum("./2014/14dg.csv")
dj14 <- GetSum("./2014/14dj.csv")
ic14 <- GetSum("./2014/14ic.csv")
jb14 <- GetSum("./2014/14jb.csv")
jj14 <- GetSum("./2014/14jj.csv")
jn14 <- GetSum("./2014/14jn.csv")
kb14 <- GetSum("./2014/14kb.csv")
kj14 <- GetSum("./2014/14kj.csv")
kn14 <- GetSum("./2014/14kn.csv")
kw14 <- GetSum("./2014/14kw.csv")
sj14 <- GetSum("./2014/14sj.csv")
sl14 <- GetSum("./2014/14sl.csv")
us14 <- GetSum("./2014/14us.csv")

bs15 <- GetSum("./2015/15bs.csv")
cb15 <- GetSum("./2015/15cb.csv")
cn15 <- GetSum("./2015/15cn.csv")
dg15 <- GetSum("./2015/15dg.csv")
dj15 <- GetSum("./2015/15dj.csv")
ic15 <- GetSum("./2015/15ic.csv")
jb15 <- GetSum("./2015/15jb.csv")
jj15 <- GetSum("./2015/15jj.csv")
jn15 <- GetSum("./2015/15jn.csv")
kb15 <- GetSum("./2015/15kb.csv")
kj15 <- GetSum("./2015/15kj.csv")
kn15 <- GetSum("./2015/15kn.csv")
kw15 <- GetSum("./2015/15kw.csv")
sj15 <- GetSum("./2015/15sj.csv")
sl15 <- GetSum("./2015/15sl.csv")
us15 <- GetSum("./2015/15us.csv")

# 리스트로 된 데이터를 
bs14 <- unlist(bs14)
cb14 <- unlist(cb14)
cn14 <- unlist(cn14)
dg14 <- unlist(dg14)
dj14 <- unlist(dj14)
ic14 <- unlist(ic14)
jb14 <- unlist(jb14)
jj14 <- unlist(jj14)
jn14 <- unlist(jn14)
kb14 <- unlist(kb14)
kj14 <- unlist(kj14)
kn14 <- unlist(kn14)
kw14 <- unlist(kw14)
sj14 <- unlist(sj14)
sl14 <- unlist(sl14)
us14 <- unlist(us14)

bs15 <- unlist(bs15)
cb15 <- unlist(cb15)
cn15 <- unlist(cn15)
dg15 <- unlist(dg15)
dj15 <- unlist(dj15)
ic15 <- unlist(ic15)
jb15 <- unlist(jb15)
jj15 <- unlist(jj15)
jn15 <- unlist(jn15)
kb15 <- unlist(kb15)
kj15 <- unlist(kj15)
kn15 <- unlist(kn15)
kw15 <- unlist(kw15)
sj15 <- unlist(sj15)
sl15 <- unlist(sl15)
us15 <- unlist(us15)

d14 <- c((bs14),  (cb14),  (cn14),  (dg14),  (dj14),  (ic14),  (jb14),  (jj14),  (jn14), 
         (kb14),  (kj14),  (kn14),  (kw14),  (sj14),  (sl14),  (us14))
d14 <- d14[order(names(d14))]
d14 <- data.frame(n = names(d14), X14 = d14, row.names = c(1:length(d14)))

d15 <- c((bs15),  (cb15),  (cn15),  (dg15),  (dj15),  (ic15),  (jb15),  (jj15),  (jn15), 
          (kb15),  (kj15),  (kn15),  (kw15),  (sj15),  (sl15),  (us15))
d15 <- d15[order(names(d15))]
d15 <- data.frame(n = names(d15), X15 = d15, row.names = c(1:length(d15)))



d081 <- split(d08$정책사업예산총계, d08$자치단체명)
x08v <- unlist(d081)
x08v <- x08v[order(names(x08v))]
d08 <- data.frame(n = names(x08v), X08 = x08v, row.names = c(1:length(x08v)))

d091 <- split(d09$정책사업예산총계, d09$자치단체명)
x09v <- unlist(d091)
x09v <- x09v[order(names(x09v))]
d09 <- data.frame(n = names(x09v), X09 = x09v, row.names = c(1:length(x09v)))

d101 <- split(d10$정책사업예산총계, d10$자치단체명)
x10v <- unlist(d101)
x10v <- x10v[order(names(x10v))]
d10 <- data.frame(n = names(x10v), X10 = x10v, row.names = c(1:length(x10v)))

d111 <- split(d11$정책사업예산총계, d11$자치단체명)
x11v <- unlist(d111)
x11v <- x11v[order(names(x11v))]
d11 <- data.frame(n = names(x11v), X11 = x11v, row.names = c(1:length(x11v)))

d121 <- split(d12$정책사업예산총계, d12$자치단체명)
x12v <- unlist(d121)
x12v <- x12v[order(names(x12v))]
d12 <- data.frame(n = names(x12v), X12 = x12v, row.names = c(1:length(x12v)))

d131 <- split(d13$정책사업예산총계, d13$자치단체명)
x13v <- unlist(d131)
x13v <- x13v[order(names(x13v))]
d13 <- data.frame(n = names(x13v), X13 = x13v, row.names = c(1:length(x13v)))

d08$n <- as.character(d08$n)
d09$n <- as.character(d09$n)
d10$n <- as.character(d10$n)
d11$n <- as.character(d11$n)
d12$n <- as.character(d12$n)
d13$n <- as.character(d13$n)
d14$n <- as.character(d14$n)
d15$n <- as.character(d15$n)

library(stringr)
d09$n <- str_trim(d09$n)
d10$n <- str_trim(d10$n)
d11$n <- str_trim(d11$n)
d14$n <- str_trim(d14$n)
d15$n <- str_trim(d15$n)
# 예산데이터 추출, 정제 끝

# 데이터들을 하나의 data.frame으로 합친 뒤 Na를 0으로 대치
fd <- merge(d08, d09, key = "n", all = T)
fd <- merge(fd, d10, key = "n", all = T)
fd <- merge(fd, d11, key = "n", all = T)
fd <- merge(fd, d12, key = "n", all = T)
fd <- merge(fd, d13, key = "n", all = T)
fd <- merge(fd, d14, key = "n", all = T)
fd <- merge(fd, d15, key = "n", all = T)
fd[is.na.data.frame(fd)] <- 0

# 지역별 면적데이터를 읽어온 뒤 정제 
area <- read.csv("./da/area2.csv")
area$시별 <- as.character(area$시별)
area1 <- subset(area, select = c(시별,X2008,X2009,X2010,X2011,X2012,X2013,X2014,X2015))
colnames(area1) <- c("n", "A08", "A09", "A10", "A11", "A12", "A13", "A14", "A15")
area2 <- area1[order(area1$n), ]

# 각 시군구별 예산을 면적으로 나눔
afd <- merge(area2, fd, key = "n")

bpa <- data.frame(n = afd[,"n"], P08 = afd[,"X08"]/afd[,"A08"], P09 = afd[,"X09"]/afd[,"A09"], P10 = afd[,"X10"]/afd[,"A10"],
                  P11 = afd[,"X11"]/afd[,"A11"], P12 = afd[,"X12"]/afd[,"A12"], P13 = afd[,"X13"]/afd[,"A13"],
                  P14 = afd[,"X14"]/afd[,"A14"], P15 = afd[,"X15"]/afd[,"A15"])

# NaN(=0/0) 데이터를 삭제
dn <- c()
for(i in 1:nrow(bpa)) {
  if(is.nan(bpa[i,"P15"])) {
    dn <- c(dn, i)
  } 
}
dbpa <- bpa[-dn,]
dbpa$n <- as.character(dbpa$n)

# clustering을 위한 평균의 로그(숫자가 매우 커 로그를 취함)과 최소비용년도대비 최근년도의 비용을 구함
data <- data.frame(means = rowMeans(dbpa[,-1]), delta = (dbpa[,"P15"]-apply(dbpa[,-1], 1, min))/apply(dbpa[,-1], 1, min)*100)
data1 <- data
data1$means <- sapply(data[,1], function(x) {log(x)})