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
with(relevant_days, plot(as.character(row_number), Global_active_power, type = "l", xaxt = "n",
                         xlab = "", ylab = "Global Active Power (kilowatts)"))
axis(side = 1, at = c("1", "1440", "2880"), labels = c("Thu", "Fri", "Sat"), tick = TRUE)
dev.copy(png, file = "plot2.png", width = 480, height = 480, units = "px")
dev.off()
