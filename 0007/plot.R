library('tidyverse')

Harmonic <- function(theta0,k,v0,Angle){
	V <- (1/2) * k * (theta0 - Angle)^2 + v0
	return(V)
}

Harmonic_fit <- function(D) {
	nls(Energy~Harmonic(theta0,k,v0,Angle), 
		start=list(theta0=110,k=1,v0=0), 
		data=D) 
}

bin <- function(D,n){
	binned <- data.frame(Energy=0, Angle=0, SD=0)	
	bin_size <- as.integer(nrow(D)/n)
	for (i in 1:n){
		j <- i*bin_size - bin_size
		index <- full_seq(c(j,j+bin_size),1) 
		binned[i,"Angle"] <- mean(D[ index , "Angle" ]) 
		binned[i,"Energy"] <- mean(D[ index , "Energy" ])
		binned[i,"SD"] <- sd(D[ index , "Energy" ])	
	}
	return(binned)
}

gaussian_b3lyp <- read.table("b3lyp_data.txt") %>% 
	rename(Angle=V1, Energy=V2) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(Harmonic_fit(.))) %>%
	mutate(Energy = Energy - min(fit), fit = fit-min(fit))

gaussian_w <- read.table("w_data.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="WB97XD") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(Harmonic_fit(.))) %>%
	mutate(Energy = Energy - min(fit), fit = fit-min(fit))

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_scan_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(Harmonic_fit(.))) %>%
	mutate(Energy = Energy - min(fit), fit = fit-min(fit))

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_scan_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(fit = predict(Harmonic_fit(.))) %>%
	mutate(Energy = Energy - min(fit), fit = fit-min(fit))

Difference <- as_tibble(data.frame(matrix(ncol=3,nrow=26))) %>%
	rename(Angle=X1, Energy=X2) %>%
	mutate(Method = "B2LYP-MD") %>%
	mutate(Angle = MD_scan_on$Angle) %>%
	mutate(Energy = gaussian_b3lyp$Energy - MD_scan_off$Energy) %>%
	mutate(fit = predict(Harmonic_fit(.)))
	
data <- bind_rows(gaussian_b3lyp, MD_scan_off,MD_scan_on, Difference) %>% 
	ggplot(aes(x=Angle, y=Energy, color=Method)) + 
		geom_point() + 
		geom_line(aes(y=fit)) + 
		labs(y="Energy, KJ/mol", x="Angle, degrees", subtitle="Fitted with harmonic potentials") +
		theme_classic()
		ggsave("Energy_scans.pdf") 

Difference %>% Harmonic_fit(.) %>% print()

#MD_NVT_off <- read.table("MD_NVT_off.txt",skip=1000) %>%
#	rename(Time=V1,Energy=V2, Angle=V3) %>%
#	mutate(Method="MD_scan_potential_on") %>%
#	mutate(Energy = Energy * 10.36) %>%
#	arrange(Angle) %>%
#	select(Energy,Angle) %>% 
#	bin(22) %>% 
#	mutate(Energy = Energy-min(Energy)) %>%
#	mutate(Mode="Potential_off") %>%
#	ggplot(aes(x=Angle,y=Energy,color=Mode)) +
#		geom_point() +
#		geom_line() + 
#		theme_classic() + 
#		labs(x="Angle", y="Energy Kjmol-1", subtitle="C-C-O Angle PES in NVT")
#	ggsave("MD_NVT_PES.pdf")






