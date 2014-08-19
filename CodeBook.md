## Raw Data
The raw data comes from sensor data obtained from 30 test subjects (volunteers) wearing
a smartphone on their waist. The sensor data is comprised of various types of motion 
measurements (e.g. angular velocity, acceleration, etc.) during six different types of
activities: walking, walking upstairs, walking downstairs, sitting, standing and laying.
Further pre-processing of these signals was performed on the raw signals to produce more
data that comprised the raw data set that is the starting point of this project. A full
description of the raw data can be found here (given in the course project instructions):

  &nbsp;&nbsp;&nbsp;http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

The raw data was downloaded (given in the course project instructions) from:

  &nbsp;&nbsp;&nbsp;https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


With the above raw data as the starting point (input) for this project, no manual pre-
processing steps of any kind are needed to produce the tidy data set. The run_analysis.R
script downloads and unzips the zip file automatically before manipulating the data into
a tidy data set. The zip file will not be downloaded if it previously had been.


## How mean and standard deviation variables were selected
The course project instructions require selection of only mean and standard deviation
variables. I carefully reviewed the feature names, and I also carefully read the raw data
description in the web link above. A quick scan of the feature names in the features.txt
file for strings that look like means or standard deviations reveals that only features
with substrings "mean" or "std" could possibly fit the criteria. Also, the features_info.txt
file has a brief description of the suffixes of all the the features. The suffixes of mean
and standard deviation features are defined as:

  * mean(): Mean value
  * std(): Standard deviation

I therefore reason that only features with one of these suffixes match the project criteria.

One feature suffix "meanFreq()" contains the string "mean", making it a possible candidate.
However, the definition of features with this suffix is as follows:

  * meanFreq(): Weighted average of the frequency components to obtain a mean frequency

I decided to exclude features with this suffix since I believe this quantity is not the mean
requested in the course project requirement. For one thing it is a weighted average, and I
take the definition of mean to be an unweighted average. For another, if it were really a
mean, why would it not simply have the suffix "mean()" like all the other features that are
means?

The string "Mean" can also be found in variables that have the prefix "angle", but I also
decided to exclude those features because they are angles between other things, defined in
features_info.txt as:

  * angle(): Angle between to vectors. 


## Variables in the tidy data set
The following is a list of variables in my final tidy data set. The first two - "subject" and
"activity" - are the volunteer and activity variables described in the section on the raw data.
All the others are the means of the "mean()" or "std()" variables I selected from the raw
data features.


I decided to make my variable names as human-readable as possible. As the original feature
names are quite cryptic, it was necessary to spell each of them out. When deciding variable
names, you have two opposing objectives: shortness (for convenience in display) or readability.
As tidy data (and this course) emphasizes making variable names as readable and understandable
as possible, I chose to make the names as explicit and spelled-out as possible, with the
consequence that they became very long. For further readability, I capitalized the first letter
of each word, and separated the words by '.' characters. For 'x', 'y', and 'z'-axis variables,
I added the ".axis" suffix to make the name more explicit. I also expanded abbreviations (e.g.
"acc" to "Accelerometer") to eliminate ambiguity as much as possible. Raw data variables
beginning with "t" denote time domain measurements. Likewise, raw data variables beginning
with "f" denote frequency domain measurements. To make these easy to interpret I expanded these
out to "Time.Domain" and "Frequency.Domain" respectively.


## Variable list with definitions
* subject \[integer\]:
  * The test subject (a person) number
  * It has values in the range 1-30
* activity \[Factor with 6 levels\]:
  * The six possible activities the test subject could be doing while the data was being sampled
  * The six possible values are: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"
