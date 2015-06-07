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

# graph 1
png(file = "plot1.png")
hist(pwr$Global_active_power, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", breaks = 20, col = "red")
dev.off()