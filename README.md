# CourseraCleaningData

This function uses data for smart phone use from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
The data is wearable feature data from smart phones across multiple users and different measurements. The purpose of this code is to combine the data from its current 2 sets (training and test); drop all data that doesn't relate to the mean or standard deviation, and add descriptors including relevant subject and activity to the data.
The code also produces a summary in the form of overall means for the standard deviation and means for each user/ acitivity combination.

The code returns 2 different datatables from 2 different functions"
downloaddatat() returns the tidy data set in the form of a dataframe that contains all standard deviation and mean observations
run_analysis() calculates the mean for all variable columns for each unique subject/ activity combination and returns a dataframe

This has 2 functions within the run_analysis script. 

downloadData() function:
This function takes the zip file and downloads it from the source, merges the available datasets as per the instructions provided by the Assignment outline, and returns a tidy dataframe with the specified variables, descriptors and titles on the dataframe.

Steps to complete:
1. Access each of the txt files: x_test, y_test, and subject_test within the zip file and place them in data frames, combine these dataframes using cbind
2. Repeat 1 replacing test with train, binding columns together.
3. Row bind the data sets (they are of the same width) into single dataframe DF.

4. Download the activity names from the zip file and held in special table ACTS. Columns are labeled Training for the corresponding number for the activity and ActivityName for the activity name itself (descriptor).

5. Download the activity labels the are the column labels for the x_test/x_train data sets
6. Apply the column labels to the relevant columns in DF, along with column headers for the subject (Subject) and activity(Training)

7. All non-subject, non-training, non-mean values, non-standard deviation values columns are deleted from the DF table.

8. The ACTS and DF table are merged on the training code, the training code is then dropped.

9. The resulting data table is returned from the function

run_analysis() function:
1. Calls the downloadData() function to get a tidy data table
2. Uses dplyr data set in order to aggregate the data by finding the mean for all unique subject, activity.
3. The resulting summarized data table is returned.