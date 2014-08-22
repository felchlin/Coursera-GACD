###########################################################################################
# run_analysis.R
#
# What this script does:
#
# 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set.
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each
#    activity and each subject. 
#
# Information about the raw data:
#
#  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 
#
# Data set to be downloaded as part of running this script: 
#  
#  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
#

#####################################################################################
# Download and uncompress the zipped raw data in a directory called subDir.
# If subDir already exists, don't re-download
# Return the full path of the top level directory of the unzipped file
#
install <- function(baseDir, subDir, fileUrl, topZipSubdir) {
    
    # Full path of the data dir
    dataDir <- file.path(baseDir, subDir)
    
    topUnzippedDir <- file.path(dataDir, topZipSubdir)
    
    # for testing, delete the data dir so we can debug data dir creation and unzip
    #unlink(dataDir, recursive=TRUE)
    
    # Create the data directory if it does not exist
    if (!file.exists(dataDir)) {
        dir.create(dataDir, mode = "0777")
    
        # Get the file
        zipFile <- file.path(dataDir, "zipfile.zip")
        download.file(url=fileUrl, destfile = zipFile)
        
        # Unzip the file
        unzip(zipFile, exdir = dataDir)
    }
    
    # return the full path of the installed (unzipped) top-level folder
    topUnzippedDir
}


##################################################################################
# Transform a vector of original feature names into human-readable (long) form
#
plainEnglishNames <- function(features.orig) {
    # Write out the word "mean"
    features <- gsub("-mean\\(\\)", ".Mean.", features.orig)
    # Write out the word "Standard.Deviation"
    features <- gsub("-std\\(\\)", ".Standard.Deviation.", features)
    # Write out the word "Accelerometer"
    features <- gsub("Acc", ".Accelerometer.", features)
    # Write out the word "Gyroscope"
    features <- gsub("Gyro", ".Gyroscope.", features)
    # Write out the word "Magnitude"
    features <- gsub("Mag", ".Magnitude.", features)
    # "BodyBody" is a typo. Substitute just the single word "Body"
    features <- gsub("BodyBody", ".Body.", features)
    # Write out the word "Time.Domain" to replace the "t" prefix
    features <- sub("^t", "Time.Domain.", features)
    # Write out the word "Frequency.Domain" to replace the "f" prefix
    features <- sub("^f", "Frequency.Domain.", features)
    # Replace "-X" suffix with ".X.axis"
    features <- sub("-X$", ".X.axis", features)
    # Replace "-Y" suffix with ".Y.axis"
    features <- sub("-Y$", ".Y.axis", features)
    # Replace "-Z" suffix with ".Z.axis"
    features <- sub("-Z$", ".Z.axis", features)
    # Replace multiples of "." with a single "." character
    features <- gsub("[.]+", ".", features)
    # Eliminate any "." characters at the end
    features <- gsub("[.]+$", "", features)
    # Return the re-formatted feature names
    features
}


####################################################################################
# Figure out ("grok") units from (processed) feature names. Features containing
# the substring "Accelerometer" will be assumed to have "standard gravity units 'g'"
# for units, and features containing "Gyroscope" be assumed to have "radians/second"
# units
#
grokUnits <- function(features) {
    sgu <- "normalized standard gravity units 'g'"
    rps <- "normalized radians/second"
    accel.l <- grepl("Accelerometer", features)
    gyro.l <- grepl("Gyroscope", features)
    units <- rep("unknown", length(features))
    units[accel.l] <- sgu
    units[gyro.l] <- rps
    units
}


