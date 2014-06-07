library(data.table)

# Download the file:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Unzip file in data directory in the same folder as this R file

suppressWarnings(DT <- fread("data/household_power_consumption.txt")) 
  

DT[, Date := as.Date(Date, "%d/%m/%Y")]

filterDays <- c(as.Date("2007-02-01", "%Y-%m-%d"), as.Date("2007-02-02", "%Y-%m-%d"))

twoDays <- (DT$Date == filterDays[1]) | (DT$Date == filterDays[2]) 

plot.data <- DT[twoDays,]
plot.data$Global_active_power <- as.numeric(plot.data$Global_active_power)
plot.data$Voltage <- as.numeric(plot.data$Voltage)
plot.data$Global_reactive_power <- as.numeric(plot.data$Global_reactive_power)

Sub_metering_1 <- as.numeric(plot.data$Sub_metering_1)
Sub_metering_2 <- as.numeric(plot.data$Sub_metering_2)
Sub_metering_3 <- as.numeric(plot.data$Sub_metering_3)

datetime <- strptime(paste(as.character(plot.data$Date), plot.data$Time), 
                             "%Y-%m-%d %H:%M:%S")


png("plot4.png", bg="white", width=480, height=480)
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))
with(plot.data, {
  plot(datetime, Global_active_power, type="l" , 
    ylab = "Global Active Power", xlab = "")     
  plot(datetime, Voltage, type="l")
  
  plot(datetime, Sub_metering_1, type="l" , 
      ylab = "Energy sub metering", xlab = "")  
  lines(datetime, Sub_metering_2, col="red")   
  lines(datetime, Sub_metering_3, col="blue")  
  legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1, bty="n")
  plot(datetime, Global_reactive_power, type="l")
})
dev.off()