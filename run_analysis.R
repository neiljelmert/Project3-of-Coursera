#################################################
# Code for Project 3
#################################################

# Load the following libraries

library(dplyr)
library(data.table)
library(tidyr)


###############################
# Part 1: Reading the Data
###############################
# If the file to be loaded does not exist, create it

if(!file.exists("./project3")) {
      dir.create("./project3")
}

fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./project3/Dataset.zip", mode = "wb")

unzip(zipfile = "./project3/Dataset.zip", exdir = "./project3")

# Set the primary path and check the files for correctness

path <- file.path("./project3", "UCI HAR Dataset")
files <- list.files(path, recursive = TRUE)

# Allocate file paths for each .txt file in the download

testy <- file.path(path, "test", "y_test.txt")
trainy <- file.path(path, "train", "y_train.txt")

trainsub <- file.path(path, "train", "subject_train.txt")
testsub <- file.path(path, "test", "subject_test.txt")

testx <- file.path(path, "test", "x_test.txt")
trainx <- file.path(path, "train", "x_train.txt")

features <- file.path(path, "features.txt")
act <- file.path(path, "activity_labels.txt")

###############################
# Part 4(1): Label the loaded Data Set with descriptive variable names
###############################

featNames <- read.table(features, strip.white = TRUE, stringsAsFactors = FALSE)

testx <- read.table(testx)
colnames(testx) <- featNames$V2
trainx <- read.table(trainx)
colnames(trainx) <- featNames$V2

testy <- read.table(testy)
colnames(testy) <- c("activity_id")
trainy <- read.table(trainy)
colnames(trainy) <- c("activity_id")

testsub <- read.table(testsub)
colnames(testsub) <- c("subject_id")
trainsub <- read.table(trainsub)
colnames(trainsub) <- c("subject_id")

ActNames <- read.table(act)
colnames(ActNames) <- c("activity_id", "activity")

# cbind(rbind) tables

dSub <- rbind(trainsub, testsub)
dAct <- rbind(trainy, testy)
dt <- rbind(trainx, testx)

allData <- cbind(dSub, dAct, dt)
allData <- tbl_df(allData)

###############################
# Part 2: Extract the Mean/STD measurements on each measurement
###############################

featMeanStd <- featNames[grep("mean\\(\\)|std\\(\\)", featNames$V2), ]

allDataMS <- allData[ , c(1, 2, featMeanStd$V1 + 2)]

###############################
# Part 3: Descriptively name the activities in the Data Set
###############################

#allDataMS <- merge(ActNames, allDataMS, by = "activity_id", all.x = TRUE)
#allDataMS$activity <- as.character(allDataMS$activity)

allDataMS$activity <- as.character(allDataMS$activity)
for (i in 1:6) {
      allDataMS$activity[allDataMS$activity == i] <- as.character(ActNames[i,2])
}

# Convert to factors

allDataMS$activity <- as.factor(allDataMS$activity)

###############################
# Part4(2): Label the loaded Data Set with descriptive variable names
###############################


names(allDataMS) <- gsub("-mean()", "Mean", names(allDataMS), ignore.case = TRUE)
names(allDataMS) <- gsub("-std()", "STD", names(allDataMS), ignore.case = TRUE)
names(allDataMS) <- gsub("Acc", "Accelerometer", names(allDataMS))
names(allDataMS) <- gsub("Gyro", "Gyroscope", names(allDataMS))
names(allDataMS) <- gsub("BodyBody", "Body", names(allDataMS))
names(allDataMS) <- gsub("Mag", "Magnitude", names(allDataMS))
names(allDataMS) <- gsub("^t", "Times", names(allDataMS))
names(allDataMS) <- gsub("^f", "Frequency", names(allDataMS))
names(allDataMS) <- gsub("tBody", "TimeBody", names(allDataMS))

###############################
# Part 5: Make a tidy data set consisting of the mean of each variable for each activity/subject
###############################

tidyData <- aggregate(. ~subject_id + activity, allDataMS, mean)
tidyData <- tidyData[order(tidyData$subject_id, tidyData$activity),]

# Write the tidy table

write.table(format(tidyData, scientific=TRUE), "tidysetProject3.txt",
            row.names=FALSE, col.names=FALSE, quote=2)
