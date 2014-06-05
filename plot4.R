url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(url, 'cp1data.zip')
unzip('cp1data.zip')

con <- file('household_power_consumption.txt', open = 'r')
n <- 0
start <- 0
end <- 0
find <- F
name <- strsplit(readLines(con, 1), ';')[[1]]
while(length(line <- readLines(con, 1)) > 0){
  n = n + 1
  if(grepl('^1/2/2007', line)){
    if(!find){
      start <- n
      find <- T
    }
  }
  if(grepl('^3/2/2007', line)){
    if(find){
      end <- n - 1
      break()
    }
  }
}
close(con)
data <- read.table('household_power_consumption.txt', head = F, sep = ";", na.strings= '?', stringsAsFactors = F, skip = start, nrow = end - start + 1)
names(data) <- name
data$dt <- as.POSIXlt(paste(data[, 1], data[, 2]), format = '%d/%m/%Y %H:%M:%S')

png('plot4.png', 480, 480)
par(mfrow = c(2,2))
plot(data$dt, data$Global_active_power, type = 'l', ylab = 'Global Active Power(kilowatts)', xlab = '')
plot(data$dt, data$Voltage, type = 'l', ylab = 'Voltage', xlab = 'datetime')
plot(data$dt, data$Sub_metering_1, type = 'n', ylab = 'Energy sub metering', xlab = '')
lines(data$dt, data$Sub_metering_1, type = 'l', col = 'black')
lines(data$dt, data$Sub_metering_2, type = 'l', col = 'red')
lines(data$dt, data$Sub_metering_3, type = 'l', col = 'blue')
legend('topright', lty = 1, bty = 'n', col = c('black', 'red', 'blue'), legend = c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))
plot(data$dt, data$Global_reactive_power, type = 'l', ylab = 'Global_reactive_power', xlab = 'datetime')
dev.off()
