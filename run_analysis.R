## run_analysis.R
## For the Coursera class Getting and Cleaning Data
## 9/19/2014  Dylan Peters
library(stringr)

## First set variable names for file locations
DataFolder <- ".\\UCI HAR Dataset\\";
TestDataMain <- paste(DataFolder,"test\\X_test.txt", sep="");
TestDataActs <- paste(DataFolder,"test\\y_test.txt", sep="");
TestDataSub <- paste(DataFolder,"test\\subject_test.txt", sep="");

TrainDataMain <- paste(DataFolder,"train\\X_train.txt", sep="");
TrainDataActs <- paste(DataFolder,"train\\y_train.txt", sep="");
TrainDataSub <- paste(DataFolder,"train\\subject_train.txt", sep="");

ActivitiesFile <- paste(DataFolder,"activity_labels.txt", sep="");
FeatureNamesFile <- paste(DataFolder,"features.txt", sep="");

## Load data into data frames

ActivitiesList <- read.table(ActivitiesFile, sep=" ", col.names=c("ID","ACTIVITY.NAME"));
FeatureNames <- read.table(FeatureNamesFile, sep=" ", col.names=c("ID","NAME"));

## Load test data
TestData <- read.table(TestDataMain, sep="", col.names = FeatureNames[,2])
TestData2 <- read.table(TestDataActs, sep="", col.names = c("ActivityID"))
TestDataSub <- read.table(TestDataSub, sep="", col.names = c("SubjectID"))

## Load train data
TrainData <- read.table(TrainDataMain, sep="", col.names = FeatureNames[,2])
TrainData2 <- read.table(TrainDataActs, sep="", col.names = c("ActivityID"))
TrainDataSub <- read.table(TrainDataSub, sep="", col.names = c("SubjectID"))

# Step 1: Merge the training and the test sets to create one data set.
print("Merging train and test data")
MergedData <- rbind(TestData, TrainData)
MergedData2 <- rbind(TestData2, TrainData2)
MergedDataSub <- rbind(TestDataSub, TrainDataSub)

MergedData2 <- cbind(MergedData2, MergedDataSub)

# Step 2: Extract only the measurements on the mean
#  and standard deviation for each measurement.

print("Extracting mean and std measurements")
for (fieldName in FeatureNames[,2])
{
  if (str_detect(fieldName, "mean()") || str_detect(fieldName, "std()"))
  {
    fieldName2 <- str_replace(fieldName, "\\(\\)", "..")
    fieldName2 <- str_replace_all(fieldName2, "-", ".")
    #print(fieldName2)
    tmp <- data.frame(MergedData[,fieldName2])
    colnames(tmp) <- fieldName2
    MergedData2 <- cbind(MergedData2, tmp)
  }
}


# 4 Appropriately label the data set with descriptive variable names. 
# This is accomplished in the loop in step 2

# 5 From the data set in step 4, create a second, independent 
#  tidy data set with the average of each variable for each activity 
#  and each subject.

AvgData <- aggregate (MergedData2, by=list(ActivityID2=MergedData2$ActivityID,SubjectID2=MergedData2$SubjectID), FUN=mean, na.rm=TRUE)

# 3 Use descriptive activity names to name the activities in the data set

AvgData <- merge(AvgData, ActivitiesList, by.x="ActivityID", by.y="ID", sort=FALSE)

write.table(AvgData, "TidyData.txt", row.names=FALSE)
