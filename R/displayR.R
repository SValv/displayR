displayR<-function(DF="None",factordeclare=T,limit=8, na.rm=T, colorPalette="None"){

  ## Statics

  loader<-function(){
    drata<-tryCatch({
      filename<-choose.files()
      if(grepl(".xls",filename)){
        drata<-as.data.frame(readxl::read_excel(filename))
        return(drata)
      }else{drata<- as.data.frame(data.table::fread(filename))
      return(drata)}
    },error=function(cond){message("Couldnt read file, try loading it in manually!")}
    )
    return(drata)
  }

  ## load file functionality
  if(DF=="None"){
    DF<-loader()
  }else{NULL}

  ##clean missing values functionality
  if(na.rm==T){
    DF<-na.omit(DF)
  }

  ##function tab determining factors
  areFacs<-function(drata,limit){
    for(i in c(1:ncol(drata))){
      if (length(unique(unlist(drata[,i])))<=limit & !is.factor(as.data.frame(drata%>%select(i))[,1])){
        drata[,i]<-as.factor(unlist(drata[,i]))
      }else if (length(unique(unlist(drata[,i])))>=limit & !is.factor(as.data.frame(drata%>%select(i))[,1])){
        if(is.character(as.data.frame(drata%>%select(i))[,1])){
          drata[,i]<-sub(",",".",as.data.frame(drata%>%select(i))[,1])
        }
        drata[,i]<-as.numeric(unlist(drata[,i]))}
    }
    return(drata)
  }

  ## Factordeclare functionality
  if(factordeclare==T){
    DF<-areFacs(DF,limit)
  }

  ## Vector ohne Faktoren
  vecOhFac<-function(drata){
    vec=c()
    for(i in c(1:ncol(drata))){
      if(!is.factor(as.data.frame(drata%>%select(i))[,1])){
        vec=c(vec,colnames(drata)[i])
      }
    }
    return(vec)
  }

  ## Vector für faktoren
  vecFac<-function(drata){
    vec=c()
    for(i in c(1:ncol(drata))){
      if(is.factor(as.data.frame(drata%>%select(i))[,1])){
        vec=c(vec,colnames(drata)[i])
      }
    }
    return(vec)
  }

  ##Funktionen und Fixe Werte
  None<-NULL
  varlist<-c("None",names(DF))
  geomlist<-c("None","point","smooth","col","boxplot","violin","histogram","density")

  if(colorPalette=="None"){
    my_palette<-c("blue","red","green","orange","violet","black","cyan","yellow4","brown","grey60","pink")
  }else{
    my_palette<-colorPalette
  }

  listWithoutFactorsON<-vecOhFac(DF)
  listWithoutFactors<-c("None",listWithoutFactorsON)
  FactorList<-vecFac(DF)
  FactorList<-c("None",FactorList)
  DataDesc<-"You can check if you loaded the correct dataframe in here, the Variables should be in the rows of the table, the first five observations in the columns.
Thank you for using displayR!"

  ##Funktionen Data-tab

  headdisplay<-function(drata){
    hd<-t(head(drata,n=5))
    colnames(hd)<-c("Obs1","Obs2","Obs3","Obs4","Obs5")
    return(hd)
  }

  ##Definiere Funktion für Explore-tab
  ggplotselect<-function(drata,xaxis,yaxis,color,geom1=F,geom2=F,alphja1=0.8,alphja2=0.8,method1,method2){
    if(yaxis==varlist[1]){
      plota<-ggplot(drata,aes(x=get(xaxis),color=get(color),fill=get(color)))+theme_bw()
      plota<-plota+labs(x=xaxis)
    }else{
      plota<-ggplot(drata,aes(x=get(xaxis),y=get(yaxis),color=get(color),fill=get(color)))+theme_bw()
      plota<-plota+labs(x=xaxis,y=yaxis)
    }
    if(geom1!=geomlist[1]){
      plota<-plota+get(paste("geom_",as.character(geom1),sep=""))(alpha=alphja1,method=method1,se=F)}
    if(geom2!=geomlist[1]){
      plota<-plota+get(paste("geom_",as.character(geom2),sep=""))(alpha=alphja2,method=method2,se=F)}
    if(color!=varlist[1]){
      if(is.factor(as.data.frame(drata%>%select(color))[,1])){
        plota<-plota+scale_color_manual(name=color,breaks = unique(drata[,color]),values = my_palette)+scale_fill_manual(name=color,breaks = unique(drata[,color]),values = my_palette)
      }else{
        plota<-plota+scale_color_continuous(name=color,type = "viridis")+scale_fill_continuous(name=color,type = "viridis")}}

    if(geom1 == "point" | geom2 == "point"){
      ggplotly(plota)
      if(color==varlist[1]){
        tada<-paste(xaxis,":",drata[,xaxis],"<br>",yaxis,":",drata[,yaxis],"<br>")
      }else{tada<-paste(xaxis,":",drata[,xaxis],"<br>",yaxis,":",drata[,yaxis],"<br>",color,":",drata[,color])}
      style( plota, text=tada, hoverinfo = "text", traces = c(1, 2, 3, 4) ) ##mögl traces problematisch
    }else{ggplotly(plota)}
  }


  ## function summary-tab
  sumary<-function(drata,col,col2,col3){
    if (is.factor(as.data.frame(drata%>%select(col))[,1])){
      summ<-as.data.frame(addmargins(table(drata[,col])))
      colnames(summ)[1]<-col
    }else{
      summ<-drata%>%
        summarise(Observations=length(get(col)),Mean = mean(get(col)),SD = sd(get(col)),Median=median(get(col)),CoV=sd(get(col))/mean(get(col)),Variance=var(get(col)),Minimum=min(get(col)),Maximum=max(get(col)))
      rownames(summ)[1]<-col
      if(col2!="None"){
        summ2<-drata%>%
          summarise(Observations=length(get(col2)),Mean = mean(get(col2)),SD = sd(get(col2)),Median=median(get(col2)),CoV=sd(get(col2))/mean(get(col2)),Variance=var(get(col2)),Minimum=min(get(col2)),Maximum=max(get(col2)))
        rownames(summ2)[1]<-col2
        summ<-rbind(summ,summ2)
      }
      if(col3!="None"){
        summ3<-drata%>%
          summarise(Observations=length(get(col3)),Mean = mean(get(col3)),SD = sd(get(col3)),Median=median(get(col3)),CoV=sd(get(col3))/mean(get(col3)),Variance=var(get(col3)),Minimum=min(get(col3)),Maximum=max(get(col3)))
        rownames(summ3)[1]<-col3
        summ<-rbind(summ,summ3)
      }
      summ<-t(format.data.frame(summ,digits=3))
    }
    return(summ)
  }

  summGroup<-function(drata,group,trat){
    if(group!="None"){
      if(is.factor(as.data.frame(drata%>%select(trat))[,1])){
        DS<-as.data.frame.matrix(addmargins(table(unlist(drata[,trat]),unlist(drata[,group]))))
        colnames(DS)[3]<-paste("Summe",group)
        rownames(DS)[3]<-paste("Summe",trat)
      }else{
        DS<-drata%>%
          group_by(name = get(group)) %>%
          summarise(Observations=length(get(trat)),Mean = mean(get(trat)),SD = sd(get(trat)),Median=median(get(trat)),CoV=sd(get(trat))/mean(get(trat)),Variance=var(get(trat)),Minimum=min(get(trat)),Maximum=max(get(trat)))
        DS<-t(format.data.frame(DS,digits=3))
      }
      return(DS)
    }
  }


  ##Correlation-funcs

  ### Makes correlation Matrix
  vcor<-function(drata,inputs){
    g<-format(cor(drata[,inputs]),digits=3)
    return(g)
  }

  ###creates dimension args for plotly
  getcorm<-function(drata,inputs){
    argus<-list()
    a<-c(1:length(inputs))
    for (i in a){
      argus[[i]]<-list(label = inputs[i], values = drata[,inputs[i]])
    }
    return(argus)
  }


  ### makes Scatterplot-Matrix
  corplot<-function(drata,inputs){
    inlist=as.list(inputs)
    cp<-tryCatch({
      drata%>%
        plot_ly() %>%
        add_trace(
          type = 'splom',
          alpha=0.5,
          opacity=0.5,
          dimensions = getcorm(drata,inputs)
        )
    },error=function(cond){message("Please select more than one Variable")})
    return(cp)
  }

  ##Sidebar of App

  ##desciptives sidebar
  sidebarSummary<-dashboardSidebar(
    selectInput('vara','Select Variable 1', names(DF)),
    selectInput('vara2','Select Variable 2', listWithoutFactors,selected= listWithoutFactors[2]),
    selectInput('vara3','Select Variable 3', listWithoutFactors,selected= listWithoutFactors[2]),
    h4("Grouping Section"),
    selectInput('vargroup','Select variable to group', varlist,selected= "None"),
    selectInput('group','Group by Factor', FactorList)
  )

  ##explore sidebar
  sidebar3<-dashboardSidebar(
    selectInput('xcol2','X Variable', varlist),
    selectInput('ycol2','Y Variable', varlist),
    selectInput('colcol2','Color', varlist),
    selectInput('geom1','Geom1', geomlist),
    conditionalPanel(
      condition = "input.geom1 == 'smooth'",
      selectInput("Method1", "Method",
                  list("lm","gam", "loess"),selected = "lm")
    ),
    sliderInput("alpha1","Transparency Geom1",0,1,0.8,step = 0.05),
    selectInput('geom2','Geom2', geomlist),
    conditionalPanel(
      condition = "input.geom2 == 'smooth'",
      selectInput("Method2", "Method",
                  list("lm", "gam", "loess"),selected = "lm")
    ),
    sliderInput("alpha2","Transparency Geom1",0,1,0.8,step = 0.05),
    sidebarMenu())

  sidebarCorrel<-dashboardSidebar(
    selectInput("corl","Select variables to correlate them",listWithoutFactorsON,multiple = T)

  )


  ##Body of App
  bodyData<- dashboardBody(
    DTOutput("head")
  )

  bodyDesc <- dashboardBody(
    DTOutput("tbl"),
    conditionalPanel(condition = "input.group !='None'",
                     h3(textOutput("header"))),
    DTOutput("grptable")
  )

  bodyCorrel<-dashboardBody(
    DTOutput("corrm"),
    plotlyOutput("corrplot")
  )

  bodyInfo<-dashboardBody(
    includeMarkdown(system.file("rmd", "include.Rmd", package = "displayR"))
  )


  ##App- final UI
  ui<-navbarPage("displayR", theme = shinytheme("cosmo"),#themeSelector(),
                 tabPanel("Data",
                          sidebarLayout(
                            sidebarPanel(DataDesc
                            ),
                            #sidebarData),
                            mainPanel(
                              bodyData

                            )
                          )),
                 tabPanel("Descriptives",
                          sidebarLayout(
                            sidebarPanel(sidebarSummary),
                            mainPanel(
                              bodyDesc

                            )
                          )
                 ),
                 # tabPanel("Bericht",
                 #          sidebarLayout(
                 #              sidebarPanel(
                 #              ),
                 #              mainPanel(
                 #              )
                 #          )
                 # ),
                 tabPanel("Explore",
                          sidebarLayout(
                            sidebarPanel(
                              sidebar3
                            ),
                            mainPanel(
                              plotlyOutput("plota")
                            )
                          )
                 ),
                 tabPanel("Correlate",
                          sidebarLayout(
                            sidebarPanel(
                              sidebarCorrel
                            ),
                            mainPanel(
                              bodyCorrel
                            )
                          )
                 ),
                 tabPanel("Help",
                          sidebarLayout(
                            dashboardSidebar(
                              collapsed = TRUE,
                              sidebarMenu()
                            ),
                            mainPanel(
                              bodyInfo
                            )
                          )
                 )
  )

  ### Dynamics





  ##Server of App

  server <- function(input, output,session) {
    ## Data Tab
    output$head<-renderDT(datatable(headdisplay(DF),
                                    options = list(ordering=F,
                                                   initComplete = JS( "function(settings, json) {","$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});","}"))))


    ## Summary tab
    output$tbl = renderDT(datatable(sumary(DF,input$vara,input$vara2,input$vara3),
                                    options = list(dom = 't', ordering=F,
                                                   initComplete = JS( "function(settings, json) {","$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});","}"))))

    output$grptable<-renderDT(datatable(summGroup(DF,input$group,input$vargroup),
                                        options = list(dom = 't', ordering=F,
                                                       initComplete = JS( "function(settings, json) {","$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});","}"))))

    output$header<-renderText(paste(input$vargroup," by ",input$group))
    ## Plot for visualisation -as reactive as Possible
    output$plota <- renderPlotly(
      plot<-ggplotselect(DF,input$xcol2,input$ycol2,input$colcol2,input$geom1,input$geom2,input$alpha1,input$alpha2,input$Method1,input$Method2)
    )
    ##CorrelationPage
    output$corrm<-renderDT(datatable(vcor(DF,input$corl),
                                     options = list(dom = 't',
                                                    initComplete = JS( "function(settings, json) {","$(this.api().table().header()).css({'background-color': '#000', 'color': '#fff'});","}"))))
    output$corrplot<-renderPlotly(corplot(DF,input$corl))

    ##Output Info

  }

  shinyApp(ui,server)
}
