# Load data
EPC <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.string="?", stringsAsFactors = FALSE)
str(EPC)
# Format the date variable 
EPC$Date <- as.Date(EPC$Date, format = "%d/%m/%Y")

## Filter data set from Feb. 1, 2007 to Feb. 2, 2007
EPC <- subset(EPC,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

## Remove incomplete observation
EPC <- EPC[complete.cases(EPC),]

## Combine Date and Time column
EPC$datetime <- strptime(paste(EPC$Date, EPC$Time), "%Y-%m-%d %H:%M:%S")

EPC$datetime <- as.POSIXct(EPC$datetime)

with(EPC, {
  plot(Sub_metering_1~datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~datetime,col='Red')
  lines(Sub_metering_3~datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.copy(png, file = "plot3.png", height = 480, width = 480)
dev.off()