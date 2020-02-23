library("tidyverse")
library("Rpdb")
source("~/Dropbox/library/R_functions.R")

data <- read_pdb2("NPT_8000ps_rot.pdb") %>% print()

