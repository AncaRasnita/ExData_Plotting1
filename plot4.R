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
x <- paste(dates,times)
y <- strptime(x, "%Y-%m-%d %H:%M:%S")
par(mfrow=c(2,2))
plot(y,dataproject$Global_active_power,type="l",xlab="DateTime",ylab="Global Active Power (kilowatts)")
plot(y,dataproject$Voltage,type="l",xlab="DateTime",ylab="Voltage")
with(dataproject,plot(y,dataproject$Sub_metering_1,type="l",xlab="DateTime",ylab="Energy Sub Metering"))
with(dataproject,lines(y,dataproject$Sub_metering_2,col="red"))
with(dataproject,lines(y,dataproject$Sub_metering_3,col="blue"))
legend("topright",pch=NA, lwd=1,cex=0.6,col=c("Black","Red","Blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
plot(y,dataproject$Global_reactive_power,type="l",xlab="DateTime",ylab="Global_Reactive_Power")
dev.copy(png, file="plot4.png")
dev.off()