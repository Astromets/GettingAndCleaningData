# Getting And Cleaning Data
Course Project from the Coursera Class with the same name

The goal was the following:

  # Create one R script called run_analysis.R that does the following:

  # 1. Merges the training and the test sets to create one data set.

  # 2. Extracts only the measurements on the mean and standard deviation for each measurement.

  # 3. Uses descriptive activity names to name the activities in the data set

  # 4. Appropriately labels the data set with descriptive activity names.

  # 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

First, you'll need the appropriate dataset downloaded into your current working directory. From there, the script will read all of the data into R and merge it into one dataframe. It then searches for and keeps only mean() and std() values for each measurement. After some renaming, a new data set is created that contains only the average of each variable for each activity and subject.
