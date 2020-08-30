# displayR

exploring and understanding data is one of the most important activities for data scientists and researchers, regardless of their exact field of activity.
In more and more areas, people are regularly faced with new data that must be understood before it can be processed. 
Nevertheless, in most standard programs there is no fast way to display the most important data in a well-organized way. 
For this reason this project - a R-Package called "displayR" - was developed. 
DisplayR offers a fast and easy to use insight into data and a comparatively deep overview without the need for deep R-knowledge. Therefore this package is also interesting for newcomers to R.

The advantages of this package are that it can be applied to almost any data set and thus, in addition to the results confirmation for study participants, it is a tool for the visual and statistical exploration of data sets. It can also be used by people who do not feel comfortable with the R programming language, as the package is easy and uncomplicated to use. Therefore it can be used for data exploration. 

Thank you for your interest in my package, i hope you enjoy it if you use it!

## Example

This is a link to an example of displayR useing a simulated dataset. You can make yourself familiar with the functionalities by experimenting and trying around. Note that computation speed is slower than on your own machine if you use displayR locally, because it is hosted locally - not in the web - which normally makes it a lot faster.

https://svalv.shinyapps.io/displayR


## Installation and Usage

If you want to install displayR you have to make sure you have devtools and Rtools installed.
You can get Rtools here https://cran.r-project.org/bin/windows/Rtools/ - I used Rtools 35 for the installation, but higher versions should work too.

To get devtools you can just use the line of code below:
```{r ,echo=T,eval=F}
install.packages("devtools")
```

If you followed the steps, to get displayR from my GitHub just use:

```{r ,echo=T,eval=F}
devtools::install_github("SValv/displayR")
```
There is a high probability that RStudio wants to update packages that got pre-installed from github. Just download all to ensure functionality.

To load and use it in your environment use one of the following options:

```{r ,echo=T,eval=F}
## Option 1:
displayR::displayR()

## Option 2: 
library(displayR)

displayR()
```

displayR has only one function called "displayR" it has five arguments:

DF(default="None"): a dataframe or object convertable to a dataframe that will be displayed. If you dont specify a dataframe, a menu to select one will open. It works with most formats like .txt, .csv etc (using fread), it also works with .xls/.xlsx data using readxl. If you encounter any problems with loading the data, try loading it manually.
```{r, eval=F}
displayR()
displayR(data)
```

factordeclare(default= *TRUE*): if your dataframe isnt already structured (the factors are not declared as factors) this argument will do it for you by using the limit argument as margin.
```{r, eval=F}
displayR(data,factordeclare = FALSE)
```

limit(default=*8*): describes the maximum number of instances where the variable is converted into a factor, if the instances(determined by the length of the unique-vector) are higher, the variable wont be converted.
```{r, eval=F}
displayR(data,factordeclare = TRUE,limit = 8)
```

colorPalette(default="None"): this argument gives you more control about the coloring of your plots, if you specify colors you will see them as factor levels in the plots. Note that it is important that your color vector contains as many colors as the levels of your highest-level factor.
```{r, eval=F}
displayR(data,colorPalette = c("green","yellow","black",....,"other custom colors"))
```

if nothing is given the default palette is:
```{r , eval=F}
c("blue","red","green","orange","violet","black","cyan","yellow4","brown","grey60","pink")
```

## Functionalities

The functions of displayR are listed here. There are a few ones, which are still work in progress.

### Data-Tab

In the data-tab of DisplayR you see the first five observations and which variables they have. The data set is transposed for visual reasons. This tab exists primarily to see if the data set has been read in correctly.

### Descriptive-Tab

In the descriptive-tab basic descriptive statistical values can be explored. For factors, a contingency table is displayed, for interval scaled data the following key figures are displayed:

