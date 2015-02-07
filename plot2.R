

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

#--------Plot 2----------#
# Line plot with Global_active_power vs date (in days of week)
png("plot2.png", width = 480, height = 480) # Start a graphics device. 

plot(x = data3$DateTime,  
     y = data3$Global_active_power, 
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)"
)

dev.off() # Close the graphics device



