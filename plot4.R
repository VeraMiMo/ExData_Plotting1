#Libraries
library(data.table)
library(lubridate)
library(readr)

#Download file and read data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- tempfile()
download.file(fileURL, file)
file <- unzip(file)
DT <- fread(file)
DT$adjusted_date <- dmy(DT$Date)
relevant_days <- DT[adjusted_date == "2007-02-01" | adjusted_date == "2007-02-02", ]
relevant_days$row_number <- 1:nrow(relevant_days)
par(mfcol = c(2, 2))
plot1 <- with(relevant_days, plot(as.character(row_number), Global_active_power, type = "l", xaxt = "n",
                                  xlab = "", ylab = "Global Active Power (kilowatts)"))
axis(side = 1, at = c("1", "1440", "2880"), labels = c("Thu", "Fri", "Sat"), tick = TRUE)

plot2 <- with(relevant_days, plot(as.character(row_number), Sub_metering_1, type = "l", col = "black",
                         xaxt = "n", xlab = "", ylab = "Energy sub metering"))
lines(x = as.character(relevant_days$row_number), y = relevant_days$Sub_metering_2, type = "l", col = "red",
                         xaxt = "n", xlab = "", ylab = "Energy sub metering")
lines(x = as.character(relevant_days$row_number), y = relevant_days$Sub_metering_3, type = "l", col = "blue",
      xaxt = "n", xlab = "", ylab = "Energy sub metering")
axis(side = 1, at = c("1", "1440", "2880"), labels = c("Thu", "Fri", "Sat"), tick = TRUE)
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty = "solid",
       col = c("black", "red", "blue"), xjust = 1, text.width = 1500, bty = "n", y.intersp = 0.75)
plot3 <- with(relevant_days, plot(as.character(row_number), Voltage, type = "l", col = "black",
                                  xaxt = "n", yaxt = "n", xlab = "datetime", ylab = "Voltage"))
axis(side = 1, at = c("1", "1440", "2880"), labels = c("Thu", "Fri", "Sat"), tick = TRUE)
axis(side = 2, at = c("234", "238", "242", "246", labels = TRUE, tick = TRUE))
plot4 <- with(relevant_days, plot(as.character(row_number), Global_reactive_power, type = "l", col = "black",
                                  xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power"))
axis(side = 1, at = c("1", "1440", "2880"), labels = c("Thu", "Fri", "Sat"), tick = TRUE)
dev.copy(png, file = "plot4.png", width = 480, height = 480, units = "px")
dev.off()


