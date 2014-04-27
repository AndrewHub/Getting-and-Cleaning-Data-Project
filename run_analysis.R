## read data from .txt files downloaded in working directory
## into data frame using read.table function
X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
subject_test <- read.table("./test/subject_test.txt")
X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
subject_train <- read.table("./train/subject_train.txt")
features <- read.table("./features.txt")
activity_labels <- read.table("./activity_labels.txt")

## combine activity labels and subject names into a data frame
## using column bind function
df.A <- cbind(Y_test, subject_test)
df.B <- cbind(Y_train, subject_train)

## assign friendly names to both data frames
names(df.A) <- c("Activity", "Subject")
names(df.B) <- c("Activity", "Subject")
## merge them into one data frame using merge function
df.C <- merge(df.A, df.B, all=T)

## merge measured data into a data frame
df.D <- merge(X_train, X_test, all=T)
## assign featurn names to merged data
names(df.D) <- features$V2

## substract columns with "mean()" and "std()" in
## colnames using grepl function to get logical vectors
mean_or_std <- grepl("mean\\(\\)", names(df.D)) | grepl("std\\(\\)", names(df.D))
df.E <- df.D[,mean_or_std]

## assign corelated activity labels and subject names to
## the substracted data frame
df.F <- cbind(df.C, df.E)

## get average of features by subject and activity respectfully
## using the combination of split and sapply functions
s <- split(df.F, list(df.F$Subject, df.F$Activity))    
Mean <- sapply(s, function(x) colMeans(x[,]))

## convert the Mean back into a readable data frame and assign
## colnames with previous names from
df.G <- data.frame(t(Mean))
names(df.G) <- names(df.F)

## add readable activity names to the data frame by merging
## activity_labels and df.G
df.H <- merge(activity_labels, df.G, by.x="V1", by.y="Activity")
names(df.H)[1] <- c("activity_label")
names(df.H)[2] <- c("Activity")

## export the result data frame using write.table function
write.table(df.H, file="./tidy.txt")