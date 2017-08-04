# ------------------        Libraries    ---------------
library(plyr)
library(dplyr)


# ------------------        1- File Downloading    ---------------
if (!file.exists( "./data" )) { 
    dir.create( "./data" ) 
}

zipfile = "./data/getdata%2Fprojectfiles%2FUCI HAR Dataset.zip"
if ( !file.exists( zipfile ) ) {
    print( "Dowloading file ..." )
    fileUrl1 = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
    print( paste("From" , fileUrl1) )
    download.file( fileUrl1 , destfile = zipfile)
}   

# ------------------        2- File Extracting    ---------------
if ( !file.exists( "./data/UCI HAR Dataset" ) ) {
    print( "Extracting folder ..." )
    unzip(zipfile , exdir = "./data")
}   



# ------------------        3- Files reading    ---------------

            # Common
#activity_labels
activity_labels = read.delim( "./data/UCI HAR Dataset/activity_labels.txt"
                         , sep = "", header = FALSE )
names(activity_labels) = c("activity_id", "activity" )
#nrow (unique(activity_labels) )    # 6 activities

# features
features = read.delim( "./data/UCI HAR Dataset/features.txt"
                              , sep = "", header = FALSE )
names(features) = c("feature_id", "feature" )
#nrow (features)     # 561 features

            # Test
# subject_test
subject_test = read.csv( "./data/UCI HAR Dataset/test/subject_test.txt"
                         , header = FALSE )
names(subject_test) = "subject"
#nrow (unique(subject_test) )    # 9 subjects

# y_test
y_test = read.csv( "./data/UCI HAR Dataset/test/y_test.txt"
                         , header = FALSE )
names(y_test) = "y_test"
nrow (unique(y_test) )    # 6 activity ids

y_test = factor(y_test$y_test, levels = activity_labels$activity_id, 
       labels = activity_labels$activity )

# X_test
X_test = read.delim( "./data/UCI HAR Dataset/test/X_test.txt"
                           , sep = "", header = FALSE)
names(X_test) = features$feature


            # Train
# subject_train
subject_train = read.csv( "./data/UCI HAR Dataset/train/subject_train.txt"
                          , header = FALSE )
names(subject_train) = "subject"
#nrow(unique(subject_train) )    # 21 subjects 

# y_train
y_train = read.csv( "./data/UCI HAR Dataset/train/y_train.txt"
                   , header = FALSE )
names(y_train) = "y_train"
nrow (unique(y_train) )    # 6 activity ids

y_train = factor(y_train$y_train, levels = activity_labels$activity_id, 
       labels = activity_labels$activity )  

# X_train
X_train = read.delim( "./data/UCI HAR Dataset/train/X_train.txt"
                     , sep = "", header = FALSE)
names(X_train) = features$feature


# ------------------        4- Renaming features    ----

# Function searchfeatures

# This function identifies how many times is each value in features$feature
searchfeatures = function( texto ) {
    num = length(grep(texto, features$feature, fixed = TRUE) )
    return(num)
}

features$repcol = sapply(features$feature, searchfeatures)

# Comparing first repeated feature
X_test[1:5 , c(303 , 317, 331) ]
X_train[1:5 , c(303 , 317, 331)]


# new colum uniquename to rename the features

features$uniquename = ifelse( features$repcol == 1 , 
                              as.character(features$feature) , NA )
for (i in 1:561) {
    suffix = ifelse ( between(i, 303, 303 +13 ) |  
                          between(i, 382, 382 +13 ) |  
                          between(i, 461, 461 +13 ) , "_X", 
                      ifelse ( between(i, 317, 317 + 13 ) |  
                                   between(i, 396, 396 +13 ) |  
                                   between(i, 475, 475 +13 ), "_Y", "_Z"
                      ) )
    if ( features[i, 3] == 3 ) {
        features[i, 4] = paste0( features[i, 2], suffix)
    }
    
}

# ------------------        5- Merging data    ---------------

# Previous treatment

# 1. The 561 columns of both datasets were named as features$uniquename
names(X_test) = features$uniquename
names(X_train) = features$uniquename

# 2. The column "dataset" was added
# 3. The column "subject" was added
# 4. The column "activity" was added

X_test = data.frame( dataset = "Test" ,
             ( subject_test) ,
            activity = ( y_test ) ,
            (X_test)
            , check.names = FALSE
)    

X_train = data.frame( dataset = "Train" ,
             ( subject_train ) ,
            activity = (y_train  ) , 
            (X_train)
            , check.names = FALSE
)

 # Merge

CompleteData = bind_rows ( X_test , X_train )

# -------------------       6- Extracting mean and standard deviation ----

# identifying columns that are going to be extracted
features$meanorstd = grepl("mean()" , features$feature , fixed = TRUE) | 
    grepl("std()" , features$feature , fixed = TRUE)

# COnstructing the variable with the mean and std data
MeanStdData = CompleteData[, c(1:3, which(features$meanorstd ) + 3 )]


# -------------------       7- Exporting the average of each variable

# Variable with the average data
avgData = MeanStdData %>%
    select( c(2:69 ) )  %>% 
    group_by(subject, activity) %>%
    summarise_each(funs(mean))

# Exporting data
write.table(avgData, file="./data/avgData.txt" , row.name=FALSE)

# Reading the exported file
# avgData2<-read.table("./data/avgData.txt", header = TRUE )