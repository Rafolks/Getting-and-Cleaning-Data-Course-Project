library(reshape2)

subject_test <- read.table("subject_test.txt")
  
X_test <- read.table("X_test.txt")
  
y_test <- read.table("y_test.txt")
  
features <- read.table("features.txt")
  
###
  
subject_train <- read.table("subject_train.txt")
  
X_train <- read.table("X_train.txt")
  
y_train <- read.table("y_train.txt")
  
activity_labels <- read.table("activity_labels.txt")
  
activities <- rbind(y_test, y_train)
  
subjects <- rbind(subject_test,subject_train) 
  
  
  
  
activity_labels[,2] <- gsub("_"," ", activity_labels[,2])
  
dataset <- rbind(X_test,X_train)
  
colnames(dataset) <- features[,2] 
  
means_measurements <- grep("mean", features[,2])
  
standard_deviations_measurements <- grep("std", features[,2])
  
means_and_standard_deviations <- c(means_measurements,standard_deviations_measurements)
  
dataset <- dataset[,means_and_standard_deviations]

dataset <- cbind(subjects,activities,dataset)


names(dataset)[c(1,2)] <- c("Subject", "Activity")
  
for(i in 1:nrow(activity_labels)) dataset[dataset[,2] == activity_labels[i,1],2] <- activity_labels[i,2]

  
order_subject_and_activities <- order(dataset[,2],dataset[,1])
  
dataset <- dataset[order_subject_and_activities,]
 
averages <- aggregate(dataset[,-c(1,2)], by = list(dataset[,2],dataset[,1]), mean)

averages <- averages[order(averages[,1], averages[,2]),]

names(averages)[c(1,2)] <- c("Activity", "Subject")

write.table(averages, "Tidy data", row.names = FALSE)





  
