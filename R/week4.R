# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library("tidyverse")

# Data Import
import_tbl <- read_delim(file ="../data/week4.dat", col_names = c("casenum", "parnum", "stimver", "datadate",  "qs"), delim = "-")
glimpse(import_tbl)
wide_tbl <- import_tbl %>% separate("qs", sep = " - ", into = c("q1","q2","q3","q4","q5"), convert = TRUE)
sapply(wide_tbl[,c("q1","q2","q3","q4","q5")], as.integer) #Check with is.integer() = TRUE, even before running this line
wide_tbl$datadate <- as.POSIXct(wide_tbl$datadate, format = c("%b %d %Y, %H:%M:%S"))
wide_tbl$q1 <- na_if(wide_tbl$q1,0)
wide_tbl$q2 <- na_if(wide_tbl$q2,0)
wide_tbl$q3 <- na_if(wide_tbl$q3,0)
wide_tbl$q4 <- na_if(wide_tbl$q4,0)
wide_tbl$q5 <- na_if(wide_tbl$q5,0)
wide_tbl <- wide_tbl %>% drop_na("q2")
long_tbl <- pivot_longer(wide_tbl, names_to = c("question"), cols = c(q1,q2,q3,q4,q5), values_to = ) #Can rename values column using final modifier 
