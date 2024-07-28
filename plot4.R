library(tidyverse)
library(lubridate)

# Load Data ---------------------------------------------------------------

# Create data directory

if(!dir.exists("data")) { dir.create("data") }

# Download and unzip data file

file.url   <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file.path  <- "data/household_power_consumption.zip"
file.unzip <- "data/household_power_consumption.txt"

if(!file.exists(file.path) & !file.exists(file.unzip)) {
  download.file(file.url, file.path)
  unzip(file.path, exdir = "data")
}

# Load data from 2007-02-01 to 2007-02-02
data <- read_delim('data/household_power_consumption.txt', delim = ';', na = c('?'),
                   col_types = list(col_date(format = '%d/%m/%Y'),
                                    col_time(format = ""),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number(),
                                    col_number()))
data <- filter(data, between(Date, as.Date('2007-02-01'), as.Date('2007-02-02')))

#Create a new column on the dataset
data <- mutate(data, datetime = ymd_hms(paste(Date, Time)))
#We display our resultS in a multiple plot graph
par(mfrow = c(2,2))
#Plot the global active power plot
plot(Global_active_power ~ datetime, data, type = 'l', xlab = NA, ylab = 'Global Active Power (kilowatts)')
#Plot the voltage plot
plot(Voltage ~ datetime, data, type = 'l', col = 'black')
#Plot the energy sub metering plot
plot(Sub_metering_1 ~ datetime, data, col = 'black', type = 'l', ylab = 'Energy Sub Metering', xlab = NA)
lines(Sub_metering_2 ~ datetime, data, col= 'red' , type = 'l')
lines(Sub_metering_3 ~ datetime, data, col = 'blue', type = 'l')
legend('topright', col = c('black', 'red', 'blue'), legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty = 1)
#Plot the global reactive power graph
plot(Global_reactive_power ~ datetime, data, col = 'black', type = 'l')
dev.copy(png, 'plot4.png', height = 480, width = 480)
dev.off()