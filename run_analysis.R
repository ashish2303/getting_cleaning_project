train=read.csv("E:\\UCI HAR Dataset\\train\\X_train.csv")
test=read.csv("E:\\UCI HAR Dataset\\test\\X_test.csv",)
features=read.csv("E:\\UCI HAR Dataset\\features.csv")
new=rbind(train,test)
new1=new[,c(-1:-2)]
names(new1)<- features$features
new2=cbind(new$activity,new$subject,new1)
subdataFeaturesNames<-features$features[grep("mean\\(\\)|std\\(\\)", features$features)]
selectedNames<-c(as.character(subdataFeaturesNames), "new$subject", "new$activity" )
Data<-subset(new2,select=selectedNames)
activityLabels <- read.table("E:\\UCI HAR Dataset\\activity_labels.txt",header = FALSE)
data1=merge(Data,activityLabels,by ="new$activity")
names(data1)<-gsub("^t", "time", names(data1))
names(data1)<-gsub("^f", "frequency", names(data1))
names(data1)<-gsub("Acc", "Accelerometer", names(data1))
names(data1)<-gsub("Gyro", "Gyroscope", names(data1))
names(data1)<-gsub("Mag", "Magnitude", names(data1))
names(data1)<-gsub("BodyBody", "Body", names(data1))
colnames(data1)[68]="subject"

library(plyr)
Data2<-aggregate(. ~activity1+subject, data1, mean)
Data2<-Data2[order(Data2$subject,Data2$activity1),]
write.table(Data2, file = "E:\\tidydata.txt",row.name=FALSE)
