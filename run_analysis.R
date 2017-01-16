
# Return a single-variable data.frame with tidied names for the selected
# columns from the UCI HAR dataset.  
# 
# The selected columns contain mean() or std() values of the original measurements
# which will be averaged in the final output.
# Excluded are the meanFreq() values, since these are weighted averages and not the
# sensor measurements.
#
# Note that the names are left in "camel case" (mixed case) so that they are easier to read.
#
getColumnNames <- function(){
    cleanColumn <- function( x ){
        x <- sub("[.]m","M",x)
        x <- sub("[.]s","S",x)
        x <- gsub("[.]","",x)
        x <- sub("Acc","Accelerometer",x)
        x <- sub("Gyro","Gyroscope",x)
        x <- sub("Mag","Magnitude",x)
        x
    }

    dtFeatureNames <- read.table("./sourcedata/features.txt", stringsAsFactors = FALSE)
    cols <- dtFeatureNames[grep("mean[^F]|std", dtFeatureNames$V2),]
    # make unique, syntactically valid names
    cols[,2] <- make.names(cols[,2], unique = TRUE)
    # further tidying of the column names
    cols[,2] <- vapply(cols[,2], cleanColumn, "")
    cols
}

getActivityLabels <- function(){
    labels <- read.table("./sourcedata/activity_labels.txt")
    labels
}

# Merges the measurement, subject and activity files for either the test or
# train datasets and applies column names.
getData <- function(runtype = "test", columns = NULL){
    folder <- paste0("./sourcedata/",runtype,"/")
    dtSubject <- read.table(paste0(folder, "subject_", runtype, ".txt"))
    dtActivity <- read.table(paste0(folder,"y_", runtype, ".txt"))
    dtActivityLabels <- getActivityLabels()
    dtMeasurements <- read.table(paste0(folder,"X_", runtype, ".txt"))
    if ( !is.null(columns)){
        dtMeasurements <- dtMeasurements[, columns[,1]]
        colnames(dtMeasurements) <- columns[,2]
    }
    dtActivity <- join(dtActivity, dtActivityLabels)
    dtMeasurements$subject <- dtSubject[,1]
    dtMeasurements$activity <- dtActivity[,2]
    dtMeasurements
}

# Executes the project goals by merging the test and train datasets and writing
# a tidier dataset as "tidy_data.txt"
run <- function(){
    require(plyr)
    averager <- function(dataset){
        colMeans(dataset[, -c(67,68)]) #67,68 are the subject, activity columns
    }
    cols <- getColumnNames()
    dtTest <- getData("test", cols)
    dtTrain <- getData("train", cols)
    dtAll <- rbind(dtTest,dtTrain)
    dtAll <- arrange(dtAll, subject, activity )
    dtAvg <- ddply(dtAll, .(subject,activity), averager)
    write.table(dtAvg, "tidy_data.txt", row.names = FALSE)
}




