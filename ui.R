#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(ggplot2)
library(plotly)
library(shinyjs)
library(tibble)
library(knitr)
library(kableExtra)
library(stargazer)
library(xtable)
library(leaflet)
library(ggpubr)
library(grid)
library(measurements)
library(Hmisc)
library(corrplot)
library(PerformanceAnalytics)
library(cowplot)
library(rayshader)
library(blscrapeR)
library(rgdal)
library(spdplyr)
library(geojsonio)
library(rmapshaper)
library(sp)
library(magick)
library(webshot)
library(DT)
library(shinydashboard)
library(shiny)
library(readxl)
library(tidyverse)
library(maps)
library(RColorBrewer)
library(formattable)
library(knitr)
library(papeR)
library(rintrojs)


ui <- dashboardPage(skin="blue",title="Obesity",
  
    # HEADER ------------------------------------------------------------------    
    dashboardHeader(
      title=img(src="analysis.svg", height = 50, align = "center")
      ),
    # SIDEBAR -----------------------------------------------------------------
    dashboardSidebar(
      sidebarMenu(id="tab",
      menuItem("Introduction",tabName = "raw",icon=icon("database")),
          menuSubItem(tabName="sub_item_1",selectInput("gender", "Gender",
                                  c("All", "female", "male"))),
          menuSubItem(tabName="sub_item_2",selectInput("obesity", "Obesity status",
                                                     c("All","Underweight",  "Normal","Overweight","obese"))),
          menuSubItem(tabName="sub_item_3",selectInput("diabetic", "Diabetic status",
                                                     c("All", "normal", "prediabetes","diabetes","extremely obese"))),
      menuItem("Patients characteristics",tabName="pat",icon=icon('patient'),
      menuItem("Diabetes epidemiology",tabName = "epi",icon=icon("start")),
      menuItem("Correlation analysis",tabName = "corr",icon=icon("link")))
      )),

    # BODY -----------------------------------------------------------------
    dashboardBody(tabItems(
      # Tab n°1 : introduction --------------------------------------------------------------------
      tabItem(tabName = "raw",
                 fluidRow(
                   column(width=3,img(src="analysis.svg"),"AnalysiR"),
                   box(
                     title="Data presentation",
                     collapsible = TRUE,
                     collapsed = FALSE,
                     width=12,
                     background = NULL,
                     status="primary",
                     solidHeader = TRUE,
                fluidRow(
                        column(
                        width=12,
                        leafletOutput("mymap"),
                        column(
                        width=6,
                        dataTableOutput("drjohnschorling_dt")
                        ),
                      tags$h4("Parameters"),
                      column(
                        width = 6,
                        sliderInput("slider_sample_size", "Sample size",
                                     min = 0, max = 403, value = 80, step = 1
                        ),
                        sliderInput("slider_age", "Age",
                                     min = 18, max = 100, value = c(0,10), step = 1
                        ),
                        sliderInput("slider_BMI", "BMI",
                                     min = 15, max = 60, value = c(15,60), step = 1
                        ),
                        sliderInput("slider_hba1c", "HbA1c level",
                                     min = 2.5, max = 16.5 , value = c(2.68,16.11), step = 0.5
                        ),
                        sliderInput("slider_stabilizedglucose", "Stabilized glucose",
                                    min = 48, max = 386, value = c(48,386), step = 5
                      ),
                      column(
                        width = 6,
                        sliderInput("slider_cholesterol", "Cholesterol level",
                                     min = 78, max = 445, value = c(78,445), step = 10
                        ),
                        sliderInput("slider_HDL", "HDL level",
                                     min = 12, max = 120, value = c(12,120), step = 5
                        )
                        ,sliderInput("slider_BPS", "Blood pressure systolic (1st measure)",
                                     min = 90, max = 250, value = c(90,250), step = 10
                        ),
                        sliderInput("slider_BPD", "Blood pressure diastolic (1st measure)",
                                     min = 48, max = 124, value = c(48,124), step = 10
                        ),
                        fluidRow(
                          column(
                            width=12,
                            align="center",
                            actionButton(
                              inputId="learn_more_button",
                              label="Learn more",
                              color="default",
                              style="jelly"
                            )
                          )
                        ),
                        hidden(
                          div(
                            id="learn_more_div",
                            fluidRow(
                              column(
                                width=12,
                                tags$p("Dr John Schorling dataset consists of 19 variables on 403 subjects from 1046 subjects who were interviewed in a study to understand the prevalence of obesity, diabetes, and other cardiovascular risk factors in central Virginia for African Americans. According to Dr John Hong, Diabetes Mellitus Type II (adult onset diabetes) is associated most strongly with obesity. The waist/hip ratio may be a predictor in diabetes and heart disease. DM II is also agssociated with hypertension - they may both be part of Syndrome X. The 403 subjects were the ones who were actually screened for diabetes.Glycosolated hemoglobin <7.0% is usually taken as a positive diagnosis of diabetes")
                              )
                            )
                          )
                        )
                      )
                      )
                      )
                      )
                     )
                   )
                 )
              )
              )
    )


