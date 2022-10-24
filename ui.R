# user interface template

library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: Power, Transmittance, Absorbance, and Beer's Law",
                theme = shinytheme("journal"),
                tags$head(
                  tags$link(rel = "stylesheet", 
                            type = "text/css", 
                            href = "style.css")
                ),
    # user interface for introduction tab
      tabPanel("Introduction",
        fluidRow(
          column(width = 6,
            wellPanel(
              includeHTML("introduction.html")
               )
               ),
          column(width = 6,
           align = "center",
           img(src = "nessler.png", height = "350px"),
           br(),
           br(),
           img(src = "spec20.png", height = "350px")
                ) # close column
                ) # close fluidPanel         
                ), # close tabPanel
      tabPanel("Activity 1",
               fluidRow(
                 column(width = 6,
                  wellPanel(
                  includeHTML("activity1.html")
                )),
                 column(width = 6,
                        align = "center",
                        br(),
                        br(),
                        br(),
                   img(src = "cuvettes.png"),
                   br(),
                   br(),
                   br(),
                   img(src = "bulb_to_eye.png", width = "300px")
                )
                )
                ),
      tabPanel("Activity 2",
               fluidRow(
                 column(width = 6,
                  wellPanel(
                    includeHTML("activity2.html")
                    )),
                 column(width = 6,
                        align = "center",
                   wellPanel(
                     splitLayout(
                       sliderInput("epsilon", "probability photon is absorbed",
                                   min = 0, max = 0.16, value = 0, step = 0.02,
                                   width = "300px"),
                       radioButtons("plotoption", "type of visualization",
                                    choices = c("none", "cross-sectional", 
                                                "P(d) vs. d"), 
                                    selected = "none", inline = FALSE,
                                    width = "100px")
                   )
                   ),
                   plotOutput("activty2plot", height = "500px")
               )
               )
               ),
    tabPanel("Activity 3",
             fluidRow(
               column(width = 6,
              wellPanel(
                includeHTML("activity3.html")
              )),
              column(width = 6,
               wellPanel(
                  radioButtons("linearize", "type of model",
                                choices = c("none","model 1", 
                                            "model 2", 
                                            "model 3"), 
                                selected = "none", inline = TRUE)
               ),
                plotOutput("activity3plot", height = "300px"),
                verbatimTextOutput("model")
              )
             )),
    tabPanel("Wrapping Up",
      fluidRow(column(width = 6,
        wellPanel(
          includeHTML("wrapup.html")
        )),
        column(width = 6, 
            br(),
            br(),
            img(src = "Figure10.22.png", width = "100%")
          )
        
      ))
               
      
    ) # close navbar page
