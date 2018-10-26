
function(input, output, session) {

  #Alabama Uninsured dataset
  #reactive function down until 29 -- currently static til buttons work
  
#TAB1
  
filt_data <- reactive({
  M1 = AHRT %>%
    filter(., StateName == input$state) %>%
    filter(., MeasureName == input$measure1) %>%
    filter(., !is.na(Value))
  #Alabama low health status dataset
  M2 = AHRT %>%
    filter(., StateName == input$state) %>%
    filter(., MeasureName == input$measure2) %>%
    filter(., !is.na(Value))
  #Alabama unins/lowhs joined dataset
  M1M2 = inner_join(M1, M2, by = c("Edition","Edition"))
  })
  
    output$plot <- renderPlot({
    #plot graphs
	M1M2_G = ggplot(data=filt_data(), aes(x = Value.x, y = Value.y)) 
	M1M2_G + geom_point() #AL_UN_LHS_GSC = 
#	AL_UN_LHS_GLM = AL_UN_LHS_G + geom_point() + geom_smooth(method = "lm")

  })
#line 4 -- replace w ggplot/correlation lines 
  output$summary <- renderPrint({
    summary(AHR_AL)
  })

  output$table <- DT::renderDataTable({
    DT::datatable(AHR_AL)
  })
}

#TAB2

# filt_data2 <- reactive({
#   M3 = AHRT %>%
#     filter(., StateName == input$state) %>%
#     filter(., MeasureName == input$measure1) %>%
#     filter(., !is.na(Value))
#   #Alabama low health status dataset
#   M4 = AHRT %>%
#     filter(., StateName == input$state) %>%
#     filter(., MeasureName == input$measure2) %>%
#     filter(., !is.na(Value))
#   #Alabama unins/lowhs joined dataset
#   M3M4 = inner_join(M1, M2, by = c("Edition","Edition"))
#   M3M4_cor = cor(M3M4$Value.x, M3M4$Value.y,  method = "pearson", use = "complete.obs")
#   M3M4_lm = lm(M3M4$Value.x ~ M3M4$Value.y)
#   M3M4_coef = M3M4_lm$coefficients[["M3M4$Value.y"]]
#     
# })


# # Tab 1 Correlation between two measures ####
# output$map1 <- renderGvis({
#   gvisGeoChart(filter(AHR,DataValueTypeID==input$data_type), locationvar="StateAbbr", 
#                colorvar=input$measure1,
#                options=list(title="Correlation Strength",
#                             region="US", 
#                             displayMode="regions", 
#                             resolution="provinces",
#                             width=300, height=200))   