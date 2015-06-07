# Week 1 Project
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Check for local data file and download as needed
if (!file.exists("household_power_consumption.txt")) {
  download.file(fileUrl, "./power.zip")
  unzip("./power.zip", files = "household_power_consumption.txt")
}

# import data file into R
power <- read.table(file = "household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
# clean up date formatting
power$Date2 <- strptime(paste(as.Date(power$Date, "%d/%m/%Y"), power$Time), "%Y-%m-%d %H:%M:%S")

# subset data to 2-day period of interest
pwr <- subset(power, Date2 >= '2007-02-01 00:00:00' & Date2 <= '2007-02-02 23:59:59')

# produce graph
png(file = "plot4.png")
par(mfrow = c(2,2))
# graph 1
plot(pwr$Date2,pwr$Global_active_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "")
# graph 2
plot(pwr$Date2,pwr$Voltage, type = "l", ylab = "Voltage", xlab = "datetime")
# graph 3
plot(pwr$Date2,pwr$Sub_metering_1, ylab = "energy sub metering", xlab = "", type = "n")
points(pwr$Date2,pwr$Sub_metering_3, type = "l", col = "blue")
points(pwr$Date2,pwr$Sub_metering_2, type = "l", col = "red")
points(pwr$Date2,pwr$Sub_metering_1, type = "l")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty = "n", pch="-", col = c("black","red","blue"))
# graph 4
plot(pwr$Date2,pwr$Global_reactive_power, type = "l", ylab = "Global Active Power (kilowatts)", xlab = "datetime")
dev.off()