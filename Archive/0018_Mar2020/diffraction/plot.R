library("tidyverse")

#a <- read.table("inner.xvg", skip=17) %>% 
#	rename(Angle=V1, Probability=V2) %>%
#	ggplot(aes(x=Angle, y=Probability)) +
#	geom_line() + 
#	theme_classic() +
#	labs(x="Angle, Degrees", y="Probability Density", title="Probability distribution function for inner dihedral")
#	ggsave("inner.pdf")
#
#
#a <- read.table("angle.xvg", skip=17) %>% 
#	rename(Angle=V1, Probability=V2) %>%
#	ggplot(aes(x=Angle, y=Probability)) +
#	geom_line() + 
#	theme_classic() +
#	labs(x="Angle, Degrees", y="Probability Density", title="Probability distribution function for CCO angle")
#	ggsave("angle.pdf")

a<- read.table("super_cell.dat", skip=2) %>%
	rename(Q=V1,S=V2) %>%
	mutate(Time="Initial")

b <- read.table("NVT_50ps.dat", skip=2) %>%
	rename(Q=V1,S=V2) %>%
	mutate(Time="NVT_50ps")
	
c <- read.table("NPT_1ns.dat", skip=2) %>%
	rename(Q=V1,S=V2) %>%
	mutate(Time="NPT_1ns")

bind_rows(a,b,c) %>%
	ggplot(aes(x=Q, y=S, color=Time)) +
	geom_line() +
	scale_y_log10() + 
	theme_classic(base_size=24) +
	labs(x="Q / A" , y="S(Q)") 
	ggsave("x_ray.pdf", width=10)
