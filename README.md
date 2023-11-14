# Code Repository for "JWRP&amp;M’s Reproducibility Review Program: Accomplishments, Lessons, and Next Steps"

This repository contains all code needed to recreate Fig 1 in the manuscript "JWRP&amp;M’s Reproducibility Review Program: Accomplishments, Lessons, and Next Steps" by James H. Stagge, David E Rosenberg, Adel M. Abdallah, Anthony M. Castronova, Avi Ostfeld, and Amber Spackman Jones.

## Citation
Please use the following citation for all references to the code or data:

- Stagge, J.H. Rosenberg, D.E., Abdallah, A.M., Castronova, A.M., Ostfeld, A., and Spackman Jones, A.. (2023) jstagge/jwrpm_editorial_2023. Github. doi:10.5281/ZENODO.10125823

[![DOI](https://zenodo.org/badge/718644572.svg)](https://zenodo.org/doi/10.5281/zenodo.10125822)

## Reproducible Results Statement
The code used to generate Fig. 1 is available in a Github repository (https://github.com/jstagge/wrpm_reproduc). Kyungmin Sung and Irenee Munyejuru (Ohio State University) downloaded the repository, ran the code, and successfully reproduced Fig. 1 as presented.

## To run on a personal computer

### Running all scripts at once
If you would like to simply recreate the results of Stagge et al. (2023, in review), you may run the following in R after setting the working directory to the downloaded folder:

```
source("run_all.R")
```
You will find the results under output/figures/fig_1.

### Running scripts individually
Alternatively, you may open and run each file in order.  The code is numbered based on the order of operations.

```
source("01_preparation.R")
source("02_jwrpm_fig1.R")
```
You will find the results under output/figures/fig_1.

## Software versions
All code is written in the R language.

- R 4.3.2
- tidyverse 2.0.0
- readxl 1.4.3
- lubridate 1.9.3
- here 1.0.1
- svglite 2.1.2
