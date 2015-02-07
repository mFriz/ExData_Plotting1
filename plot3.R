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

#--------Plot 3----------#
# Line plot with Energy sub metering vs date. 3 Lines for each sub_metering

png("plot3.png", width = 480, height = 480) # Start a graphics device. 

colours <- c("black", "red", "blue")
plot(x = data3$DateTime, 
     y = data3$Sub_metering_1, 
     ylim = c( 0, 40),
     type = "l",
     xlab = "", 
     ylab = "Energy sub metering",
     col = colours[1]
     
)
lines(x = data3$DateTime,  
      y = data3$Sub_metering_2, 
      type = "l",
      ylab = "Energy sub metering",
      col = colours[2]
      
)
lines(x = data3$DateTime,  
      y = data3$Sub_metering_3, 
      type = "l",
      ylab = "Energy sub metering",
      col = colours[3]
      
)
legend( "topright",  col = colours, lty = 1,  legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off() # Close the graphics device




