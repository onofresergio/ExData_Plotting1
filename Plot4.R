### Loading library
library("data.table")

# Getting the working directory
path <- getwd()

#Reading data from the file and subsets data for specified dates
power <- data.table::fread(input = file.path(path, "household_power_consumption.txt"), na.strings="?")

# Preventing histogram from printing in scientific notation
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering Dates for 2007-02-01 and 2007-02-02
power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

### Plotting Graph 1
plot(power[, dateTime], power[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

### Plotting Graph 2
plot(power[, dateTime],power[, Voltage], type="l", xlab="datetime", ylab="Voltage")

### Plotting Graph 3
plot(power[, dateTime], power[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(power[, dateTime], power[, Sub_metering_2], col="red")
lines(power[, dateTime], power[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue"), c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "), lty=c(1,1), bty="n", cex=.5) 

### Plotting Graph 4
plot(power[, dateTime], power[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()
