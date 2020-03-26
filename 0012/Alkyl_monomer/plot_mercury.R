setwd("/Users/nicholassiemons/Dropbox/OBT/0012/Alkyl_monomer")
library(tidyverse)
library(ggrepel)
source("~/Dropbox/library/R_functions.R")

a <- read.table("alkyl_xray.tsv")
a <- as_tibble(data.frame(q=(4*pi / 1.54)*sin(a$V1*0.0174533 /2),S=a$V2, method="Simulated")) 

lab <- as_tibble(read.table("alkyl_xray.hkl", header=TRUE)) %>% select(-c("multiplicity")) %>% 
	mutate(q= 2*pi / d.spacing) %>% select(-c("d.spacing")) %>%
	mutate(label=paste("(",h," ", k," ", l,")", sep="")) %>%  
	dplyr::filter((F.2 > 4000 & q<2) | label=="(0 0 2)" ) 
		
plot1 <- a %>% dplyr::filter(q<2 & q>0.1) %>%
	ggplot(aes(x=q,y=S+200)) + 
		geom_line(size=1) +
#		labs(	
#  			x = expression(q/ring(A)^-1),
#  			y = "S(q)/A.U."
#		) + 
#		theme_classic(base_size=18) +  
#		theme(
#			legend.position = c(0.8,0.8),
#			legend.title    = element_blank()
#		) +
#		geom_point( data=lab, aes(x=q, y=-100) ) +  
#		geom_text_repel(
#			data	= lab, 
#			aes(x=q, y=2000),
#			label	= lab$label,
#			angle	= 90,
#			nudge_y	= 3400,
#			size	= 6,
#			max.iter = 5000
# 		) +
		scale_y_log10() + 
		labs(x="q/A",y="S(q)")
 
ggsave("xray_mercury.pdf",plot1,width=14)

