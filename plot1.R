
# Read in text file called household_power_consumption.txt
# delimiter: semicolon; with header

# The following descriptions of the 9 variables in the dataset are taken from the UCI web site:
#     
# Date: Date in format dd/mm/yyyy
# Time: time in format hh:mm:ss
# Global_active_power: household global minute-averaged active power (in kilowatt)
# Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# Voltage: minute-averaged voltage (in volt)
# Global_intensity: household global minute-averaged current intensity (in ampere)
# Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). It corresponds to the kitchen, containing mainly a dishwasher, an oven and a microwave (hot plates are not electric but gas powered).
# Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). It corresponds to the laundry room, containing a washing-machine, a tumble-drier, a refrigerator and a light.
# Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). It corresponds to an electric water-heater and an air-conditioner.

# Loading the data
# 
# When loading the dataset into R, please consider the following:
# The dataset has 2,075,259 rows and 9 columns. 
# First calculate a rough estimate of how much memory the dataset will require 
# in memory before reading into R. Make sure your computer has enough memory 
# (most modern computers should be fine).


#-------Estimate Storage for Whole Data Set-------#

# Example row: 16/12/2006;17:24:00;4.216;0.418;234.840;18.400;0.000;1.000;17.000

storageEstimateInMB <- 2075259 * ( 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 + 8 ) / 1024 / 1024
storageEstimateInMB # 142 MB
# With a few GigaByte of RAM there is no problem

# We will only be using data from the dates 2007-02-01 and 2007-02-02. 
# One alternative is to read the data from just those dates rather than reading 
# in the entire dataset and subsetting to those dates.
# 
# You may find it useful to convert the Date and Time variables to Date/Time 
# classes in R using the strptime() and as.Date() functions.
# 
# Note that in this dataset missing values are coded as ?.


#-------Read in Data---------#
library(data.table)
data <- fread(input = "household_power_consumption.txt", 
              sep = ";", 
              header = TRUE, 
              na.strings = c('?')) 
#               colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "integer", "integer", "integer"))

data2 <- data
data2 <- data2[data2$Date == "1/2/2007" | data2$Date == "2/2/2007",  ]

data3 <- data2
tempVec <- paste(data2$Date, "T", data2$Time, sep = "")
tempVec <- strptime(tempVec, format = "%d/%m/%YT%H:%M:%S")
tempVec <- as.POSIXct(tempVec)
data3$DateTime <- tempVec

for (i in 3:6) {
    data3[[i]] <- as.numeric(data2[[i]])
}
for (i in 7:8) {
    data3[[i]] <- as.integer(data2[[i]])
}

# Making Plot

# For each plot you should:
#   Construct the plot and save it to a PNG file with a width of 480 pixels and a height of 480 pixels.
#   Name each of the plot files as plot1.png, plot2.png, etc.
#   Create a separate R code file (plot1.R, plot2.R, etc.) that constructs the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. Your code file should include code for reading the data so that the plot can be fully reproduced. You should also include the code that creates the PNG file.
#   Add the PNG file and R code file to your git repository



#--------Plot 1----------#
# This plot is a histrogram with data$Global_active_power on the x-axes and 
# Frequency on the y-axes
?par
png("plot1.png", width = 480, height = 480) # Start a graphics device. 

histogram <- hist(data3$Global_active_power, 
     col = "red", 
     breaks = 12,
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")

dev.off() # Close the graphics device

