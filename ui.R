library(shiny)

shinyUI(fluidPage(
    titlePanel("Road Trip Planner"),
    
    sidebarLayout(
        sidebarPanel(
            helpText("This app will help you plan a European road trip!"),
            
            br(),
            
            helpText("From the drop-down menu, pick the city that you are starting your trip from. 
                     Then on the slider, choose the maximum distance you are willing to drive (in kilometers)."),
            
            br(),
            
            helpText("You will then see the cities you can drive to from your starting city. Happy planning!"),
            
            selectInput("city", label = "What city within the EU are you starting from?",
                        choices = list("Athens", "Barcelona", "Brussles", "Calais", 
                                       "Cherbourg", "Cologne", "Copenhagen", "Geneva", "Gilbraltar", 
                                       "Hamburg", "Hook of Holland", "Lisbon", "Lyons", "Madrid",
                                       "Marseilles", "Milan", "Munich", "Paris", "Rome", "Stockholm",
                                       "Vienna"),
                        selected = "Athens"),
            sliderInput("range", label = "Maximum distance you are willing to drive (in km):", min = 0, max = 4532,
                        value = 0)
        ),
        mainPanel(
            plotOutput("tripPlot")
        )
    )
))