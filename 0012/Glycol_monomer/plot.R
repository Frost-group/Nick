setwd("/Users/nicholassiemons/Dropbox/OBT/0012/Glycol_monomer")
library(tidyverse)
library(ggrepel)

a <- read.table("glycol_xray.tsv")
a <- as_tibble(data.frame(q=(4*pi / 1.54)*sin(a$V1*0.0174533 /2),S=a$V2, method="Simulated")) 

lab <- as_tibble(read.table("glycol_xray.hkl", header=TRUE)) %>% select(-c("multiplicity")) %>% 
	mutate(q= 2*pi / d.spacing) %>% select(-c("d.spacing")) %>%
	mutate(label=paste("(",h," ", k," ", l,")", sep="")) %>% 
	filter(F.2 > 15000 & q<2) 
		
plot1 <- a %>% filter(q<2 & q>0.1) %>%
	ggplot(aes(x=q,y=S)) + 
		geom_line(size=1) +
		labs(	
  			x = expression(q/ring(A)^-1),
  			y = "S(q)/A.U."
		) + 
		theme_classic(base_size=18) +  
		theme(
			legend.position = c(0.8,0.8),
			legend.title    = element_blank()
		) +
		geom_point( data=lab, aes(x=q, y=-100) ) +  
		geom_text_repel(
			data	= lab, 
			aes(x=q, y=-100),
			label	= lab$label,
			angle	= 90,
			nudge_y	= -3400,
			size	= 6,
			max.iter = 5000
 		) +
		ylim(-3500, 10000)
 
ggsave("xray_mercury.pdf",plot1,width=11)


as_tibble(read.table("super_cell.xq", skip=16, header=FALSE)) %>% 
	rename(q=V1, S=V2) %>% 
	filter(q<2) %>%
	ggplot(aes(x=q,y=S)) + 
		geom_line(size=1) + 
		theme_classic(base_size=18) +
		labs(	
			x = expression(q/ring(A)^-1),
			y = "S(q)/A.U."
		)  
ggsave("xray_deb.pdf", width=10)

