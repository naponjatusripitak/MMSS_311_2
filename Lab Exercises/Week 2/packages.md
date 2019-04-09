Installing and Loading Packages in R
====================================
-   [The Typical Way](#the-typical-way)
-   [Function for Checking, Installing and Loading Packages](#function-for-checking-installing-and-loading-packages)

Here's a brief overview of how I perform the following tasks: 1. Check for packages whether they have been installed or not 2. Install them if they are not yet installed 3. Load the packages into R 4. Do this in batch

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
