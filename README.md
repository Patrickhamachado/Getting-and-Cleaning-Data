README
================

Getting and Cleaning Data Course Project
----------------------------------------

This is the **ReadME** for the assignment of week 4 of the *Getting and Cleaning Data* Course Project.

The original data can be found in: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The original description of the data is in: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The description of the original dataset is in: <http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names>

Special thanks to David Hood and his advise in: <https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment>

This Repo is intendend to achieve the instructions of the assigment, those can be found in: <https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project>

The assignment is this:

`You should create one R script called run_analysis.R that does the following.`

`1. Merges the training and the test sets to create one data set.`

`2. Extracts only the measurements on the mean and standard deviation for each measurement.`

`3. Uses descriptive activity names to name the activities in the data set`

`4. Appropriately labels the data set with descriptive variable names.`

`5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.`

The file **`run_analysis.R`** does all the work to acomplish the assignment.

### Instructions:

1.  Download the file **run\_analysis.R**
2.  Open it in R
3.  Execute it. It downloads, extracts and process the data. In the **CodeBook** there is a detailed explanation of what the script does.
4.  Open the file **"./data/avgData.txt"**, that it's geneated for the script, which has the average of each variable, point 5. of the assignment
