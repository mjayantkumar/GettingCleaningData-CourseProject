## The Merg_data functon mereges the data from the UCI HAR Dataset" 

##The merge data function loads the data from the files into the
## respective variables and later merges the test and the train data 
## into data frame. The data frame is constructed using read.table.
## The workspace is located one level above the dataset direcotry path.

## To load and run the function. Use source('run_analysis.R')
## calling the function mergeTidyData()

mergeTidyData <- function() {
  
  library(reshape2)
  ##The paths to the below datasets are given as below.
  ##The paths of test and train dataset for X 
  ## and Y are as give below. 
  
  x_test_path <- "./uci_har_dataset/test/X_test.txt"
  y_test_path <- "./uci_har_dataset/test/y_test.txt"
  sub_test_path <- "./uci_har_dataset/test/subject_test.txt"
  x_train_path <- "./uci_har_dataset/train/X_train.txt"
  y_train_path <- "./uci_har_dataset/train/y_train.txt"
  sub_train_path <- "./uci_har_dataset/train/subject_train.txt"
  activites_path <- "./uci_har_dataset/activity_labels.txt"
  features_path <- "./uci_har_dataset/features.txt"
  
  ##Load the data of train and test using read.table and it constructs a data
  ##frame out it 
  
  ## Read the features data into a data frame using read.table
  features_df <- read.table(features_path)
  feature_names<- features_df$V2
  
  ##Load the subjects data into dataframes
  sub_test = read.table(sub_test_path)
  sub_trn = read.table(sub_train_path)
  #Adding the column name to the subject for test and train
  names(sub_test) <- "SubjectId"
  names(sub_trn)  <- "SubjectId"
  
  ##load the train data into data frame variables called as df_train_data and 
  ##y_train_data
  
  trn_x_df <- read.table(x_train_path)
  trn_y_df <- read.table(y_train_path)
  
  ### Load the train data into data frame variables called as x_test_data and
  ## y_test_data
  
  test_x_df <- read.table(x_test_path)
  test_y_df <- read.table(y_test_path)
  
  ##Adding columns names to test_x_df and train_x_df
  names(test_x_df) <- feature_names
  names(trn_x_df)  <- feature_names
  
  ## read activities into data frame
  activities_df <- read.table(activites_path)
    
  ## Merge the activities/labels  for y_test and y_train
  act_test_y_df <- merge(test_y_df, activities_df)   
  act_trn_y_df  <- merge(trn_y_df, activities_df)
  
  ## Activity vector with the names to be assigned to activities
  activity_vec <- c("ActivityId", "Activity")
  names(act_test_y_df) <- activity_vec
  names(act_trn_y_df)  <- activity_vec
  
  ## The below dataframes hold the data for the test and train using cbind.
  ## The test_df represents the test dataframe and the trn_df represents the
  ## train dataframe
  test_df  <- cbind(sub_test, act_test_y_df,test_x_df)
  trn_df   <- cbind(sub_trn, act_trn_y_df, trn_x_df)
  
  ##The merged dataframe has the data related to test and train 
  ##Completed until :: Step 1 Merged the dataset for test and train 
  merged_df <- rbind(trn_df, test_df)
  ##return(merged_df)
  
  ## Starting Step 2:
  
  ## Get the columns indices for mean and std deviation using the grepl function
  mean_std_cols <- grepl("(mean\\(\\)|std\\(\\))", names(merged_df))
  
  ## keeping the id and activity cols as wl 
  mean_std_cols[1:3] <- TRUE
  
  ##Get the data frame that consists of merged data that contains only the mea, std cols
  
  merged_df <- merged_df[, mean_std_cols]
  
  # convert the activity column from integer to factor
  #merged_df$Activity <- factor(merged_df$Activity, labels=c("Walking",
  #                                                        "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying"))
  
  ##Use Descriptive 
  
  melted_data <- melt(merged_df, id=c("SubjectId","ActivityId","Activity"))
  tidy_data <- dcast(melted_data, formula = SubjectId + ActivityId + Activity ~ variable, mean) 
  
  ##Rename the colnames properly by removing parenthesiis using gsub function
  col_names_vector <- colnames(tidy_data)
  col_names_vector <- gsub("-mean()","Mean",col_names_vector,fixed=TRUE)
  col_names_vector <- gsub("-std()","Std",col_names_vector,fixed=TRUE)
  col_names_vector <- gsub("BodyBody","Body",col_names_vector,fixed=TRUE)
  
  ## Set the colnames with the new names.
  colnames(tidy_data) <- col_names_vector
  
  
  ## Write the data to the csv file using a comma separator.
  write.table(tidy_data, file="tidy.csv", sep=",", row.names=FALSE)
  ## Write file to a txt file using a tab separator
  write.table(tidy_data, file="tidy.txt", sep="\t", row.names=FALSE)
  
}
