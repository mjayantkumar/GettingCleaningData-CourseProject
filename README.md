# Course Project Description
=============================

##### The Getting and Cleaning course project describes the following steps

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for       each activity and each subject.

#####Purpose of the Project
The purpose of this project is to merge and tidy the data set provided. The dataset is divided into test and train and the test and train dataset needs to be merged to form a clean and tidy dataset in a single file. Each of the test and train datasets consists of 561 columns and these need to be merged with subjects and one another. The top most row should contain the names of the features.txt file. 

##### Steps that need to be performed before runnig the method on run_analysis.R
1. Create or download the run_analysis.R in a directory on your machine. 
2. Download the dataset files from this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip  "Title") in to the run_analysis.R directory
3. Extract the dataset zip file into a directory called uci_har_dataset. The directory set would contain the 2 Directories (test and train) and files (activity_labels.txt, features.txt, features_info.txt , README.txt ) . The test directory contain 3 files (X_test.txt, y_test.txt,subject_test.txt) and one directory (Inertial Signals). The train directory contain the 3 files (X_train.txt, y_train.txt , subject_train.txt ) and one directory (Inertial Signals). The data set details are described in the README.txt file. The subject details are given in subject_test.txt and subject_train.txt .The data set the script works on  are X_test.txt, X_train.txt, y_test.txt, y_train.txt, subject_test.txt, subject_train.txt, activity_labels.txt and features.txt)
4. Install reshape2 package for running the run_analysis.R file 
5. Load the script using source('run_analysis.R') in RStudio. Please install RStudio if not installed.
6. Run the function mergeTidyData() from command line.
7. The output file tidy.txt will be generated in the output directory. 
8. The output diretory tidy.txt will contain 40 observations of all the means and standard deviations


