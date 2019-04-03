# Lab Section 1: Installing GitHub, R, and RStudio 

## Setting up GitHub
In this class, you will be using GitHub to store your codes and to host your projects. Think of GitHub as a Dropbox-like version control system for tracking changes in your source code. Make sure you know what it means to push, pull, fork, clone. I came up with a quick installation guide below. Alternatively, you may consult [this tutorial](https://happygitwithr.com/install-git.html).
1. Install [Git](https://git-scm.com/downloads).
2. Sign up for an account at [GitHub](https://github.com).
3. Make sure you are logged in. Create a new repository called `MMSS_311_2`.
4. Clone the repository you just created to your local computer.
5. Share the repository with me. Add me as a collaborator to the repository. My username is  `naponjatusripitak`.

## Setting up R and Rstudio
What's the difference between R and RStudio? Think of R as a programming language and RStudio as a tool that provides a work environment for writing the R language. I came up with a brief tutorial below. Alternatively, you may follow this [guide](https://happygitwithr.com/install-r-rstudio.html).
1. Download [R](https://cran.cnr.berkeley.edu/).
2. Install R by opening the installer.
3. Verify that you have R installed on your computer and can launch the R application.
4. Download [RStudio](https://www.rstudio.com/products/rstudio/download/).
5. Install RStudio by opening the installer.
6. Run RStudio.
7. Familiarize yourself with RStudio. Create a new R script that does the following:
- Set the working directory to the location of your newly created git repository
- Install and load the following packages: dplyr, ggplot2, stringr, lubridate
- Import [QoG Standard Data](https://qog.pol.gu.se/data/datadownloads/qogstandarddata) as `qog`
- Print the number of variables and the number of observations.
8. Save the script to file (.R) in your working directory, commit changes, and push to GitHub.