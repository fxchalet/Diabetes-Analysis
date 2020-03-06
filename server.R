
server <- function(input, output) { 

  ####--SERVER BLOCK-----------------------------------------------------------------------------------------
  
  
  # Server modules 
  source('function.R', local = TRUE)
  source('data.R', local = TRUE)
  
  --### SERVER ###--
  
#--BLOCK PANEL DATA INTRODUCTION--------------------------------------------------------------------------------------

  
  # Display the dataset table (filtered or no)
  
  output$drjohnschorling_dt<-renderDataTable({
    my_data<-my_data_filtered()
    dataTable(my_data)
  })
  
  #Display the map of patients

output$mymap<-renderLeaflet({
  map<-readRDS("gadm36_USA_2_sp.rds")
  map %>% 
    filter(NAME_1=="Virginia")->virginia
  county1<-virginia[virginia$NAME_2=="Buckingham",]
  county2<-virginia[virginia$NAME_2=="Louisa",]
  county<-rbind(county1,county2)
  sum1<-sum(my_data$location=="Louisa")
  sum2<-sum(my_data$location=="Buckingham")
  
  content1<-paste(sep="<br/>",
                  "<b><a href='https://www.google.com/search?sxsrf=ALeKk00Z8pT3cLC0yuQKhGn98p9YupIIhw%3A1582717831754&ei=h1tWXvDALYHAa6fUnfAP&q=hree+Rivers+Medical+Center&oq=hree+Rivers+Medical+Center&gs_l=psy-ab.3..0i13l10.1563.1563..1829...0.1..0.79.79.1......0....1..gws-wiz.......0i71.rXosrOCu6hA&ved=0ahUKEwiwoJCxk-_nAhUB4BoKHSdqB_4Q4dUDCAs&uact=5'>Louisa Hospital</a></b>","203 patients screened for diabetes","and included in the study")
  
  content2<-paste(sep="<br/>",
                  "<b><a href='https://www.google.com/maps/search/hospital/@26.6607163,-81.8055767,12z/data=!3m1!4b1'>Buckingham Hospitals</a></b>","200 patients screened for diabetes","and included in the study")
  
  leaflet(county) %>% 
    addTiles() %>% 
    addPolygons() %>% 
    addPopups(lng=c(-78.003433,-78.524219),lat=c(38.025070,37.593907),popup = c(content1,content2))
})

###Display the learn more button to display additional information
observeEvent(input$learn_more_button,{
  toggle("learn_more_div")
})



}  
  