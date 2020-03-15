

a <- read.table("AM_cryst_merc.tsv")
a <- as_tibble(data.frame(q=(4*pi / 1.54)*sin(a$V1*0.0174533 /2),S=a$V2, method="Simulated")) 

lab <- as_tibble(read.table("AM_cryst_merc.hkl", header=TRUE)) %>% select(-c("multiplicity")) %>% 
	mutate(q= 2*pi / d.spacing) %>% select(-c("d.spacing")) %>%
	mutate(label=paste("(",h," ", k," ", l,")", sep="")) %>%  
	dplyr::filter((F.2 > 4000 & q<2) | label=="(0 0 1)" | label=="(0 1 0)" | label=="(1 0 0)" | label=="(0 2 0)"| label=="(0 3 0)") 
		
plot1 <- a %>% dplyr::filter(q<2 & q>0.1) %>%
	ggplot(aes(x=q,y=S)) + 
		geom_line(size=1) +
		labs(	
  			x = expression(q/ring(A)^-1),
  			y = "S(q)/A.U."
		) + 
		theme_minimal(base_size=18) +  
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
 
ggsave("AM_cryst_merc.pdf",plot1,width=11)

