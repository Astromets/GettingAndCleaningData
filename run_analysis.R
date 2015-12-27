run_analysis <- function(...){
  # Create one R script called run_analysis.R that does the following:
  # 1. Merges the training and the test sets to create one data set.
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.
  # 3. Uses descriptive activity names to name the activities in the data set
  # 4. Appropriately labels the data set with descriptive activity names.
  # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
  
  # Assumes 'UCI HAR Dataset' folder is in your current working directory
  
  require(data.table)
  require(plyr)
  require(knitr)
  
  path_rf <- file.path(getwd(), "UCI HAR Dataset")
  
  yTest  <- read.table(file.path(path_rf, "test" , "Y_test.txt" ), header = FALSE)
  yTrain <- read.table(file.path(path_rf, "train", "Y_train.txt"), header = FALSE)
  subjectTrain <- read.table(file.path(path_rf, "train", "subject_train.txt"), header = FALSE)
  subjectTest  <- read.table(file.path(path_rf, "test" , "subject_test.txt"), header = FALSE)
  xTest  <- read.table(file.path(path_rf, "test" , "X_test.txt" ), header = FALSE)
  xTrain <- read.table(file.path(path_rf, "train", "X_train.txt"), header = FALSE)
  
  subject <- rbind(subjectTrain, subjectTest)
  y <- rbind(yTrain, yTest)
  x <- rbind(xTrain, xTest)
  
  names(subject) <- c("subject")
  names(y) <- c("activity")
  xNames <- read.table(file.path(path_rf, "features.txt"), head=FALSE)
  names(x) <- xNames$V2
  
  #dataCombine <- cbind(subject, y)
  Data <- cbind(x, subject, y)
  
  xNames <- xNames$V2[grep("mean\\(\\)|std\\(\\)", xNames$V2)]
  
  xNames <- c(as.character(xNames), "subject", "activity")
  Data <- subset(Data, select=xNames)
  
  names(Data) <- gsub("^t", "Time", names(Data))
  names(Data) <- gsub("^f", "Frequency", names(Data))
  names(Data) <- gsub("Acc", "Accelerometer", names(Data))
  names(Data) <- gsub("Gyro", "Gyroscope", names(Data))
  names(Data) <- gsub("Mag", "Magnitude", names(Data))
  names(Data) <- gsub("BodyBody", "Body", names(Data))
  
  dataFinal <- aggregate(. ~subject + activity, Data, mean)
  dataFinal <- dataFinal[order(dataFinal$subject, dataFinal$activity),]
  write.table(dataFinal, file = "tidydata.txt", row.name=FALSE)
}
