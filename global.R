
library(shiny)
library(dplyr)
library(maps)
library(googleVis)
library(leaflet)
library(DT)
library(tidyr)
library(ggplot2)



####### Loading data for first Two tabs #######

AHRT <- readr::read_csv("AHRT.csv")
#mapdf4 <- readr::read_csv("Alabamatest.csv")

Health_Variables = readr::read_csv("Health_Variables.csv")
Economic_Variables = readr::read_csv("Economic_Variables.csv")
Societal_Variables = readr::read_csv("Societal_Variables.csv")


choices_measures = unique(AHRT$MeasureName)

states_measures = unique(AHRT$StateName)

health_choices_measures = Health_Variables$Variable

economic_choices_measures = Economic_Variables$Variable

societal_choices_measures = Societal_Variables$Variable

#Alabama Uninsured dataset
#reactive function down until 29 -- currently static til buttons work
# AL_UN = AHRT %>%
#   filter(., StateName == "Alabama") %>%
#   filter(., MeasureName == "Uninsured") %>%
#   filter(., !is.na(Value))
# #Alabama low health status dataset
#   AL_LHS = AHRT %>%
#   filter(., StateName == "Alabama") %>%
#   filter(., MeasureName == "Low Health Status") %>%
#   filter(., !is.na(Value))
# #Alabama unins/lowhs joined dataset
#   AL_UN_LHS = inner_join(AL_UN, AL_LHS, by = c("Edition","Edition"))
# #plot graphs
# AL_UN_LHS_G = ggplot(data=AL_UN_LHS, aes(x = Value.x, y = Value.y)) 
# AL_UN_LHS_GSC = AL_UN_LHS_G + geom_point()
# AL_UN_LHS_GLM = AL_UN_LHS_G + geom_point() + geom_smooth(method = "lm")
# #derive Rsq value
# AL_UN_LHS.lm = lm(Value.x ~ Value.y, data=AL_UN_LHS)
# AL_UN_LHS.cor = summary(AL_UN_LHS.lm)$r.squared 

#http://www.r-tutor.com/elementary-statistics/simple-linear-regression/coefficient-determination


# static plot first
# then buttons
# buttons work 
