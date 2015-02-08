plot2 <- function() {
    
    fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
    zipFileName <- "data.zip"
    filename <- "household_power_consumption.txt"
    
    # download and extract data set
    download.file(fileUrl, destfile = zipFileName, method = "curl")
    unzip(zipfile = zipFileName, overwrite = TRUE )
    
    # read only the data that falls within the range
    dataTable <- read.table(text = grep("^[1,2]/2/2007", readLines(filename), value = TRUE), 
                            sep = ";", na.strings = "?")
    
    # rename the columns
    colnames(dataTable)<- c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3" )

    # combine date and time columns
    DateTime <-paste(dataTable$Date,dataTable$Time)
    dataTable$DateTime <-strptime(DateTime, "%d/%m/%Y %H:%M:%S")
    
    # configure png dimensions
    png(filename = "plot2.png", width = 480, height = 480, units = "px" )
    
    # plot
    with(dataTable, plot( DateTime, Global_active_power, type = "l", ylab="Global Active Power (kilowatts)", xlab=""))

    dev.off()
}
