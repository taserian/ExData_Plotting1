# Common data extraction across plots
datafile <- file("household_power_consumption.txt")

# Using grep to extract the lines from the datafile which start with either "Date", "1/2/2007" or "2/2/2007"
powerCons <- read.table(text = grep("(^[1,2]/2/2007|^Date)", readLines(datafile), value = TRUE), sep=";", header=TRUE, na.strings="?")

# Convert date to a true Date format 
powerCons$Date <- as.Date(powerCons$Date, format = "%d/%m/%Y")

# Setting up the histogram on the screen first
hist(powerCons$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency")

# I'm happy with it, so let's save it as a .png
dev.copy(png, file="plot1.png")
dev.off()


