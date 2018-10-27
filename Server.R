
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
  # output$summary <- renderPrint({
  #   summary(AHR_AL)
  # })
  # 
  # output$table <- DT::renderDataTable({
  #   DT::datatable(AHR_AL)
  # })


#TAB2

filt_data2 <- reactive({
  
  State_Cor = numeric()
  State_Coef = numeric()
  state_names = unique(AHRT$StateName)
  state_names = state_names[state_names!='ALL' & !is.na(state_names) & 
                              state_names!='United States' & state_names!= 'District of Columbia']
  state_names = unique(state_names)[order(unique(state_names))]
  
  for (state in state_names) {
    #derive measure 1 by state
    M3 = AHRT %>%
      filter(., StateName == state) %>%
      filter(., MeasureName == input$measure3) %>%
      filter(., !is.na(Value))
    #derive measure 2 by state
    M4 = AHRT %>%
      filter(., StateName == state) %>%
      filter(., MeasureName == input$measure4) %>%
      filter(., !is.na(Value))
    #Alabama unins/lowhs joined dataset
    M3M4 = inner_join(M3, M4, by = c("Edition","Edition"))
    M3M4_cor = cor(M3M4$Value.x, M3M4$Value.y,  method = "pearson", use = "complete.obs")
    M3M4_lm = lm(M3M4$Value.x ~ M3M4$Value.y)
    M3M4_coef = M3M4_lm$coefficients[["M3M4$Value.y"]]
    
    State_Cor = c(State_Cor, M3M4_cor)
    State_Coef = c(State_Coef, M3M4_coef)
    
  }
  mapdf = data.frame(cbind(state_names, State_Cor, State_Coef))
  print(dim(mapdf))
  mapdf$State_Cor = as.numeric(
    as.character(mapdf$State_Cor)
  )
  return(mapdf)
})


#map 1 of pearsons

   output$map1 <- renderGvis({
    gvisGeoChart(filt_data2(), locationvar="state_names", 
     colorvar="State_Cor",
     options=list(title="The Strength of the Relationship Between Selected Varriables (Pearsons Correlation)",
                  region="US",
                  sizeAxis.maxValue = 1.0,
                  sizeAxis.minValue = -1.0,
                  displayMode="regions", 
                  resolution="provinces",
                  width=300, height=200))     
   })
}
  # 
  # output$map2 <- renderGvis({
  #   colorvar=input$State_Coef,
  #   options=list(title="The Degree of the Relationship Between Selected Varriables (Correlation Coeffecient)",
  #                region="US", 
  #                displayMode="regions", 
  #                resolution="provinces",
  #                width=300, height=200)     
  # })  


# filt_data2 <- reactive({
# State_Cor = numeric()
# State_Coef = numeric()
# state_names = unique(AHRT$StateName)
# state_names = state_names[state_names!='ALL' & !is.na(state_names)]
# state_names = unique(state_names)[order(unique(state_names))]
# 
# for (state in state_names) {
# #derive measure 1 by state
#   M3 = AHRT %>%
#     filter(., StateName == input$state) %>%
#     filter(., MeasureName1 == input$measure3) %>%
#     filter(., !is.na(Value))
# #derive measure 2 by state
#   M4 = AHRT %>%
#     filter(., StateName == input$state) %>%
#     filter(., MeasureName == input$measure4) %>%
#     filter(., !is.na(Value))
#   #Alabama unins/lowhs joined dataset
#   M3M4 = inner_join(M3, M4, by = c("Edition","Edition"))
#   M3M4_cor = cor(M3M4$Value.x, M3M4$Value.y,  method = "pearson", use = "complete.obs")
#   M3M4_lm = lm(M3M4$Value.x ~ M3M4$Value.y)
#   M3M4_coef = M3M4_lm$coefficients[["M3M4$Value.y"]]
# 
#   State_Cor = c(State_Cor, M3M4_cor)
#   State_Coef = c(State_Coef, M3M4_coef)
# }
# })




# filt_data2 <- reactive({
#   State_Cor = numeric()
#   State_Coef = numeric()
#   state_names = unique(AHRT$StateName)
#   state_names = state_names[state_names!='ALL' & !is.na(state_names)]
#   state_names = unique(state_names)[order(unique(state_names))]
#   
#   for (state in state_names) {
#     #derive measure 1 by state
#     M3 = AHRT %>%
#       filter(., StateName == state) %>%
#       filter(., MeasureName == input$measure3) %>%
#       filter(., !is.na(Value))
#     #derive measure 2 by state
#     M4 = AHRT %>%
#       filter(., StateName == state) %>%
#       filter(., MeasureName == input$measure4) %>%
#       filter(., !is.na(Value))
#     #Alabama unins/lowhs joined dataset
#     M3M4 = inner_join(M3, M4, by = c("Edition","Edition"))
#     M3M4_cor = cor(M3M4$Value.x, M3M4$Value.y,  method = "pearson", use = "complete.obs")
#     M3M4_lm = lm(M3M4$Value.x ~ M3M4$Value.y)
#     M3M4_coef = M3M4_lm$coefficients[["M3M4$Value.y"]]
#     
#     State_Cor = c(State_Cor, M3M4_cor)
#     State_Coef = c(State_Coef, M3M4_coef)
#   }    
#     mapdf = cbind(state_names, State_Cor, State_Coef)
#     return(mapdf)
# 
# })

#########################################################################################
  
#sophies  
# # Tab 1 Correlation between two measures ####
# output$map1 <- renderGvis({
#   gvisGeoChart(filter(AHR,DataValueTypeID==input$data_type), locationvar="StateAbbr", 
#                colorvar=input$measure1,
#                options=list(title="Correlation Strength",
#                             region="US", 
#                             displayMode="regions", 
#                             resolution="provinces",
#                             width=300, height=200))   