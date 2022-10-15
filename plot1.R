#Libraries
library(data.table)
library(lubridate)
#Download file and read data
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- tempfile()
download.file(fileURL, file)
file <- unzip(file)
DT <- fread(file)
DT$adjusted_date <- dmy(DT$Date)
relevant_days <- DT[adjusted_date == "2007-02-01" | adjusted_date == "2007-02-02", ]
hist(as.numeric(relevant_days$Global_active_power), col = "red", 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.copy(png, file = "plot1.png", width = 480, height = 480, units = "px")
dev.off()
