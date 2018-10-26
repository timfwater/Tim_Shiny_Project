
library(markdown)

# shinyServer(function(input, output,session) {


navbarPage("Tab1 but really Tab2",
  tabPanel("Historic Correlation by State",
    #fluid page
    sidebarLayout(
      sidebarPanel(
        #fluidRow(something else)
        fluidRow(
          column(6, selectizeInput(inputId = "state",
                                   label = "Choose a state",
                                   choices = states_measures,
                                   selected = states_measures[1])),
          column(6, selectizeInput(inputId = "measure1",
                                   label = "Choose a measure",
                                   choices = choices_measures,
                                   selected = choices_measures[1])),
          column(6, selectizeInput(inputId = "measure2",
                                   label="Choose a second measure",
                                   choices = choices_measures,
                                   selected = choices_measures[1]))
        )
      ),
      mainPanel(

      
        
        plotOutput("plot")
      )
    )
  ),
  tabPanel("Summary",
    verbatimTextOutput("summary")
  ),
  navbarMenu("More",
    tabPanel("Table",
      DT::dataTableOutput("table")
    )))

#TAB 2    
        
# navbarPage("Tab 2 but really Tab 1",
#            tabPanel("Historic Correlation by State",
#                     #fluid page
#                     sidebarLayout(
#                       sidebarPanel(
#                         #fluidRow(something else)
#                         fluidRow(
#                           column(6, selectizeInput(inputId = "measure1",
#                                                    label = "Choose a measure",
#                                                    choices = choices_measures,
#                                                    selected = choices_measures[1])),
#                           column(6, selectizeInput(inputId = "measure2",
#                                                    label="Choose a second measure",
#                                                    choices = choices_measures,
#                                                    selected = choices_measures[1]))
#                         )
#                       ),
#                       mainPanel(
#                         
#                         
#                         
#                         plotOutput("plot")
#                       )
#                     )
#            )  
#     
    # tabPanel("About",
    #   fluidRow(
    #     column(6,
    #       #includeMarkdown("about.md")
    #     ),
    #     column(3,
    #       img(class="img-polaroid",
    #         src=paste0("http://upload.wikimedia.org/",
    #         "wikipedia/commons/9/92/",
    #         "1919_Ford_Model_T_Highboy_Coupe.jpg")),
    #       tags$small(
    #         "Source: Photographed at the Bay State Antique ",
    #         "Automobile Club's July 10, 2005 show at the ",
    #         "Endicott Estate in Dedham, MA by ",
    #         a(href="http://commons.wikimedia.org/wiki/User:Sfoskett",
    #           "User:Sfoskett")
    #       )
    #     )
    #   )
    # )
