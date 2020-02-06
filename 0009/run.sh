source ~/.zshrc

sh MD_scan_off.sh  > /dev/null 2>&1
sh MD_scan_on.sh  > /dev/null 2>&1
Rscript plot.R
open Energy_MD.pdf
