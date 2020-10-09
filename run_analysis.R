# Call for data
download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip',
              destfile = './Data.zip')
unzip(zipfile = 'Data.zip')
file.rename('./UCI HAR Dataset','./Data')

# Merges the training and the test sets to create one data set.
## Names for each variable (columns) in the x files
variables <- read.table("Data/features.txt")
## Activities
activities <- read.table("Data/activity_labels.txt")
## Data
subject_test <- read.table("Data/test/subject_test.txt")
x_test <- read.table("Data/test/X_test.txt")
y_test <- read.table("Data/test/y_test.txt")
subject_train <- read.table("Data/train/subject_train.txt")
x_train <- read.table("Data/train/X_train.txt")
y_train <- read.table("Data/train/y_train.txt")
## Merge train/test
train<-cbind(subject_train,y_train,x_train)
test<-cbind(subject_test,y_test,x_test)
df<-rbind(train,test)
## Name columns
names(df)<-c("subject","activity",variables[[2]])
names(activities)<-c("id","activity")
## remove objects
rm(list=ls()[!ls() %in% c("df","activities")])

#Extracts only the measurements on the mean and standard deviation for each measurement.
df_tidy<-df[,c("subject","activity",grep("mean\\(\\)",names(df),value=T),
               grep("std\\(\\)",names(df),value=T))]

#Uses descriptive activity names to name the activities in the data set
library(dplyr)
df_tidy<-df_tidy%>%mutate(activity=activities[df_tidy$activity,2])

#Appropriately labels the data set with descriptive variable names.
nom<-names(df_tidy)

nom<-gsub("Acc", "Accelerometer", nom)
nom<-gsub("Gyro", "Gyroscope", nom)
nom<-gsub("Mag", "Magnitude", nom)
nom<-sub("^t", "Time-", nom)
nom<-sub("^f", "Frequency-", nom)
nom<-sub("\\(\\)", "", nom)

names(df_tidy)<-nom

#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

df_tidy_grouped<-df_tidy%>%group_by(subject,activity)%>%summarise_all(mean)

write.table(df_tidy_grouped, file = 'SummarizedTidyDataSet.txt',
            row.names = F, sep = "\t", quote = F)
