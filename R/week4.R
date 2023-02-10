# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library("tidyverse")

# Data Import
import_tbl <- read_delim(file ="../data/week4.dat", col_names = c("casenum", "parnum", "stimver", "datadate",  "qs"), delim = "-")
str(import_tbl)
wide_tbl <- import_tbl %>% separate("qs", sep = " - ", into = c("q1","q2","q3","q4", "q5"), convert = TRUE)
str(wide_tbl)
