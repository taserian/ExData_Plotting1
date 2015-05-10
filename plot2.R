# Common data extraction across plots
datafile <- file("household_power_consumption.txt")

# Using grep to extract the lines from the datafile which start with either "Date", "1/2/2007" or "2/2/2007"
powerCons <- read.table(text = grep("(^[1,2]/2/2007|^Date)", readLines(datafile), value = TRUE), sep=";", header=TRUE, na.strings="?")

# Convert date to a true Date format 
powerCons$Date <- as.Date(powerCons$Date, format = "%d/%m/%Y")
powerCons$DateTime <- as.POSIXct(paste(powerCons$Date, powerCons$Time))

# This is a line plot using Global active power through datetime
plot(powerCons$Global_active_power ~ powerCons$DateTime, type='l', ylab="Global Active Power (kilowatts)", xlab="")

# I think it's cool, so let's save it as a .png
dev.copy(png, file="plot2.png")
dev.off()