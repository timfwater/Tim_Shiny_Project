
library(markdown)

# shinyServer(function(input, output,session) {


navbarPage("Relationships Between Different Demigraphic Variables",
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
#TAB2

  tabPanel("Variable Relatonships across States",
sidebarLayout(
  sidebarPanel(
    #fluidRow(something else)
    fluidRow(
      column(6, selectizeInput(inputId = "measure3",
                               label = "Choose a measure",
                               choices = choices_measures,
                               selected = choices_measures[1])),
      column(6, selectizeInput(inputId = "measure4",
                               label="Choose a second measure",
                               choices = choices_measures,
                               selected = choices_measures[1]))
    )
  ),
  mainPanel(
                             fluidRow(  
                               column(6, htmlOutput("map1")),
                               column(6, htmlOutput("map2"))
                             )    
    
    
#    plotOutput("plot")
  )
)
),


# sidebarLayout(
#   sidebarPanel(
# 
# 
# )),
#   mainPanel()


#Tab 3


tabPanel("Variable Relatonships across States: Health",
         sidebarLayout(
           sidebarPanel(
             #fluidRow(something else)
             fluidRow(
               column(6, selectizeInput(inputId = "measure5",
                                        label = "Choose a measure",
                                        choices = health_choices_measures,
                                        selected = health_choices_measures[1])),
               column(6, selectizeInput(inputId = "measure6",
                                        label="Choose a second measure",
                                        choices = health_choices_measures,
                                        selected = health_choices_measures[1]))
             )
           ),
           mainPanel(
             fluidRow(  
               column(6, htmlOutput("map5")),
               column(6, htmlOutput("map6"))
             )    
             
             
             #    plotOutput("plot")
           )
         )
),



#Tab 4


tabPanel("Variable Relatonships across States: Economy",
         sidebarLayout(
           sidebarPanel(
             #fluidRow(something else)
             fluidRow(
               column(6, selectizeInput(inputId = "measure7",
                                        label = "Choose a measure",
                                        choices = economic_choices_measures,
                                        selected = economic_choices_measures[1])),
               column(6, selectizeInput(inputId = "measure8",
                                        label="Choose a second measure",
                                        choices = economic_choices_measures,
                                        selected = economic_choices_measures[1]))
             )
           ),
           mainPanel(
             fluidRow(  
               column(6, htmlOutput("map7")),
               column(6, htmlOutput("map8"))
             )    
             
             
             #    plotOutput("plot")
           )
         )
),



#Tab 5


tabPanel("Variable Relatonships across States: Societal",
         sidebarLayout(
           sidebarPanel(
             #fluidRow(something else)
             fluidRow(
               column(6, selectizeInput(inputId = "measure9",
                                        label = "Choose a measure",
                                        choices = societal_choices_measures,
                                        selected = societal_choices_measures[1])),
               column(6, selectizeInput(inputId = "measure10",
                                        label="Choose a second measure",
                                        choices = societal_choices_measures,
                                        selected = societal_choices_measures[1]))
             )
           ),
           mainPanel(
             fluidRow(  
               column(6, htmlOutput("map9")),
               column(6, htmlOutput("map10"))
             )    
             
             
             #    plotOutput("plot")
           )
         )
)
#navpage parenthese below
)










 # tabPane1("Historic Correlation by State")


  #          sidebarLayout(
  #            sidebarPanel(
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
#     
#     
#   )))  
# ))
  # tabPanel("Summary",
  #   verbatimTextOutput("summary")
  # ))
  # navbarMenu("More",
  #   tabPanel("Table",
  #     DT::dataTableOutput("table")
  #   )))

#TAB 2    
        
# navbarPage("Tab 2 but really Tab 1")
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
#                         fluidRow(  
#                           column(6, htmlOutput("map1")),
#                           column(6, htmlOutput("map2"))
#                         ),
#
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
