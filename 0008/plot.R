library('tidyverse')


RB <- function(C0,C1,C2,C3,C4,C5,Angle){
	V <- C0*cos(Angle)^0 + 
		C1*cos(Angle*0.0174533)^1 + 
		C2*cos(Angle*0.0174533)^2 + 
		C3*cos(Angle*0.0174533)^3 + 
		C4*cos(Angle*0.0174533)^4 + 
		C5*cos(Angle*0.0174533)^5
	return(V)
}

RB_fit <- function(D) {
	nls(Energy~RB(C0,C1,C2,C3,C4,C5,Angle), 
		start=list(C0=30,C1=10,C2=-30,C3=10,C4=10,C5=10), 
		data=D) 
}

bin <- function(D,n){
	binned <- data.frame(Angle=0, Energy=0)	
	bin_size <- as.integer(nrow(D)/n)
	for (i in 0:n){
		j <- i * bin_size
		binned[i,1] = mean(D[j:j+bin_size,1])
		binned[i,2] = mean(D[j:j+bin_size,2])
	}
	return(binned)
}


gaussian_b3lyp <- read.table("b3lyp_data.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle=if_else(Angle>180,Angle-360,Angle))

gaussian_w <- read.table("w_data.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="wB97XD") %>%
	mutate(Energy= Energy*27211.4) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle=if_else(Angle>180,Angle-360,Angle))

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Energy = Energy * 10.36) 

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Energy = Energy * 10.36)

data <- bind_rows(gaussian_b3lyp,gaussian_w) %>%
	filter(Energy < 500) %>%
	ggplot(aes(x=Angle, y=Energy, color=Method)) + 
		geom_point() + 
		geom_line() + 
		labs(y="Energy, meV", x="Angle, degrees") +
		theme_classic()
		ggsave("Energy_QCC.pdf")
 
data <- bind_rows(MD_scan_off,MD_scan_on) %>%
	filter(Energy < 500) %>%
	ggplot(aes(x=Angle, y=Energy, color=Method)) + 
		geom_point() + 
		geom_line() + 
		labs(y="Energy, meV", x="Angle, degrees") +
		theme_classic()
		ggsave("Energy_MD.pdf") 
