## Check if data already exists in working directory.  If not, download and unpack
        
if(!file.exists("household_power_consumption.txt")) {
        
        print("Downloading source data set...")
        ## Download zip file to temp files folder
        
        temp.file <- tempfile()
        url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(url, temp.file, method="curl")
        
        # Unzip to working directory
        
        unzip(temp.file)
}

# Load data
data <- read.table(file="household_power_consumption.txt",header=TRUE, sep=";", na.strings="?")

# Subset required observations
data <- subset(data, data$Date %in% c("1/2/2007","2/2/2007"))

# Create datetime variable
data$dtm <- strptime(paste(data$Date, data$Time),"%d/%m/%Y %H:%M:%S")


# Open png device, create plot, then close device.
png(filename="plot4.png", width=480, height=480)

par(mfrow=c(2,2))
# Plot 1 (top-left)
plot(data$dtm, data$Global_active_power,type="l",
     xlab="",
     ylab="Global Active Power")

# Plot 2 (top-right)
plot(data$dtm, data$Voltage,type="l",
     xlab="datetime",
     ylab="Voltage")

# Plot 3 (bottom-left)
plot(data$dtm, data$Sub_metering_1,type="l",
     xlab="",
     ylab="Energy sub metering")

lines(data$dtm, data$Sub_metering_2, col="red")
lines(data$dtm, data$Sub_metering_3, col="blue")
legend("topright", lwd=1, col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), bty="n")

# Plot 4 (bottom-right)
plot(data$dtm, data$Global_reactive_power,type="l",
     xlab="datetime",
     ylab="Global_reactive_power")

dev.off()

