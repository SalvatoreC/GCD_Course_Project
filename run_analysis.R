#
# NAME OF THE FILE: run_analysis.R
#
# Prerequisites:
# - the working directory contains the unzipped "getdata_projectfiles_UCI HAR Dataset.zip" file
#   that is the "UCI HAR Dataset" directory and all its subdirectories
# - the following packages and libraries are installed and loaded: dplyr, reshape2
#

# 0. Common data are read and descriptive column names are assigned

# 0.1 Activities (#6)

activity_labelsFile <- "./UCI HAR Dataset/activity_labels.txt"
activity_labels <- read.table(activity_labelsFile)
colnames(activity_labels) <- c("activityLabel", "activityName")

# 0.2 Features (#561)

featuresFile <- "./UCI HAR Dataset/features.txt"
features <- read.table(featuresFile)
colnames(features) <- c("featureID", "featureName")

# descriptive and sintatically valid names are choosen for features of interest (mean and standard deviation)

x_colnames <- c("tBodyAccMeanX",
                "tBodyAccMeanY",
                "tBodyAccmeanZ",
                "tBodyAccStdX",
                "tBodyAcStdY",
                "tBodyAccStdZ")

# 1. Training data are read and descriptive column names are assigned

# 1.1 Voluteers (#21 subjects = 70%) randomly selected for training

subject_trainFile <- "./UCI HAR Dataset/train/subject_train.txt"
subject_train <- read.table(subject_trainFile)
colnames(subject_train) <- "subjectID"

# 1.2 Training set (#7352 observations over #561 features)

x_trainFile <- "./UCI HAR Dataset/train/X_train.txt"
x_train <- read.table(x_trainFile)

# Only the measurements on the mean and standard deviation for each measurement are extracted
# note:
# the dplyr package is needed here, pleasecomment/uncomment following lines as needed
# install.packages("dplyr")
# library(dplyr)

x_train <- select(x_train, 1:6)

colnames(x_train) <- x_colnames

# 1.3 Training labels (#7352 observations classified by activity label)

y_trainFile <- "./UCI HAR Dataset/train/y_train.txt"
y_train <- read.table(y_trainFile)
colnames(y_train) <- "activityLabel"


# 1.4 Activity and subject information is merged

ds_train <- cbind(y_train, x_train)

ds_train <- cbind(subject_train, ds_train)

ds_train <- merge(activity_labels, ds_train, by = "activityLabel")

ds_train <- select(ds_train, -(activityLabel))


# 2. Testing data are read and descriptive column names are assigned

# 2.1 Voluteers (#9 subjects = 30%) randomly selected for testing

subject_testFile <- "./UCI HAR Dataset/test/subject_test.txt"
subject_test <- read.table(subject_testFile)
colnames(subject_test) <- "subjectID"

# 2.2 Test set (#2947 observations over #561 features)

x_testFile <- "./UCI HAR Dataset/test/X_test.txt"
x_test <- read.table(x_testFile)

# Only the measurements on the mean and standard deviation for each measurement are extracted

x_test <- select(x_test, 1:6)

colnames(x_test) <- x_colnames

# 2.3 Test labels (#2947 observations classified by activity label)

y_testFile <- "./UCI HAR Dataset/test/y_test.txt"
y_test <- read.table(y_testFile)
colnames(y_test) <- "activityLabel"

# 2.4 Activity and subject information is merged

ds_test <- cbind(y_test, x_test)

ds_test <- cbind(subject_test, ds_test)

ds_test <- merge(activity_labels, ds_test, by = "activityLabel")

ds_test <- select(ds_test, -(activityLabel))
                  
# 3. Train and Test datasets are merged to create one dataset

trainAndTestDS <- rbind(ds_train, ds_test)

# the merged database is written to a file named "trainAndTestDS.txt" in the working directory

write.table(trainAndTestDS, "./trainAndTestDS.txt", row.names = FALSE)

# to read the file above please use:
# ds01 <- read.table("./trainAndTestDS.txt", header = TRUE)

# 4. From the merged data set, a second, independent tidy data set is created with the average
# of each variable for each activity and each subject.
# note:
# the reshape package2 is needed here, please comment/uncomment following lines as needed
# install.packages("reshape2")
# library(reshape2)

trainAndTestDSMelt <- melt(trainAndTestDS, id = c("activityName",
                                  "subjectID"),
                           measure.vars = c("tBodyAccMeanX",
                                    "tBodyAccMeanY",
                                    "tBodyAccmeanZ",
                                    "tBodyAccStdX",
                                    "tBodyAcStdY",
                                    "tBodyAccStdZ"))

averageActAndSubj <- dcast(trainAndTestDSMelt, activityName + subjectID ~ variable, mean)

# the new database is written to a file named "averageActAndSubj.txt" in the working directory

write.table(averageActAndSubj, "./averageActAndSubj.txt", row.names = FALSE)

# to read the file above please use:
# ds02 <- read.table("./averageActAndSubj.txt", header = TRUE)
