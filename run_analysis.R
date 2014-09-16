## Read_merge_train_test
## _____________________
## Read train and test file into dataframes;  
## Merge these data frames and return the new data frame created from the merge operation.
##
## Parameters:
##   train_fn - train file name
##   test_fn - test file name
## Return
##   a data.frame with the files merged by row
##
read_merge_train_test <- function (train_fn, test_fn) {
    
    train_df <- read.table(train_fn)
    test_df <- read.table (test_fn)
    rbind (train_df, test_df)
}
##
## run_analysis() 
## ______________
## Execute the requirements of the Course Project for 
## Coursera getdata-007.
##
## R1. Merges the training and the test sets to create one data set.
## R2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## R3. Uses descriptive activity names to name the activities in the data set.
## R4. Appropriately labels the data set with descriptive variable names. 
## R5. From the data set in step 4, creates a second, independent tidy data set with the average
##     of each variable for each activity and each subject. 
##
## Parameter:
##   base_dir- the directory where the files are organized in the same structure of the original
##             data set.
##
## Return:
##   a data frame containing the data set with the average of each variable for each activity and each subject.
##             
##
run_analysis <- function (base_dir="./") {
##
## Merge the training and test data set to create one data set (R1)
##    
    train_ffn <- paste(base_dir, "train/X_train.txt", sep="")
    test_ffn <- paste(base_dir, "test/X_test.txt", sep="")
    train_test_df <- read_merge_train_test (train_ffn, test_ffn)
##
##
## Read the features file and select the indexes of those which are related to 
## mean and std (preparing for R2)
##
## Note: the "ms" prefix in the variable names means that the variable contains
##       only the features related to mean and std.
##
    features_df <- read.table(paste(base_dir, "features.txt", sep=""))
    ms_features_idx <- grep("*mean*|*std*", features_df[,2])
##
## Extract the measurements related to mean and std (R2)
##
    ms_train_test_df <- train_test_df [,ms_features_idx]     
##
## Insert the feature names as variable names in the data frame (R4)
##
    colnames(ms_train_test_df) <- features_df[ms_features_idx,2]
    ms_train_test_df
##
##
##  Add to the data frame a column with the activity names coming from
##  the files y-Train & y-Test which rows are syncronixed with the rows in the
##  X-train and X-test files (R3).
##
##  -- First - read the activity labels
##
    act_labels_df <- read.table (paste(base_dir, "activity_labels.txt", sep=""))
##
##  -- Read the activities
##
    act_train_test_df <- read_merge_train_test (paste(base_dir, "train/y_train.txt",sep=""),
                                                paste(base_dir, "test/y_test.txt", sep=""))
##
##  -- Add a column to the data frame with the acitivity labels
##
    ms_train_test_df["activity"] <- act_labels_df[act_train_test_df[,1],2]
##
##  Add to the data frame a column with the subject ids coming from
##  the files subject_train & ysubject_test which rows are syncronixed with the rows in the
##  X-train and X-test files (preparing for R5).
##
##  -- Read the subjects
##
    sub_train_test_df <- read_merge_train_test (paste(base_dir, "train/subject_train.txt", sep=""),
                                                paste(base_dir, "test/subject_test.txt", sep=""))
##
##  -- Add a column to the data frame with the subject ids.
##
    ms_train_test_df["subject"] <- sub_train_test_df
##
##  Creates a new data set with the average of each variable for each activity
##  and each subject
##
    ms_tt_summarised_df <- summarise_each(group_by(ms_train_test_df, activity, subject),
                                          funs(mean))
    ms_tt_summarised_df
}

