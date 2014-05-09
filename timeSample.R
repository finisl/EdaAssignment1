require("ggplot2")
require("scales")
dtstring <- c(
    "2011-09-28 03:33:00", "2011-08-24 13:41:00", "2011-09-19 16:14:00",
    "2011-08-18 11:01:00", "2011-09-17 06:35:00", "2011-08-15 12:48:00"
)
dtPOSIXct <- as.POSIXct(dtstring)

# extract time of 'date+time' (POSIXct) in hours as numeric
dtTime <- as.numeric(dtPOSIXct - trunc(dtPOSIXct, "days"))
class(dtTime) <- "POSIXct"

p <- qplot(dtTime) + xlab("Time slot") + scale_x_datetime(labels = date_format("%S:00"))
print(p)


