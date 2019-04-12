Lab Section 2: A Crash Course in R
==================================
-   [Installing and Loading Packages in R](#installing-and-loading-packages-in-r)
    -   [The Typical Way](#the-typical-way)
    -   [Function for Checking, Installing and Loading Packages](#function-for-checking-installing-and-loading-packages)
-   [R Markdown Tutorial](#r-markdown-tutorial)
    -   [Metadata](#metadata)
    -   [Code Chunks](#code-chunks)
    -   [Text](#text)
-   [A Brief Review](#a-brief-review)
    -   [Data Types](#data-types)
    -   [Data Structures](#data-structures)
    -   [Generating Sequences](#generating-sequences)
    -   [Creating a Function](#creating-a-function)
    -   [Using a For Loop vs Apply() vs Vectorization](#using-a-for-loop-vs-apply-vs-vectorization)
    -   [Logical Operators](#logical-operators)
    -   [If Statements](#if-statements)
    -   [Sampling from a Given Data](#sampling-from-a-given-data)
    -   [Generating Distribution Samples](#generating-distribution-samples)
    -   [Data Manipulation](#data-manipulation)
    -   [Dplyr](#dplyr)
    -   [Linear Regression](#linear-regression)
-   [Excercise](#excercise)

Installing and Loading Packages in R
====================================

Here's a brief overview of how I perform the following tasks:
1. Check for packages whether they have been installed or not
2. Install them if they are not yet installed
3. Load the packages into R 
4. Do this in multiple packages

The Typical Way
---------------

The most common way to install and load packages is simply to do this.

``` r
# Install
install.packages("dplyr")
install.packages("ggplot2")
install.packages("lubridate")
install.packages("stringr")
install.packages("foreign")

# Load
library(dplyr)
library(ggplot2)
library(lubridate)
library(stringr)
library(foreign)
```

However, as you work with more and more packages, it could be increasingly difficult to keep track of what packages have been installed or loaded and whatnot. A simple solution is to write a function that checks, installs, and loads the packages all in one go.

Function for Checking, Installing and Loading Packages
------------------------------------------------------

-   First, we assign a vector containing the names of the packages that you need for a given project to a variable called "packages"

``` r
packages <- c("dplyr", "ggplot2", "lubridate", "stringr", "foreign")
```

-   Second, we write a function that takes each element of "packages" as an argument and name this function `load.packages`

``` r
load.packages <- function(x) {
  if (!require(x, character.only = TRUE)) {
    # character.only = TRUE specifies that the argument being passed to the function is in character type
    install.packages(x, dependencies = TRUE)
    # setting dependencies to TRUE will also install other packages that are necessary
    library(x, character.only = TRUE) # load the package once it has been installed
  }
}
```

Here's a brief explanation of what's going on. The function `require()` is generally used to load a given package in a manner that is similar to `library()`. However, when we put an exclamation in front of it (`!require`), it not only tries to load the package but also returns `FALSE` if the package is installed and `TRUE` if the package is missing. Using this logical output, we can incorporate it into an if statement that loads a given package if it has been installed or installs the package and loads it if it has not been installed. - Lastly, we use `lapply()` to apply this function on each element in the vector "packages"

``` r
lapply(packages, load.packages)
```

R Markdown Tutorial
===================

R Markdown (.Rmd) provides a notebook interface that combines text and code to generate highly readable output. R Markdown documents typically have three main components.

Metadata
--------

The header section of the document is where you can include the metadata. Things like title, author, date and output ususally go here. Here's an example of what I used to generate this document.

``` r
---
title: "Lab Section 2: A Crash Course in R"
author: "Napon Jatusripitak"
date: "4/8/2019"
output:
  md_document:
    toc: true
    toc_depth: 2
    variant: markdown_github
---
```

In terms of output, you have several options (html, pdf, word doc, etc.). I chose markdown which is readable on GitHub.

Code Chunks
-----------

You can write your codes in chunks and run them separately. Note that when you knit the document, all your code chunks will be evaluated unless specified otherwise. Here's how to wrap your codes. Begin your chunk with three backticks (generally the same button as "~"") followed by "r" in braces and end your chunk with three backticks. For example,

`````` r
```{r}
packages <- c("dplyr", "ggplot2", "lubridate", "stringr", "foreign")
```
``````

You have many different options in dealing with your codes. At times, you might want to display your codes without running them. At other times, you might want to run your codes but without displaying the actual output. You will be making choices with regard to three issues:
1. Whether or not to evaluate your codes
2. Whether or not to display your codes
3. Whether or not to display your output

Here's a few chunk options:
- The default is to evaluate your codes and to display the codes as well as their output
- `eval=FALSE` displays your codes without evaluating them
- `echo=FALSE` does not display your codes but evaluates them and displays their output
- `include=FALSE` evaluates your codes but does not display your codes or their output
- `eval=FALSE, include=FALSE` does not evaluate or display your codes and their output
- `results="hide"` evaluates your codes and displays them without displaying their output

Can you think of what situations might call for the use of which commands?

Text
----

Lastly, you have texts. Anything that's not wrapped in backticks will generally be displayed as texts. You can make them bold, italic, create a header, create a link, create a list, and more. You can also do footnotes and citations, which is pretty neat.

Additional resources can be found here:
- [R Markdown Reference](https://www.rstudio.com/wp-content/uploads/2015/03/rmarkdown-reference.pdf)
- [R Markdown Cheat-sheet](https://www.rstudio.com/wp-content/uploads/2016/03/rmarkdown-cheatsheet-2.0.pdf)

A Brief Review
==============

Data Types
----------

Generally, you will be dealing with four main types of data objects (atomic vectors) including numeric, character, integer and logical.

``` r
numeric <- 1
character <- "a"
integer <- 1L
logical <- TRUE # or FALSE
```

Use `c()` with elements separated by commas to add multiple elements to a vector.

``` r
vector_numeric <- c(1, 2, 3, 4)
vector_character <- c("a", "b", "c", "d")
vector_integer <- c(1L, 2L, 3L, 4L)
vector_logical <- c(TRUE, FALSE, TRUE, FALSE)
```

To select specific element(s) in a vector, use brackets.

``` r
vector_logical[1]
```

    ## [1] TRUE

``` r
vector_character[1:3]
```

    ## [1] "a" "b" "c"

The functions `typeof()`, `length()`, `class()` and `str()` provide useful information about your vectors and R objects in general.

``` r
typeof(logical)
```

    ## [1] "logical"

``` r
length(vector_character)
```

    ## [1] 4

``` r
class(integer)
```

    ## [1] "integer"

``` r
str(vector_numeric)
```

    ##  num [1:4] 1 2 3 4

Data Structures
---------------

You will also encounter different data sturctures such as matrix, list, dataframes and factors.

``` r
matrix <- matrix(data = 1, nrow = 2, ncol = 2)
list <- list(1, 2, 3, 4)
dataframe <- data.frame(first = c("John", "Sarah", "Kate"), last = c("Legend", "Sanders", "Middleton"), age = c(40, 36, 37))
factor <- factor(c("low", "mid", "high", "mid", "low", "low", "high"))
# To coerce to different data structures, use as.matrix, as.list, as.data.frame, as.factor
```

Generating Sequences
--------------------

``` r
ones <- rep(1, 10)
ones
```

    ##  [1] 1 1 1 1 1 1 1 1 1 1

``` r
one_to_ten <- 1:10 # from:to
one_to_ten
```

    ##  [1]  1  2  3  4  5  6  7  8  9 10

``` r
one_to_ten2 <- seq(1,10,2) # seq(from, to, by=)
one_to_ten2
```

    ## [1] 1 3 5 7 9

``` r
one_to_ten_m <- matrix(data=seq(1,10,1), nrow=2, ncol=5, byrow=T)
one_to_ten_m
```

    ##      [,1] [,2] [,3] [,4] [,5]
    ## [1,]    1    2    3    4    5
    ## [2,]    6    7    8    9   10

Creating a Function
-------------------

Suppose we want a function that adds 1 to its argument:

``` r
plusone <- function(x){
  x + 1
}

plusone(2)
```

    ## [1] 3

Alternatively, we might write the function as:

``` r
plusone <- function(x){
  x + 1
}
```

We can pass a scalar (2) to this function which yields the following.

``` r
plusone(2)
```

    ## [1] 3

Or we can pass a vector of multiple elements.

``` r
plusone(c(2, 5, 9))
```

    ## [1]  3  6 10

Using a For Loop vs Apply() vs Vectorization
--------------------------------------------

Often, you'll want to repeat certain tasks or instructions. Suppose you are asked to square every value from 1 to 10.

In R, you have three main options.

### For Loops

``` r
vector = NULL # Initialize an empty vector for storing your data
for(i in 1:10){
  vector[i] <- i^2
}
vector
```

    ##  [1]   1   4   9  16  25  36  49  64  81 100

### Apply()

``` r
vector <- sapply(1:10, function(x) x^2)
vector
```

    ##  [1]   1   4   9  16  25  36  49  64  81 100

### Vectorization

According to Datacamp,
> vectorization is the operation of converting repeated operations on simply numbers ("scalars") into single operations on vectors or matrices. [Link](https://www.datacamp.com/community/tutorials/tutorial-on-loops-in-r)

My translation: this means it tends to be faster than loops or apply(), all else equal.

``` r
vector = 1:10
vector <- vector^2
vector
```

    ##  [1]   1   4   9  16  25  36  49  64  81 100

Logical Operators
-----------------

``` r
3 == 3
```

    ## [1] TRUE

``` r
3 >= 4
```

    ## [1] FALSE

``` r
3 < 4
```

    ## [1] TRUE

``` r
"Hi" == "Hello"
```

    ## [1] FALSE

``` r
3 != 4
```

    ## [1] TRUE

``` r
3 < 4 && 3 > 2 # use a single & to evaluate things element-wise
```

    ## [1] TRUE

``` r
3 < 4 || 3 > 6 # use a single | to evaluate things element-wise
```

    ## [1] TRUE

If Statements
-------------

For a simple illustration, suppose we want to compare two numbers.

``` r
a <- 6
b <- 5

if(a > b){
  print("True")
} else {
  print("False")
}
```

    ## [1] "True"

Or use a one-liner:

``` r
ifelse(a > b, print("True"), print("False"))
```

    ## [1] "True"

    ## [1] "True"

For more than two conditions, you would need to specify `else if()`

``` r
if(a > b){
  print("Greater")
} else if(a < b) {
  print("Lesser")
} else {
  print("Equal")
}
```

    ## [1] "Greater"

Sampling from a Given Data
--------------------------

``` r
names = c("John", "Jane", "Sam", "Sarah", "Blake", "Tim", "Jordan", "Lisa", "Alicia", "Emily")
sample(x = names, size = 2, replace = FALSE) # without replacement
```

    ## [1] "Jane"  "Emily"

To ensure that your result is reproducible, use the set.seed() function.

``` r
set.seed(125); sample(x = names, size = 2, replace = FALSE) 
```

    ## [1] "Alicia" "Jane"

Generating Distribution Samples
-------------------------------

### Normal Distribution

``` r
norm <- rnorm(10000, 3, 0.5) # rnorm(sample size = 10000, mean = 3, sd = 0.5)
mean(norm)
```

    ## [1] 2.999941

``` r
sd(norm)
```

    ## [1] 0.5017744

### Bernoulli Distribution

``` r
bern <- rbinom(100, 1, 0.5) # 100 iterations of a single coin toss
```

### Binomial Distribution

``` r
binom <- rbinom(100, 3, 0.5) # 100 iterations of three coin tosses, counting the number of heads (or tails)
```

### Discrete Uniform Distribution

``` r
dunif <- sample(1:10,10,replace=TRUE) 
```

### Continuous Uniform Distribution

``` r
cunif <- runif(10, min = 1, max = 10)
```

Data Manipulation
-----------------

### Describing the data

``` r
data(mtcars) # mtcars is a built-in dataset in R
str(mtcars) # describe the structure of the data
```

    ## 'data.frame':    32 obs. of  11 variables:
    ##  $ mpg : num  21 21 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 ...
    ##  $ cyl : num  6 6 4 6 8 6 8 4 4 6 ...
    ##  $ disp: num  160 160 108 258 360 ...
    ##  $ hp  : num  110 110 93 110 175 105 245 62 95 123 ...
    ##  $ drat: num  3.9 3.9 3.85 3.08 3.15 2.76 3.21 3.69 3.92 3.92 ...
    ##  $ wt  : num  2.62 2.88 2.32 3.21 3.44 ...
    ##  $ qsec: num  16.5 17 18.6 19.4 17 ...
    ##  $ vs  : num  0 0 1 1 0 1 0 1 1 1 ...
    ##  $ am  : num  1 1 1 0 0 0 0 0 0 0 ...
    ##  $ gear: num  4 4 4 3 3 3 3 4 4 4 ...
    ##  $ carb: num  4 4 1 1 2 1 4 2 2 4 ...

``` r
head(mtcars) # print the first 6 rows
```

    ##                    mpg cyl disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4         21.0   6  160 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag     21.0   6  160 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710        22.8   4  108  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive    21.4   6  258 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout 18.7   8  360 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant           18.1   6  225 105 2.76 3.460 20.22  1  0    3    1

``` r
nrow(mtcars) # number of rows
```

    ## [1] 32

``` r
ncol(mtcars) # number of columns
```

    ## [1] 11

``` r
rownames(mtcars) # row names
```

    ##  [1] "Mazda RX4"           "Mazda RX4 Wag"       "Datsun 710"         
    ##  [4] "Hornet 4 Drive"      "Hornet Sportabout"   "Valiant"            
    ##  [7] "Duster 360"          "Merc 240D"           "Merc 230"           
    ## [10] "Merc 280"            "Merc 280C"           "Merc 450SE"         
    ## [13] "Merc 450SL"          "Merc 450SLC"         "Cadillac Fleetwood" 
    ## [16] "Lincoln Continental" "Chrysler Imperial"   "Fiat 128"           
    ## [19] "Honda Civic"         "Toyota Corolla"      "Toyota Corona"      
    ## [22] "Dodge Challenger"    "AMC Javelin"         "Camaro Z28"         
    ## [25] "Pontiac Firebird"    "Fiat X1-9"           "Porsche 914-2"      
    ## [28] "Lotus Europa"        "Ford Pantera L"      "Ferrari Dino"       
    ## [31] "Maserati Bora"       "Volvo 142E"

``` r
colnames(mtcars) # column names
```

    ##  [1] "mpg"  "cyl"  "disp" "hp"   "drat" "wt"   "qsec" "vs"   "am"   "gear"
    ## [11] "carb"

``` r
dim(mtcars) # dimensions (observation & variables)
```

    ## [1] 32 11

### Selecting specific rows and/or columns of a dataframe

``` r
mtcars["mpg"]
```

    ##                      mpg
    ## Mazda RX4           21.0
    ## Mazda RX4 Wag       21.0
    ## Datsun 710          22.8
    ## Hornet 4 Drive      21.4
    ## Hornet Sportabout   18.7
    ## Valiant             18.1
    ## Duster 360          14.3
    ## Merc 240D           24.4
    ## Merc 230            22.8
    ## Merc 280            19.2
    ## Merc 280C           17.8
    ## Merc 450SE          16.4
    ## Merc 450SL          17.3
    ## Merc 450SLC         15.2
    ## Cadillac Fleetwood  10.4
    ## Lincoln Continental 10.4
    ## Chrysler Imperial   14.7
    ## Fiat 128            32.4
    ## Honda Civic         30.4
    ## Toyota Corolla      33.9
    ## Toyota Corona       21.5
    ## Dodge Challenger    15.5
    ## AMC Javelin         15.2
    ## Camaro Z28          13.3
    ## Pontiac Firebird    19.2
    ## Fiat X1-9           27.3
    ## Porsche 914-2       26.0
    ## Lotus Europa        30.4
    ## Ford Pantera L      15.8
    ## Ferrari Dino        19.7
    ## Maserati Bora       15.0
    ## Volvo 142E          21.4

``` r
mtcars[c("mpg", "hp")]
```

    ##                      mpg  hp
    ## Mazda RX4           21.0 110
    ## Mazda RX4 Wag       21.0 110
    ## Datsun 710          22.8  93
    ## Hornet 4 Drive      21.4 110
    ## Hornet Sportabout   18.7 175
    ## Valiant             18.1 105
    ## Duster 360          14.3 245
    ## Merc 240D           24.4  62
    ## Merc 230            22.8  95
    ## Merc 280            19.2 123
    ## Merc 280C           17.8 123
    ## Merc 450SE          16.4 180
    ## Merc 450SL          17.3 180
    ## Merc 450SLC         15.2 180
    ## Cadillac Fleetwood  10.4 205
    ## Lincoln Continental 10.4 215
    ## Chrysler Imperial   14.7 230
    ## Fiat 128            32.4  66
    ## Honda Civic         30.4  52
    ## Toyota Corolla      33.9  65
    ## Toyota Corona       21.5  97
    ## Dodge Challenger    15.5 150
    ## AMC Javelin         15.2 150
    ## Camaro Z28          13.3 245
    ## Pontiac Firebird    19.2 175
    ## Fiat X1-9           27.3  66
    ## Porsche 914-2       26.0  91
    ## Lotus Europa        30.4 113
    ## Ford Pantera L      15.8 264
    ## Ferrari Dino        19.7 175
    ## Maserati Bora       15.0 335
    ## Volvo 142E          21.4 109

``` r
mtcars[1, 3] # [row, column]
```

    ## [1] 160

``` r
mtcars[1, ] # first row, all columns
```

    ##           mpg cyl disp  hp drat   wt  qsec vs am gear carb
    ## Mazda RX4  21   6  160 110  3.9 2.62 16.46  0  1    4    4

``` r
mtcars[, 1] # all rows, first column
```

    ##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
    ## [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
    ## [29] 15.8 19.7 15.0 21.4

``` r
mtcars$mpg # selecting a variable
```

    ##  [1] 21.0 21.0 22.8 21.4 18.7 18.1 14.3 24.4 22.8 19.2 17.8 16.4 17.3 15.2
    ## [15] 10.4 10.4 14.7 32.4 30.4 33.9 21.5 15.5 15.2 13.3 19.2 27.3 26.0 30.4
    ## [29] 15.8 19.7 15.0 21.4

### Filtering for observations where the conditions are true

``` r
mtcars[mtcars$mpg < 20, ] # filtering for cars with mpg less than 20, retaining all columns
```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8

``` r
mtcars[mtcars$mpg < 20 & mtcars$cyl == 8, ] # filtering for cars with mpg less than 20 AND cyl equal to 8, retaining all columns
```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8

### Appending and dropping observations

``` r
newrow <- mtcars[1, ] # creating a new row
mtcars2 <- rbind(mtcars, newrow) # combined <- rbind(initial, additional)
mtcars2
```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
    ## Mazda RX41          21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4

``` r
mtcars2[-33, ] # removing the row we just created by referencing the row number
```

    ##                      mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## Mazda RX4           21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag       21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710          22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive      21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout   18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## Valiant             18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## Duster 360          14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D           24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## Merc 230            22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## Merc 280            19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C           17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE          16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL          17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC         15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial   14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128            32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic         30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla      33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona       21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger    15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin         15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28          13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird    19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9           27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2       26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa        30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L      15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino        19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora       15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E          21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2

### Selecting variables

``` r
target <- c("mpg", "hp")
mtcars[target]
```

    ##                      mpg  hp
    ## Mazda RX4           21.0 110
    ## Mazda RX4 Wag       21.0 110
    ## Datsun 710          22.8  93
    ## Hornet 4 Drive      21.4 110
    ## Hornet Sportabout   18.7 175
    ## Valiant             18.1 105
    ## Duster 360          14.3 245
    ## Merc 240D           24.4  62
    ## Merc 230            22.8  95
    ## Merc 280            19.2 123
    ## Merc 280C           17.8 123
    ## Merc 450SE          16.4 180
    ## Merc 450SL          17.3 180
    ## Merc 450SLC         15.2 180
    ## Cadillac Fleetwood  10.4 205
    ## Lincoln Continental 10.4 215
    ## Chrysler Imperial   14.7 230
    ## Fiat 128            32.4  66
    ## Honda Civic         30.4  52
    ## Toyota Corolla      33.9  65
    ## Toyota Corona       21.5  97
    ## Dodge Challenger    15.5 150
    ## AMC Javelin         15.2 150
    ## Camaro Z28          13.3 245
    ## Pontiac Firebird    19.2 175
    ## Fiat X1-9           27.3  66
    ## Porsche 914-2       26.0  91
    ## Lotus Europa        30.4 113
    ## Ford Pantera L      15.8 264
    ## Ferrari Dino        19.7 175
    ## Maserati Bora       15.0 335
    ## Volvo 142E          21.4 109

### Excluding variables

``` r
target <- names(mtcars) %in% c("mpg", "hp")
mtcars[!target]
```

    ##                     cyl  disp drat    wt  qsec vs am gear carb
    ## Mazda RX4             6 160.0 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag         6 160.0 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710            4 108.0 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive        6 258.0 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout     8 360.0 3.15 3.440 17.02  0  0    3    2
    ## Valiant               6 225.0 2.76 3.460 20.22  1  0    3    1
    ## Duster 360            8 360.0 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D             4 146.7 3.69 3.190 20.00  1  0    4    2
    ## Merc 230              4 140.8 3.92 3.150 22.90  1  0    4    2
    ## Merc 280              6 167.6 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C             6 167.6 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE            8 275.8 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL            8 275.8 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC           8 275.8 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood    8 472.0 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental   8 460.0 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial     8 440.0 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128              4  78.7 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic           4  75.7 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla        4  71.1 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona         4 120.1 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger      8 318.0 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin           8 304.0 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28            8 350.0 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird      8 400.0 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9             4  79.0 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2         4 120.3 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa          4  95.1 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L        8 351.0 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino          6 145.0 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora         8 301.0 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E            4 121.0 4.11 2.780 18.60  1  1    4    2

Dplyr
-----

``` r
library(dplyr)
```

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
select(mtcars, mpg)
```

    ##                      mpg
    ## Mazda RX4           21.0
    ## Mazda RX4 Wag       21.0
    ## Datsun 710          22.8
    ## Hornet 4 Drive      21.4
    ## Hornet Sportabout   18.7
    ## Valiant             18.1
    ## Duster 360          14.3
    ## Merc 240D           24.4
    ## Merc 230            22.8
    ## Merc 280            19.2
    ## Merc 280C           17.8
    ## Merc 450SE          16.4
    ## Merc 450SL          17.3
    ## Merc 450SLC         15.2
    ## Cadillac Fleetwood  10.4
    ## Lincoln Continental 10.4
    ## Chrysler Imperial   14.7
    ## Fiat 128            32.4
    ## Honda Civic         30.4
    ## Toyota Corolla      33.9
    ## Toyota Corona       21.5
    ## Dodge Challenger    15.5
    ## AMC Javelin         15.2
    ## Camaro Z28          13.3
    ## Pontiac Firebird    19.2
    ## Fiat X1-9           27.3
    ## Porsche 914-2       26.0
    ## Lotus Europa        30.4
    ## Ford Pantera L      15.8
    ## Ferrari Dino        19.7
    ## Maserati Bora       15.0
    ## Volvo 142E          21.4

``` r
select(mtcars, -mpg, -hp)
```

    ##                     cyl  disp drat    wt  qsec vs am gear carb
    ## Mazda RX4             6 160.0 3.90 2.620 16.46  0  1    4    4
    ## Mazda RX4 Wag         6 160.0 3.90 2.875 17.02  0  1    4    4
    ## Datsun 710            4 108.0 3.85 2.320 18.61  1  1    4    1
    ## Hornet 4 Drive        6 258.0 3.08 3.215 19.44  1  0    3    1
    ## Hornet Sportabout     8 360.0 3.15 3.440 17.02  0  0    3    2
    ## Valiant               6 225.0 2.76 3.460 20.22  1  0    3    1
    ## Duster 360            8 360.0 3.21 3.570 15.84  0  0    3    4
    ## Merc 240D             4 146.7 3.69 3.190 20.00  1  0    4    2
    ## Merc 230              4 140.8 3.92 3.150 22.90  1  0    4    2
    ## Merc 280              6 167.6 3.92 3.440 18.30  1  0    4    4
    ## Merc 280C             6 167.6 3.92 3.440 18.90  1  0    4    4
    ## Merc 450SE            8 275.8 3.07 4.070 17.40  0  0    3    3
    ## Merc 450SL            8 275.8 3.07 3.730 17.60  0  0    3    3
    ## Merc 450SLC           8 275.8 3.07 3.780 18.00  0  0    3    3
    ## Cadillac Fleetwood    8 472.0 2.93 5.250 17.98  0  0    3    4
    ## Lincoln Continental   8 460.0 3.00 5.424 17.82  0  0    3    4
    ## Chrysler Imperial     8 440.0 3.23 5.345 17.42  0  0    3    4
    ## Fiat 128              4  78.7 4.08 2.200 19.47  1  1    4    1
    ## Honda Civic           4  75.7 4.93 1.615 18.52  1  1    4    2
    ## Toyota Corolla        4  71.1 4.22 1.835 19.90  1  1    4    1
    ## Toyota Corona         4 120.1 3.70 2.465 20.01  1  0    3    1
    ## Dodge Challenger      8 318.0 2.76 3.520 16.87  0  0    3    2
    ## AMC Javelin           8 304.0 3.15 3.435 17.30  0  0    3    2
    ## Camaro Z28            8 350.0 3.73 3.840 15.41  0  0    3    4
    ## Pontiac Firebird      8 400.0 3.08 3.845 17.05  0  0    3    2
    ## Fiat X1-9             4  79.0 4.08 1.935 18.90  1  1    4    1
    ## Porsche 914-2         4 120.3 4.43 2.140 16.70  0  1    5    2
    ## Lotus Europa          4  95.1 3.77 1.513 16.90  1  1    5    2
    ## Ford Pantera L        8 351.0 4.22 3.170 14.50  0  1    5    4
    ## Ferrari Dino          6 145.0 3.62 2.770 15.50  0  1    5    6
    ## Maserati Bora         8 301.0 3.54 3.570 14.60  0  1    5    8
    ## Volvo 142E            4 121.0 4.11 2.780 18.60  1  1    4    2

``` r
filter(mtcars, mpg <20) # filter(df, condition)
```

    ##     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## 1  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## 2  18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## 3  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## 4  19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## 5  17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## 6  16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## 7  17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## 8  15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## 9  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## 10 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## 11 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## 12 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## 13 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## 14 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## 15 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## 16 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## 17 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## 18 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8

``` r
filter(mtcars, mpg <20, cyl == 8) # filter(df, condition1, condition 2)
```

    ##     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## 1  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## 2  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## 3  16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## 4  17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## 5  15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## 6  10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## 7  10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## 8  14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## 9  15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## 10 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## 11 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## 12 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## 13 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## 14 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8

``` r
count(mtcars, cyl == 8)
```

    ## # A tibble: 2 x 2
    ##   `cyl == 8`     n
    ##   <lgl>      <int>
    ## 1 FALSE         18
    ## 2 TRUE          14

``` r
mtcars2 <- bind_rows(mtcars, newrow)
mtcars2
```

    ##     mpg cyl  disp  hp drat    wt  qsec vs am gear carb
    ## 1  21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4
    ## 2  21.0   6 160.0 110 3.90 2.875 17.02  0  1    4    4
    ## 3  22.8   4 108.0  93 3.85 2.320 18.61  1  1    4    1
    ## 4  21.4   6 258.0 110 3.08 3.215 19.44  1  0    3    1
    ## 5  18.7   8 360.0 175 3.15 3.440 17.02  0  0    3    2
    ## 6  18.1   6 225.0 105 2.76 3.460 20.22  1  0    3    1
    ## 7  14.3   8 360.0 245 3.21 3.570 15.84  0  0    3    4
    ## 8  24.4   4 146.7  62 3.69 3.190 20.00  1  0    4    2
    ## 9  22.8   4 140.8  95 3.92 3.150 22.90  1  0    4    2
    ## 10 19.2   6 167.6 123 3.92 3.440 18.30  1  0    4    4
    ## 11 17.8   6 167.6 123 3.92 3.440 18.90  1  0    4    4
    ## 12 16.4   8 275.8 180 3.07 4.070 17.40  0  0    3    3
    ## 13 17.3   8 275.8 180 3.07 3.730 17.60  0  0    3    3
    ## 14 15.2   8 275.8 180 3.07 3.780 18.00  0  0    3    3
    ## 15 10.4   8 472.0 205 2.93 5.250 17.98  0  0    3    4
    ## 16 10.4   8 460.0 215 3.00 5.424 17.82  0  0    3    4
    ## 17 14.7   8 440.0 230 3.23 5.345 17.42  0  0    3    4
    ## 18 32.4   4  78.7  66 4.08 2.200 19.47  1  1    4    1
    ## 19 30.4   4  75.7  52 4.93 1.615 18.52  1  1    4    2
    ## 20 33.9   4  71.1  65 4.22 1.835 19.90  1  1    4    1
    ## 21 21.5   4 120.1  97 3.70 2.465 20.01  1  0    3    1
    ## 22 15.5   8 318.0 150 2.76 3.520 16.87  0  0    3    2
    ## 23 15.2   8 304.0 150 3.15 3.435 17.30  0  0    3    2
    ## 24 13.3   8 350.0 245 3.73 3.840 15.41  0  0    3    4
    ## 25 19.2   8 400.0 175 3.08 3.845 17.05  0  0    3    2
    ## 26 27.3   4  79.0  66 4.08 1.935 18.90  1  1    4    1
    ## 27 26.0   4 120.3  91 4.43 2.140 16.70  0  1    5    2
    ## 28 30.4   4  95.1 113 3.77 1.513 16.90  1  1    5    2
    ## 29 15.8   8 351.0 264 4.22 3.170 14.50  0  1    5    4
    ## 30 19.7   6 145.0 175 3.62 2.770 15.50  0  1    5    6
    ## 31 15.0   8 301.0 335 3.54 3.570 14.60  0  1    5    8
    ## 32 21.4   4 121.0 109 4.11 2.780 18.60  1  1    4    2
    ## 33 21.0   6 160.0 110 3.90 2.620 16.46  0  1    4    4

Linear Regression
-----------------

``` r
data(cars) # Load the built-in data
car_lm <- lm(dist ~ speed, data = cars) # lm(y ~ x, data = data)
car_lm <- lm(dist ~., data = cars) # use a dot to denote all other variables
summary(car_lm) # Print the regression report
```

    ## 
    ## Call:
    ## lm(formula = dist ~ ., data = cars)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -29.069  -9.525  -2.272   9.215  43.201 
    ## 
    ## Coefficients:
    ##             Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept) -17.5791     6.7584  -2.601   0.0123 *  
    ## speed         3.9324     0.4155   9.464 1.49e-12 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 15.38 on 48 degrees of freedom
    ## Multiple R-squared:  0.6511, Adjusted R-squared:  0.6438 
    ## F-statistic: 89.57 on 1 and 48 DF,  p-value: 1.49e-12

``` r
coef(car_lm) # Get the coefficients - use brackets [] to access individual elements
```

    ## (Intercept)       speed 
    ##  -17.579095    3.932409

``` r
fitted(car_lm) # Predicted values (Y-hat)
```

    ##         1         2         3         4         5         6         7 
    ## -1.849460 -1.849460  9.947766  9.947766 13.880175 17.812584 21.744993 
    ##         8         9        10        11        12        13        14 
    ## 21.744993 21.744993 25.677401 25.677401 29.609810 29.609810 29.609810 
    ##        15        16        17        18        19        20        21 
    ## 29.609810 33.542219 33.542219 33.542219 33.542219 37.474628 37.474628 
    ##        22        23        24        25        26        27        28 
    ## 37.474628 37.474628 41.407036 41.407036 41.407036 45.339445 45.339445 
    ##        29        30        31        32        33        34        35 
    ## 49.271854 49.271854 49.271854 53.204263 53.204263 53.204263 53.204263 
    ##        36        37        38        39        40        41        42 
    ## 57.136672 57.136672 57.136672 61.069080 61.069080 61.069080 61.069080 
    ##        43        44        45        46        47        48        49 
    ## 61.069080 68.933898 72.866307 76.798715 76.798715 76.798715 76.798715 
    ##        50 
    ## 80.731124

``` r
residuals(car_lm) # Residuals (Y - Y-hat)
```

    ##          1          2          3          4          5          6 
    ##   3.849460  11.849460  -5.947766  12.052234   2.119825  -7.812584 
    ##          7          8          9         10         11         12 
    ##  -3.744993   4.255007  12.255007  -8.677401   2.322599 -15.609810 
    ##         13         14         15         16         17         18 
    ##  -9.609810  -5.609810  -1.609810  -7.542219   0.457781   0.457781 
    ##         19         20         21         22         23         24 
    ##  12.457781 -11.474628  -1.474628  22.525372  42.525372 -21.407036 
    ##         25         26         27         28         29         30 
    ## -15.407036  12.592964 -13.339445  -5.339445 -17.271854  -9.271854 
    ##         31         32         33         34         35         36 
    ##   0.728146 -11.204263   2.795737  22.795737  30.795737 -21.136672 
    ##         37         38         39         40         41         42 
    ## -11.136672  10.863328 -29.069080 -13.069080  -9.069080  -5.069080 
    ##         43         44         45         46         47         48 
    ##   2.930920  -2.933898 -18.866307  -6.798715  15.201285  16.201285 
    ##         49         50 
    ##  43.201285   4.268876

Excercise
=========

1.  Create a function that prints "Even" if the number is even, "Odd" if the number is odd, and "Not an integer" if not an integer.

2.  Simulate rolling a fair, six-sided dice 20 times. Double the outcome if even, square the outcome if odd. Return the result as a vector.

3.  Starwars

-   Import `dplyr` and load the built-in dataset `starwars` into the RStudio environment

-   Print the number of observations and variables in the dataset

-   What is the average mass of the characters? (Hint: drop the NAs)

-   What is the average mass for blue-eyed characters that are taller than 160 but shorter than 200?

-   Create a new dataframe that contains only name, height, mass, gender and species

-   Using the dataframe obtained from the previous step, make a scatterplot of mass against height

-   Identify the outlier from the previous graph and drop that character from the dataset

-   Estimate a linear regression of mass on height, using the dataset that you obtained from the previous step

-   Using the regression model you obtained, estimate the mass if the height is 180
