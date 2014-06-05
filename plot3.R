library(data.table)

# Download the file:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Unzip file in data directory in the same folder as this R file

suppressWarnings(DT <- fread("data/household_power_consumption.txt")) 
  

DT[, Date := as.Date(Date, "%d/%m/%Y")]

filterDays <- c(as.Date("2007-02-01", "%Y-%m-%d"), as.Date("2007-02-02", "%Y-%m-%d"))

twoDays <- (DT$Date == filterDays[1]) | (DT$Date == filterDays[2]) 

plot.data <- DT[twoDays,]

Sub_metering_1 <- as.numeric(plot.data$Sub_metering_1)
Sub_metering_2 <- as.numeric(plot.data$Sub_metering_2)
Sub_metering_3 <- as.numeric(plot.data$Sub_metering_3)

plot.matrix <- cbind(Sub_metering_1, Sub_metering_2, Sub_metering_3) 

plot.times <- strptime(paste(as.character(plot.data$Date), plot.data$Time), 
                             "%Y-%m-%d %H:%M:%S")

png("plot3.png", bg="white", width=480, height=480)
plot(plot.times, Sub_metering_1, type="l" , 
    ylab = "Energy sub metering", xlab = "")  
lines(plot.times, Sub_metering_2, col="red")   
lines(plot.times, Sub_metering_3, col="blue")  
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col=c("black", "red", "blue"),
       lty=1)
dev.off()