Source of Data: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip for wearable tech. Full descriptors as to the raw data and descriptions of transformations applied by the data providers can be found within the zip file link. 

Original data (from providers)[1]:
"For each record it is provided:
======================================
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file."

Features are provided as described by the authors [1]:
"Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag"



DownloadData() function 
==============================================================
This file has the following
Inputs: Data from zip file above
Purpose:combine training and testing data sets contained within the zip folder text files, drops all values not associated with variable means or standard deviations, and appends the data with its Subject (person) label: a number representing the individual and the activity during which recording took place (a string descriptor). 
Outputs: dataframes as R objects

Features are expressed in their original units as contained in the original data set, no transformations are made to the variables themselves.
The original data is contained in 3 different files: feature data, feature subject labels, and activity labels. This data is held across 2 sets: a test set and training set.

Each of the 3 files acros both test sets is downloaded and bound together assuming they were recorded in the same order.
Labels are applied, assuming they are provided in decending order from the features.txt file corresponding to the same order they appear left to right in the x_train.txt and x_test.txt files.
Any column of the data that does not contain a -mean() or -std() label is dropped, assuming that it does not contain a mean or standard deviation for the data.
Using a merge command, the activities are aligned from the data contained in y_train.txt/ y_test.txt with the respective activity name contained in activity_labels.txt.
Remaining columns are returned to the user in a data frame.


Run_Analysis() function 
==============================================================
Inputs: R data frame from the downloadData() function described above
Purpose: calculate mean values for each variable for a single subject, activity combination from the dataframe created from DownloadData.
Outputs: Mean values of variables for subject, activity pairings for each type of mean and std. deviation variable observed.

All variables remain the same as described above: standard deviation and mean measurements at point in time from the original dataset. This file takes the mean for all entries with the same activityName and subject. For each of the variables, the mean is a simple mean (sum of entries divided by the number of entries).
All units remain the same as in the original file.

Data has been provided by:
[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

