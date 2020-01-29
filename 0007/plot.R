library('tidyverse')

Harmonic <- function(theta0,k,Angle){
	V <- (1/2) * k * (theta0 - Angle)^2
	return(V)
}

Harmonic_fit <- function(D) {
	nls(Energy~Harmonic(theta0,k,Angle), 
		start=list(theta0=119,k=1), 
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
	mutate(Energy= Energy*27211.4) %>%
	mutate(Energy = Energy - min(Energy))

gaussian_w <- read.table("w_data.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="WB97XD") %>%
	mutate(Energy= Energy*27211.4) %>%
	mutate(Energy = Energy - min(Energy))

MD_energy_min <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_scan_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Energy = Energy * 10.36) 

MD_energy_min_p <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_scan_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Energy = Energy * 10.36) 
	
data <- bind_rows(gaussian_b3lyp, gaussian_w, MD_energy_min,MD_energy_min_p) %>%
#	group_by(Method) %>%
#	nest() %>%
#	mutate(
#		model = map(data, Harmonic_fit),
#		fit = map(model,predict)
#		)  %>%
#	unnest(c(data,fit)) %>%
	ggplot(aes(x=Angle, y=Energy, color=Method)) + 
		geom_point() + 
		geom_line() + 
		labs(y="Energy, meV", x="Angle, degrees", subtitle="Fitted with harmonic potentials") +
		theme_classic()
		ggsave("Energy_scans.pdf") 

MD_NVT <- read.table("MD_NVT_data.txt",skip=1000) %>%
	rename(Time=V1,Energy=V2, Angle=V3) %>%
	mutate(Method="MD_scan_potential_on") %>%
	mutate(Energy = Energy * 10.36) %>%
	arrange(Angle) %>%
	select(Energy,Angle) %>% 
	bin(22) %>% 
	mutate(Energy = Energy-min(Energy)) %>%
	mutate(Mode="Potential_off") %>%
	mutate(fit = predict(nls(Energy~Harmonic(theta0,k,Angle), 
			start=list(theta0=130,k=1), 
			data=.))) %>%
	ggplot(aes(x=Angle,y=Energy,color=Mode)) +
		geom_point() +
		geom_line(aes(y=fit)) + 
		theme_classic() + 
		labs(x="Angle", y="Energy Kjmol-1", subtitle="C-C-O Angle PES in NVT")
	ggsave("MD_NVT_PES.pdf")






