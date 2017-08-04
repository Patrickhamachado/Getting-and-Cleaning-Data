CodeBook
================

Getting and Cleaning Data Course Project
----------------------------------------

This is the **CodeBook** for the assignment of week 4 of the *Getting and Cleaning Data* Course Project.

This Repo is intendend to achieve the instructions of the assigment, those can be found in: <https://www.coursera.org/learn/data-cleaning/peer/FIZtT/getting-and-cleaning-data-course-project>

The original data can be found in: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

The original description of the data is in: <http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones>

The description of the original dataset is in: <http://archive.ics.uci.edu/ml/machine-learning-databases/00240/UCI%20HAR%20Dataset.names>

The repo made to acomplish the assignment is located in: <https://github.com/Patrickhamachado/Getting-and-Cleaning-Data>

Special thanks to David Hood and his advise in: <https://thoughtfulbloke.wordpress.com/2015/09/09/getting-and-cleaning-the-assignment>

Description of run\_analysis.R script
-------------------------------------

The main activities the script does are:

### 1- File Downloading

If the file "./data/getdata%2Fprojectfiles%2FUCI HAR Dataset.zip" doesn't exist, it is downloaded

### 2- File Extracting

If the folder "./data/UCI HAR Dataset" doesn't exits, the previous file is extracted there

### 3- Files reading

In the next table there are the main R variables that the script creates, by reading the respective file.

    ##          Variable                                           File
    ## 1 activity_labels     ./data/UCI HAR Dataset/activity_labels.txt
    ## 2        features            ./data/UCI HAR Dataset/features.txt
    ## 3    subject_test   ./data/UCI HAR Dataset/test/subject_test.txt
    ## 4          y_test         ./data/UCI HAR Dataset/test/y_test.txt
    ## 5          X_test         ./data/UCI HAR Dataset/test/X_test.txt
    ## 6   subject_train ./data/UCI HAR Dataset/train/subject_train.txt
    ## 7         y_train       ./data/UCI HAR Dataset/train/y_train.txt
    ## 8         X_train       ./data/UCI HAR Dataset/train/X_train.txt

#### 3.1 activity\_labels

This variable has the six activities and their id's (1:6)

``` r
activity_labels
```

    ##   activity_id           activity
    ## 1           1            WALKING
    ## 2           2   WALKING_UPSTAIRS
    ## 3           3 WALKING_DOWNSTAIRS
    ## 4           4            SITTING
    ## 5           5           STANDING
    ## 6           6             LAYING

#### 3.2 features

It has the 561 features than where measured on the experiments and their id's (1:561)

``` r
nrow (features) 
```

    ## [1] 561

``` r
head(features)
```

    ##   feature_id           feature
    ## 1          1 tBodyAcc-mean()-X
    ## 2          2 tBodyAcc-mean()-Y
    ## 3          3 tBodyAcc-mean()-Z
    ## 4          4  tBodyAcc-std()-X
    ## 5          5  tBodyAcc-std()-Y
    ## 6          6  tBodyAcc-std()-Z

#### 3.3 subject\_test

This variable has 2947 rows with the subject id for each of the test observations. It has 9 diferent subjects, that corresponds to 30% of the total of 30 participants, which were choosed for the test data.

``` r
nrow(subject_test)
```

    ## [1] 2947

``` r
unique(subject_test)
```

    ##      subject
    ## 1          2
    ## 303        4
    ## 620        9
    ## 908       10
    ## 1202      12
    ## 1522      13
    ## 1849      18
    ## 2213      20
    ## 2567      24

``` r
nrow (unique(subject_test) )
```

    ## [1] 9

#### 3.4 y\_test

It has 2947 rows with the activity id (a number between 1:6) for each of the test observations.

``` r
nrow (y_test) 
```

    ## [1] 2947

``` r
sort ( unique(y_test[,]) )
```

    ## [1] 1 2 3 4 5 6

For make easier the coming merging, this variable was factorized:

``` r
y_test = factor(y_test$y_test, levels = activity_labels$activity_id, 
       labels = activity_labels$activity )

head(y_test)
```

    ## [1] STANDING STANDING STANDING STANDING STANDING STANDING
    ## 6 Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS ... LAYING

