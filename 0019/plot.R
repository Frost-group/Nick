library("tidyverse")

b3lyp_no_methyl <- read.table("b3lyp_no_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy) - 5) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

xb97xdp_no_methyl <- read.table("wb97xd_no_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

b3lyp_with_methyl <- read.table("b3lyp_with_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

wb97xd_with_methyl <- read.table("wb97xd_with_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

data <- bind_rows(b3lyp_with_methyl, wb97xd_with_methyl, xb97xdp_no_methyl, b3lyp_no_methyl) %>%
	filter(Energy < 30) %>%
	ggplot(aes(x=Angle,y=Energy, color=Functional, shape=Sidechain, group=interaction(Functional,Sidechain))) +
		geom_point(size=3) +
		geom_line() +
		labs(x="Angle , degrees", y="Energy , Kj/mol",
			subtitle="Scans using two whole monomers") + 
		theme_classic() 
	ggsave("outer_dihedral_scans_two_mon.pdf")


b3lyp_no_methyl <- read.table("b3lyp_no_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle-180) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle< -180),Angle+360,Angle)) %>%
	arrange(Angle)

wb97xdp_no_methyl <- read.table("wb97xd_no_methyl_two_half_mon_hd.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

MP2_no_methyl <- read.table("../0024/MP2.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="MP2") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)


b3lyp_with_methyl <- read.table("b3lyp_with_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle-180) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle< -180),Angle+360,Angle)) %>%
	arrange(Angle)

wb97xd_with_methyl <- read.table("wb97xd_with_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle-180) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle< -180),Angle+360,Angle)) %>%
	arrange(Angle)


data <- bind_rows(wb97xdp_no_methyl, b3lyp_no_methyl, MP2_no_methyl) %>%
	filter(Energy < 30) %>%
	ggplot(aes(x=Angle,y=Energy, color=Functional, shape=Sidechain, group=interaction(Functional,Sidechain))) +
		geom_point(size=3) +
		geom_line() +
		labs(x="Angle , degrees", y="Energy , Kj/mol",
			subtitle="Scans using two half monomers") + 
		theme_classic() 
	ggsave("outer_dihedral_scans_two_half_mon.pdf")
