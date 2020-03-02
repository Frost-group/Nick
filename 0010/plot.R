library('tidyverse')


gaussian <- read.table("~/Dropbox/OBT/0019/wb97xd_no_methyl_two_mon_hd.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="wb97xd") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)  

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	filter(Angle>=-70, Angle<=70) %>%
	mutate(Energy = Energy - min(Energy)) 

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%	
	filter(Angle>-80, Angle<80) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	filter(Angle < 76 , Angle > -76) 

Data <- bind_rows(gaussian, MD_scan_on, MD_scan_off)

Data %>% filter(Energy < 160 & Energy > -100 & Angle<100 & Angle>-100) %>%  
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		geom_line(aes(y=Energy), linetype="dashed") + 
		theme_classic() + 
		labs(x="Angle, Degrees", y="Energy, KJ/mol") 
	ggsave("Energy_MD.pdf") 
