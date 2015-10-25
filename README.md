## Getting_And_Cleaning_Data_Course_Project

The run_analysis.R file in this repo is used to refine a data set of accelerometer readings.
The script is used to download the file from an internet source to your working directory. 
The file is then unzipped and then the data is extracted into R from the directories contained 
within the zip file. Tho original data used numerics to identify different activities that were 
monitered, so the first step of the script is converting these to the 'real-world' description
using the key, "activity_labels.txt". 

I then added these lables to the original data sets and
combined the "test" and "training" sets that were contained in the zip into one data set.
I then looked through the combined file to determine the columns corresponding to the mean and
standard deviations of each of the readings and annotated the column locations as a "subset_key" in
the script which is then used to subset the full set into only the columns I am interested in looking
at.

Finally, I attached the subject identifier to the front of the data set.

As an additional step, I created an additional data set that contains the averages for each reading 
for each activity performed by each subject. This set I write to a file called "tidy_set.txt".

#Code Book

The tidy set written by this script contains the following columns

* Subject: A numeric from 1 to 30 that is used to identify the different subjects from the study
* Activity: Can be "Standing", "Sitting", "Laying", "Walking", "Walking_Downstairs", or "Walking_Upstairs". Describes the activity performed while the data was collected.  


 Additionally, from the "features_info.txt" file in the zip file, the remaining features were calculated as follows:
"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.


tBodyAcc-XYZ  
tGravityAcc-XYZ  
tBodyAccJerk-XYZ  
tBodyGyro-XYZ  
tBodyGyroJerk-XYZ  
tBodyAccMag  
tGravityAccMag  
tBodyAccJerkMag  
tBodyGyroMag  
tBodyGyroJerkMag  
fBodyAcc-XYZ  
fBodyAccJerk-XYZ  
fBodyGyro-XYZ  
fBodyAccMag  
fBodyAccJerkMag  
fBodyGyroMag  
fBodyGyroJerkMag  

The set of variables that were estimated from these signals are: 

mean(): Mean value  
std(): Standard deviation"   
And in the tidy_set output, each column represents the mean of all of the readings for the corresponding subject and activity.

