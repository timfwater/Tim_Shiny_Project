
library(markdown)

# shinyServer(function(input, output,session) {


navbarPage("Relationships Between Different Demigraphic Variables",

#Intro tab
           tabPanel("An Overview of Application Offerings",
                    #fluid page

                      mainPanel(
                        fluidRow(("This web application is designed to provide basic statistical comparisons across a wide range vital-statistic and socio-economic variables, as recorded within the past the past 28 years of Census data.")),
                        fluidRow(),
                        fluidRow(("Specifically, the user is able to determine both the strength, and magnitude, of the linear relationships between over 800 different variables of interest, across all 50 states.")),
                        fluidRow(),                                    
                        fluidRow(("Hypothetical, the application has the potential to generate over 36 million analyses.")),
                        fluidRow(),                                   
                        fluidRow(("Of note, although records go back until 1990, not every variable was recorded for every year. Therefore, before drawing any conclusions from this application's analysis, it is prudent to investigate the data provided within the Historic Correlation by State tab, so as to ensure that a sufficient body of cross-referenced data points exist.
                                    
                                    
                                    
                                    Directory of Tabs:

                                    
                                    Tab 1: Historic Correlation by State
                                    
                                    This tab provides the user with the greatest degree of evaluative control, and specific detail. 
                                    
                                    The user may specify any of the 50 states, while simultaneously selecting any pairing of the 854 variables that are available within the database.
                                    
                                    Upon specifying these selections, a scatterplot is rendered. Each data point represents the pairing of the specified varriables, for a specific year. This enables the user to see the relationship between variables over time, as well as identifying the number of years of cross-referenced data off of which the model was built.

                                    
                                    Tab 2: Variable Relationships Across States
                                    
                                    This tab allows the user to visualize both the strength, and magnitude of the statistical relationship between any pairing of the 854 variables, across all 50 states, over the past 28 years.
                                    
                                    Upon selecting the variables of interest, two maps of the United States are rendered. 
                                    
                                    The first map displays the Pearson's Correlation between the two selected variables, as it exists for each state. 
                                    
                                    This statistic is based off of the model's variance, and indicates the predictive accuracy of the model. Values range from -1 to 1, with values closer to -1 indicating a strong negative predictive strength of the model, and values closer to 1 indicating a strong positive predictive strength of the model.
                                    
                                    A gradient color scale indicates the relative value for each state
                                    
                                    The second map displays the regression coefficient between the variables, as it exists for each state. 
                                    
                                    This statistic Indicates the positive or negative change of the dependent Y variable, for a single-unit-increase in independent X variable.
                                    
                                    A gradient color scale indicates the relative value for each state

                                    
                                    Tab 3: Variable Relationships Across States: Health
                                    
                                    This tab provides the same functionality as Tab 2, but limits the selection of available variables to those closely related to health concerns.
                                    
                                    Additionally, a brief description is provided for each available variable, in order to provide a better degree of context to what each measure specifically infers.

                                    
                                    Tab 4: Variable Relationships Across States: Economic
                                    
                                    This tab provides the same functionality as Tab 2, but limits the selection of available variables to those closely related to economic concerns.
                                    
                                    Additionally, a brief description is provided for each available variable, in order to provide a better degree of context to what each measure specifically infers.

                                    
                                    Tab 5: Variable Relationships Across States: Societal
                                    
                                    This tab provides the same functionality as Tab 2, but limits the selection of available variables to those closely related to societal concerns.
                                    
                                    Additionally, a brief description is provided for each available variable, in order to provide a better degree of context to what each measure specifically infers.
                                    
                                    
                                    
                                    All data was sourced from America's Health Rankings <https://www.americashealthrankings.org> which sources its information from multiple governmental and non-governmental sources.
                                    
                                    For additional details on the methodology of measuring of any of the varriables included, please visit the American Health Ranking's website for further details. 
                                    
                                    Here is my test")),
                        fluidRow()
                    )
           ),
           
           
tabPanel("Historic Variable Relationship by State",
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

  tabPanel("All Variable Relatonships across States",
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
  )
)
),



#Tab 3


tabPanel("Health Variable Relatonships across States",
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
                h1("Variable Description"),
                DT::dataTableOutput("healthtable")
              )  
             )
           )
),


#Tab 4


tabPanel("Economic Variable Relatonships across States",
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
                h2("Variable Description" 
                ),
                DT::dataTableOutput("economictable")            
              )   
            )
         )
),


#Tab 5


tabPanel("Societal Variable Relatonships across States",
         sidebarLayout(
           sidebarPanel(
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
