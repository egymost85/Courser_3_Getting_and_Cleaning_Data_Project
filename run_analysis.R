run_analysis<- function(){

#read the activity_labels.txt and give its column descriptive names
ActivityLabels<- read.table("E:\\in\\activity_labels.txt")
colnames(ActivityLabels)<- c("ActivityNumb","ActivityName")

#read the features.txt
Features<- read.table("E:\\in\\features.txt")
colnames(Features)<- c("FeatureIndex","FeatureName")

#from features extract that containing mean or std
FeaturesWanted<-grep("mean|std",Features[,"FeatureName"])
#extract measurements according to required features
MeasurementsWanted<- Features[FeaturesWanted,"FeatureName"]
MeasurementsWanted2<- gsub("[()]","",MeasurementsWanted)

#read the train dataset
xtrain<- read.table("E:\\in\\X_train.txt")
ytrain<- read.table("E:\\in\\y_train.txt")
SubjectTrain<- read.table("E:\\in\\subject_train.txt")

#extract required columns from train dataset
xtrainWanted<- xtrain[,FeaturesWanted]

#assigning names to train dataset
colnames(xtrainWanted)<- MeasurementsWanted2
colnames(ytrain)<- c("Activity")
colnames(SubjectTrain)<- c("SubjectNum")

#collects the train datasets into one tidy train dataset
TrainDataset<- cbind(SubjectTrain,ytrain,xtrainWanted)

#read the test dataset
xtest<- read.table("E:\\in\\X_test.txt")
ytest<- read.table("E:\\in\\y_test.txt")
SubjectTest<- read.table("E:\\in\\subject_test.txt")

#extract required columns from test dataset
xtestWanted<- xtest[,FeaturesWanted]

#assigning names to test dataset
colnames(xtestWanted)<- MeasurementsWanted2
colnames(ytest)<- c("Activity")
colnames(SubjectTest)<- c("SubjectNum")

#collects the test datasets into one tidy test dataset
TestDataset<- cbind(SubjectTest,ytest,xtestWanted)

#merge train and test dataset
AllDataset<- rbind(TrainDataset,TestDataset)

#writes the clean merged dataset
write.table(AllDataset,"E:\\out\\AllDataset1.txt")

#creates the second dataset with aggregated averages and writes it
AllAverage<- aggregate(AllDataset, by=list(AllDataset$SubjectNum,AllDataset$Activity),FUN=mean)
write.table(AllAverage,"E:\\out\\AllDataset2.txt")

}