# Write variables' descriptions to a file
writeVariablesFile <- function(baseDir, fileName, features, features.orig, units) {
    variablesFile <- file.path(baseDir, fileName)
    if (file.exists(variablesFile)) {
        file.remove(variablesFile)
    }
    features.w.spaces <- tolower(gsub("[.]+", " ", features))

    lines <- paste("* ", features, " (", units, "), ", "\\[numeric\\]:\n  * The mean of the ", features.w.spaces, sep="")
    lines <- paste(lines, " measurement\n  *", sep="")
    lines <- paste(lines, " This value was derived by taking", sep="")
    lines <- paste(lines, " the mean of \"", features.orig, sep="")
    lines <- paste(lines, "\" for each combination of test", sep="")
    lines <- paste(lines, " subject and activity type", sep="")
    
    fileConn <- file(variablesFile)
    writeLines(lines, fileConn)
    close(fileConn)
}

# Write a data frame to a file without column names and without quotes
writeReport <- function(means, reportFile) {
    write.table(means, reportFile, row.names=FALSE, col.names=TRUE, quote=FALSE)
}

# Swap one column in a data frame according to a map data frame "map"
swapColumns <- function(toSwap, map, toCol) {
    numElem <- length(toSwap)
    swapped <- rep("", numElem)
    
    #browser()
    
    for(i in 1:numElem) {
        swapped[i] <- as.character(map[toSwap[i],toCol])
    }
    swapped
}


