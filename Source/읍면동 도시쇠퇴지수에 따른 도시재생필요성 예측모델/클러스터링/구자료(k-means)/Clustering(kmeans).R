###########################
##k-medoid. factor=5. k=7##
###########################
library(rgl) #3D plot에 필요
library(stringr) #str_c함수에 필요
library(fpc)
library(cluster) #k-medoid pam함수에 필요
setwd("c:/test") #저장된 파일위치로 갑니다.
Nationwide<-read.csv("project_Nationwide.csv")
Gyeonggi<-read.csv("project_Gyeonggi.csv") #경기도 데이터를 불러옵니다.

Nationwide$pass<-NULL
Gyeonggi$pass<-NULL

Nationwide$population_year<-as.numeric(Nationwide$population_year)
Nationwide$business_year<-as.numeric(Nationwide$business_year)
Gyeonggi$population_year<-as.numeric(Gyeonggi$population_year)
Gyeonggi$business_year<-as.numeric(Gyeonggi$business_year)
#scale.Gyeonggi<-scale(Gyeonggi[,-1])
#scale.Nationwide<-scale(Nationwide[,-1])

#Gyeonggi$old_building<-Gyeonggi$old_building*2
Nationwide$old_building<-Nationwide$old_building*2 #scailing?

kmeans.result<-kmeans(Nationwide[,-1],7) #클러스터링을 합니다 k-means로 했습니다.

#TB<-table(Gyeonggi$,kmeans.result$cluster)
#write.csv(TB,"hello3.csv")
#Gyeonggi$old_building<-Gyeonggi$old_building/2
Nationwide$old_building<-Nationwide$old_building/2 #복구

plot3d(Nationwide[,2],Nationwide[,4],Nationwide[,6],xlim=c(-100,100),ylim=c(-50,50),zlim=c(0,100),
       xlab="population",ylab="Business",zlab="Old buildings",col=kmeans.result$cluster)



####################
##  train & test  ##
####################
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



####################
##machine learning##
####################
teacher <- Nationwide #전국데이터의 클러스터링 값을
student <- Gyeonggi   #경기도 데이터가 맞춰줍니다.

library(NbClust) #k값 검증단계
nc <- NbClust(teacher[,-1], min.nc=2, max.nc=15, method="kmeans")
par(mfrow=c(1,1))
barplot(table(nc$Best.n[1,]),xlab="Numer of Clusters", ylab="Number of Criteria",main="Number of Clusters Chosen")

teacher$old_building<-teacher$old_building*2   #scailing?

kmeans.result<-kmeans(teacher[,-1],7,nstart=100) #k-medoid 클러스터링합니다.
teacher$cluster<-as.factor(kmeans.result$cluster)
write.csv(teacher,"report7_1.csv") #저장합니다

teacher$old_building<-teacher$old_building/2   #복구

plot3d(teacher$population,teacher$business,teacher$old_building,xlim=c(-100,100),ylim=c(-50,50),zlim=c(0,100),
       xlab="population",ylab="Business",zlab="Old buildings",col=teacher$cluster)

#install.packages(pkgs="e1071",repos="http://cran.cnr.berkeley.edu")  
modFit <- train(x=teacher[,2:6],
                y=teacher$cluster,
                method="nnet") #신경망회로 방법으로 학습시킵니다. 

testClusterPred <- predict(modFit,student[,-1]) #학습한 걸 바탕으로 test파일의 cluster를 예측합니다.

plot3d(student$population,student$business,student$old_building,xlim=c(-100,100),ylim=c(-50,50),zlim=c(0,100),
       xlab="population",ylab="Business",zlab="Old buildings",col=testClusterPred)

student$cluster<-as.factor(testClusterPred)
write.csv(student,"report7_2.csv") #저장합니다.
