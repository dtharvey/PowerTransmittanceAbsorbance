# user interface template

library(shiny)
library(shinythemes)

ui = navbarPage("AC 3.0: Transmittance and Absorbance",
                theme = shinytheme("journal"),
                header = tags$head(
                  tags$link(rel = "stylesheet", 
                            type = "text/css", 
                            href = "style.css")
                ),
    # user interface for introduction tab
      tabPanel("Introduction",
        fluidRow(
          column(width = 6,
            wellPanel(
              includeHTML("text/introduction.html")
               )
               ),
          column(width = 6,
           align = "center",
           img(src = "nessler_tubes.png", height = "350px"),
           br(),
           br(),
           img(src = "spec20.png", height = "350px")
                ) # close column
                ) # close fluidPanel         
                ), # close tabPanel
      
      tabPanel("Power and Transmittance",
               fluidRow(
                 column(width = 6,
                  wellPanel(
                    includeHTML("text/transmittance.html")
                    )),
                 column(width = 6,
                        align = "center",
                     splitLayout(
                       sliderInput("epsilon", "probability photon is absorbed",
                                   min = 0, max = 0.16, value = 0, step = 0.02,
                                   width = "300px", ticks = FALSE),
                       radioButtons("plotoption", "type of visualization",
                                    choices = c("none", "cross-sectional", 
                                                "P(d) vs. d"), 
                                    selected = "none", inline = FALSE,
                                    width = "100px")
                   ),
                   plotOutput("activty1plot", height = "500px")
               )
               )
               ),
    tabPanel("Modeling Transmittance",
             fluidRow(
               column(width = 6,
              wellPanel(
                includeHTML("text/model.html")
              )),
              column(width = 6,
               wellPanel(
                  radioButtons("linearize", "type of model",
                                choices = c("none","model 1", 
                                            "model 2", 
                                            "model 3"), 
                                selected = "none", inline = TRUE)
               ),
                plotOutput("activity2plot", height = "300px"),
                verbatimTextOutput("model")
              )
             )),
    tabPanel("Absorbance",
             fluidRow(
               column(width = 6,
                      wellPanel(
                        includeHTML("text/absorbance.html")
                      )),
               column(width = 6,
                      align = "center",
                      selectInput("set_opt", "Choose Cuvette Set",
                                  choices = c("Cuvette Key",
                                              "Set 1", 
                                              "Set 2",
                                              "Set 3"),
                                  selectize = FALSE),
                      # img(src = "cuvettes_new.png", height = "700px"),
                      imageOutput("sets", height = "500px"),
                      br(),
                      br(),
                      br(),
                      # img(src = "bulb_to_eye.png", width = "300px")
               )
             )
    ),
    tabPanel("Wrapping Up",
      fluidRow(column(width = 6,
        wellPanel(id = "wrapuppanel",
                  style = "overflow-y:scroll; max-height: 750px",
          includeHTML("text/wrapup.html")
        )),
        column(width = 6, 
            br(),
            br(),
            br(),
            br(),
            img(src = "Figure10.22.png", width = "100%"),
          )
        
      ))
               
      
    ) # close navbar page
