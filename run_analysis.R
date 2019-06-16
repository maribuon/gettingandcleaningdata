### Mariana Pereira
### 2019.06.16
### Getting and cleaning data --projet

library(reshape2)
library(dplyr)

# --------------------------------------------------------------------------#
#1. Merges the training and the test sets to create one data set.
# --------------------------------------------------------------------------#

### This is not the fastest way to do it, but I am following the steps asked on the assigment to make it easier to follow/ grade

### extracting variable names
colNames <- read.table('./UCI HAR Dataset/features.txt', stringsAsFactors=F)
colNames <- unlist( c('subject', colNames[,2], 'y'))

### reading train files
train <- NULL
for (f in list.files('./UCI HAR Dataset/train',pattern='*.txt', full.names=T)) {train <- cbind(train, as.matrix( read.table(f))) }
train <- as.data.frame(train)
colnames(train) <- colNames
train$dataset <- 'TRAIN'

### reading test files
test <- NULL
for (f in list.files('./UCI HAR Dataset/test',pattern='*.txt', full.names=T)) {test <- cbind(test, as.matrix( read.table(f))) }
colnames(test) <- colNames
test <- as.data.frame(test)
test$dataset <- 'TEST'

data <- rbind(train, test)



# --------------------------------------------------------------------------#
#2. Extracts only the measurements on the mean and standard deviation for each measurement.
# --------------------------------------------------------------------------#

### selecting colNames to keep
meanNames <- grep('mean|Mean', colNames, value=T)
stdNames <- grep('std', colNames, value=T)
keep <- c('subject', meanNames, stdNames, 'y', 'dataset')

data <- data[,keep]



# --------------------------------------------------------------------------#
#3. Uses descriptive activity names to name the activities in the data set
# --------------------------------------------------------------------------#
#1 WALKING
#2 WALKING_UPSTAIRS
#3 WALKING_DOWNSTAIRS
#4 SITTING
#5 STANDING
#6 LAYING

data$y <- gsub('1', 'WALKING', data$y)
data$y <- gsub('2', 'WALKING_UPSTAIRS', data$y)
data$y <- gsub('3', 'WALKING_DOWNSTAIRS', data$y)
data$y <- gsub('4', 'SITTING', data$y)
data$y <- gsub('5', 'STANDING', data$y)
data$y <- gsub('6', 'LAYING', data$y)



# --------------------------------------------------------------------------#
#4. Appropriately labels the data set with descriptive variable names.
# --------------------------------------------------------------------------#
names(data)[names(data) == 'y'] <- "activity"
aux <- names(data)
aux <- gsub('[(]','', aux)
aux <- gsub('[)]','', aux)
aux <- gsub(',','-', aux)

names(data) <- aux





# --------------------------------------------------------------------------#
#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
# --------------------------------------------------------------------------#
data <- data %>% select(-c('dataset'))
md <- melt(data, id.vars=c('subject', 'activity'))
meanData <- dcast(md, subject + activity  ~ variable, mean)

write.table(meanData, file='summary_mean.txt', quote=F, row.names=F)

print(head(meanData))
