\name{displayR}
\alias{displayR}
\title{explore and visualize data}
\usage{
displayR(DF = "None", factordeclare = TRUE, limit = 8, na.rm = TRUE, colorPalette = "None")
}
\description{
Main function of the displayR package. displayR is a package for easy and quick exploration and visualisation of data directed to people with little expirience in R
}
\arguments{
  \item{DF}{a dataframe or object convertable to a dataframe that will be displayed. If you dont specify a dataframe, a menu to select one will open. It works with most formats like .txt, .csv etc (using fread). It cant open .xlsx files, if you encounter any problems with loading the data, try loading it manually.}

  \item{factordeclare}{if your dataframe isnt already structured (the factors are not declared as factors) this argument will do it for you by using the limit argument as margin.}

  \item{limit}{describes the maximum number of instances where the variable is converted into a factor, if the instances(determined by the length of the unique-vector) are higher, the variable wont be converted.}

  \item{na.rm}{if set to TRUE, na.rm removes missing values from the dataframe, it is recommended to be set to TRUE, because many functionalities of displayR wont work with missing values.}

  \item{colorPalette}{this argument gives you more control about the coloring of your plots, if you specify colors you will see them as factor levels in the plots. Note that it is important that your color vector contains as many colors as the levels of your highest-level factor.}

}

\note{
if you encounter any bugs or problems please feel free to contact me on github (@svalv) or via email to s.valverde146@gmail.com.
Since i am farely new to coding and have no expirience with development of anything this is actually very likely.
I'd also welcome feedback of any kind to improve this little baby-project.
}

\examples{
##without data set
displayR()

##With data set
displayR(data)

##without manipulation of data
displayR(data,factordeclare = FALSE, na.rm = FALSE)

##change colors in plots by factor. do not run, as "..." will throw an error
displayR(data,colorPalette = c("green","yellow","black",....,"other custom colors"))

}
