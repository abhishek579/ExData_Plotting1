# Store the current path to restore to at the end
path <- getwd()

# store the url of the dataset in a variable "fileurl"
fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

# Download and unzip the dataset file if the file does not already exist on the computer
if(!file.exists("~/Electric Power Consumption.zip" | "~/Electric Power Consumption/")){
    download.file(fileurl, destfile = "Electric Power Consumption.zip")
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

# Conversion of time variable into POSIXlt class
dataset$time <- strptime(dataset$time, format = "%H:%M:%S")

# Create a PNG file plot1.png of the specified height and width
png(filename = "plot1.png", width = 480, height = 480, units = "px")

# Code to create the desired histogram
hist(dataset$globalactivepower, col = "red", xlab = "Global Active Power (kilowatts)", main = "Global Active Power")
dev.off()

# Restore the working directory to the original path
setwd(path)