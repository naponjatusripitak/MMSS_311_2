
Lab Section 3
=============
-   [Dplyr](#dplyr)
-   [Pipes](#pipes)
-   [Regression & Classification](#regression-classification)

Dplyr
-----

Provides useful functions for easy data manipulation:
- `filter()` allows you to select specific observations
- `arrange()` allows you to reorder your data
- `select()` allows you to select data based on names
- `rename()` allows you to rename variables
- `mutate()` allows you to create new variables from current ones
- `summarize()` condenses data values
- `sample_n()` takes samples

Here are some examples:

``` r
# Load dplyr
library(dplyr)

# Examples
filter(mtcars, mpg < 20, cyl == 6) # filter(df, condition, condition)
arrange(mtcars, mpg) # arrange(matcars, desc(mpg)) returns the result in a descending order
select(mtcars, mpg, cyl) # select(df, variable1, variable2)
mutate(mtcars, kpg = mpg*1.609) # create a new variable inside the dataframe called kpg as a function of mpg
```

Pipes
-----

Consult this [guide](https://style.tidyverse.org/pipes.html) for additional info. Generally, we use pipes to organize our codes into readable, sequential chunks. Here's how I use them. Recall the `starwars` dataset.

-   What is the average mass for blue-eyed characters that are taller than 160 but shorter than 200?

``` r
# Load the packages & the data
library(dplyr)
library(broom)
data(starwars)
```

``` r
### Without pipes
subset_starwars <- filter(starwars, eye_color == "blue", height > 160 & height < 200)
mean(subset_starwars$mass, na.rm=T)
```

    ## [1] 79.02

``` r
### With pipes
starwars %>%
  filter(eye_color == "blue", height > 160 & height < 200) %>%
  summarize(Mean = mean(mass, na.rm=T))
```

    ## # A tibble: 1 x 1
    ##    Mean
    ##   <dbl>
    ## 1  79.0

-   Calculate the number of characters of each species that have mass greater than 60

``` r
### Without pipes
subset_starwars <- filter(starwars, mass > 60)
group <- group_by(subset_starwars, species)
result <- tally(group)
result
```

    ## # A tibble: 20 x 2
    ##    species          n
    ##    <chr>        <int>
    ##  1 Besalisk         1
    ##  2 Cerean           1
    ##  3 Droid            2
    ##  4 Geonosian        1
    ##  5 Gungan           2
    ##  6 Human           20
    ##  7 Hutt             1
    ##  8 Kaleesh          1
    ##  9 Kaminoan         1
    ## 10 Kel Dor          1
    ## 11 Mon Calamari     1
    ## 12 Nautolan         1
    ## 13 Neimodian        1
    ## 14 Pau'an           1
    ## 15 Rodian           1
    ## 16 Sullustan        1
    ## 17 Toong            1
    ## 18 Trandoshan       1
    ## 19 Wookiee          2
    ## 20 Zabrak           1

``` r
### With pipes
starwars %>%
  filter(mass > 60) %>%
  group_by(species) %>%
  tally()
```

    ## # A tibble: 20 x 2
    ##    species          n
    ##    <chr>        <int>
    ##  1 Besalisk         1
    ##  2 Cerean           1
    ##  3 Droid            2
    ##  4 Geonosian        1
    ##  5 Gungan           2
    ##  6 Human           20
    ##  7 Hutt             1
    ##  8 Kaleesh          1
    ##  9 Kaminoan         1
    ## 10 Kel Dor          1
    ## 11 Mon Calamari     1
    ## 12 Nautolan         1
    ## 13 Neimodian        1
    ## 14 Pau'an           1
    ## 15 Rodian           1
    ## 16 Sullustan        1
    ## 17 Toong            1
    ## 18 Trandoshan       1
    ## 19 Wookiee          2
    ## 20 Zabrak           1

Now it's your turn. Use `%>%` to complete the following steps.

-   Calculate the average height by species (Hint: use `group_by()` and `summarize()`)

-   Calculate the mass to height ratio for all characters and rank them from high to low. (Hint: use `mutate()` to create a new column for mass to height ratio and use `arrange()` to rank the observations)

-   What is the coefficient on `height` when we regress `mass` on `height`?

-   Construct a dataframe from the regression model's results (Hint: use `tidy()` from the `broom` library)

Regression & Classification
---------------------------

In this exercise, we will be predicting whether a given character in the `starwars` dataset is human or non-human, using mass and height as our predictors and OLS as our model.

1.  Import the dataset as `starwars`. Drop any missing values in `species`, `mass` and `height`.

2.  Get rid of Jabba Desilijic Tiure. He's a little too heavy for our analysis!

3.  Estimate a regression in the form of *y* = *x*<sub>1</sub> + *x*<sub>2</sub> + *ϵ* and display the results. (Hint: create a binary response variable that takes the value of 1 if the character is a human and 0 if the character is not a human.)

4.  Set our decision boundary. Let's say that *y* ≥ 0.5 implies that the character is a human and *y* &lt; 0.5 implies that the character is not a human. How good is our prediction? (Hint: create a confusion matrix and compute the accruracy/classification rate.)

5.  Create a scatterplot of mass against height. Use color or shape to distinguish between human and non-human characters. Add a line where $\\hat{y} = 0.5$ as a function of mass and height (Hint: use `coef()`.)

6.  Challenge: repeat the previous steps, using Logit instead of OLS.
