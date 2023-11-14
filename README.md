# Code Repository for "JWRP&amp;M’s Reproducibility Review Program: Accomplishments, Lessons, and Next Steps"

This repository contains all code needed to recreate Fig 1 in the manuscript "JWRP&amp;M’s Reproducibility Review Program: Accomplishments, Lessons, and Next Steps" by James H. Stagge, David E Rosenberg, Adel M. Abdallah, Anthony M. Castronova, Avi Ostfeld, and Amber Spackman Jones.

## Citation
Please use the following citation for all references to the code or data:

## Reproducible Results Statement
The code used to generate Fig. 1 is available in a Github repository (https://github.com/jstagge/wrpm_reproduc). Kyungmin Sung (OSU) downloaded, ran the code, and successfully reproduced the results presented.

## To run on a personal computer

### Running all scripts at once
If you would like to simply recreate the results of Stagge et al. (2023, in review), you may run the following in R after setting the working directory to the downloaded folder:

```
source("00_run_all.R")
```
You will find the results under output/figures/fig_1.

### Running scripts individually
Alternatively, you may open and run each file in order.  Code is numbered based on the order of operations:

```
source("01_preparation.R")
source("02_jwrpm_fig1.R")
```

## Software versions
All code is written in the R language.

- R 4.3.2
- tidyverse 2.0.0
- readxl 1.4.3
- lubridate 1.9.3
- here 1.0.1
- svglite 2.1.2
