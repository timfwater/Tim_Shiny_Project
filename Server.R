
function(input, output, session) {

  
#TAB2
  
filt_data <- reactive({
  M1 = AHRT %>%
    filter(., StateName == input$state) %>%
    filter(., MeasureName == input$measure1) %>%
    filter(., !is.na(Value))
  #state data set 1
  M2 = AHRT %>%
    filter(., StateName == input$state) %>%
    filter(., MeasureName == input$measure2) %>%
    filter(., !is.na(Value))
  #state data set 2
  M1M2 = inner_join(M1, M2, by = c("Edition","Edition"))
  })
  
    output$plot <- renderPlot({
    #plot graphs
	M1M2_G = ggplot(data=filt_data(), aes(x = Value.x, y = Value.y)) 
	M1M2_G + geom_point() + geom_smooth(method = "lm") #AL_UN_LHS_GSC = 
#	AL_UN_LHS_GLM = AL_UN_LHS_G + geom_point() + geom_smooth(method = "lm")
    })	

  output$statstable = DT::renderDataTable({
 
    M11 = AHRT %>%
      filter(., StateName == input$state) %>%
      filter(., MeasureName == input$measure1) %>%
      filter(., !is.na(Value))
    #state data set 1
    M12 = AHRT %>%
      filter(., StateName == input$state) %>%
      filter(., MeasureName == input$measure2) %>%
      filter(., !is.na(Value))
    #state data set 2
    M11M12 = inner_join(M11, M12, by = c("Edition","Edition"))
       
    M11M12_cor = cor(M11M12$Value.x, M11M12$Value.y,  method = "pearson", use = "complete.obs")
    M11M12_lm = lm(M11M12$Value.x ~ M11M12$Value.y)
    
    beta = summary(M11M12_lm)$coefficients[2,1]
    stde = summary(M11M12_lm)$coefficients[2,2]
    corre = M11M12_cor
    
    Statistic_Value = c(beta, stde, corre)
    Statistic_Name = c("Regression Coeffecient", 
                       "Standard Deviation of the Regression Coeffecient", "Correlation Coeffecient")
    
    ccc = cbind(Statistic_Name, Statistic_Value)
    ddd = as.data.frame(ccc)
    return(ddd)
  })    
    
    # output$qq = qq  	
# 	M1M2_cor = cor(M1M2$Value.x, M1M2$Value.y,  method = "pearson", use = "complete.obs")
# 	M1M2_lm = lm(M1M2$Value.x ~ M1M2$Value.y)
# 	M1M2_coef = M1M2_lm$coefficients[["M1M2$Value.y"]]
# 	qq = c(M1M2_cor, M1M2_coef)
#   })


#TAB 3

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
  mapdf$State_Coef = as.numeric(
    as.character(mapdf$State_Coef)
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
                  width=430, height=400))     
   })

#map 2 of Beta coefficient
   
   output$map2 <- renderGvis({
     gvisGeoChart(filt_data2(), locationvar="state_names", 
                  colorvar="State_Coef",
                  options=list(title="The Strength of the Relationship Between Selected Varriables (Pearsons Correlation)",
                               region="US",
                               sizeAxis.maxValue = 1.0,
                               sizeAxis.minValue = -1.0,
                               displayMode="regions", 
                               resolution="provinces",
                               width=430, height=400))     
   })   

