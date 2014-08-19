## Raw Data
The raw data comes from sensor data obtained from 30 test subjects (volunteers) wearing
a smartphone on their waist. The sensor data is comprised of various types of motion 
measurements (e.g. angular velocity, acceleration, etc.) during six different types of
activities: walking, walking upstairs, walking downstairs, sitting, standing and laying.
Further pre-processing of these signals was performed on the raw signals to produce more
data that comprised the raw data set that is the starting point of this project. A full
description of the raw data can be found here:

  &nbsp;&nbsp;[http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones]

The raw data was downloaded from (per course project instructions):

  &nbsp;&nbsp;[https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip]


With the above raw data as the starting put (input) for this project, no manual pre-
processing steps of any kind are needed to produce the tidy data set. The run_analysis.R
script downloads and unzips the zip file automatically before manipulating the data into
a tidy data set.


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

I decided to exclude features of this type since I believe this quantity is not the mean
requested in the course project requirement. For one thing it is a weighted average, and I
take the definition of mean to be an unweighted average. For another, if it were really a
mean, why would it not simply have the suffix "mean()" like all the other features that are
means?


## Variables in the tidy data set
The following is a list of variables in my final tidy data set. The first two - "subject" and
"activity" - are the volunteer and activity variables described in the section on the raw data.
All the others are the means of the "mean()" or "std()" variables I selected from the raw
data feature set.


I decided on to make my variable names as human readable as possible. As the original feature
names are quite cryptic, it was necessary to spell each of them out. When deciding variable
names, you have two opposing objectives: shortness (for convenience in display) or readability.
As tidy data (and this course) emphasizes making variable names as readable and understandable
as possible, I chose to make the names as explicit and spelled-out as possible, with the
consequence that they became very long. For further readability, I capitalized the first letter
of each word, and separated the words by '.' characters. For 'x', 'y', and 'z'-axis variables,
I added the ".axis" suffix to make the name more explicity. I also expanded appreviations (e.g.
("acc" to "Accelerometer") to eliminate ambiguity as mich as possible. Raw data variables
beginning with "t" denote time domain measurements. Likewise, raw data variables beginning
with "f" denote frequency domain measurements. To make these easy to interpret I expanded these
out to "Time.Domain" and "Frequency.Domain" respectively.


## Variable list with definitions
* subject \[integer\]:
  --* The test subject (a person) number.
  --* It has values in the range 1-30.
* activity \[Factor with 6 levels\]:
  --* The six possible activities the test subject could be doing while the data was being sampled.
  --* The six possible values are: "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"

