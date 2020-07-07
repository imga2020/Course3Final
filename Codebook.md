# Code Book

*Description of the variables, the data, and any transformations or work that have performed to clean up the data.*

The archive r_analysis.R contains the script created to clean up the data that corresponds to the project “Human Activity Recognition Using Smartphones Dataset” by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto. This script was developed for the final assignment of the course Getting and Cleaning Data as part of the Data Science Specialization.

The script performs the following steps:
1.	Collects the Dataset from the website: It obtains the data set in a zip format and extracts all the contents in a new folder named UCIHARDataset. At the end, it lists all the available documents in the folder. 
2.	Selects and loads the required documents and assign the corresponding column names: 
It selects the archives for the Train and Test set, the activity_labels and the features. After, it assigns the column names using the features and activity_labels contents.
* Loads the Train sets and assign then names: 
  * xtrain for X_train.txt – That contains the data measured in the experiment for the Train group. According to the original data, the features included in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. (t stands for time)
  * ytrain for y_train.txt – That contains the data for the activity performed. (From the following: Walking, Walking upstairs, Walking downstairs, Sitting, Standing and Laying)
  * subject_train for subject_train.txt – That contains the information on the subjects that performed the activities. An identification number.
* Loads the Test sets and assign then names:
  * xtest for X_test.txt - That contains the data measured in the experiment for the Test group. According to the original data, the features included in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. (t stands for time)
  * ytest for y_test.txt - That contains the data for the activity performed. (From the following: Walking, Walking upstairs, Walking downstairs, Sitting, Standing and Laying)
  * subject_test for subject_test.txt- That contains the information on the subjects that performed the activities. An identification number.
* Loads the activity labels list:
  * activity_labels for activity_labels.txt – That contains the list of all the activities that were performed by the subjects: Walking, Walking upstairs, Walking downstairs, Sitting, Standing and Laying.
* Loads the features information:
  * features for features.txt - That contains the list of all the features that were measure during the experiment with the watch. According to the original data, the features included in this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. (t stands for time)
3.	Merges the Train and Test sets: It selects the Train and Test sets to merge then and create a unique dataset named mainData.
4.	Extracts only the measurements on the mean and standard deviation for each measurement: Creates a new set of data named mainData1 that contains all the rows with the columns that include the word mean or std on their variable names (Corresponding measurements).
5.	Designates each descriptive activity names to name the activities in the data set: Takes the mainData1 and assings the activity name according to the list and the code presented in the activity_labels list.
6.	Renames the variable: It labels the data set with their descriptive variable names:
* Column 1 is renamed from “activitynum” to “Activity”
* Column 2 is renamed from “subjectnum” to “SubjectNumber”
* All “Acc” in column’s name is replaced by “Accelerometer”
* All “Gyro” in column’s name is replaced by “Gyroscope”
* All “Mag” in column’s name is replaced by “Magnitude”
* All “BodyBody” in column’s name is replaced by “Body”
* All column names that start with the character “t” are replaced with the word “Time”, leaving the rest of the name unchanged.
* All columns names that start with the character “f” are replaced with the word “Frequency”, leaving the rest of the name unchanged.
* All “angle” in column’s name is replaced by “Angle”
7.	Creates a second, independent tidy data set with the average of each variable for each activity and each subject: Takes the mainData1 set, groups it by subject and activity and takes the mean of each variable. The result is mainDatafinal
8.	Creates the final data set: It takes the final set mainDatafinal and converts it into a text document.
