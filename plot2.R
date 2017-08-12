# Store the current path to restore to at the end
path <- getwd()

# store the url of the dataset in a variable "fileurl"
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download and unzip the dataset file if the file does not already exist on the computer
if(!file.exists("~/Electric Power Consumption.zip")){
    download.file(fileurl, destfile = "Electric Power Consumption.zip")
}

# Unzip the downloaded zip file
if(!file.exists("~/Electric Power Consumption")){
unzip("Electric Power Consumption.zip", exdir = "Electric Power Consumption")
}

# Set the working directory to folder containing the unzipped file(s)
setwd("./Electric Power Consumption/")

#Size of the file = (2,075,259 * 9 * 8) = 149418648 bytes = (149418648/2^20) MB = 142.4 MB

# Size of my computer's RAM = 8 GB so this dataset can be loaded into my computer's memory

# Read the dataset file using R as a data frame "power_data"
power_data <- read.table("./household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", stringsAsFactors = FALSE)

# Cleaning the dataset
names(power_data) <- tolower(names(power_data))
names(power_data) <- gsub("_","", names(power_data))

# Removing the NA values and storing the resultant in the dataset data frame
dataset <- na.omit(power_data)

# Conversion of the date variable into data class
dataset$date <- as.Date(dataset$date, format = "%d/%m/%Y")

# Subset the dataset to contain only data from the dates 2007-02-01 and 2007-02-02
dataset <- subset(dataset, date >= "2007-02-01" & date <= "2007-02-02")

# Add a variable to the dataset to store the timestamp
dataset$datetime <- strptime(paste(dataset$date, dataset$time, sep = " "), format = "%Y-%m-%d %H:%M:%S")

# Create a PNG file plot2.png of the specified height and width
png(filename = "plot2.png", width = 480, height = 480, units = "px")

# Code to create the desired plot2
plot(dataset$datetime, dataset$globalactivepower, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()

# Restore the working directory to the original path
setwd(path)