* Number of observations
* Mean
* Median
* Standard Division
* CoV (Coefficient of Variation)
* Variance
* Minimum
* Maximum
* Missings (Number of NA's)

It's also possible to group a variable by different levels of a factor, even if the variable is a factor itself.

### Explore-Tab

In the Explore-Tab interactive graphs can be built, which can be very helpful to understand and explore your data. The frameworks of ggplot2 and plotly are used.
This might be confusing for newcomers at first, but with a bit of experience it can very effective and simple.
The aesthetics that you can assign variables to, are the x-axis, the y-axis and the color. 

### Correlate-Tab

The correlate-tab allows to correlate different variables. The correlation coefficient, as well as a scatterplot-matrix is generated automatically. If many variables correlate, it is often helpful to sort the table by the size of the correlation coefficient to quickly see what strongly correlates.

### Filter-Tab (work in progress)

In the filter-tab you can subset your data by using specific filters and use all the other tabs on the filtered data. You can also disable the filters to work with the original dataset again.

### Help-Tab

the Help-Tab is there to provide information about the package and to explain the commands to use displayR. It has a list of all dependencies of displayR

### Loader-Functionality

If there is no Argument passed for the dataset in the function, the loader will appear and a user will have the option to choose a file over a GuI-element. The most file-formats in use can be read by the loader.  

### Factordeclare

The factordeclare-functionality tries to recognize factors and convert them into the fitting format. It does so by usage of the "limits" argument. Look into the documentation to learn more.

## Strengths

The big strength of displayR is the high versatility and speed with which you can explore and visualize data. The interactive plotly framework allows far deeper insights into the data than traditional graphs without built-in interactivity.

## Weaknesses

DisplayR is still not that easy to install on older versions of R. It depends on newer versions of vctrs and ellipsis package, both cause problems with githubs auto-install feature.
Another Weakness is the failure-rate of the factordeclare- and loader functionalities. Even if those options are very comfortable, they are a possible source of errors, which is why the dataset sometimes has to be specified manually.

## Dependencies and note of thanks

The dependencies of this package are as follows:

> * data.table
> * dplyr
> * DT
> * ggplot2
> * plotly
> * readxl
> * shiny 
> * shinydashboard
> * shinythemes

Thanks a lot to the people providing these packages, to Julia Himmelsbach who helped me to come up with a few functionalities and to my college and friend Lena Pfeiffer who helped a lot with creative input.

# Similar Products

There are other similar products, whose differences to displayR are described in more detail below. All products/packages are very good and definitely worth a look. 

## burro

Burro has a nice but difficult framework but requires lots of dependencies, where displayR gives the same or a higher amount of insight in a easier visually format than burro. Furthermore displayR's use of interactivity in graphs and tables brings a more structured and deeper insight.

if you want to check out burro: https://laderast.github.io/burro/

## esquisse

Esquisse is a way better plotbuilder than displayR and an overall work of art, having a beautiful design and a wide range of functionalities of the ggplot framework - it's also available on CRAN which makes it a lot easier to use. 
But there are a few functionalities of displayR which esquisse is lacking (due to the fact that esquisse isn't specifically for data exploration but as an ggplot-builder). Those functionalities include the descriptives and the interactiveness of the plotly-framework, which is used by displayR and enable a deeper insight than static graphs. 

if you want to check out esquisse: https://github.com/dreamRs/esquisse

# Citations

To cite package ‘data.table’ in publications use:

  > Matt Dowle and Arun Srinivasan (2019). data.table: Extension of `data.frame`. R package version 1.12.8.
   https://CRAN.R-project.org/package=data.table

To cite package ‘dplyr’ in publications use:

  > Hadley Wickham, Romain François, Lionel Henry and Kirill Müller (2020). dplyr: A Grammar of Data Manipulation. R
   package version 0.8.5. https://CRAN.R-project.org/package=dplyr

To cite package ‘DT’ in publications use:

  > Yihui Xie, Joe Cheng and Xianying Tan (2020). DT: A Wrapper of the JavaScript Library 'DataTables'. R package version
    0.12. https://CRAN.R-project.org/package=DT

To cite ggplot2 in publications, please use:

  > H. Wickham. ggplot2: Elegant Graphics for Data Analysis. Springer-Verlag New York, 2016.
  
To cite plotly in publications use:

  > Carson Sievert (2018) plotly for R. https://plotly-r.com
  
To cite readxl in publications use:

  > Hadley Wickham and Jennifer Bryan (2019). readxl: Read Excel Files. R package version 1.3.1.
    https://CRAN.R-project.org/package=readxl

To cite package ‘shiny’ in publications use:

  > Winston Chang, Joe Cheng, JJ Allaire, Yihui Xie and Jonathan McPherson (2020). shiny: Web Application Framework for R.
    R package version 1.4.0.2. https://CRAN.R-project.org/package=shiny
  
To cite package ‘shinydashboard’ in publications use:

  > Winston Chang and Barbara Borges Ribeiro (2018). shinydashboard: Create Dashboards with 'Shiny'. R package version
    0.7.1. https://CRAN.R-project.org/package=shinydashboard

To cite package ‘shinythemes’ in publications use:

  > Winston Chang (2018). shinythemes: Themes for Shiny. R package version 1.1.2.
   https://CRAN.R-project.org/package=shinythemes


