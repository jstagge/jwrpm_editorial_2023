# *------------------------------------------------------------------
# | FILE NAME: 01_preparation.R
# | DATE: 11/14/2023
# | CREATED BY:  Jim Stagge
# *----------------------------------------------------------------
# | PURPOSE:  Prepares all folders and installs all necesary packages
# |           "JWRP&M’s Reproducibility Review Program: Accomplishments, Lessons, and Next Steps"
# |
# *------------------------------------------------------------------

###########################################################################
## Install and run Versions to get the correct package versions
###########################################################################
install.packages("versions")
#install.packages("checkpoint")
library(versions)

###########################################################################
## Set the install date and get the package versions used in this study
###########################################################################
# install yesterday's version of checkpoint, by date
#install.dates('checkpoint', Sys.Date() - 1)

# install correct versions of required packages
#install.versions(c('tidyverse', 'readxl', 'lubridate', 'here'), c('2.0.0', '1.4.3', '1.9.3', '1.0.1'), repos = "http://cran.us.r-project.org")
install.packages(c('tidyverse', 'readxl', 'lubridate', 'here', 'svglite'))

###########################################################################
## Set the Paths and create folders
###########################################################################
require(here)

### Path for Data and Output
data_path <- file.path(here(), "data")
output_path <- file.path(here(), "output")

### Set up output folders
write_output_path <- output_path
dir.create(write_output_path, recursive=TRUE, showWarnings = FALSE)

### Set up figure folder
write_figures_path <- file.path(output_path, "figures")
dir.create(write_figures_path, recursive=TRUE, showWarnings = FALSE)
