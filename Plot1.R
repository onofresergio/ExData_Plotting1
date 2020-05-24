### Loading library
library("data.table")

#Getting the working directory
path <- getwd()

#Reading data from the file and subsets data for specified dates
power <- data.table::fread(input = file.path(path, "household_power_consumption.txt"), na.strings="?")

# Preventing histogram from printing in scientific notation
power[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

# Changes the Date Column to Date Type
power[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filtering Dates for 2007-02-01 and 2007-02-02
power <- power[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

### Plotting graph 1
hist(power[, Global_active_power], main="Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()
