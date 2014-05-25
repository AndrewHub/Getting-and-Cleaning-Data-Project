##  Read in data
library(reshape2)
x_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
x_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")
subject_test <- read.table("./test/subject_test.txt")
subject_train <- read.table("./train/subject_train.txt")
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

## Data processing
## 1. Merges the training and the test sets to create one data set.
names(subject_test) <- "subject" -> names(subject_train)
names(y_test) <- "activity.ID" -> names(y_train)
names(activity_labels) <- c("activity.ID", "activity")
test <- cbind(subject_test, y_test, x_test)
train <- cbind(subject_train, y_train, x_train)
df.test <- merge(activity_labels, test)
df.train <- merge(activity_labels, train)
df.whole <- rbind(df.test, df.train)

cnames.whole <- names(df.whole)[1:3]
names(df.whole) <- c(cnames.whole, as.character(features$V2))
first2_cols <- df.whole[, c(1,3)]

## 2. Extracts only the measurements on the mean and standard deviation
## 3. Uses descriptive activity names to name the activities in the dataset
## 4. Appropriately labels the data set with descriptive activity names. 
mean_std <- grepl("mean\\(\\)", names(df.whole)) | 
        grepl("std\\(\\)", names(df.whole))
df.whole <- df.whole[, mean_std]
df.whole <- cbind(first2_cols, df.whole)

# reshape2
dfMelt <- melt(df.whole, id.vars=c("activity.ID", "subject"))
dfDcast <- dcast(dfMelt, subject + activity.ID ~ variable, mean)
## 5. Tidy: average of each variable for each activity and each subject
write.table(dfDcast, file="./tidy.txt")