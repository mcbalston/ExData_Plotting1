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
png(filename="plot2.png", width=480, height=480)

plot(data$dtm, data$Global_active_power,type="l",
        xlab="",
        ylab="Global Active Power (kilowatts)")

dev.off()
