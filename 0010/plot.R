library('tidyverse')


gaussian <- read.table("~/Dropbox/OBT/0019/wb97xd_with_methyl.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="wb97xd") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)  

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

Data <- bind_rows(gaussian, MD_scan_off, MD_scan_on)

Data %>% filter(Energy < 100 & Energy > -100) %>%  
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		geom_line(aes(y=Energy), linetype="dashed") + 
		theme_classic() + 
		labs(x="Angle, Degrees", y="Energy, KJ/mol") 
	ggsave("Energy_MD.pdf") 
