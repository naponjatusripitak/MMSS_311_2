Lab Section 2: A Crash Course in R
==================================

Data Types
----------

Generally, you will be dealing with four main types of data objects (atomic vectors) including numeric, character, integer and logical.

``` r
numeric <- 1
character <- "a"
integer <- 1L
logical <- TRUE # or FALSE
```

Use `c()` with commas to add multiple elements to a vector

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
