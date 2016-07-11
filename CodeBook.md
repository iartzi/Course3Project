### Data for this project can be found below

[Source](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) of the original data:

	https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

[Full Description](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones) is found here:

	http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones
	
### The Project

Run the script `run_analysis.R`, which collects and cleans a data set:

1. Merge the training and test sets to create one data set.

2. Reads `features.txt` and uses only the measurements on the MEAN and STANDARD DEVIATION for each measurement. 

3. Reads `activity_labels.txt` and replaces labels with more meaningful, descriptive ones.

4. Merges the features with activity labels and subject IDs. The merged features are saved to the file `tidy.txt`.
 
5. A second, independent tidy data set with the average of each variable for each activity and each subject (based on Step 4) is created and saved in the file `tidy2.txt`.

### Variables

xTest:                 table read from `test/X_test.txt`
xTrain:                table read from `train/X_train.txt`
yTest:                 table read from `test/Y_test.txt`
yTrain:                table read from `train/Y_train.txt`
subjectTest:           table read from `test/subject_test.txt`
subjectTrain:          table read from `test/subject_train.txt`
one_data_set:          combined data set of the above variables
data_set_X_mean_std:   measurements on the mean and standard deviation for each measurement
descriptive_names_set: the data set with descriptive activity names
