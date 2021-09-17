# Current approaches to species distribution modelling with R

[Chris Brown](https://experts.griffith.edu.au/7867-chris-brown)  

Welcome to our "Current approaches to species distribution modelling with R" R course site. This course was run for the World Fisheries Congress 2021, but all the course materials are freely available. Below are instructions for getting setup or jump straight to the notes and data.

Thanks to Dr Christina Buelow for contributing her introduction to simulating data.

[Check out the conservation hackers site for upcoming online courses](https://www.conservationhackers.org/courses)

### [Course notes](http://www.seascapemodels.org/SDM-fish-course-notes/2021-09-20-SDM-fish-course.html)

### [Data for course](https://github.com/cbrown5/SDM-fish-course-notes/raw/main/data.zip)

### [Supplemental introduction to simulating data for power analysis](http://www.seascapemodels.org/SDM-fish-course-notes/Intro-data-simulation_2021-09-17.html)

## Setup

So that the course runs efficiently, and to save plenty of time for trying fun things in R, we'd ask that you come to the course prepared.
This is an intermediate level course, so we'll assume you know how to install R and R packages. As a general guide to what we expect in terms of prior knowledge, we'll assume you can run R, load data and write basic calculations that you save in a script.

Please have R ([install from here](https://cran.r-project.org/)) and [Rstudio](https://www.rstudio.com/products/rstudio/) (we use the free desktop version) installed on your computer before starting. You'll want to save plenty of time for doing this, it can be tricky on some computers, especially if you do not have 'admin' permission on a work computer. You may need to call IT to get help. We obviously only offer limited help with such installation issues.
We are using R version >4.0.2 currently for writing this course, so there may be some minor differences if you have a different version. We definitely recommend making sure you have version 4 or greater.

You'll also need to install a few R packages. You can install them with this R code in R's console:
`install.packages(c("tmap", "tidyverse", "terra", "sf", "nlme", "patchwork", "visreg"))`
If that doesn't work email us with the error and we'll try to help. Otherwise, see your IT department for help.

We're using dplyr version 1.0, which was released earlier this year. If you have an older version of dplyr the course should still work fine, but there may be some minor differences in the code.
