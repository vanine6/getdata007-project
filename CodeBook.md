## CodeBook for the Coursera getdata-007 Course Project

### Dataset Directory for the Script

The **run_analysis** function receives as a parameter the base directory where the files are organized in the same structure as
supplied for the course project. This means that run_analysis expects to receive the following structure:

* \<base directory\>
  * test
    * subject-test.txt
    * X_test.txt
    * y_test.txt
  * train
    * subject-train.txt
    * X_train.txt
    * y_train.txt
  * activity-labels.txt
  * features.txt
    
### Dataset Contents

**X_train.txt**

  Each line contains a set of 561 measurements related to a subject performing one activity. The 561 measuremente are 
  variables (columns) in the file. These measurements are identified in the **features.txt** file. 
  The subject corresponding to each row is in the file **subject_train.txt**. It is identified as
  a number in the 1..30 interval. In the same way, the activity corresponding to each row is in the file **y_train.txt**.
  In this file, the activity is a number in the 1..6 interval. 
  The corresponding name of each activity is in the **activity-labels.txt**.
      
**X_test.txt**

  Same description substituting "train" by "test".

### Data Transformations

the rest of this document describes the transformations performed to the data 

-- Merges the training and the test sets to create one data set.

The X_train and X_test files are read and merged in a data frame "train_test_df". 
The data frame "train_test_df" has *n+m* rows and 561 columns where *n* and *m* are the number of rows in the X_train and X_test file, respectively.

-- Extracts only the measurements on the mean and standard deviation for each measurement. 

To define which features are mean or standard deviation, the criteria is to check the feature names (in the features.txt)
contains the substrings "mean" or "std". 
The features are read to the "features_df" variable.
The subset obtained is stores in the variable "ms_features_idx".
Finally the variable "ms_train_test_df" is created from "train_test_df" with the columns identified in "ms_features_df". 

-- Appropriately labels the data set with descriptive variable names. 

In this step, the colnames of "ms_train_test_df" are set to the names in "features_df" corresponding to the indexes 
in "ms_features_idx".

-- Uses descriptive activity names to name the activities in the data set.

The "ms_train_test_df" is increased byf one column named "activity". The rows for this columns are obtained from the merge of
y_train.txt and y_test.txt files, since they correspond to the rows in X_train.txt and X_test.txt files, and transformed
to the names from the avtivity-labels.

-- From the data set in step 4, creates a second, independent tidy data set with the average
   of each variable for each activity and each subject. 
   
This is performed in two steps. 
The first, the "ms_train_test_df" increased by one more column named "subjecty". The rows for this columns are obtained 
from the merge of subject_train.txt and subject_test.txt files, since they correspond to the rows in X_train.txt and X_test.txt
files.
Finally, the "ms_tt_summarised_df" data frame is created. Each row corresponds to the pair (activity, subject) and 
contains the average of the values corresponding to this pair in the "ms_train_test_df" variable.
