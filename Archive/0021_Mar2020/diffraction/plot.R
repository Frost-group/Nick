library("tidyverse")

a<- read.table("xray.xq", skip=2) %>%
	rename(Q=V1,S=V2) %>%
	mutate(S = S+100) %>%
	ggplot(aes(x=Q, y=S)) +
	geom_line() +
	scale_y_log10() + 
	theme_classic(base_size=24) +
	labs(x="Q / A" , y="S(Q)") 
	ggsave("x_ray.pdf")