* Time.Domain.Body.Accelerometer.Mean.X.axis \[numeric\]:
  * The mean of the time domain body accelerometer mean x axis measurement
  * This value was derived by taking the mean of "tBodyAcc-mean()-X" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Mean.Y.axis \[numeric\]:
  * The mean of the time domain body accelerometer mean y axis measurement
  * This value was derived by taking the mean of "tBodyAcc-mean()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Mean.Z.axis \[numeric\]:
  * The mean of the time domain body accelerometer mean z axis measurement
  * This value was derived by taking the mean of "tBodyAcc-mean()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the time domain body accelerometer standard deviation x axis measurement
  * This value was derived by taking the mean of "tBodyAcc-std()-X" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the time domain body accelerometer standard deviation y axis measurement
  * This value was derived by taking the mean of "tBodyAcc-std()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the time domain body accelerometer standard deviation z axis measurement
  * This value was derived by taking the mean of "tBodyAcc-std()-Z" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Mean.X.axis \[numeric\]:
  * The mean of the time domain gravity accelerometer mean x axis measurement
  * This value was derived by taking the mean of "tGravityAcc-mean()-X" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Mean.Y.axis \[numeric\]:
  * The mean of the time domain gravity accelerometer mean y axis measurement
  * This value was derived by taking the mean of "tGravityAcc-mean()-Y" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Mean.Z.axis \[numeric\]:
  * The mean of the time domain gravity accelerometer mean z axis measurement
  * This value was derived by taking the mean of "tGravityAcc-mean()-Z" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the time domain gravity accelerometer standard deviation x axis measurement
  * This value was derived by taking the mean of "tGravityAcc-std()-X" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the time domain gravity accelerometer standard deviation y axis measurement
  * This value was derived by taking the mean of "tGravityAcc-std()-Y" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the time domain gravity accelerometer standard deviation z axis measurement
  * This value was derived by taking the mean of "tGravityAcc-std()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Mean.X.axis \[numeric\]:
  * The mean of the time domain body accelerometer jerk mean x axis measurement
  * This value was derived by taking the mean of "tBodyAccJerk-mean()-X" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Mean.Y.axis \[numeric\]:
  * The mean of the time domain body accelerometer jerk mean y axis measurement
  * This value was derived by taking the mean of "tBodyAccJerk-mean()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Mean.Z.axis \[numeric\]:
  * The mean of the time domain body accelerometer jerk mean z axis measurement
  * This value was derived by taking the mean of "tBodyAccJerk-mean()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the time domain body accelerometer jerk standard deviation x axis measurement
  * This value was derived by taking the mean of "tBodyAccJerk-std()-X" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the time domain body accelerometer jerk standard deviation y axis measurement
  * This value was derived by taking the mean of "tBodyAccJerk-std()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the time domain body accelerometer jerk standard deviation z axis measurement
  * This value was derived by taking the mean of "tBodyAccJerk-std()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Mean.X.axis \[numeric\]:
  * The mean of the time domain body gyroscope mean x axis measurement
  * This value was derived by taking the mean of "tBodyGyro-mean()-X" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Mean.Y.axis \[numeric\]:
  * The mean of the time domain body gyroscope mean y axis measurement
  * This value was derived by taking the mean of "tBodyGyro-mean()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Mean.Z.axis \[numeric\]:
  * The mean of the time domain body gyroscope mean z axis measurement
  * This value was derived by taking the mean of "tBodyGyro-mean()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the time domain body gyroscope standard deviation x axis measurement
  * This value was derived by taking the mean of "tBodyGyro-std()-X" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the time domain body gyroscope standard deviation y axis measurement
  * This value was derived by taking the mean of "tBodyGyro-std()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the time domain body gyroscope standard deviation z axis measurement
  * This value was derived by taking the mean of "tBodyGyro-std()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Mean.X.axis \[numeric\]:
  * The mean of the time domain body gyroscope jerk mean x axis measurement
  * This value was derived by taking the mean of "tBodyGyroJerk-mean()-X" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Mean.Y.axis \[numeric\]:
  * The mean of the time domain body gyroscope jerk mean y axis measurement
  * This value was derived by taking the mean of "tBodyGyroJerk-mean()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Mean.Z.axis \[numeric\]:
  * The mean of the time domain body gyroscope jerk mean z axis measurement
  * This value was derived by taking the mean of "tBodyGyroJerk-mean()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the time domain body gyroscope jerk standard deviation x axis measurement
  * This value was derived by taking the mean of "tBodyGyroJerk-std()-X" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the time domain body gyroscope jerk standard deviation y axis measurement
  * This value was derived by taking the mean of "tBodyGyroJerk-std()-Y" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the time domain body gyroscope jerk standard deviation z axis measurement
  * This value was derived by taking the mean of "tBodyGyroJerk-std()-Z" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Magnitude.Mean \[numeric\]:
  * The mean of the time domain body accelerometer magnitude mean measurement
  * This value was derived by taking the mean of "tBodyAccMag-mean()" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the time domain body accelerometer magnitude standard deviation measurement
  * This value was derived by taking the mean of "tBodyAccMag-std()" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Magnitude.Mean \[numeric\]:
  * The mean of the time domain gravity accelerometer magnitude mean measurement
  * This value was derived by taking the mean of "tGravityAccMag-mean()" for each combination of test subject and activity type
* Time.Domain.Gravity.Accelerometer.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the time domain gravity accelerometer magnitude standard deviation measurement
  * This value was derived by taking the mean of "tGravityAccMag-std()" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Magnitude.Mean \[numeric\]:
  * The mean of the time domain body accelerometer jerk magnitude mean measurement
  * This value was derived by taking the mean of "tBodyAccJerkMag-mean()" for each combination of test subject and activity type
