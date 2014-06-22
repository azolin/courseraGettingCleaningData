--- README ---

run_analysis.R script: 

Script extracts mean and standard deviation for variables from training set and test set 
of "Human Activity Recognition Using Smartphones Data Set" (http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones);

Data was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Note: 
 -> following files have to be in same folder as script: 
activity_labels.txt
subject_test.txt
subject_train.txt
X_test.txt
Y_test.txt
x_train.txt
y_train.txt
features.txt

   -> files are included on this github repository
   
Script function:
 1) extracts variables from X_test and x_train, matches them with 
 Y_test and y_train to create main dataset
 2) features.txt is used to extract variable names which include mean 
 and standard deviation and these are extracted from main dataset
 3) appropriate variable names are added to main dataset
 and activity names are loaded from activity_labels.txt and applied 
 to main dataset
   -> this dataset is saved as "tidy_dataset_01.txt"
 
 4) subject IDs are added to dataset and it is aggregated
 by subject and by activity; means are calculated for each
 subject/activity group for each variable
   -> this dataset is saved as "tidy_dataset_aggregated.txt"