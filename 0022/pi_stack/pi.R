library("tidyverse")
library("Rpdb")

########################################################################################
########################################################################################

source("~/Dropbox/library/R_functions.R")

########################################################################################
########################################################################################

find_plane <- function(data){
  
	x <- data$x
	y <- data$y
	z <- data$z
	      
	v1 <- c(x[2]-x[1], y[2]-y[1], z[2]-z[1])
	v2 <- c(x[3]-x[1], y[3]-y[1], z[3]-z[1])
	      
	n <- tcrossprod(v1,v2)
	n <- n / sqrt(sum(n^2))
  
	return(n)

}

before <- read.table("pi_before.xvg", skip=24) %>%
	rename(r=V1, RDF=V2) %>% 
	mutate(r=r*10) %>%
	mutate(time="at t=0")

after <- read.table("pi_after.xvg", skip=24) %>%
	rename(r=V1, RDF=V2) %>% 
	mutate(r=r*10) %>%
	mutate(RDF=RDF*3) %>%
	mutate(time="between 20ns and 30ns")

rbind(before, after) %>%
	filter(r<6 & r>2) %>%
	ggplot(aes(x=r, y=RDF, color=time)) +
		geom_line(size=1) + 
		theme_classic() +
		geom_segment(aes(x=3.67 , xend=3.67 , y=6 , yend=20), width=4, color="black") +
	ggsave("RDF.pdf", width=14)

#aft <- read_pdb2("NPT_30000ps.pdb") %>%
#	select(AtomName, Part, ResNum, x, y, z) %>% 
#	filter(AtomName=="SS"|AtomName=="CS3"|AtomName=="CD4") %>%
#	group_by(ResNum) %>% 
#	nest() %>%
#	mutate(norm = map(data,find_plane)) 
	






