if (!file.exists("./Dataset1"))
{dir.create("./Dataset1")}
if (!file.exists("./Dataset1/Dataset.zip"))
{download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "./Data/Dataset.zip")}
unzip("./Dataset1/Dataset.zip", exdir="./Data")
# get features
features <- read.table("./Dataset1/UCI HAR Dataset/features.txt", header = FALSE, sep="")
# get DataSets
TrainingSet <-  read.table("./Dataset1/UCI HAR Dataset/train/X_train.txt", header = FALSE, sep="")
TestSet <-  read.table("./Dataset1/UCI HAR Dataset/test/X_test.txt", header = FALSE, sep="")
MergedSet <- rbind(TrainingSet,TestSet)
# get Activity labels
TrainingLabels <-  read.table("./Dataset1/UCI HAR Dataset/train/y_train.txt", header = FALSE, sep="")
TestLabels <-  read.table("./Dataset1/UCI HAR Dataset/test/y_test.txt", header = FALSE, sep="")
MergedLables <- rbind(TrainingLabels,TestLabels)
# get activity description
ActivityLabels <-  read.table("./Dataset1/UCI HAR Dataset/activity_labels.txt", header = FALSE, sep="")
# get subject data
Trainingsubjects <-  read.table("./Dataset1/UCI HAR Dataset/train/subject_train.txt", header = FALSE, sep="")
TestSubjects <-  read.table("./Dataset1/UCI HAR Dataset/test/subject_test.txt", header = FALSE, sep="")
MergedSubjects <- rbind(Trainingsubjects,TestSubjects)
# add descriptive column names for Merged Dataset
colnames(MergedSet) <- as.vector(features$V2)
# subset only mean and std columns
subsetMerged <- MergedSet[,grep("mean()|std()",colnames(MergedSet))]
# get rid of meanFrequency columns
newSet <- subsetMerged[,-(grep("meanFreq()",colnames(subsetMerged)))]
# add new column activity label
newSet["ActivityLabel"] <- MergedLables$V1
# add new column subject
newSet["Subject"] <- MergedSubjects$V1
#rename column name in activitylabels data frame so that it is easy to join
colnames(ActivityLabels) <- c("ActivityLabel", "Activity")
#merge the columnnames for activity so that we have descriptive activity
LatestSet <- merge(newSet,ActivityLabels, by = "ActivityLabel", all.x = TRUE)
#remove # from columnnames
colnames(LatestSet) <- gsub("-()","",colnames(LatestSet))
#create mean
#LatestSet %>% group_by(Subject,Activity) %>% summarise(fboygrypMeanX = mean(`tBodyAccmean()X`, na.rm = TRUE))
library(dplyr)
NewDataset <- LatestSet %>% group_by(Subject,Activity) %>% summarise_each(funs(mean))

write.table(NewDataset, "finaldata.txt", row.name=FALSE)