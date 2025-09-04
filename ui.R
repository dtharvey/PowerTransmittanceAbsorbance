# user interface for transmittance and absorbance learning module

ui = navbarPage("AC 3.0: Power, Transmittance, and Absorbance",
                theme = shinytheme("journal"),
                header = tags$head(
                  tags$link(rel = "stylesheet", 
                            type = "text/css", 
                            href = "style.css")
                ),
                
    # user interface for introduction tab
      tabPanel("Introduction",
        fluidRow(
          withMathJax(),
          column(width = 6,
            wellPanel(
              class = "scrollable-well",
              div(
                class = "html-fragment",
              includeHTML("text/introduction.html")
               ))),
          column(width = 6,
           align = "center",
           img(src = "nessler_tubes.png", height = "250px"),
           br(),
           br(),
           br(),
           br(),
           img(src = "spec20.png", height = "250px")
                ) # close column
                ) # close fluidRow         
                ), # close tabPanel
      
# first activity
      tabPanel("Power and Transmittance",
               fluidRow(
                 column(width = 6,
                  wellPanel(
                    class = "scrollable-well",
                    div(
                      class = "html-fragment",
                    includeHTML("text/activity1.html")
                    ))),
                 column(width = 6,
                        align = "center",
                     splitLayout(
                       sliderInput("epsilon", 
                                   "probability photon is absorbed",
                                   min = 0, max = 0.16, value = 0, 
                                   step = 0.02,
                                   width = "200px", ticks = FALSE),
                       img(src = "cuvette.png", height = "150px"),
                       radioButtons("plotoption", 
                                    "type of visualization",
                                    choices = c("none", 
                                                "cross-section plot", 
                                                "P(d) vs. d"), 
                                    selected = "none", inline = FALSE,
                                    width = "150px")
                   ),
                   plotOutput("activty1plot", height = "450px")
               ))),

# second activity   
    tabPanel("Modeling Transmittance",
             fluidRow(
               column(width = 6,
              wellPanel(
                class = "scrollable-well",
                div(
                  class = "html-fragment",
                includeHTML("text/activity2.html")
              ))),
              column(width = 6,
               wellPanel(
                  radioButtons("linearize", "type of model",
                                choices = c("none","model 1", 
                                            "model 2", 
                                            "model 3"), 
                                selected = "none", inline = TRUE)
               ),
                plotOutput("activity2plot", height = "250px"),
                br(),
                verbatimTextOutput("model")
              ))),

# third activity    
    tabPanel("Absorbance",
             fluidRow(
               column(width = 6,
                      wellPanel(
                        class = "scrollable-well",
                        div(
                          class = "html-fragment",
                        includeHTML("text/activity3.html")
                      ))),
               column(width = 6,
                      align = "center",
                      selectInput("set_opt", "Choose Cuvette Set",
                                  choices = c("Cuvette Key",
                                              "Set 1", 
                                              "Set 2",
                                              "Set 3"),
                                  selectize = FALSE),
                      br(),
                      br(),
                      br(),
                      imageOutput("sets", width = "90%"),
          
               ))),

# wrapping up    
    tabPanel("Wrapping Up",
      fluidRow(
        column(width = 6,
        wellPanel(
          class = "scrollable-well",
          div(
            class = "html-fragment",
          includeHTML("text/wrapup.html")
        ))),
        column(width = 6, 
            br(),
            br(),
            br(),
            br(),
            br(),
            br(),
            br(),
            div(style = "text-align: center;", img(src = "Figure10.22.png", width = "80%")),
          )))
            
    ) # close navbar page
