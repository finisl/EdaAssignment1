## Part 1: loading data

# Figure out the calculation to get only the required dates: 2007-02-01 and 2007-02-02 
# The steps are:
#   1) Load 1 row to figure out how many columns
#   2) Load only the 1st column for dates
#   3) Calcualte the beginning rows to skip & the number of rows to load
hpower1row <- read.table("household_power_consumption.txt", header=TRUE, sep=";", nrows=1)
hpower1col <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", 
                         colClasses = c(NA, rep("NULL", ncol(hpower1row) - 1)))
hpower1col[,1] <- as.Date(hpower1col[,1], format="%d/%m/%Y")
load_skip <- which.max(hpower1col$Date == "2007-02-01") - 1
load_nrow <- which.max(hpower1col$Date == "2007-02-03") - which.max(hpower1col$Date == "2007-02-01")



# Load the file with only the required dates
hpower <- read.table("household_power_consumption.txt", header=TRUE, sep=";", skip=load_skip, nrows=load_nrow)
names(hpower) <- names(hpower1row)
hpower[,1] <- as.Date(hpower[,1], format="%d/%m/%Y")
hpower[,2]  <- as.POSIXct(hpower[,2], format="%H:%M:%S")
hpower[,2]  <- as.numeric(hpower[,2]  - trunc(hpower[,2] , units="days"))
# clean up the temporary variables used for calclating the time frame
rm(hpower1row)
rm(hpower1col)
rm(load_skip)
rm(load_nrow)



## Part 2: plot the diagram
png("plot1.png", width = 480, height = 480)
hist(as.numeric(hpower$Global_active_power), col="red", main = "Global Active Power",xlab="Global Active Power (kilowatts)")
dev.off()

