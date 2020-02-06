library('tidyverse')


gaussian_b3lyp <- read.table("b3lyp_data.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)  

#gaussian_w <- read.table("w_data.txt") %>% 
#	rename(Angle=V1, Energy=V2) %>%
#	mutate(Angle = round(Angle)) %>% 
#	mutate(Method="WB97XD") %>%
#	mutate(Energy= Energy*27211.4/10.36) %>%
#	mutate(Energy = Energy - min(Energy)) %>%
#	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
#	arrange(Angle)

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	filter(Angle>-100, Angle<90) %>%
	mutate(Energy = Energy - min(Energy)) 

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%	
	filter(Angle>-100, Angle<90) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) 

Data <- bind_rows(gaussian_b3lyp, MD_scan_off, MD_scan_on)

Data %>% filter(Energy < 100 & Energy > -100) %>%  
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		geom_line(aes(y=Energy), linetype="dashed") + 
		theme_classic() 
	ggsave("Energy_MD.pdf") 


#QCCdata <- bind_rows(gaussian_b3lyp,gaussian_w) %>%
#	filter(Energy < 60) %>%
#	ggplot(aes(x=Angle, y=Energy, color=Method)) + 
#		geom_point() +
#		geom_line(linetype="dashed") +   
#		labs(y="Energy, Kj/mol", x="Angle, degrees") +
#		theme_classic()
#	ggsave("Energy_QCC.pdf")

 
