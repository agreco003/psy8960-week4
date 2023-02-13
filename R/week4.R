# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library("tidyverse")

# Data Import
import_tbl <- read_delim(file ="../data/week4.dat", col_names = c("casenum", "parnum", "stimver", "datadate",  "qs"), delim = "-")
glimpse(import_tbl)
wide_tbl <- import_tbl %>% separate("qs", sep = " - ", into = c("q1","q2","q3","q4","q5"), convert = FALSE)
wide_tbl[,5:9] <- sapply(wide_tbl[,c("q1","q2","q3","q4","q5")], as.integer)
wide_tbl$datadate <- as.POSIXct(wide_tbl$datadate, format = c("%b %d %Y, %H:%M:%S"))
wide_tbl <- wide_tbl %>% mutate(across(.cols = 5:9, ~na_if(.,0)))
wide_tbl <- wide_tbl %>% drop_na("q2")
long_tbl <- pivot_longer(wide_tbl, names_to = c("question"), cols = c(q1,q2,q3,q4,q5))

#Alternate versions and reminders for Anthony:
#Line 8 # wide_tbl <- import_tbl %>% separate("qs", sep = " - ", into = c("q1","q2","q3","q4","q5"), convert = TRUE) #@Line 8, coerces values to integers for q1 - q5. Can delete line 9
#Line 11 # wide_tbl <- wide_tbl %>% mutate(across(5:9, ~na_if(.,0)))
#Extended version of line 11:
#wide_tbl$q1 <- na_if(wide_tbl$q1,0) #@Line 11, converts 0 to NAs for q1 only
#wide_tbl$q2 <- na_if(wide_tbl$q2,0) #+ line, converts 0 to NAs for q2 only
#wide_tbl$q3 <- na_if(wide_tbl$q3,0) #+ line, converts 0 to NAs for q3 only
#wide_tbl$q4 <- na_if(wide_tbl$q4,0) #+ line, converts 0 to NAs for q4 only
#wide_tbl$q5 <- na_if(wide_tbl$q5,0) #+ line, converts 0 to NAs for q5 only
#Reminders:
#wide_tbl[,5:9] and wide_tbl[,c("q1","q2","q3","q4","q5")] are equivalents in all of these functions, you just tried both to see that both would work
#separate() = separate_wider_delim(), just an older function, and the new one is still experimental in the tidyverse. 