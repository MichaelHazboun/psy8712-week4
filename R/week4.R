# Script Settings and Resources
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))
library(tidyverse)

# Data Import
import_tbl<- read_delim("../data/week4.dat", delim="-",col_names = c("casenum","parnum", "stimver", "datadate", "qs"))
glimpse(import_tbl)
wide_tbl<- separate(import_tbl,qs,c("q1","q2","q3","q4","q5"))
wide_tbl[,5:9]<-sapply(wide_tbl[,5:9],as.integer)
wide_tbl$datadate<- mdy_hms(wide_tbl$datadate) #thank god this worked, I wasn't going to spend an hour trying different formats in posixct
wide_tbl[,5:9]<-replace(wide_tbl[,5:9],wide_tbl[,5:9]==0,NA)
wide_tbl<-drop_na(wide_tbl,q2)
long_tbl <- pivot_longer(wide_tbl,5:9,names_to = "Question",values_to = "Response") #you didn't ask us to specify the names of the columns, but I feel like this should be a given???