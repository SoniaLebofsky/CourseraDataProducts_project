library(shiny)

shinyServer(function(input, output) {
    
    output$tripPlot <- renderPlot({
        plotPossibleTrips(input$city, input$range)
    })
    
})

plotPossibleTrips <- function(startCity, maxDist){
    library(datasets)
    library(ggplot2)
    data(eurodist)

    # convert to matrices for ease of manipulation
    eurodist <- as.matrix(eurodist)
    usdist <- as.matrix(UScitiesD)
    
    allTrips <- eurodist[!row.names(eurodist) == startCity, startCity]
    possibleTrips <- allTrips <= maxDist
    
    trips <- data.frame(city = labels(allTrips), distance = allTrips, possible = as.factor(possibleTrips))
    
    if (all(trips$possible == FALSE)){
        g <- ggplot(data = trips, aes(city, distance)) + geom_bar(stat = "identity", fill = "lightgray") +
            coord_flip() + theme_bw() + ylab("distance (km)") +
            labs(title = "I'm sorry, there are no possible trips.")
    }else if (all(trips$possible == TRUE)){
        g <- ggplot(data = trips, aes(city, distance)) + geom_bar(stat = "identity", fill = "yellow") +
            coord_flip() + theme_bw() + ylab("distance (km)") + 
            labs(title = "All trips are possible!")
    }else{
        g <- ggplot(data = trips, aes(city, distance, fill = possible)) + geom_bar(stat = "identity") +
            coord_flip() + theme_bw() + ylab("distance (km)") + 
            scale_fill_discrete("Possible Trip?", labels = c("No", "Yes")) +
            labs(title = "Check out the trips you can take!")
    }
    return(g)
}