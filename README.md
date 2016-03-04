# README for run_analysis.R #
## DCS - Getting and Cleaning Data ##
### Project 3 ###

### Introduction ###

The run_analysis.R script has all the code necessary to perform the transformations and calculations required by the project.
More information about the structure for the code can be found in the codebook.md file of the repository. This repository
contains my work for the course project for the Coursera course "Getting and Cleaning Data."

### The Raw Data ###

The original data collected from the accelerometers from the Samsung Galaxy S Smartphone.
The 561 features are unlabled and are found in the x_test.txt file. The activity labels are found in the y_test.txt file, and
the test subjects are in the subject_test.txt file.

### Objective ###

The project aims to demonstrate abilities to collect, work with, and clean a given data set. The end result is to create a tidy
data set which may be used for subsequent analysis. 

### run_analysis.R ###

The program
* Merges the training and test data sets into one data set
* Extracts only the measurements of the mean and standard deviation for each measurement
* Utilizes descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names
* Creates a second, independent tidy data set with the average of each variable for activity and each subject

### Steps ###

1. The zip files is downloaded and unzipped to a specific location data folder; as it is a large file, if the
file exists, there will be no download repetition.
2. Next, the column names of the test and train data are named with descriptive labels. The data is then merged using rbind
and then cbind into data table where the first column consists of subject identifications, the second column consists of 
activity identifications, and the third column consists of the features.
3. Next, only the mean and standard deviation columns from the data set are extracted and stored in a new variable called
"featMeanStd." It was then subsetted from the entire data table.
4. Next, the data features were given descriptive character names and converted to factors in a for loop
5. The data was aggregated and saved to tidysetProject3.txt file

