Lab Section 8: PCA
================
Napon Jatusripitak
5/24/2019

-   [Principal Component Analysis (PCA)](#principal-component-analysis-pca)
    -   [Useful Resources](#useful-resources)

Principal Component Analysis (PCA)
==================================

1.  Import the wine dataset and transform/standardize the variables for Principal Component Analysis (Hint: drop the first two variables from analysis)

    ``` r
    wine <- read.csv("https://raw.githubusercontent.com/naponjatusripitak/MMSS_311_2/master/Lab%20Exercises/Week%208/wine.csv", stringsAsFactors = F)
    knitr::kable(head(wine))
    ```

    |    X|  Type|  Alcohol|  Malic|   Ash|  Alcalinity|  Magnesium|  Phenols|  Flavanoids|  Nonflavanoids|  Proanthocyanins|  Color|   Hue|  Dilution|  Proline|
    |----:|-----:|--------:|------:|-----:|-----------:|----------:|--------:|-----------:|--------------:|----------------:|------:|-----:|---------:|--------:|
    |    1|     1|    14.23|   1.71|  2.43|        15.6|        127|     2.80|        3.06|           0.28|             2.29|   5.64|  1.04|      3.92|     1065|
    |    2|     1|    13.20|   1.78|  2.14|        11.2|        100|     2.65|        2.76|           0.26|             1.28|   4.38|  1.05|      3.40|     1050|
    |    3|     1|    13.16|   2.36|  2.67|        18.6|        101|     2.80|        3.24|           0.30|             2.81|   5.68|  1.03|      3.17|     1185|
    |    4|     1|    14.37|   1.95|  2.50|        16.8|        113|     3.85|        3.49|           0.24|             2.18|   7.80|  0.86|      3.45|     1480|
    |    5|     1|    13.24|   2.59|  2.87|        21.0|        118|     2.80|        2.69|           0.39|             1.82|   4.32|  1.04|      2.93|      735|
    |    6|     1|    14.20|   1.76|  2.45|        15.2|        112|     3.27|        3.39|           0.34|             1.97|   6.75|  1.05|      2.85|     1450|

2.  Performs a principal components analysis on the data and inpect the results using `print()` and `summary()`

3.  Create a scree plot that illustrates how much variation each principal component captures from the data.

4.  Visualize the first and second principal components using a biplot. Color each observation according to the `Type` variable.

Useful Resources
----------------

-   <https://stats.stackexchange.com/a/140579>
-   <https://blog.bioturing.com/2018/06/18/how-to-read-pca-biplots-and-scree-plots/>
-   <https://www.r-bloggers.com/principal-component-analysis-in-r/>
