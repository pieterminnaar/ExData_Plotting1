library(data.table)

# Download the file:
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
# Unzip file in data directory in the same folder as this R file

suppressWarnings(DT <- fread("data/household_power_consumption.txt")) 
strtotime <- function(a_string) {
  vals <- unlist(strsplit(a_string, ":"))
  nums <- as.numeric(vals)
  nums[1] + (nums[2] + (nums[3] / 60)) / 60
}
  

DT[, Date := as.Date(Date, "%d/%m/%Y")]
suppressWarnings(DT[, Time := strtotime(Time)])

filterDays <- c(as.Date("2007-02-01", "%Y-%m-%d"), as.Date("2007-02-02", "%Y-%m-%d"))

twoDays <- (DT$Date == filterDays[1]) | (DT$Date == filterDays[2]) 

plot.data <- DT[twoDays,]

plot.data$Global_active_power <- as.numeric(plot.data$Global_active_power)

png("plot1.png", bg="white", width=480, height=480)
hist(plot.data$Global_active_power, breaks = seq(0, 7.5, by = 0.5), col="red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")
dev.off()