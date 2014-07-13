# Reproducible Research: Peer Assessment 1


## Loading and preprocessing the data

```r
if(sum(list.files()=="activity.csv") == 0){
  fileURL <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2Factivity.zip"
  activity <- unz(fileURL,fileName="activity.csv",open="r")
}
activity <- read.csv("activity.csv")
```



```r
# convert date?
activity$date = as.Date(activity$date, "%Y-%m-%d")
```


## What is mean total number of steps taken per day?


```r
steps_per_day <- aggregate(activity$steps, by=list(activity$date), sum)
names(steps_per_day)[1] <- "date"
names(steps_per_day)[2] <- "steps"
mean_steps <- mean(steps_per_day$steps,na.rm=TRUE)
median_steps <- median(steps_per_day$steps,na.rm=TRUE)
hist(steps_per_day$steps)
```

![plot of chunk unnamed-chunk-3](figure/unnamed-chunk-3.png) 

10766
10765

## What is the average daily activity pattern?

```r
steps_per_interval <- aggregate(activity$steps, by=list(activity$interval), mean, na.rm=TRUE)
head(steps_per_interval)
```

```
##   Group.1       x
## 1       0 1.71698
## 2       5 0.33962
## 3      10 0.13208
## 4      15 0.15094
## 5      20 0.07547
## 6      25 2.09434
```

```r
names(steps_per_interval)[1] <- "interval"
names(steps_per_interval)[2] <- "steps"
plot(steps_per_interval$interval,steps_per_interval$steps,type="l")
```

![plot of chunk unnamed-chunk-4](figure/unnamed-chunk-4.png) 

```r
max_interval <- steps_per_interval$interval[which.max(steps_per_interval$steps)]
```

835

## Imputing missing values

```r
na_data <- apply(is.na(activity),1,sum)
na_rows <- length(na_data) - length(na_data[na_data==0])
```
2304


```r
activity$steps_nona = activity$steps
for (i in 1:length(activity$steps)){
  if (is.na(activity$steps[i])) {
    activity$steps_nona[i] = mean(activity$steps, na.rm = TRUE)
  }
}

steps_per_day_nona <- aggregate(activity$steps_nona, by=list(activity$date), sum)
names(steps_per_day_nona)[1] <- "date"
names(steps_per_day_nona)[2] <- "steps"
mean_steps_nona <- mean(steps_per_day_nona$steps)
median_steps_nona <- median(steps_per_day_nona$steps)
hist(steps_per_day_nona$steps)
```

![plot of chunk unnamed-chunk-6](figure/unnamed-chunk-6.png) 

10766
10766

## Are there differences in activity patterns between weekdays and weekends?

```r
activity$day <- weekdays(activity$date)
weekdays_list <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
activity$daytype <- lapply(activity$day, function(x) ifelse((x == "Saturday" || x == "Sunday"),x<-"Weekend",x<-"Weekday"))
```


```r
steps_per_interval_daytype.wd <- aggregate(steps ~ interval, data = activity, subset = activity$daytype == 
        "Weekday", FUN = mean)
steps_per_interval_daytype.we <- aggregate(steps ~ interval, data = activity, subset = activity$daytype == 
        "Weekend", FUN = mean)
par(mfrow=c(2,1))
plot(steps_per_interval_daytype.wd$interval,steps_per_interval_daytype.wd$steps,type="l")
plot(steps_per_interval_daytype.we$interval,steps_per_interval_daytype.we$steps,type="l")
```

![plot of chunk unnamed-chunk-8](figure/unnamed-chunk-8.png) 