#### 3.5 X\_test

This is one of the principal variables and has the test data, 2947 rows and 561 features (columns).

#### 3.6 subject\_train

This variable has 7352 rows with the subject id for each of the train observations. It has 21 diferent subjects, that corresponds to 70% of the total of 30 participants, which were choosed for the train data.

``` r
nrow(subject_train)
```

    ## [1] 7352

``` r
unique(subject_train)
```

    ##      subject
    ## 1          1
    ## 348        3
    ## 689        5
    ## 991        6
    ## 1316       7
    ## 1624       8
    ## 1905      11
    ## 2221      14
    ## 2544      15
    ## 2872      16
    ## 3238      17
    ## 3606      19
    ## 3966      21
    ## 4374      22
    ## 4695      23
    ## 5067      25
    ## 5476      26
    ## 5868      27
    ## 6244      28
    ## 6626      29
    ## 6970      30

``` r
nrow (unique(subject_train) )
```

    ## [1] 21

#### 3.7 y\_train

It has 7352 rows with the activity id (a number between 1:6) for each of the train observations.

``` r
nrow (y_train) 
```

    ## [1] 7352

``` r
sort ( unique(y_train[,]) )
```

    ## [1] 1 2 3 4 5 6

For make easier the coming merging, this variable was factorized:

``` r
y_train = factor(y_train$y_train, levels = activity_labels$activity_id, 
       labels = activity_labels$activity ) 

head(y_train)
```

    ## [1] STANDING STANDING STANDING STANDING STANDING STANDING
    ## 6 Levels: WALKING WALKING_UPSTAIRS WALKING_DOWNSTAIRS ... LAYING

#### 3.8 X\_train

This is the second of the principal variables and has the train data, 7352 rows and 561 features (columns).

### 4- Renaming features

Analyzing the variable "features", I noticed that there are certain features that are not unique. A new column, features$repcol, was created to identify these repeated features, indicating how many times there is each name. Below there are those repeated features. There it can be noticed than all the names that are more than once, are present exactly three times.

``` r
unique( features[features$repcol > 1, c("feature" , "repcol")] )
```

    ##                              feature repcol
    ## 303       fBodyAcc-bandsEnergy()-1,8      3
    ## 304      fBodyAcc-bandsEnergy()-9,16      3
    ## 305     fBodyAcc-bandsEnergy()-17,24      3
    ## 306     fBodyAcc-bandsEnergy()-25,32      3
    ## 307     fBodyAcc-bandsEnergy()-33,40      3
    ## 308     fBodyAcc-bandsEnergy()-41,48      3
    ## 309     fBodyAcc-bandsEnergy()-49,56      3
    ## 310     fBodyAcc-bandsEnergy()-57,64      3
    ## 311      fBodyAcc-bandsEnergy()-1,16      3
    ## 312     fBodyAcc-bandsEnergy()-17,32      3
    ## 313     fBodyAcc-bandsEnergy()-33,48      3
    ## 314     fBodyAcc-bandsEnergy()-49,64      3
    ## 315      fBodyAcc-bandsEnergy()-1,24      3
    ## 316     fBodyAcc-bandsEnergy()-25,48      3
    ## 382   fBodyAccJerk-bandsEnergy()-1,8      3
    ## 383  fBodyAccJerk-bandsEnergy()-9,16      3
    ## 384 fBodyAccJerk-bandsEnergy()-17,24      3
    ## 385 fBodyAccJerk-bandsEnergy()-25,32      3
    ## 386 fBodyAccJerk-bandsEnergy()-33,40      3
    ## 387 fBodyAccJerk-bandsEnergy()-41,48      3
    ## 388 fBodyAccJerk-bandsEnergy()-49,56      3
    ## 389 fBodyAccJerk-bandsEnergy()-57,64      3
    ## 390  fBodyAccJerk-bandsEnergy()-1,16      3
    ## 391 fBodyAccJerk-bandsEnergy()-17,32      3
    ## 392 fBodyAccJerk-bandsEnergy()-33,48      3
    ## 393 fBodyAccJerk-bandsEnergy()-49,64      3
    ## 394  fBodyAccJerk-bandsEnergy()-1,24      3
    ## 395 fBodyAccJerk-bandsEnergy()-25,48      3
    ## 461      fBodyGyro-bandsEnergy()-1,8      3
    ## 462     fBodyGyro-bandsEnergy()-9,16      3
    ## 463    fBodyGyro-bandsEnergy()-17,24      3
    ## 464    fBodyGyro-bandsEnergy()-25,32      3
    ## 465    fBodyGyro-bandsEnergy()-33,40      3
    ## 466    fBodyGyro-bandsEnergy()-41,48      3
    ## 467    fBodyGyro-bandsEnergy()-49,56      3
    ## 468    fBodyGyro-bandsEnergy()-57,64      3
    ## 469     fBodyGyro-bandsEnergy()-1,16      3
    ## 470    fBodyGyro-bandsEnergy()-17,32      3
    ## 471    fBodyGyro-bandsEnergy()-33,48      3
    ## 472    fBodyGyro-bandsEnergy()-49,64      3
    ## 473     fBodyGyro-bandsEnergy()-1,24      3
    ## 474    fBodyGyro-bandsEnergy()-25,48      3

