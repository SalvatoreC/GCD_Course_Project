# GCD_Course_Project
Course Project for "Getting and Cleaning Data" at Coursera

Name of the R script file: run_analysis.R

Prerequisites:
- the working directory contains the unzipped "getdata_projectfiles_UCI HAR Dataset.zip" file, that is the "UCI HAR Dataset" directory and all its subdirectories are in the working directory;
- the following packages and libraries are installed and loaded: dplyr, reshape2.

Step 0 - Common data are read and descriptive column names are assigned.

Step 1 - Training data are read and descriptive column names are assigned.
Note: only mean and standard deviation measurements are extracted.

Step 2 - Testing data are read and descriptive column names are assigned.
Note: only mean and standard deviation measurements are extracted.

Step 3 - Train and Test datasets are merged to create one dataset.

Step 4 - An independent tidy data set is created with the average of each variable for each activity and each subject.

Output:
- a merged dataset is created and written to the working directory: trainAndTestDS.txt;
- a second, independent tidy data set with the average of each variable for each activity and each subject is created and written to the working directory: averageActAndSubj.txt (this is the tidy data set submitted in the Coursera GCD Course Project web page).

See CodeBook.txt for detailed variable descriptions.