* Time.Domain.Body.Accelerometer.Jerk.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the time domain body accelerometer jerk magnitude standard deviation measurement
  * This value was derived by taking the mean of "tBodyAccJerkMag-std()" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Magnitude.Mean \[numeric\]:
  * The mean of the time domain body gyroscope magnitude mean measurement
  * This value was derived by taking the mean of "tBodyGyroMag-mean()" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the time domain body gyroscope magnitude standard deviation measurement
  * This value was derived by taking the mean of "tBodyGyroMag-std()" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Magnitude.Mean \[numeric\]:
  * The mean of the time domain body gyroscope jerk magnitude mean measurement
  * This value was derived by taking the mean of "tBodyGyroJerkMag-mean()" for each combination of test subject and activity type
* Time.Domain.Body.Gyroscope.Jerk.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the time domain body gyroscope jerk magnitude standard deviation measurement
  * This value was derived by taking the mean of "tBodyGyroJerkMag-std()" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Mean.X.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer mean x axis measurement
  * This value was derived by taking the mean of "fBodyAcc-mean()-X" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Mean.Y.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer mean y axis measurement
  * This value was derived by taking the mean of "fBodyAcc-mean()-Y" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Mean.Z.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer mean z axis measurement
  * This value was derived by taking the mean of "fBodyAcc-mean()-Z" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer standard deviation x axis measurement
  * This value was derived by taking the mean of "fBodyAcc-std()-X" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer standard deviation y axis measurement
  * This value was derived by taking the mean of "fBodyAcc-std()-Y" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer standard deviation z axis measurement
  * This value was derived by taking the mean of "fBodyAcc-std()-Z" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Mean.X.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk mean x axis measurement
  * This value was derived by taking the mean of "fBodyAccJerk-mean()-X" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Mean.Y.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk mean y axis measurement
  * This value was derived by taking the mean of "fBodyAccJerk-mean()-Y" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Mean.Z.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk mean z axis measurement
  * This value was derived by taking the mean of "fBodyAccJerk-mean()-Z" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk standard deviation x axis measurement
  * This value was derived by taking the mean of "fBodyAccJerk-std()-X" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk standard deviation y axis measurement
  * This value was derived by taking the mean of "fBodyAccJerk-std()-Y" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk standard deviation z axis measurement
  * This value was derived by taking the mean of "fBodyAccJerk-std()-Z" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Mean.X.axis \[numeric\]:
  * The mean of the frequency domain body gyroscope mean x axis measurement
  * This value was derived by taking the mean of "fBodyGyro-mean()-X" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Mean.Y.axis \[numeric\]:
  * The mean of the frequency domain body gyroscope mean y axis measurement
  * This value was derived by taking the mean of "fBodyGyro-mean()-Y" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Mean.Z.axis \[numeric\]:
  * The mean of the frequency domain body gyroscope mean z axis measurement
  * This value was derived by taking the mean of "fBodyGyro-mean()-Z" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Standard.Deviation.X.axis \[numeric\]:
  * The mean of the frequency domain body gyroscope standard deviation x axis measurement
  * This value was derived by taking the mean of "fBodyGyro-std()-X" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Standard.Deviation.Y.axis \[numeric\]:
  * The mean of the frequency domain body gyroscope standard deviation y axis measurement
  * This value was derived by taking the mean of "fBodyGyro-std()-Y" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Standard.Deviation.Z.axis \[numeric\]:
  * The mean of the frequency domain body gyroscope standard deviation z axis measurement
  * This value was derived by taking the mean of "fBodyGyro-std()-Z" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Magnitude.Mean \[numeric\]:
  * The mean of the frequency domain body accelerometer magnitude mean measurement
  * This value was derived by taking the mean of "fBodyAccMag-mean()" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the frequency domain body accelerometer magnitude standard deviation measurement
  * This value was derived by taking the mean of "fBodyAccMag-std()" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Magnitude.Mean \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk magnitude mean measurement
  * This value was derived by taking the mean of "fBodyBodyAccJerkMag-mean()" for each combination of test subject and activity type
* Frequency.Domain.Body.Accelerometer.Jerk.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the frequency domain body accelerometer jerk magnitude standard deviation measurement
  * This value was derived by taking the mean of "fBodyBodyAccJerkMag-std()" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Magnitude.Mean \[numeric\]:
  * The mean of the frequency domain body gyroscope magnitude mean measurement
  * This value was derived by taking the mean of "fBodyBodyGyroMag-mean()" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the frequency domain body gyroscope magnitude standard deviation measurement
  * This value was derived by taking the mean of "fBodyBodyGyroMag-std()" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Jerk.Magnitude.Mean \[numeric\]:
  * The mean of the frequency domain body gyroscope jerk magnitude mean measurement
  * This value was derived by taking the mean of "fBodyBodyGyroJerkMag-mean()" for each combination of test subject and activity type
* Frequency.Domain.Body.Gyroscope.Jerk.Magnitude.Standard.Deviation \[numeric\]:
  * The mean of the frequency domain body gyroscope jerk magnitude standard deviation measurement
  * This value was derived by taking the mean of "fBodyBodyGyroJerkMag-std()" for each combination of test subject and activity type
