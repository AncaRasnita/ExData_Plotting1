#downloading the archive with  the data directly from the specified url into the working directory
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","file.zip")
unzip("file.zip")

#reading the txt file into R but only the range with dates 1/2/2007 and 2/2/2007
cnames <- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")
dataproject <- read.table("household_power_consumption.txt",sep=";",col.names=cnames,skip=grep("1/2/2007",readLines("household_power_consumption.txt"))-1,nrows=2880)
dataproject$Date <-strptime(dataproject$Date, "%d/%m/%Y")

#constructing the plot and the png file
dates <- dataproject$Date
times <- dataproject$Time
v1 <- paste(dates,times)
v2 <- strptime(v1, "%Y-%m-%d %H:%M:%S")
plot(v2,dataproject$Global_active_power,type="l",xlab="DateTime",ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png")
dev.off()
