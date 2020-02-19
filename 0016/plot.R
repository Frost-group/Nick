library("tidyverse")

b3lyp_no_methyl <- read.table("b3lyp_no_methyl_hd.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

xb97xdp_no_methyl <- read.table("wb97xd_no_methyl_hd.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

b3lyp_with_methyl <- read.table("b3lyp_with_methyl_hd.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

wb97xd_with_methyl <- read.table("wb97xd_with_methyl_hd.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

data <- bind_rows(b3lyp_no_methyl, xb97xdp_no_methyl, b3lyp_with_methyl, wb97xd_with_methyl) %>%
	ggplot(aes(x=Angle,y=Energy, color=Functional, shape=Sidechain, group=interaction(Functional,Sidechain))) +
		geom_point(size=3) +
		geom_line() +
		labs(x="Angle , degrees", y="Energy , Kj/mol") + 
		theme_classic() 
	ggsave("CCO_angle_scans.pdf")
