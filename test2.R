# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data
if(sum(list.files()=="activity.csv") == 0){
  fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
  activity <- unz(fileURL,fileName="activity.csv",open="r")
}
activity <- read.csv("activity.csv")

# convert date?
activity$date = as.Date(activity$date, "%Y-%m-%d")
print(class(activity))


steps_per_day <- aggregate(activity$steps, by=list(activity$date),sum)
print(class(steps_per_day))




#mean_steps <- mean(steps_per_day,na.rm=TRUE)
#median_steps <- median(steps_per_day,na.rm=TRUE)
#hist(steps_per_day)

