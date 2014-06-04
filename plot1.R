url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, 'cp1data.zip')
unzip('cp1data.zip')
data <- read.table('household_power_consumption.txt', head = T, sep = ";", na.strings= '?', nrows = 1000, stringsAsFactors = F)
data <- read.table('household_power_consumption.txt', head = T, sep = ";", na.strings= '?', stringsAsFactors = F)
data$dt <- as.POSIXlt(paste(data[, 1], data[, 2]), format = '%d/%m/%Y %H:%M:%S')
data1 <- data[data$Date =='2/2/2007' | data$Date =='1/2/2007',]

summary(data1$Global_active_power)
hist(data1$Global_active_power, main='Global Active Power', xlab = 'Global Active Power(kilowatts)', col = 'red')
dev.copy(png, file='plot1.png')
dev.off
dev.off(4)
