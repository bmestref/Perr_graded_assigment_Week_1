
# Load Libraries ----------------------------------------------------------

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

data <- read.table("data/household_power_consumption.txt",
                   sep = ";",
                   na    = c("?"))

colnames(data) <- data[1,]
data <- data[-1,]
data$Date <- as.Date(data$Date, '%d/%m/%Y')
df_sub <- filter(new_data, between(Date, as.Date("2007-02-01"), as.Date("2007-02-02")))
df_sub$Global_active_power <- as.numeric(df_sub$Global_active_power)

#Let's plot the histogram
hist(df_sub$Global_active_power,xlab = "Global Active Power (kilowatts)",
     col  = "red",
     main = "Global Active Power")
dev.copy(png, 'plot1.png', width = 480, height = 480)
dev.off()