After comparing some data, I noticed than the columns on "X\_test" and "X\_train" than correspond with those repeated names on the features variable are not te same, so the columns should have different names in order to prevent conflicts in merging the data of the two datasets.

A new column was created, features$uniquename, to rename the features. Normally, it has the original feature name, and in the case than the feature is repeated, a suffix was added, "\_X", "\_Y" and "\_Z" in each of its apeareances. Below there is some of the new names.

``` r
head(features$uniquename[features$repcol == 3] , 20)
```

    ##  [1] "fBodyAcc-bandsEnergy()-1,8_X"   "fBodyAcc-bandsEnergy()-9,16_X" 
    ##  [3] "fBodyAcc-bandsEnergy()-17,24_X" "fBodyAcc-bandsEnergy()-25,32_X"
    ##  [5] "fBodyAcc-bandsEnergy()-33,40_X" "fBodyAcc-bandsEnergy()-41,48_X"
    ##  [7] "fBodyAcc-bandsEnergy()-49,56_X" "fBodyAcc-bandsEnergy()-57,64_X"
    ##  [9] "fBodyAcc-bandsEnergy()-1,16_X"  "fBodyAcc-bandsEnergy()-17,32_X"
    ## [11] "fBodyAcc-bandsEnergy()-33,48_X" "fBodyAcc-bandsEnergy()-49,64_X"
    ## [13] "fBodyAcc-bandsEnergy()-1,24_X"  "fBodyAcc-bandsEnergy()-25,48_X"
    ## [15] "fBodyAcc-bandsEnergy()-1,8_Y"   "fBodyAcc-bandsEnergy()-9,16_Y" 
    ## [17] "fBodyAcc-bandsEnergy()-17,24_Y" "fBodyAcc-bandsEnergy()-25,32_Y"
    ## [19] "fBodyAcc-bandsEnergy()-33,40_Y" "fBodyAcc-bandsEnergy()-41,48_Y"

### 5- Merge data

In order to merge the data, a previous treatment of the two main variables, "X\_test" and "X\_train", was made:

1.  The 561 columns of both datasets were named as features$uniquename
2.  The column "dataset" was added, as the first column, with the value of "Test" and "Train", for the corresponding data
3.  The column "subject" was added, as the second column, with the value of variables "subject\_test" and "subject\_train"
4.  The column "activity" was added, as the third column, with the value of variables "y\_test" and "y\_train", that have the description of the corresponding activity of each observation

The script merge the test and train data, in a variable called **"CompleteData"**, that acomplies the first point of the assignment: "Merges the training and the test sets to create one data set."

The final dataset also accomplies the third requirement: "Uses descriptive activity names to name the activities in the data set", as can be seen in the third column: CompleteData$activity.

By naming the columns 4 to 564 of the final dataset as in features$uniquename, the fourth requirement "Appropriately labels the data set with descriptive variable names" is also covered.

### 6- Extracting mean and standard deviation

