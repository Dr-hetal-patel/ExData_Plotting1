install.packages("plyr")
library(plyr)
install.packages("dplyr")
library(dplyr)

## Read in Data

## create a folder for the data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileURL, destfile = "./consumption.zip")
unzip("./consumption.zip")
eda <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE)

## combine date and time as Dates
eda$datetime<- strptime(paste(eda$Date, eda$Time), "%d/%m/%Y %H:%M:%S")

## save Date as Date
eda$Date<-as.Date(eda$Date, "%d/%m/%Y")

##Create a subset for the 1st and 2nd February 2007
data<-subset(eda, Date=="2007-02-01"| Date=="2007-02-02")
## create the Plot4

##create a 4x4 field for the chart
par(mfrow=c(2,2))
plot(data$datetime, data$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="" )

plot(data$datetime, data$Voltage, type="l", ylab="Voltage", xlab="datetime")

plot(data$datetime, data$Sub_metering_1, type="l", ylab="Energy sub metering", xlab="" )
points(data$datetime,data$Sub_metering_2, col="red", type="l")
points(data$datetime,data$Sub_metering_3, col="blue", type="l")
legend(x="topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black", "red", "blue"), lty=c(1,1,1))

plot(data$datetime, data$Global_reactive_power, type="l", ylab = "Global_reactive_power", xlab = "datetime")
##create the png file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()
