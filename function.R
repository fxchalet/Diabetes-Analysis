# Functions for connecting, loading, saving data 

read_my_data<-function(){
    #load data from Dr John Schorling 
    my_data<-read.csv("C:/Users/fxcha/OneDrive/Documents/R/Exercices/Shiny apps/App-Diabetes/diabetes.csv")
    #load data on variables
    my_variables<-read_excel("C:/Users/fxcha/OneDrive/Documents/R/Exercices/Shiny apps/App-Diabetes/variables.xlsx",range="B1:C20")
   
     #Compute the BMI and add a column for BMI
    my_data<-my_data%>%
        mutate(BMI=round(703*(weight/height^2),1)) 
    
    # Add a column with numeric values to filter the number of patient
    my_data<-my_data %>% mutate(n=1:403) %>% select(n,everything())
    
    
    #Add columns obesity and diabetes categories
    my_data<-my_data%>% mutate(obcat=case_when(
        BMI < 18.5~"Underweight",
        BMI>=18.5 & BMI<25~"Normal",
        BMI>=25 & BMI<30~"Overweight",
        BMI>=30 & BMI<40~"obese",
        BMI>40~"extremely obese",
    )) %>% 
        mutate(glyhbcat=case_when(
            glyhb<5.7~"normal",
            glyhb>=5.7 & glyhb<6.5~"prediabetes",
            glyhb>=6.5~"diabetes"
        )) 
    my_data<-as.data.frame(my_data)
    return(my_data)
}