#This code downloads data from a zipfile, takes labels for the data and concatenates it with the data. The code
# drops any non-mean or non-standard deviation variable observations, it adds descriptors to the data for column variables
# and the related subject and activity related to the data. It returns the resulting clean data frame for analysis.
downloadData <- function (){
    #address for the data
    urlAddy <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    
    #tempfile is created in order to download the ZIP directory
    temp <- tempfile()
    download.file(urlAddy,temp)
    
    #downloads all of the testing data required (unz unzips the data)
    data0 <- read.table(unz(temp, "UCI HAR Dataset/test/subject_test.txt"))   #test data set subject labels
    data1 <- read.table(unz(temp, "UCI HAR Dataset/test/X_test.txt"))         #test data set values
    data2 <- read.table(unz(temp, "UCI HAR Dataset/test/y_test.txt"))         #test data set training labels
    
    #combine all necessary test dataset into single dataframe df
    df1 <- cbind(data0,data2)
    df1 <- cbind(df1,data1)
    
    #downloads all of the training data required
    dataa <- read.table(unz(temp, "UCI HAR Dataset/train/subject_train.txt"))   #train data set subject labels
    datab <- read.table(unz(temp, "UCI HAR Dataset/train/X_train.txt"))         #train data set values
    datac <- read.table(unz(temp, "UCI HAR Dataset/train/y_train.txt"))         #train data set training labels
    
    #combine all of the necessary training dataset into single dataframe df2
    df2 <- cbind(dataa,datac)
    df2 <- cbind(df2,datab)
    
    #combine the datasets into a single dataframe df
    df <- rbind(df1,df2)
    
    
    #These are the activity names that will be used to add descriptors to the tidy dataset
    acts <- read.table(unz(temp, "UCI HAR Dataset/activity_labels.txt")) 
    colnames(acts)<-c('Training','ActivityName') #Labels are assigned to these columns, note that the training label is particularly sensitive
    
    
    #This extracts the features titles - contains all of the titles
    df.labels <- read.table(unz(temp,"UCI HAR Dataset/features.txt")) 
    m<- as.character(labels$V2) #extract just the titles as text
    
    
    #Create a new header for the columns of the data frame with the subject, the activity number (training), and each of the features
    headLabel<-c('Subject', 'Training',m)
    colnames(df)<-headLabel  #assigns this label to the dataFrame
    
    #This pulls only columns that are those we added to the data (subject and training) or any of the features that have
    # the mean or standard deviation information from the dataset
    df <- df[,grepl("-mean()",headLabel)|grepl("-std()",headLabel)|grepl("Subject",headLabel)|grepl("Training",headLabel)]
    
    #This takes the activity names, merges them with the current numerical values to get the text label for each activity
    #and then drops the old number label (removes it from the DF) based on its current title (Training)
    #Note that in the acts table the first column (activity numbers) was labeled with the same Training label so that no
    # further specification are required for the merge command here. Also note that all other headers are unique so nothing
    # else will be combined on.
    df <- merge(df,acts)
    
    #Drops the old Training column from the Data.Frame now that individual 
    df <- df[,!(names(df) %in% 'Training')]
    unlink(temp)
    
    df
}

#runAnalysis function returns dataframe with the means for each of the mean and std. dev. variables from the dataframe
#created above for each unique activity, subject pair and returns a summary dataframe with those subject, activity 
run_analysis <- function() {
  library(dplyr)
  df <- downloadData()
  #group data by the subject and activity; take means of each of their values and return this dataframe.
  dfAvg <- df %>% group_by(Subject,ActivityName) %>% summarize_each(funs(mean))
  dfAvg
}