To accomplish the second requirement "Extracts only the measurements on the mean and standard deviation for each measurement", first is necesary to decide which features are going to be extracted.

To do that, a new column was created, features$meanorstd, in the "features" variable, to identify those columns that are going to be extracted: those than have "mean()" or "std()" in his name. Below there is the list of the 66 features choosed.

``` r
features[features$meanorstd == TRUE, "uniquename"]
```

    ##  [1] "tBodyAcc-mean()-X"           "tBodyAcc-mean()-Y"          
    ##  [3] "tBodyAcc-mean()-Z"           "tBodyAcc-std()-X"           
    ##  [5] "tBodyAcc-std()-Y"            "tBodyAcc-std()-Z"           
    ##  [7] "tGravityAcc-mean()-X"        "tGravityAcc-mean()-Y"       
    ##  [9] "tGravityAcc-mean()-Z"        "tGravityAcc-std()-X"        
    ## [11] "tGravityAcc-std()-Y"         "tGravityAcc-std()-Z"        
    ## [13] "tBodyAccJerk-mean()-X"       "tBodyAccJerk-mean()-Y"      
    ## [15] "tBodyAccJerk-mean()-Z"       "tBodyAccJerk-std()-X"       
    ## [17] "tBodyAccJerk-std()-Y"        "tBodyAccJerk-std()-Z"       
    ## [19] "tBodyGyro-mean()-X"          "tBodyGyro-mean()-Y"         
    ## [21] "tBodyGyro-mean()-Z"          "tBodyGyro-std()-X"          
    ## [23] "tBodyGyro-std()-Y"           "tBodyGyro-std()-Z"          
    ## [25] "tBodyGyroJerk-mean()-X"      "tBodyGyroJerk-mean()-Y"     
    ## [27] "tBodyGyroJerk-mean()-Z"      "tBodyGyroJerk-std()-X"      
    ## [29] "tBodyGyroJerk-std()-Y"       "tBodyGyroJerk-std()-Z"      
    ## [31] "tBodyAccMag-mean()"          "tBodyAccMag-std()"          
    ## [33] "tGravityAccMag-mean()"       "tGravityAccMag-std()"       
    ## [35] "tBodyAccJerkMag-mean()"      "tBodyAccJerkMag-std()"      
    ## [37] "tBodyGyroMag-mean()"         "tBodyGyroMag-std()"         
    ## [39] "tBodyGyroJerkMag-mean()"     "tBodyGyroJerkMag-std()"     
    ## [41] "fBodyAcc-mean()-X"           "fBodyAcc-mean()-Y"          
    ## [43] "fBodyAcc-mean()-Z"           "fBodyAcc-std()-X"           
    ## [45] "fBodyAcc-std()-Y"            "fBodyAcc-std()-Z"           
    ## [47] "fBodyAccJerk-mean()-X"       "fBodyAccJerk-mean()-Y"      
    ## [49] "fBodyAccJerk-mean()-Z"       "fBodyAccJerk-std()-X"       
    ## [51] "fBodyAccJerk-std()-Y"        "fBodyAccJerk-std()-Z"       
    ## [53] "fBodyGyro-mean()-X"          "fBodyGyro-mean()-Y"         
    ## [55] "fBodyGyro-mean()-Z"          "fBodyGyro-std()-X"          
    ## [57] "fBodyGyro-std()-Y"           "fBodyGyro-std()-Z"          
    ## [59] "fBodyAccMag-mean()"          "fBodyAccMag-std()"          
    ## [61] "fBodyBodyAccJerkMag-mean()"  "fBodyBodyAccJerkMag-std()"  
    ## [63] "fBodyBodyGyroMag-mean()"     "fBodyBodyGyroMag-std()"     
    ## [65] "fBodyBodyGyroJerkMag-mean()" "fBodyBodyGyroJerkMag-std()"

The **MeanStdData** variable is the one than has only the choosed features.

### 7- Exporting the average of each variable

In the script, the average of the selected features, grouped by activity and subject, are calculated in the variable **avgData**, and it is exported to a file called **"./data/avgData.txt"**.

To retrieve the information of the exported data, use: **`read.table("./data/avgData.txt", header = TRUE )`**
