# *------------------------------------------------------------------
# | FILE NAME: 02_jwrpm_fig1.R
# | DATE: 11/14/2023
# | CREATED BY:  Jim Stagge
# *----------------------------------------------------------------
# | PURPOSE:  Creates Fig 1 for
# |           "JWRP&M’s Reproducibility Review Program: Accomplishments, Lessons, and Next Steps"
# |
# *------------------------------------------------------------------

###########################################################################
## Set the Paths
###########################################################################
require(here)

### Path for Data and Output
data_path <- file.path(here(), "data")
#output_path <- "/fs/ess/PAS1921"
output_path <- file.path(here(), "output")

### Set up output folders
write_output_path <- output_path
### Set up figure folder
write_figures_path <- file.path(output_path, "figures")


###########################################################################
###  Load functions
###########################################################################
require(tidyverse)
require(svglite)
### For Excel
library(readxl)
### For Dates
require(lubridate)

select <- dplyr::select

###########################################################################
###  Read in data
###########################################################################
read_file <- file.path(data_path, 'WR Reproducibility New Report.xlsx')
excel_sheets(read_file)

under_review_df <- read_excel(read_file, sheet = "Papers Under Review")
accepted_silver_df <- read_excel(read_file, sheet = "Accepted AER Papers Silver")
accepted_bronze_df <- read_excel(read_file, sheet = "Accepted AER Papers Bronze")
declined_df <- read_excel(read_file, sheet = "Declined")
accepted_noreproduc_df <- read_excel(read_file, sheet = "Accepted no Reproducibility")


###########################################################################
###  Clean up  data and join
###########################################################################
### Clean Silver
accepted_silver_df <- accepted_silver_df %>%
	rename(ms_num = 1) %>%
	rename(author = 2) %>%
	rename(date = 3) %>%
	rename(doi = 4) %>%
	rename(date_online = 5) %>%
	rename(badge = 6) %>%
	rename(fee_waive = 7) %>%
	drop_na(ms_num) %>%
	rename(ae_decisions = badge) %>%
	mutate(art_type = "published")  %>%
	mutate(month = month(date), year = year(date)) %>%
	select(ms_num, date, month, year, art_type, ae_decisions) %>%
	arrange(date)

### Manually add in Matteo, M. D., G. C. Dandy, and H. R. Maier (2017), Multiobjective Optimization of Distributed Stormwater Harvesting Systems, Journal of Water Resources Planning and Management, 143(6), 04017010. https://ascelibrary.org/doi/abs/10.1061/%28ASCE%29WR.1943-5452.0000756.
### From original reproducibility review
accepted_silver_df <- accepted_silver_df %>%
	bind_rows(data.frame(ms_num = "Unknown", date = as.Date("2017-06-01"), month = 6, year = 2017, art_type = "published", ae_decisions = "Silver")) %>%
	arrange(date)

### Clean Bronze
accepted_bronze_df <- accepted_bronze_df %>%
		rename(ms_num = 1) %>%
		rename(author = 2) %>%
		rename(date = 3) %>%
		rename(doi = 4) %>%
		rename(date_online = 5) %>%
		rename(badge = 6) %>%
		drop_na(ms_num) %>%
		rename(ae_decisions = badge) %>%
		mutate(art_type = "published")  %>%
		mutate(month = month(date), year = year(date)) %>%
		select(ms_num, date, month, year, art_type, ae_decisions) %>%
		arrange(date)

### Clean Declined
declined_df <- declined_df %>%
			rename(ms_num = 1) %>%
			rename(revision_code = 2) %>%
			rename(art_type = 3) %>%
			rename(chief_ed = 4) %>%
			rename(aer = 5) %>%
			rename(ae_decisions = 8) %>%
			rename(date = 10) %>%
			drop_na(ms_num)  %>%
			mutate(month = month(date), year = year(date)) %>%
			mutate(ae_decisions = "Declined") %>%
			select(ms_num, date, month, year, art_type, ae_decisions) %>%
			arrange(date)

### Clean Under Review
under_review_df <- under_review_df %>%
	rename(ms_num = 1) %>%
	rename(revision_code = 2) %>%
	rename(art_type = 3) %>%
	rename(date = 4) %>%
	rename(aer = 5) %>%
	rename(ae_decisions = 6) %>%
	drop_na(ms_num) %>%
	mutate(month = month(date), year = year(date)) %>%
	mutate(ae_decisions = "UnderReview") %>%
	select(ms_num, date, month, year, art_type, ae_decisions) %>%
	arrange(date)

