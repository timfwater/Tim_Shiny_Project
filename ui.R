
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
             ),    
              fluidRow(
             #   
                h1("Variable Description"),
                DT::dataTableOutput("healthtable")
              )  
               
               #tableOutput("Health_Variables")
               
               #h1("list of variables"),
               #tags$img(scr="./health_variable_table.png", style="width:180px; height:150px; border:0px;")
               
             )
             
             #    plotOutput("plot")
           )
         
),



#Tab 4


tabPanel("Variable Relatonships across States: Economic",
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
               column(6, ("Pearsons Correlation: by Input Variables, by State")),
               column(6, ("Regression Coeffecient: by Input Variables, by State"))
             ),
             fluidRow(  
               column(6, htmlOutput("map7")),
               column(6, htmlOutput("map8"))
             ),
              fluidRow(
           #     
                h2("Variable Description" 
                ),
                DT::dataTableOutput("economictable")            
              )   
           #   
           #   #    plotOutput("plot")
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
             fluidRow(("The Pearsons Correlation for Selected Variables, across all 50 States")),
             fluidRow(htmlOutput("map9")),
             fluidRow(("\n\nThe Regression Coeffecient for Selected Variables, across all 50 States")),
             fluidRow(htmlOutput("map10")),
             fluidRow(
               h3("Variable Description"),
               DT::dataTableOutput("societaltable")            
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
