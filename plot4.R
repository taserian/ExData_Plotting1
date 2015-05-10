# Common data extraction across plots
datafile <- file("household_power_consumption.txt")

# Using grep to extract the lines from the datafile which start with either "Date", "1/2/2007" or "2/2/2007"
powerCons <- read.table(text = grep("(^[1,2]/2/2007|^Date)", readLines(datafile), value = TRUE), sep=";", header=TRUE, na.strings="?")

# Convert date to a true Date format 
powerCons$Date <- as.Date(powerCons$Date, format = "%d/%m/%Y")
powerCons$DateTime <- as.POSIXct(paste(powerCons$Date, powerCons$Time))

# First, set up the 2 x 2 grid of plots with smaller outer margins
par(mfrow=c(2, 2), mar=c(4, 4, 2, 1), oma=c(0, 0, 2, 0))

#Now, the four plots
with(powerCons, {
  # This is the same plot from plot2.R
  plot(powerCons$Global_active_power ~ powerCons$DateTime, type='l', ylab="Global Active Power (kilowatts)", xlab="")
  # New plot
  plot(Voltage ~ DateTime, type="l", ylab="Voltage", xlab="datetime")
  # This is the same plot from plot3.R
  plot(Sub_metering_1 ~ DateTime, type='l', ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ DateTime, col="red")
  lines(Sub_metering_3 ~ DateTime, col="blue")
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n", legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
  # New plot
  plot(Global_reactive_power ~ DateTime, type="l", ylab="Global_reactive_power", xlab="datetime")
})

# I think it looks good, so let's save it as a .png
dev.copy(png, file="plot4.png")
dev.off()