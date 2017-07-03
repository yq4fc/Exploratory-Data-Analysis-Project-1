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

par(mfrow =c(1,1))
hist(EPC$Global_active_power, col ="red", main="Global Active Power",
     xlab = "Global Active Power (kilowatts)")

# Save file
dev.copy(png, file = "plot1.png", height = 480, width = 480)
dev.off()
