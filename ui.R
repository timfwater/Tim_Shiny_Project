
library(markdown)

# shinyServer(function(input, output,session) {


navbarPage("Simple Social Science Slueth Solution",

#Intro tab
           tabPanel("Succinct Synopsis",

                      mainPanel(
                        fluidRow(h1("Simple Social Science Slueth Solution: Succinct Synposis")),
                        fluidRow(br()),
                        fluidRow(("This web application is designed to provide basic statistical comparisons across a wide range US vital-statistic and socio-economic variables, by state of interest, from a database housing 28 years of records.")),
                        fluidRow(br()),
                        fluidRow(("Specifically, the user is able to determine both the strength, and magnitude, of the linear relationships between over 850 different variables of interest, across all 50 states.")),
                        fluidRow(br()),                                    
                        fluidRow(("Hypothetical, the application has the potential to generate over 36 million analyses.")),
                        fluidRow(br()),                                   
                        fluidRow(("Of note, although records go back until 1990, not every variable was recorded for every year. Therefore, before drawing any conclusions from this application's analysis, it is prudent to investigate the data provided within the Historic 
                                  Correlation by State tab, so as to ensure that a sufficient body of cross-referenced data points exist.")),
                        fluidRow(br()),            
                        fluidRow(h2("Directory of Tabs:")),
                        fluidRow(br()),                                    
                        fluidRow((br("Tab 1: Comprehensive Correlation by State"))),
                                    
                        fluidRow(br("This tab provides the user with the greatest degree of evaluative control, and specific detail.")),
                                    
                        fluidRow(br("The user may specify any of the 50 states, while simultaneously selecting any pairing of the 854 variables that are available within the database.")),
                                    
                        fluidRow(br("Upon specifying these selections, a scatterplot is rendered. Each data point represents the pairing of the specified varriables, for a specific year. This enables
                                    the user to see the relationship between variables over time, as well as identifying the number of years of cross-referenced data off of which the model was built.")),

                        fluidRow(br()),                                    
                        fluidRow((br("Tab 2: Variable Correlations Across States: All Inclusive"))),
                                    
                        fluidRow(br("This tab allows the user to visualize both the strength, and magnitude of the statistical relationship between any pairing of the 854 variables, across all 50 states, over the past 28 years.")),
                                    
                        fluidRow(br("Upon selecting the variables of interest, two maps of the United States are rendered.")), 
                                    
                        fluidRow(br("The first map displays the Pearson's Correlation between the two selected variables, as it exists for each state.")), 
                                    
                        fluidRow(br("This statistic is based off of the model's variance, and indicates the predictive accuracy of the model. Values range from -1 to 1, with values closer to -1 indicating a strong negative predictive strength of the model, and values closer to 1 indicating a strong positive predictive strength of the model.
                                    
                                    A gradient color scale indicates the relative value for each state")),
                                    
                        fluidRow(br("The second map displays the regression coefficient between the variables, as it exists for each state.")), 
                                    
                        fluidRow(br("This statistic Indicates the positive or negative change of the dependent Y variable, for a single-unit-increase in independent X variable.
                                    
                                    A gradient color scale indicates the relative value for each state.")),

                        fluidRow(br()),                                    
                        fluidRow((br("Tab 3: Variable Correlation Across States: Health"))),
                                    
                        fluidRow(br("This tab provides the same functionality as Tab 2, but limits the selection of available variables to those closely related to health concerns.")),
                                    
                        fluidRow(br("Additionally, a brief description is provided for each available variable, in order to provide a better degree of context to what each measure specifically infers.")),

                        fluidRow(br()),                                    
                        fluidRow((br("Tab 4: Variable Correlation Across States: Economic"))),
                                    
                        fluidRow(br("This tab provides the same functionality as Tab 2, but limits the selection of available variables to those closely related to economic concerns.")),
                                    
                        fluidRow(br("Additionally, a brief description is provided for each available variable, in order to provide a better degree of context to what each measure specifically infers.")),

                        fluidRow(br()),                                   
                        fluidRow((br("Tab 5: Variable Correlation Across States: Societal"))),
                                    
                        fluidRow(br("This tab provides the same functionality as Tab 2, but limits the selection of available variables to those closely related to societal concerns.")),
                                    
                        fluidRow(br("Additionally, a brief description is provided for each available variable, in order to provide a better degree of context to what each measure specifically infers.")),
                                    
                        fluidRow(br()),                                    
                        fluidRow(br()),
                        fluidRow(br("Additional Information:")),
                        fluidRow(br("All data was sourced from America's Health Rankings (https://www.americashealthrankings.org) which provides information sourced from multiple governmental and non-governmental sources.")),
                                    
                        fluidRow(br("For additional details on the methodology of measuring of any of the varriables included, please visit the American Health Ranking's website for further details.")),
                        fluidRow()
                    )
           ),
           
#Tab 2           
tabPanel("Comprehensive Correlation by State",
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
        plotOutput("plot"),
        
        
         fluidRow(
           h3("Statistical Breakdown"),
           DT::dataTableOutput("statstable")
         )  
        
      )
    )
),
#TAB3

  tabPanel("Variable Correlation Across States: All Inclusive",
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



#Tab 4


tabPanel("Variable Correlation Across States: Health",
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
                h3("Variable Description"),
                DT::dataTableOutput("healthtable")
              )  
             )
           )
),


#Tab 5


tabPanel("Variable Correlation Across States: Economic",
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
                h4("Variable Description" 
                ),
                DT::dataTableOutput("economictable")            
              )   
            )
         )
),


#Tab 6


tabPanel("Variable Correlation Across States: Societal",
         sidebarLayout(
           sidebarPanel(
             #fluidRow(something else)
             fluidRow(
               column(6, selectizeInput(inputId = "measure9",
                                        label = "Choose a measure",
                                        choices = economic_choices_measures,
                                        selected = economic_choices_measures[1])),
               column(6, selectizeInput(inputId = "measure10",
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
               column(6, htmlOutput("map9")),
               column(6, htmlOutput("map10"))
             ),
             fluidRow(
               h5("Variable Description" 
               ),
               DT::dataTableOutput("societaltable")            
             )   
           )
         )
)
#navpage parenthese below
)



