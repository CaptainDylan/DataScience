Code book for Getting and Cleaning Data course project
Name: Dylan Peters

The files X_test.txt and X_train.txt contain the main data sets.  The files y_test.txt and y_train.txt contain the activity id's that map to each record in the main data sets.  The main data sets are processed data from wearable device sampling at 50hz, for various subjects and activites.  For this project we are disregarding the subjects.

The file activity_labels.txt contains the names that match to each activity id.  The features.txt file is a list of feature names that coorespond to the column names for the main data sets.

The variables TestData and TrainData have the pre-processed data.  These are row-combined into a single data frame called MergedData.  Likewise the activity id data is loaded and merged into MergedData2.

The project calls for extrating only variables that are a mean or standard deviation (std).  The process I used was to iterate through the feature definitions in the FeatureNames data frame.  If the feature consisted of "mean" or "std" then I reformatted it and added that particular column in MergedData to the MergedData2 data frame, including the column name, using cbind.

The final step was to append the activity name to each record based on the activity id.  This is accomplished by using the merge function with the activities data set.
