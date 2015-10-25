# Download and unzip file containing data into working directory

        if(!"source_data.zip" %in% dir()){
                download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "source_data.zip")
                unzip("source_data.zip")
                t<-1
        }

# Read the data from the folders contained in the zip file
        
        col.names <- read.table("UCI HAR Dataset/features.txt", sep = "")
        col.names <- col.names[,2]
        test_subject <- read.table("UCI HAR Dataset/test/subject_test.txt", sep = "", colClasses = "numeric")
        test_lbl <- read.table("UCI HAR Dataset/test/y_test.txt", sep = "", colClasses = "numeric")
        test_set <- read.table("UCI HAR Dataset/test/X_test.txt", sep = "", col.names = col.names, colClasses = "numeric")
        train_subject <- read.table("UCI HAR Dataset/train/subject_train.txt", sep = "", colClasses = "numeric")
        train_lbl <- read.table("UCI HAR Dataset/train/y_train.txt", sep = "", colClasses = "numeric")
        training_set <- read.table("UCI HAR Dataset/train/X_train.txt", sep = "", col.names = col.names, colClasses = "numeric")
        activity_key <- read.table("UCI HAR Dataset/activity_labels.txt", sep = "", colClasses = "character")
        activity_key <- activity_key[,2]

# Convert the activity labels from numerics to character strings
        
        convert <- function(act.num){
                act.num <- activity_key[act.num]
        }
        new_test_lbl <- sapply(test_lbl, convert); colnames(new_test_lbl) <- "Activity"
        new_train_lbl <- sapply(train_lbl, convert); colnames(new_train_lbl) <- "Activity"

# Attach the new lables to each of the data sets and merge the sets together
        
        new_test_set <- cbind(new_test_lbl, test_set); new_train_set <- cbind(new_train_lbl, training_set)
        combined_set <- rbind(new_train_set, new_test_set)
        
# Refine the data to only include the mean and standard deviation for each measurement      
        
        subset_key <- c(1:6, 41:46, 81:86, 121:126, 161:166, 201, 202, 214, 215, 227, 228, 240,241, 253, 254,266:271, 345:350, 424:429, 503, 504, 516, 517, 529, 530, 542, 543)
        subset_key <- c(1, subset_key + 1)
        refined_data <- combined_set[,subset_key] 
        
# Add the subject identifyer
        
        subject <- rbind(train_subject, test_subject); colnames(subject) <- "Subject"
        new_refined_data <- cbind(subject, refined_data)
        
# Create a new data set that contains the means of each of the columns from 'refined_data' per subject per activity
        
        count <- 0
        for(i in 1:30){
                key1 <- subject == i
                temp1 <- refined_data[key1,]
                for(j in unique(temp1[,1])){
                        key2 <- temp1[,1]==j
                        temp2 <- temp1[key2,]
                        count <- count +1
                        new_refined_data[count,] <- cbind(i,j,matrix(colMeans(temp2[,2:ncol(temp2)]),nrow = 1))
                }
        }
        new_refined_data <- new_refined_data[1:count,]
        for(n in c(1,3:ncol(new_refined_data))){
                new_refined_data[,n] <- as.numeric(new_refined_data[,n]) 
        }
        
write.table(new_refined_data, file = "tidy_set.txt", row.names = FALSE)
       