#Tab 4
   
   filt_data3 <- reactive({
     
     State_Cor_H = numeric()
     State_Coef_H = numeric()
     state_names = unique(AHRT$StateName)
     state_names = state_names[state_names!='ALL' & !is.na(state_names) & 
                                 state_names!='United States' & state_names!= 'District of Columbia']
     state_names = unique(state_names)[order(unique(state_names))]
     
     for (state in state_names) {
       #derive measure 1 by state
       M5 = AHRT %>%
         filter(., StateName == state) %>%
         filter(., MeasureName == input$measure5) %>%
         filter(., !is.na(Value))
       #derive measure 2 by state
       M6 = AHRT %>%
         filter(., StateName == state) %>%
         filter(., MeasureName == input$measure6) %>%
         filter(., !is.na(Value))
       #Alabama unins/lowhs joined dataset
       M5M6 = inner_join(M5, M6, by = c("Edition","Edition"))
       M5M6_cor = cor(M5M6$Value.x, M5M6$Value.y,  method = "pearson", use = "complete.obs")
       M5M6_lm = lm(M5M6$Value.x ~ M5M6$Value.y)
       M5M6_coef = M5M6_lm$coefficients[["M5M6$Value.y"]]
       
       State_Cor_H = c(State_Cor_H, M5M6_cor)
       State_Coef_H = c(State_Coef_H, M5M6_coef)
       
     }
     mapdf_H = data.frame(cbind(state_names, State_Cor_H, State_Coef_H))
     print(dim(mapdf_H))
     mapdf_H$State_Cor_H = as.numeric(
       as.character(mapdf_H$State_Cor_H)
     )
     mapdf_H$State_Coef_H = as.numeric(
       as.character(mapdf_H$State_Coef_H)
     )
     return(mapdf_H)
   })
   
   
   #map 1 of pearsons
   
   output$map5 <- renderGvis({
     gvisGeoChart(filt_data3(), locationvar="state_names", 
                  colorvar="State_Cor_H",
                  options=list(title="The Strength of Statistical Relationships Between Selected Health Varriables (Pearsons Correlation)",
                               region="US",
                               sizeAxis.maxValue = 1.0,
                               sizeAxis.minValue = -1.0,
                               displayMode="regions", 
                               resolution="provinces",
                               width=430, height=400))     
   })
   
   #map 2 of Beta coefficient
   
   output$map6 <- renderGvis({
     gvisGeoChart(filt_data3(), locationvar="state_names", 
                  colorvar="State_Coef_H",
                  options=list(title="The Strength of the Relationship Between Selected Varriables (Pearsons Correlation)",
                               region="US",
                               sizeAxis.maxValue = 1.0,
                               sizeAxis.minValue = -1.0,
                               displayMode="regions", 
                               resolution="provinces",
                               width=430, height=400))     
   })   
   
    output$healthtable = DT::renderDataTable({
      Health_Variables
    })
   
    
   #Tab 5
   
   filt_data4 <- reactive({
     
     State_Cor_E = numeric()
     State_Coef_E = numeric()
     state_names = unique(AHRT$StateName)
     state_names = state_names[state_names!='ALL' & !is.na(state_names) & 
                                 state_names!='United States' & state_names!= 'District of Columbia']
     state_names = unique(state_names)[order(unique(state_names))]
     
     for (state in state_names) {
       #derive measure 1 by state
       M7 = AHRT %>%
         filter(., StateName == state) %>%
         filter(., MeasureName == input$measure7) %>%
         filter(., !is.na(Value))
       #derive measure 2 by state
       M8 = AHRT %>%
         filter(., StateName == state) %>%
         filter(., MeasureName == input$measure8) %>%
         filter(., !is.na(Value))
       #Alabama unins/lowhs joined dataset
       M7M8 = inner_join(M7, M8, by = c("Edition","Edition"))
       M7M8_cor = cor(M7M8$Value.x, M7M8$Value.y,  method = "pearson", use = "complete.obs")
       M7M8_lm = lm(M7M8$Value.x ~ M7M8$Value.y)
       M7M8_coef = M7M8_lm$coefficients[["M7M8$Value.y"]]
       
       State_Cor_E = c(State_Cor_E, M7M8_cor)
       State_Coef_E = c(State_Coef_E, M7M8_coef)
       
     }
     mapdf_E = data.frame(cbind(state_names, State_Cor_E, State_Coef_E))
     print(dim(mapdf_E))
     mapdf_E$State_Cor_E = as.numeric(
       as.character(mapdf_E$State_Cor_E)
     )
     mapdf_E$State_Coef_E = as.numeric(
       as.character(mapdf_E$State_Coef_E)
     )
     return(mapdf_E)
   })
   
   
   #map 1 of pearsons
   
   output$map7 <- renderGvis({
     gvisGeoChart(filt_data4(), locationvar="state_names", 
                  colorvar="State_Cor_E",
                  options=list(title="The Strength of Statistical Relationships Between Selected Health Varriables (Pearsons Correlation)",
                               region="US",
                               sizeAxis.maxValue = 1.0,
                               sizeAxis.minValue = -1.0,
                               displayMode="regions", 
                               resolution="provinces",
                               width=430, height=400))     
   })
   
   #map 2 of Beta coefficient
   
   output$map8 <- renderGvis({
     gvisGeoChart(filt_data4(), locationvar="state_names", 
                  colorvar="State_Coef_E",
                  options=list(title="The Strength of the Relationship Between Selected Varriables (Pearsons Correlation)",
                               region="US",
                               sizeAxis.maxValue = 1.0,
                               sizeAxis.minValue = -1.0,
                               displayMode="regions", 
                               resolution="provinces",
                               width=430, height=400))     
   })   
   
    output$economictable = DT::renderDataTable({
      Economic_Variables
    })   

   #Tab 6
   
   filt_data5 <- reactive({
     
     State_Cor_S = numeric()
     State_Coef_S = numeric()
     state_names = unique(AHRT$StateName)
     state_names = state_names[state_names!='ALL' & !is.na(state_names) & 
                                 state_names!='United States' & state_names!= 'District of Columbia']
     state_names = unique(state_names)[order(unique(state_names))]
     
     for (state in state_names) {
       #derive measure 1 by state
       M9 = AHRT %>%
         filter(., StateName == state) %>%
         filter(., MeasureName == input$measure9) %>%
         filter(., !is.na(Value))
       #derive measure 2 by state
       M10 = AHRT %>%
         filter(., StateName == state) %>%
         filter(., MeasureName == input$measure10) %>%
         filter(., !is.na(Value))
       #Alabama unins/lowhs joined dataset
       M9M10 = inner_join(M9, M10, by = c("Edition","Edition"))
       M9M10_cor = cor(M9M10$Value.x, M9M10$Value.y,  method = "pearson", use = "complete.obs")
       M9M10_lm = lm(M9M10$Value.x ~ M9M10$Value.y)
       M9M10_coef = M9M10_lm$coefficients[["M9M10$Value.y"]]
       
       State_Cor_S = c(State_Cor_S, M9M10_cor)
       State_Coef_S = c(State_Coef_S, M9M10_coef)
       
     }
     mapdf_S = data.frame(cbind(state_names, State_Cor_S, State_Coef_S))
     print(dim(mapdf_S))
     mapdf_S$State_Cor_S = as.numeric(
       as.character(mapdf_S$State_Cor_S)
     )
     mapdf_S$State_Coef_S = as.numeric(
       as.character(mapdf_S$State_Coef_S)
     )
     return(mapdf_S)
   })
   
   
   #map 1 of pearsons
   
   output$map9 <- renderGvis({
     gvisGeoChart(filt_data5(), locationvar="state_names", 
                  colorvar="State_Cor_S",
                  options=list(title="The Strength of Statistical Relationships Between Selected Health Varriables (Pearsons Correlation)",
                               region="US",
                               sizeAxis.maxValue = 1.0,
                               sizeAxis.minValue = -1.0,
                               displayMode="regions", 
                               resolution="provinces",
                               width=430, height=400))     
   })
   
   #map 2 of Beta coefficient
   
   output$map10 <- renderGvis({
     gvisGeoChart(filt_data5(), locationvar="state_names", 
                  colorvar="State_Coef_S",
                  options=list(title="The Strength of the Relationship Between Selected Varriables (Pearsons Correlation)",
                               region="US",
                               sizeAxis.maxValue = 1.0,
                               sizeAxis.minValue = -1.0,
                               displayMode="regions", 
                               resolution="provinces",
                               width=430, height=400))     
   })     
   

   output$societaltable = DT::renderDataTable({
     Societal_Variables
   })  
#function(input, output, session) end bracket   
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