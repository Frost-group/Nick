library("tidyverse")

b3lyp_no_methyl_full <- read.table("b3lyp_no_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="None") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy) - 4.7) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

xb97xdp_no_methyl_full <- read.table("wb97xd_no_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="None") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

b3lyp_with_methyl_full <- read.table("b3lyp_with_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)

wb97xd_with_methyl_full <- read.table("wb97xd_with_methyl_two_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Full") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle)


b3lyp_no_methyl_half <- read.table("b3lyp_no_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle-180) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle< -180),Angle+360,Angle)) %>%
	arrange(Angle)

wb97xdp_no_methyl_half <- read.table("wb97xd_no_methyl_two_half_mon_hd.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Sidechain="None") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)

MP2_no_methyl_half <- read.table("../0024/MP2_no_methyl.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Functional="MP2") %>%
	mutate(Sidechain="None") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	arrange(Angle)


b3lyp_with_methyl_half <- read.table("b3lyp_with_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle-180) %>%
	mutate(Functional="B3LYP") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle< -180),Angle+360,Angle)) %>%
	arrange(Angle)

wb97xd_with_methyl_half <- read.table("wb97xd_with_methyl_two_half_mon.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>%
	mutate(Angle = Angle-180) %>%
	mutate(Functional="wb97xd") %>%
	mutate(Sidechain="Methyl") %>%
	mutate(Monomers="Two Half") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle< -180),Angle+360,Angle)) %>%
	arrange(Angle)

data <- bind_rows(
	b3lyp_no_methyl_full, xb97xdp_no_methyl_full, b3lyp_with_methyl_full, wb97xd_with_methyl_full, b3lyp_no_methyl_half, wb97xdp_no_methyl_half, MP2_no_methyl_half, b3lyp_with_methyl_half, wb97xd_with_methyl_half
) %>% as_tibble()

data %>% filter(Functional=="wb97xd") %>%
	filter(abs(Angle) < 100) %>%
	ggplot(aes(x=Angle, y=Energy, color=interaction(Sidechain,Monomers))) + 
		geom_point() +
		geom_line() +
		theme_classic() +
	ggsave("Structure_effect.pdf")

data %>% filter(Sidechain=="None") %>%
	filter(Monomers=="Two Full") %>%
	filter(abs(Angle) < 100) %>%
	ggplot(aes(x=Angle, y=Energy, color=Functional)) + 
		geom_point() +
		geom_line() +
		theme_classic() +
	ggsave("Functional_effect.pdf")










