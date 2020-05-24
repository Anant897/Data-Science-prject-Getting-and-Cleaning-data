#Reading required datasets in R

features <- read.table("C:/Users/HP/Desktop/R.files/features.txt")
activities_labels <-  read.table("C:/Users/HP/Desktop/R.files/activity_labels.txt")
subject_test <-  read.table("C:/Users/HP/Desktop/R.files/test/subject_test.txt")
x_test <-  read.table("C:/Users/HP/Desktop/R.files/test/x_test.txt")
y_test <-  read.table("C:/Users/HP/Desktop/R.files/test/y_test.txt")
subject_train <-  read.table("C:/Users/HP/Desktop/R.files/train/subject_train.txt")
x_train <-  read.table("C:/Users/HP/Desktop/R.files/train/X_train.txt")
y_train <-  read.table("C:/Users/HP/Desktop/R.files/train/y_train.txt")

#Assigning names to variables
names(x_test) = features[, 2]
names(y_test) = "activity_id"
names(subject_test) = "subject_id"
names(x_train) = features[, 2]
names(y_train) = "activity_id"
names(subject_train) = "subject_id"
names(activities_labels) =c("activity_id", "activity_type")

#Merging the data sets
merg_test <- cbind(x_test, y_test, subject_test)
merg_train <- cbind(x_train, y_train, subject_train)
merged_data <- rbind(merg_test, merg_train)
#Extracts only the measurements on the mean 
#and standard deviation for each measurement.
colNames <- colnames(merged_data)
mean_and_std <- (grepl("activity_id" , colNames) | 
                   grepl("subject_id" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) )

ex_data <- merged_data[ , mean_and_std == TRUE]
set_activity_names <- merge(ex_data, activities_labels)

#Appropriately labels the data set with descriptive variable names
#Already done in previous steps.

#Final Tidy data

tidy_data <- aggregate(. ~subject_id + activity_id, set_activity_names, mean)
tidy_data <- tidy_data[order(tidy_data$subject_id, tidy_data$activity_id),]
write.table(tidy_data, "tidy_data.txt", row.name=FALSE)




