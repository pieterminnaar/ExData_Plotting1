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
plot.times <- strptime(paste(as.character(plot.data$Date), plot.data$Time), 
                             "%Y-%m-%d %H:%M:%S")

png("plot2.png", bg="white", width=480, height=480)
plot(plot.times, plot.data$Global_active_power, type="l" , 
    ylab = "Global Active Power (kilowatts)", xlab = "")     
dev.off()