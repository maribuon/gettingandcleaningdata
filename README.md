# gettingandcleaningdata
project for the course with the name above

This repository contains a simple solution for the final project on the course Getting and Cleanining Data.

The script run_analysis.R which reads the suject, X and y file for the training and test datasets of UCI HAR Dataset (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The input dataset contains features (combinations of measuraments) for accelerometer and gyroscope of subjects' mobiles, captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. 

The output is both a file 'summary_mean.txt' and the head of this file, which contains the summary for each one of the 30 participants in each of the following activities: standing, sitting, laying, walking, walking_downstairs, walking_upstairs.
