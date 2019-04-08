Data types & data structures
----------------------------

1.  Data Types

``` r
numeric <- 1
character <- "a"
integer <- 1L
logical <- TRUE # or FALSE

# Use c() with commas to add multiple elements to a vector
vector_numeric <- c(1, 2, 3, 4)
vector_character <- c("a", "b", "c", "d")
vector_integer <- c(1L, 2L, 3L, 4L)
vector_logical <- c(TRUE, FALSE, TRUE, FALSE)

# Selecting specific element(s) in a vector
vector_logical[1]
```

    ## [1] TRUE

``` r
vector_character[1:3]
```

    ## [1] "a" "b" "c"

``` r
# The functions typeof(), length(), class() and str() provide useful information about your vectors and R objects in general.
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
