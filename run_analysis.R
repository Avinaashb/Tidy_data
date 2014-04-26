## Please look at the read me file first.


##Loads the Test files
x_test <- read.table("test/X_test.txt")
y_test <-read.table("test/Y_test.txt")
subs_test<-read.table("test/subject_test.txt")
##Loads Training Files
x_train <- read.table("train/X_train.txt")
y_train <-read.table("train/Y_train.txt")
subs_train<-read.table("train/subject_train.txt")
##Loads shared files 
features <- read.table("features.txt")
activities <- read.table("activity_labels.txt")

X_all<- (rbind(x_test,x_train))
Y_all<- (rbind(y_test,y_train))
all_subs<-(rbind(subs_test,subs_train))

##users features to replace the column names
colnames(X_all)<-features$V2

#adds info from activity files to the Y_All data_frame
#Also adds a nice col name to the activity
Y_all_act<- merge(Y_all,activities)
colnames(Y_all_act)[2]<-"Activity"
#adds a nice col name for the subject file
colnames(all_subs)[1]<-"Subject"

#combiles all the data files then removed an 
##unneed col which has row number in it.
Fin<-cbind(all_subs,Y_all_act,X_all)
Fin<-Fin[,c(1,3:564)]

#creates col names for what we want to focus on i.e STD and means
stdcols<-grep("std",colnames(Fin))
meancols<-grep("mean",colnames(Fin))

#filters the data for onlyt he columns we want whilst keeping
#the first two columns
Fin_f<-Fin[,c(1:2,stdcols,meancols)]

tmp<-aggregate(Fin_f[,3:81], by=list((Fin_f$Subject),Fin_f$Activity), FUN=mean)
##Fixing Col names again
colnames(tmp)[1]<-"Subject"
colnames(tmp)[2]<-"Activity"

#write to a file
write.table(tmp, "tidy_data_set.txt")