### Clean Accepted no reproduc
accepted_noreproduc_df <- accepted_noreproduc_df %>%
rename(ms_num = 1) %>%
rename(revision_code = 2) %>%
rename(art_type = 3) %>%
rename(date = 9) %>%
rename(aer = 5) %>%
rename(ae_decisions = 8) %>%
drop_na(ms_num) %>%
mutate(month = month(date), year = year(date)) %>%
mutate(ae_decisions = "Withdrawn") %>%
select(ms_num, date, month, year, art_type, ae_decisions) %>%
arrange(date)

### Check results
head(under_review_df)
head(declined_df)
head(accepted_bronze_df)
head(accepted_silver_df)
head(accepted_noreproduc_df)


### Dot plot
#plot_df <- accepted_silver_df %>% mutate(class = "accept") %>%
#	bind_rows(accepted_bronze_df %>% mutate(class = "accept")) %>%
#	bind_rows(under_review_df %>% mutate(class = "under_review")) %>%
#	bind_rows(declined_df %>% mutate(class = "declined")) %>%
#	bind_rows(accepted_noreproduc_df %>% mutate(class = "withdraw")) %>%
#	mutate(events = 1)
#ggplot(plot_df, aes(x=date, y=ae_decisions)) + geom_point()
#ggplot(plot_df %>% filter(ae_decisions != "Declined"), aes(x=date, y=ae_decisions)) + geom_point()
#ggplot(plot_df %>% filter(ae_decisions != "Declined"), aes(x=date, y=class)) + geom_point()


###########################################################################
###  Create underlying data for Fig 1 - running total within categories
###########################################################################
### Add in a running sum for under review, declined and accepted but no reproduc
under_review_df <- under_review_df %>%
  arrange(date) %>%
  mutate(cumsum = seq(1, dim(under_review_df)[1]))

declined_df <- declined_df %>%
  arrange(date) %>%
  mutate(cumsum = seq(1, dim(declined_df)[1]))

accepted_noreproduc_df <- accepted_noreproduc_df %>%
  arrange(date) %>%
  mutate(cumsum = seq(1, dim(accepted_noreproduc_df)[1]))

### Check
head(under_review_df)

### Create a plotting data frame for the reproducible papers (combine bronze and silver)
### Sort by date and create a running count
plot_df <- accepted_silver_df %>%
	bind_rows(accepted_bronze_df) %>%
	mutate(ae_decisions = "Reproducible") %>%
	arrange(date)

plot_df$cumsum  <- seq(1, dim(plot_df)[1])

### Combine all the underlying data
plot_df <- plot_df	 %>%
	bind_rows(under_review_df) %>%
	bind_rows(declined_df) %>%
	bind_rows(accepted_noreproduc_df) %>%
	mutate(events = 1)

head(plot_df)

### Add in a zero point on the first day so that the line does not start drawing at 1
zero_df <- plot_df %>% group_by(ae_decisions) %>% summarize(date = min(date, na.rm=TRUE)) %>% ungroup()
zero_df <- zero_df %>%
	mutate(date = date - 1) %>%
	mutate(month = month(date), year = year(date), cumsum = 0, ms_num = "ZeroStart", art_type = "Unknown") %>%
	select(ms_num, date, month, year, art_type, ae_decisions, cumsum)

plot_df <- plot_df %>%
	bind_rows(zero_df) %>%
	arrange(ae_decisions, cumsum)

### Factor the AE decisions to make labels better looking
plot_df$ae_decisions <- factor(plot_df$ae_decisions, levels = c("Declined", "Withdrawn", "UnderReview", "Reproducible"), labels = c("Declined", "Withdrawn", "Under Review", "Reproducible"))

### Check results
head(plot_df)


###########################################################################
###  Plot Fig 1
###########################################################################
### Set time limits for figure
lims2 <- as.POSIXct(strptime(c("2020-10-01 00:00", "2023-09-01 00:00"), format = "%Y-%m-%d %H:%M"), tz = 'UTM')

### Create figure
p <- ggplot(plot_df %>% filter(ae_decisions != "Declined"), aes(x=date, y=cumsum, colour = ae_decisions, linetype= ae_decisions)) %>%
  + geom_step() %>%
  + scale_y_continuous(name = "Cumulative Articles", breaks = seq(0,15, 5)) %>%
  + scale_x_datetime(name = "Year")%>%
  + scale_colour_brewer(name = "", palette = "Set1") %>%
  + scale_linetype_manual(name = "", values = c("longdash", "twodash", "solid")) %>%
  + coord_cartesian(ylim = c(0,20), xlim = lims2, expand = FALSE) %>%
  + theme_classic(12) %>%
  + theme(legend.position = c(0.25, 0.95))

p

### Save plot
ggsave(file.path(write_figures_path, "fig_1.png"), p,  width = 4.5, height = 3.5, dpi = 600)
ggsave(file.path(write_figures_path, "fig_1.pdf"), p,  width = 4.5, height = 3.5)
ggsave(file.path(write_figures_path, "fig_1.svg"), p,  width = 4.5, height = 3.5)
