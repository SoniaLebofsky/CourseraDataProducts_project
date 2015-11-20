### Code for playing around with eurodist and UScitiesD datasets to see how they can be manipulated
remove(list=ls())

library(datasets)
library(ggplot2)
data(eurodist)
data("UScitiesD")

# convert to matrices for ease of manipulation
eurodist <- as.matrix(eurodist)
usdist <- as.matrix(UScitiesD)

# Given a starting destination (in Europe) and max distance willing to drive,
# show the trips in order of distance
# Fun idea for a visualization --> show ALL the trips, but highlight/color the possible ones based on range

startCity <- "Cherbourg"
maxDist <- 1000

allTrips <- eurodist[!row.names(eurodist) == startCity, startCity]
#possibleTrips <- allTrips[allTrips >= drivingRange[1]][allTrips <= drivingRange[2]]
possibleTrips <- allTrips <= maxDist

trips <- data.frame(city = labels(allTrips), distance = allTrips, possible = as.factor(possibleTrips))

if (all(trips$possible == FALSE)){
    g <- ggplot(data = trips, aes(city, distance)) + geom_bar(stat = "identity", fill = "lightgray") +
        coord_flip() + theme_bw() + ylab("distance (km)")
}else if (all(trips$possible == TRUE)){
    g <- ggplot(data = trips, aes(city, distance)) + geom_bar(stat = "identity", fill = "yellow") +
        coord_flip() + theme_bw() + ylab("distance (km)") 
}else{
    g <- ggplot(data = trips, aes(city, distance, fill = possible)) + geom_bar(stat = "identity") +
        coord_flip() + theme_bw() + ylab("distance (km)") + 
        scale_fill_discrete("Possible Trips?", labels = c("No", "Yes"))
}

print(g)





