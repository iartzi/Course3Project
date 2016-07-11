#STEP 0: Get and load data.

#NOTE: When testing this script on your computer, make sure to modify the working directory
setwd("/Users/isacartzi/Documents/Data Science Course/UCI HAR Dataset")

library(plyr)
library(data.table)
subjectTrain = read.table('./train/subject_train.txt',header=FALSE)
xTrain = read.table('./train/x_train.txt',header=FALSE)
yTrain = read.table('./train/y_train.txt',header=FALSE)

subjectTest = read.table('./test/subject_test.txt',header=FALSE)
xTest = read.table('./test/x_test.txt',header=FALSE)
yTest = read.table('./test/y_test.txt',header=FALSE)

#STEP 1: Merge the training and the test sets to create one data set.

data_set_X <- rbind(xTrain, xTest)
data_set_Y <- rbind(yTrain, yTest)
one_data_set <- rbind(subjectTrain, subjectTest)

#STEP 2: Extract only the measurements on the mean and standard deviation for each measurement.

data_set_X_mean_std <- data_set_X[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
names(data_set_X_mean_std) <- read.table("features.txt")[grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2]), 2]

#STEP 3: Use descriptive activity names to name the activities in the data set.

data_set_Y[, 1] <- read.table("activity_labels.txt")[data_set_Y[, 1], 2]
names(data_set_Y) <- "Activity"

#STEP 4: Appropriately label the data set with descriptive activity names.
names(one_data_set) <- "Subject"
descriptive_names_set <- cbind(data_set_X_mean_std, data_set_Y, one_data_set)

#Relabel each 
names(descriptive_names_set) <- make.names(names(descriptive_names_set))
names(descriptive_names_set) <- gsub('Acc',"Acceleration",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('GyroJerk',"Angular_Acceleration",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('Gyro',"Angular_Speed",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('Mag',"Magnitude",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('^t',"TimeDomain.",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('^f',"Frequency_Domain.",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('\\.mean',".Mean",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('\\.std',".Standard_Deviation",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('Freq\\.',"Frequency.",names(descriptive_names_set))
names(descriptive_names_set) <- gsub('Freq$',"Frequency",names(descriptive_names_set))

#STEP 5: From the data set in step 4, creates a second, independent tidy data set with the 
#        average of each variable for each activity and each subject.


Data2<-aggregate(. ~Subject + Activity, descriptive_names_set, mean)
Data2<-Data2[order(Data2$Subject,Data2$Activity),]
write.table(Data2, file = "./tidy.txt",row.name=FALSE)