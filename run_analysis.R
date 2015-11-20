# Get the library necessary for tidy data

library(reshape2)

# Download and unzip data files

zip.name = "getdata.zip"

zip.url = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if (!file.exists(zip.name)){
        download.file(zip.url, zip.name, method = "curl")
}

if (!file.exists("UCI HAR Dataset")) {
        unzip(zip.name)
}

# Load activity labels and features

activitiyLabels = read.table("~/UCI HAR Dataset/activity_labels.txt")
activitiyLabels[,2] = as.character(activitiyLabels[,2])
features = read.table("~/UCI HAR Dataset/features.txt")
features[,2] = as.character(features[,2])

# Extracts only the measurements on the mean and standard deviation for each measurement. 

featuresWantedFlags = grep(".*mean.*|.*std.*", features[,2])
featuresWantedNames = features[featuresWantedFlags,2]

# Load data

train <- read.table("~/UCI HAR Dataset/train/X_train.txt")[featuresWantedFlags]
trainActivities <- read.table("~/UCI HAR Dataset/train/Y_train.txt")
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainSubjects, trainActivities, train)

test <- read.table("~/UCI HAR Dataset/test/X_test.txt")[featuresWantedFlags]
testActivities <- read.table("~/UCI HAR Dataset/test/Y_test.txt")
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testSubjects, testActivities, test)

# Merge datasets and add labels

allData <- rbind(train, test)
colnames(allData) <- c("subject", "activity", featuresWantedNames)

# Uses descriptive activity names to name the activities in the data set
allData$activity = factor(allData$activity,levels = activitiyLabels$V1, labels=activitiyLabels$V2)
allData$subject = as.factor(allData$subject)

# Create tidy data, from wide to long format
allData.melted = melt(allData, id.vars = c("subject","activity"))
allData.casted = dcast(allData.melted, subject+activity ~ variable, fun.aggregate = mean)

write.table(allData.casted, "UCI_tidy.txt", row.names = F, quote = F)