############################################################################################
# Given a data directory and report file name, perform the following steps:
#
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each
#    activity and each subject.
#
run <- function(dataDir, reportFile) {
    
    # Change directory to where the data set has been unzipped
    setwd(dataDir)
    
    # Read in the activity names
    activities.df <- read.table("activity_labels.txt", header=FALSE)
    num.activities <- nrow(activities.df)
    activities <- as.character(activities.df[,2])
    
    # Scan in the column headers
    features.df <- read.table("features.txt", header=FALSE)
    features <- as.character(features.df[,2])
    num.features <- nrow(features.df)
    
    
    #################################################################
    # 1. Merge the training and the test sets to create one data set.
    #

    # Read in training and test data sets

    set <- "train"

    # Read in training set activity index vector
    idxFile <- paste(set, "/y_", set, ".txt", sep="")
    train.activity.indices <- as.integer(scan(idxFile))
    train.num.samples <- length(train.activity.indices)
    
    # Read in training set subject index vector
    idxFile <- paste(set, "/subject_", set, ".txt", sep="")
    train.subject.indices <- as.integer(scan(idxFile))
    
    # Read in the training set data file
    dataFile <- paste(set, "/X_", set, ".txt", sep="")
    train.data <- read.table(dataFile, header=FALSE)
    
    set <- "test"
    
    # Read in the test set activity index vector
    idxFile <- paste(set, "/y_", set, ".txt", sep="")
    test.activity.indices <- as.integer(scan(idxFile))
    test.num.samples <- length(test.activity.indices)
    
    # Read in the test set subject index vector
    idxFile <- paste(set, "/subject_", set, ".txt", sep="")
    test.subject.indices <- as.integer(scan(idxFile))
    
    # Read in the test set data file
    dataFile <- paste(set, "/X_", set, ".txt", sep="")
    test.data <- read.table(dataFile, header=FALSE)
    

    # Put the two data frames together vertically using rbind()
    data <- rbind(test.data, train.data)
    names(data) <- features
    
    
    # Combine test.subject.indices with train.subject.indices. Careful! need to
    # combine in the same order as we bound the test.data and train.data.
    subject.indices <- c(test.subject.indices, train.subject.indices)
    subject.indices.unique <- sort(unique(subject.indices))
    num.unique.subjects <- length(subject.indices.unique)
    
    
    # Combine test.activity.indices with train.activity.indices. Careful! need to
    # combine in the same order as we bound the test.data and train.data.
    activity.indices <- c(test.activity.indices, train.activity.indices)
    activity.indices.unique <- sort(unique(activity.indices))
    num.unique.activities <- length(activity.indices.unique)
    
    
    ###########################################################################################
    # 2. Extract only the measurements on the mean and standard deviation for each measurement. 
    #
    
    # OK, now that we have everything stitched together, let's work on pruning
    # down the data into only columns that are means and standard deviations
    # features becomes the vector of features that are means or std deviations
    features.orig <- grep("(mean|std)\\(\\)", features, perl=TRUE, value=TRUE)
        
    # data becomes the data frame with only mean and stddev features
    data <- data[,features.orig]
    
    
    #######################################################################
    # 4. Appropriately label the data set with descriptive variable names. 
    #
    
    # Now let's make the column headers more human readable
    features <- plainEnglishNames(features.orig)
    names(data) <- features
    
    
    ############################################################################################
    # 5. Create a second, independent tidy data set with the average of each variable for each
    #    activity and each subject.
    
    # Create a character vector to hold the units per each feature
    units <- grokUnits(features)
    
    # Write out a file with variables and their plain-English descriptions
    writeVariablesFile(baseDir, "variable_desc.txt", features, features.orig, units)
    
    # Get the number of rows and columns in the data frame. Will be needed when
    # we pre-allocate space for our reduced data set.
    nrows.data <- nrow(data)
    ncols.data <- ncol(data)
    
    # Create a matrix with enough space to house a row for each combination
    # of subject and activity, and the number of columns as in the data frame
    nrows.reqd <- num.unique.subjects * num.unique.activities
    ncols.reqd <- ncols.data + 2 # 2 extra for subject and activity
    num.NAs <- nrows.reqd * ncols.reqd
    means.m <- matrix(rep(NA, num.NAs), nrow=nrows.reqd, ncol=ncols.reqd)
    colnames(means.m) <- c("Subject", "Activity", features)
    
    # Populate our matrix of means. Include Subject and Sctivity columns
    rowNum <- 1
    for (i in subject.indices.unique) {
        for (j in activity.indices.unique) {
            # logical vector for this combo of subject and activity
            row.selection <- (subject.indices==i & activity.indices==j)
            # pre-set col.means to NA's
            col.means <- rep(NA, ncols.data)
            # Only change take the subset if this is a valid subject/activity pair
            if (any(row.selection)) {
                # Subset the data, all columns for this subject/activity pair
                data.sub <- data[row.selection,]
                # Get the mean of all the columns in the subset, remove NA's
                col.means <- colMeans(data.sub, na.rm=TRUE)
            }
            
            # Add the row to our means.m matrix, first two columns are subject
            # and activity. All the other columns are the means of each column
            # in the subset for this i,j subject/activity pair
            means.m[rowNum,] <- c(i, j, col.means)
            
            # Increment the row number of the matrix
            rowNum <- rowNum + 1
        }
    }
    
    # Turn the means.m matrix into a data frame
    means.df <- data.frame(means.m)
    
    # Throw out any rows with NA's (note: no NA's are expected in any row, just a precaution)
    rows.without.na.l <- complete.cases(means.df)
    means.df <- means.df[rows.without.na.l,]
    
    
    ###########################################################################
    # 3. Use descriptive activity names to name the activities in the data set.
    #
    
    # Re-write means.df$Activity as a factor variable using activities.df
    toCol <- 2 # 2nd column in activities.df is Factor of descriptive names
    toSwap <- means.df$Activity
    means.df$Activity <- swapColumns(toSwap, activities.df, toCol)
    
    # Finally, write out the final tidy data set
    writeReport(means.df, reportFile)
}


# Set baseDir as the current working directory
# baseDir <- "C:/Users/jfelchli/Documents/Coursera/Data Science/Getting and Cleaning Data/Coursera-GACD"; setwd(baseDir)
baseDir <- getwd()

# Create directory, download, and unzip data
topZipSubdir <- "UCI HAR Dataset"
subDir <- "data"
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataDir <- install(baseDir, subDir, fileUrl, topZipSubdir)

# run all the tidying operations
reportFile <- file.path(baseDir, "tidy.txt")
run(dataDir, reportFile)

# Set the current working directory back to the baseDir, since it is quite possible
# it has been changed over the course of running the script.
setwd(baseDir)

# As a test, read in a data frame
#tidyData <- read.table(reportFile, header=TRUE)

# Show the tidy data file to the person running this script
#file.show(reportFile, header = reportFile)

