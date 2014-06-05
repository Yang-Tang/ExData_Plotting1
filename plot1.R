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

png('plot1.png', 480, 480)
hist(data$Global_active_power, main='Global Active Power', xlab = 'Global Active Power(kilowatts)', col = 'red')
dev.off()
