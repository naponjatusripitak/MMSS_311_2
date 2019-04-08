Lab Section 2: Crash Course in R
================================

Data Types
----------

Generally, you will be dealing with four main types of data including numeric, character, integer and logical.

Use `c()` with commas to add multiple elements to a vector

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
