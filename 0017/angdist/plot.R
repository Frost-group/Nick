library("tidyverse")

a <- read.table("inner.xvg", skip=17) %>% 
	rename(Angle=V1, Probability=V2) %>%
	ggplot(aes(x=Angle, y=Probability)) +
	geom_line() + 
	theme_classic() +
	labs(x="Angle, Degrees", y="Probability Density", title="Probability distribution function for inner dihedral")
	ggsave("inner.pdf")


a <- read.table("angle.xvg", skip=17) %>% 
	rename(Angle=V1, Probability=V2) %>%
	ggplot(aes(x=Angle, y=Probability)) +
	geom_line() + 
	theme_classic() +
	labs(x="Angle, Degrees", y="Probability Density", title="Probability distribution function for CCO angle")
	ggsave("angle.pdf")

