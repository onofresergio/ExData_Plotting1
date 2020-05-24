### Loading library
library("data.table")

#Getting the working directory
path <- getwd()

#Reading data from the file and subsets data for specified dates
power <- data.table::fread(input = file.path(path, "household_power_consumption.txt"), na.strings="?")

# Preventing histogram from printing in scientific notation
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
power[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

# Filtering Dates for 2007-02-01 and 2007-02-02
power <- power[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

### Plotting graph 2
plot(x = power[, dateTime], y = power[, Global_active_power], type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()
