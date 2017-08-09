## Prepare a tidy data that can be used later for analysis
## 1. This script merges the training and test data sets to create one data set
## 2. Extracts only the measurements on the mean and standard deviation
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names
## 5. Creates another, independent tidy data set
##
## Load packages and set vars
library(data.table)
path <- getwd()
z <- tempfile()

## Download and unzip the file
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, z)
unzip(z, exdir=path)
dpath <- file.path(path, "UCI HAR Dataset")

## 1. Read and merge train and test data
ds_trsubj <- read.table(file.path(dpath, "train", "subject_train.txt"))
ds_tesubj <- read.table(file.path(dpath, "test", "subject_test.txt"))
dtSubject <- rbind(ds_trsubj, ds_tesubj)
names(dtSubject) <- "Subject"
  
ds_trX <- read.table(file.path(dpath, "train", "X_train.txt"))
ds_teX <- read.table(file.path(dpath, "test", "X_test.txt"))
dtX <- rbind(ds_trX, ds_teX)

ds_trY <- read.table(file.path(dpath, "train", "Y_train.txt"))
ds_teY <- read.table(file.path(dpath, "test", "Y_test.txt"))
dtActivity <- rbind(ds_trY , ds_teY)
names(dtActivity) <- "Activity"

## Merge Columns
df1 <- cbind(dtSubject, dtActivity)
dfuci <- cbind(df1, dtX)

## Create key
dfuci <- as.data.table(dfuci)
setkey(dfuci, Subject, Activity)

## 2. Extracts only the measurements on the mean and standard deviation
## Get data from features.txt
ds_feature <- read.table(file.path(dpath, "UCI HAR Dataset", "features.txt"))
names(ds_feature) <- c("FeatureNo", "FeatureName"))

## Get the subset for the mean and standard deviation
ds_feature <- ds_feature[grepl("mean\\(\\)|std\\(\\)", ds_feature$FeatureName), ]

##Convert the column numbers to match columns in dfuci
ds_feature$FeatureCode <- paste0("V", c(1:66))

mylist <- c(key(dfuci), ds_feature$featureCode)
dfuci <- dfuci[mylist, with=FALSE]

## 3. Use Descriptive Activity Names
## Get data from activity_labels
ds_label <- read.table(file.path(dpath, "UCI HAR Dataset", "activity_labels.txt"))
names(ds_label) <- c("Activity", "ActivityName")

## 4. Label the dataset with Activity Names
## Merge activity labels
dfuci <- merge(dfuci, ds_label, by="Activity", all.x=TRUE)

## Add activity as key
setkey(dfuci, Subject, Activity, ActivityName)

## 5. Create a tidy dataset
dftidy <- dfuci %>%
  group_by(Subject, ActivityName) %>%
  summarize_all(funs(mean))

View(dftidy)

write.table(dftidy, "C:/Laren/Assignments/Course3/tid_data.txt")
