# TidyDataset
This is a script that combines several files together in one tidy dataset. There are 5 requirements:
    1. Merge the training and the test sets to create one data set.
    2. Extract only the measurements on the mean and standard deviation for each measurement.
    3. Use descriptive activity names to name the activities in the data set
    4. Appropriately label the data set with descriptive variable names.
    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
    
##################################################################
1. Merge the training and the test sets to create one data set.
##################################################################
- First thing to do is download the zip file and unzip it to a local directory
- Load the files into R aand merge the related files together e.g, subject, X and Y files
- Create a key for memory efficiency

##################################################################
2. Extract only the measurements on the mean and standard deviation for each measurement.
##################################################################
- Read the features.txt file to determine which variables in the dataset are measurements for the mean and standard deviation
- Get the subset for the mean and standard deviation using grep
- Convert the column numbers to a vector of variable names to match columns in the dataset

##################################################################
3. Use descriptive activity names to name the activities in the data set
##################################################################
- Read the activity_labels.txt file to get the activity labels

##################################################################
4. Appropriately label the data set with descriptive variable names
##################################################################
- Merge the activity labels from number 3 with the dataset
- Add the Activity Name as part of the key

##################################################################
5. From the data set in step 4, creates a second, independent tidy data set 
with the average of each variable for each activity and each subject.
##################################################################
- Create a second data set from #4 above, and for each subject and activity combination, get the average
