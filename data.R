####--SERVER DATA--------------------------------------------------------------------------------------------

#
# DATA
#

#### Datasets ####


###Function to filter data with the inputs widgets

  my_data_filtered<-reactive({
    my_data<-read_my_data() 
    #We temp variables for input values
    samplesize<-input$slider_sample_size
    minage<-input$slider_age[1]
    maxage<-input$slider_age[2]
    minBMI<-input$slider_BMI[1]
    maxBMI<-input$slider_BMI[2]
    minHbA1c<-input$slider_hba1c[1]
    maxHbA1c<-input$slider_hba1c[2]
    minstabilizedglucose<-input$slider_stabilizedglucose[1]
    maxstabilizedglucose<-input$slider_stabilizedglucose[2]
    mincholesterol<-input$slider_cholesterol[1]
    maxcholesterol<-input$slider_cholesterol[2]
    minHDL<-input$slider_HDL[1]
    maxHDL<-input$slider_HDL[2]
    minbloodpressuresystolic<-input$slider_BPS[1]
    maxbloodpressuresystolic<-input$slider_BPS[2]
    minbloodpressurediastolic<-input$slider_BPD[1]
    maxbloodpressurediastolic<-input$slider_BPD[2]

    #Apply filters sample size, BMI,Cholesterol,HbA1c,stabilized glucose,age,blood pressure systolic, blood pressure diastolic
    my_data<- my_data %>% 
        filter(
          n<=samplesize,
          age>=minage,
          age<=maxage,
          BMI>=minBMI,
          BMI<=maxBMI,
          glyhb>=minHbA1c,
          glyhb<=maxHbA1c,
          stab.glu>=minstabilizedglucose,
          stab.glu<=maxstabilizedglucose,
          chol>=mincholesterol,
          chol<=maxcholesterol,
          hdl>=minHDL,
          hdl<=maxHDL,
          bp.1s>=minbloodpressuresystolic,
          bp.1s<=maxbloodpressuresystolic,
          bp.1d>=minbloodpressurediastolic,
          bp.1d<=maxbloodpressurediastolic
                   )

    #filter by gender

    if (input$gender != "All") {
    my_gender <- paste0("%", input$gender, "%")
    my_data <- my_data %>% filter(gender %like% my_gender)
    }

    #filter by obesity status

    if (input$obesity != "All") {
    obesity <- paste0("%", input$obesity, "%")
    my_data <- my_data %>% filter(obcat %like% obesity)
    }

    #filter by diabetic status

    if (input$diabetic != "All") {
    diabetic <- paste0("%", input$diabetic, "%")
    my_data <- my_data %>% filter(glyhbcat %like% diabetic)
    }


  # Rename variables and remove column "frame"
    my_data<-rename(my_data,'Obesity status'=obcat, 'Diabetic status'=glyhbcat,'Subject id'=id,'Cholesterol'=chol,'Stabilized Glucose'=stab.glu,'HDL'=hdl,'Cholesterol/HDL Ratio'=ratio,HbA1c=glyhb,Location=location,Age=age,Gender=gender,'Height (inches)'=height,'Weight (pounds)'=weight,frame=frame,'First Systolic Blood Pressure'=bp.1s,'First Diastolic Blood Pressure'=bp.1d,'Second Systolic Blood Pressure'=bp.2s,'Second Diastolic Blood Pressure'=bp.2d,'Waist (inches)'=waist,'Hip (inches)'=hip,'Postprandial time (minutes)'=time.ppn)
    df<-select(my_data,-frame,-'Subject id')
    df<-select(df,n,Gender, Age,Location,BMI,'Obesity status','Diabetic status',HbA1c,everything())

    df
})