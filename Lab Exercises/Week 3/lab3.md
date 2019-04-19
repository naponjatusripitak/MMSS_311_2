-   [Lab Section 3](#lab-section-3)
    -   [Pipes](#pipes)
    -   [Classification](#classification)

Lab Section 3
=============

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
subset_starwars = filter(starwars, eye_color == "blue", height > 160 & height < 200)
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

Now it's your turn.

-   What is the average height by species? (Hint: use `group_by()` and `summarize()`)

-   Calculate the mass to height ratio for all characters and rank them from high to low. (Hint: use `mutate()` to create a new column for mass to height ratio and use `arrange()` to rank the observations)

-   What is the coefficient on `height` when we regress `mass` on `height`?

-   Construct a dataframe from the regression model's results (Hint: use `tidy()`)

Classification
--------------

In this exercise, we will be predicting whether a given character in the `starwars` dataset is human or non-human, using mass and height as our predictors and OLS as our model.

1.  Import the dataset as `starwars`. Drop any missing values in `species`, `mass` and `height`.

2.  Get rid of Jabba Desilijic Tiure. He's a little too heavy for our analysis!

3.  Estimate a regression in the form of *y* = *x*<sub>1</sub> + *x*<sub>2</sub> + *ϵ* and display the results. (Hint: create a binary response variable that takes the value of 1 if the character is a human and 0 if the character is not a human.)

4.  Set our decision boundary. Let's say that *y* ≥ 0.5 implies that the character is a human and *y* &lt; 0.5 implies that the character is not a human. How good is our prediction? (Hint: create a confusion matrix and compute the accruracy/classification rate.)

5.  Create a scatterplot of mass against height. Use color or shape to distinguish between human and non-human characters. Add a line where $\\hat{y} = 0.5$ as a function of mass and height (Hint: use `coef()`.)

6.  Challenge: repeat the previous steps, using Logit instead of OLS.
