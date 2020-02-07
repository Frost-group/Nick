library("tidyverse")

b3lyp_no_methyl <- read.table("b3lyp_no_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

xb97xdp_no_methyl <- read.table("wb97xd_no_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

b3lyp_with_methyl <- read.table("b3lyp_with_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

wb97xd_with_methyl <- read.table("wb97xd_with_methyl_indi.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

data <- bind_rows(b3lyp_no_methyl, xb97xdp_no_methyl, b3lyp_with_methyl, wb97xd_with_methyl) %>%
	filter(Energy < 30) %>%
	ggplot(aes(x=Angle,y=Energy, color=Functional, shape=Sidechain, group=interaction(Functional,Sidechain))) +
		geom_point(size=3) +
		geom_line() +
		labs(x="Angle , degrees", y="Energy , Kj/mol") + 
		theme_classic() 
	ggsave("inner_dihedral_scans.pdf")
