# Author : Seong-min Gho

##k-means##

library(rgl) #3D plot에 필요
library(stringr) #str_c함수에 필요
library(fpc)
setwd("c:/test") #저장된 파일위치로 갑니다.
Nationwide<-read.csv("project_Nationwide.csv")
Gyeonggi<-read.csv("project_Gyeonggi.csv") #경기도 데이터를 불러옵니다.
Gyeonggi_filter<-read.csv("project_Gyeonggi_filter.csv")

#Nationwide$population_year<-NULL #5개를 팩터를 3개로 줄였습니다.
#Nationwide$business_year<-NULL
Nationwide$pass<-NULL
#Gyeonggi$population_year<-NULL #5개를 팩터를 3개로 줄였습니다.
#Gyeonggi$business_year<-NULL
Gyeonggi$pass<-NULL
#Gyeonggi_filter$population_year<-NULL #5개를 팩터를 3개로 줄였습니다.
#Gyeonggi_filter$business_year<-NULL
Gyeonggi_filter$pass<-NULL

Gyeonggi$old_building<-Gyeonggi$old_building*2
Nationwide$old_building<-Nationwide$old_building*2

#Gyeonggi$population<-NULL
#Gyeonggi$business<-NULL
#Gyeonggi$old_building<-NULL
#scale.data<-scale(Gyeonggi[,-1])

#kmeans.result<-kmeans(Gyeonggi[,-1],7,nstart=100) #클러스터링을 합니다. 5개로 나눴습니다.
gy <- Gyeonggi[, 1:6]
library(cluster)
pam.result<-pam(Gyeonggi[,-1],7)
gy.result<-pam(gy[,-1],7)


#TB<-table(Gyeonggi$,kmeans.result$cluster)
#write.csv(TB,"hello3.csv")
#plot(Gyeonggi[c("population", "business")],col=kmeans.result$cluster,xlim=c(-100,100),ylim=c(-100,100))
#plot(Gyeonggi[c("population", "old_building")],col=kmeans.result$cluster)
#plot(Gyeonggi[c("business", "old_building")],col=kmeans.result$cluster,xlim=c(-40,40),ylim=c(0,100))
#points(kmeans.result$centers[,c("business", "old_building")], pch=8, cex=2)

#plot3d(Gyeonggi[,2],Gyeonggi[,4],Gyeonggi[,6],xlim=c(-100,100),ylim=c(-50,50),zlim=c(0,100),
#       xlab="population",ylab="Business",zlab="Old buildings",col=kmeans.result$cluster)
plot3d(Gyeonggi[,2],Gyeonggi[,4],Gyeonggi[,6],xlim=c(-100,100),ylim=c(-50,50),zlim=c(0,200),
       xlab="population",ylab="Business",zlab="Old buildings",col=pam.result$cluster)


##########################################################
##train & test##
##########################################################
library(caret)
set.seed(123)

##test단계(not yet)##
#intrain<-createDataPartition(y=Nationwide$name,time=1,p=0.7,list=FALSE)
#training<-Nationwide[intrain,]
#testing<-Nationwide[-intrain,]
#predictions<-predict.train(object=modFit,testing[,2:4], type="raw")
#confusionMatrix(predictions,testing[,5])
#library(klaR)
#model <- NaiveBayes(name~., data=training)
#x_test <- data_test[,1:4]
#y_test <- data_test[,5]
#predictions <- predict(model, x_test)
# summarize results
#confusionMatrix(predictions$class, y_test)
                

training <- Nationwide #전국데이터를 학습 대상으로 합니다.
report <- Gyeonggi #경기도 데이터에 테스트해봅니다.

training.data<-training[,-1] #지역명을 뺀 데이터프레임입니다.

#library(NbClust) #k값 검증단계
#nc <- NbClust(training.data, min.nc=2, max.nc=15, method="kmeans")
#par(mfrow=c(1,1))
#barplot(table(nc$Best.n[1,]),xlab="Numer of Clusters", ylab="Number of Criteria",main="Number of Clusters Chosen")


#kmeans.result <- kmeans(training.data, centers = 7, iter.max =10000) #k-means 클러스터링합니다.
pam.result<-pam(training.data,7) #k-medoid 클러스터링합니다.

#training$cluster<-as.factor(kmeans.result$cluster)
training$cluster<-as.factor(pam.result$clustering)
write.csv(training,"report7_1.csv")



plot3d(training$population,training$business,training$old_building,xlim=c(-100,100),ylim=c(-50,50),zlim=c(0,200),
       xlab="population",ylab="Business",zlab="Old buildings",col=training$cluster)

#install.packages(pkgs="e1071",repos="http://cran.cnr.berkeley.edu")  
modFit <- train(x=training.data,
                y=training$cluster,
                method="nnet") #신경망회로 방법으로 학습시킵니다. 

report.data<-as.data.frame(report[,-1]) #지역명을 뺀 데이터프레임입니다.

testClusterPred <- predict(modFit,report.data) #학습한 걸 바탕으로 test파일의 cluster를 예측합니다.

plot3d(report$population,report$business,report$old_building,xlim=c(-100,100),ylim=c(-50,50),zlim=c(0,200),
       xlab="population",ylab="Business",zlab="Old buildings",col=testClusterPred)

report$cluster<-as.factor(testClusterPred)
write.csv(report,"report7_2.csv") #저장해준다.