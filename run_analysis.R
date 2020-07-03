#Coursera Getting and Cleaning Data Course 
#Project Week 4

library(data.table)
library(dplyr)

#Download the data set from zipfile

fileUrl1 <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
filename <- "UCIHARDataset.zip"
download.file(fileUrl1, filename, method = "curl")
unzip(filename)

#Check the documents in the folder
path1 <- "C:/Users/Economics05/Documents/Coursera/UCI HAR Dataset"
archivos = list.files(path1, recursive = TRUE)
archivos

#Select all the data sets that must be merged: Train and Test sets
#Load the Train sets
xtrain = read.table(file.path(path1,"train","X_train.txt"),header = FALSE)
ytrain = read.table(file.path(path1,"train","y_train.txt"),header = FALSE)
subject_train = read.table(file.path(path1,"train","subject_train.txt"),header = FALSE)
#Load the Test sets
xtest = read.table(file.path(path1,"test","X_test.txt"), header = FALSE)
ytest = read.table(file.path(path1,"test","y_test.txt"), header = FALSE)
subject_test = read.table(file.path(path1,"test","subject_test.txt"), header = FALSE)
#Load the activity labels list
activity_labels = read.table(file.path(path1,"activity_labels.txt"), header = FALSE)
#Load the features information
features = read.table(file.path(path1,"features.txt"),header = FALSE)

#Match all the data sets with the corresponding column names
colnames(xtrain) = features[,2]
colnames(ytrain) = "activitynum"
colnames(subject_train) = "subjectnum"
colnames(xtest) = features[,2]
colnames(ytest) = "activitynum"
colnames(subject_test) = "subjectnum"
colnames(activity_labels) = c("activitynum", "activityType")

#Merge the train and test sets
utrain = cbind(ytrain, subject_train, xtrain)
utest = cbind(ytest, subject_test, xtest)
mainData = rbind(utrain, utest)

#Extract the measurements on the mean and standard deviation for each measurement
#Check the columns that contain the word mean or std

colData <- grep(".*Mean.*|.*Std.*",names(mainData),ignore.case = TRUE)
colnData <- c(1:2,colData)
mainData1 <- mainData[,colnData]

#Designate each descriptive activity names to name the activities in the data set
mainData1$activitynum <- activity_labels[mainData1$activitynum, 2]

#Label the data set with descriptive variable names
colnames(mainData1)
names(mainData1)[1] = "Activity"
names(mainData1)[2] = "SubjectNumber"
names(mainData1) <- gsub("Acc","Accelerometer", names(mainData1))
names(mainData1) <- gsub("Gyro","Gyroscope", names(mainData1))
names(mainData1) <- gsub("Mag","Magnitude", names(mainData1))
names(mainData1) <- gsub("BodyBody","Body", names(mainData1))
names(mainData1) <- gsub("^t","Time", names(mainData1))
names(mainData1) <- gsub("^f","Frequency", names(mainData1))
names(mainData1) <- gsub("angle", "Angle", names(mainData1))
colnames(mainData1)

#Creates a second, independent tidy data set with the average of each variable for each 
# activity and each subject.

mainDatafinal <- mainData1 %>% group_by(SubjectNumber,Activity) %>% summarise_all(funs(mean))
View(mainDatafinal)

#Create the final data set
write.table(mainDatafinal,"mainDatafinal.txt", row.names = FALSE)