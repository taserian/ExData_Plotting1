# Common data extraction across plots
datafile <- file("household_power_consumption.txt")

# Using grep to extract the lines from the datafile which start with either "Date", "1/2/2007" or "2/2/2007"
powerCons <- read.table(text = grep("(^[1,2]/2/2007|^Date)", readLines(datafile), value = TRUE), sep=";", header=TRUE, na.strings="?")

# Convert date to a true Date format 
powerCons$Date <- as.Date(powerCons$Date, format = "%d/%m/%Y")
powerCons$DateTime <- as.POSIXct(paste(powerCons$Date, powerCons$Time))

# Set up an initial plot, then add lines to it, and a legend at the very end
with(powerCons, {
  plot(Sub_metering_1 ~ DateTime, type='l', ylab="Energy sub metering", xlab="")
  lines(Sub_metering_2 ~ DateTime, col="red")
  lines(Sub_metering_3 ~ DateTime, col="blue")
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

# I think it looks good, so let's save it as a .png
dev.copy(png, file="plot3.png")
dev.off()