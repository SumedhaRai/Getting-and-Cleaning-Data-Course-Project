Introduction
run_analysis.R performs the following steps:
It downloads the dataset, unzips it to a folder, reads the following files
features.txt which has all the variable names
x_train.txt which has train dataset
x_test.txt which has test dataset

VARIABLE NAMES
features is a dataframe which has all the variable names read from features.txt
TrainingSet is a data frame which has train dataset in it read from x_train.txt 
TestSet is a data frame which has test dataset in it read from x_test.txt
MergedSet has both rows merged from TrainingSet and TestSet
TrainingLabels is a data frame constructed from reading y_train.txt (activity labels for train records)
TestLabels is a data frame constructed from reading y_test.txt (activity labels for test records)
MergedLables has both rows merged from TrainingLabels and TestLabels
ActivityLabels is a data constructed from reading activity_labels.txt which has class labels linked to their activity name
Trainingsubjects is a data frame constructed from reading subject_train.txt which has subject information who performed activity for each train record
TestSubjects is a data frame constructed from reading subject_test.txt which has subject information who performed activity for each test record
MergedSubjects has both rows merged from Trainingsubjects and TestSubjects
subsetMerged has only columns with mean and std in their names from MergedSubjects after variable names have been applied to the columns in MergedSubjects data frame 
newSet is a subset of subsetMerged from where meanFrequency is removed, with subjects and activity labels added
LatestSet is a data frame with the activity names added from newset and activitylavels data frames
NewDataset is a data frame with the data grouped by subject and activity and for all the mean and activity columns mean is calculated
