

a <- read.table("sq.xvg")
a <- as_tibble(data.frame(q=(4*pi /1.03320)*sin(a$V1*0.0174533 /2),S=a$V2, method="Simulated")) 
		
plot1 <- a %>% dplyr::filter(q<2 & q>0.1) %>%
	ggplot(aes(x=q,y=S)) + 
		geom_line(size=1) +
		labs(	
  			x = expression(q/ring(A)^-1),
  			y = "S(q)/A.U."
		) 
 
ggsave("gromacs.pdf",plot1,width=11)

