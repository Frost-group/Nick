library('tidyverse')


RB <- function(C0,C1,C2,C3,C4,C5,Angle){
	V <-    C0*cos(Angle*0.0174533)^0 + 
		C1*cos(Angle*0.0174533)^1 + 
		C2*cos(Angle*0.0174533)^2 + 
		C3*cos(Angle*0.0174533)^3 + 
		C4*cos(Angle*0.0174533)^4 + 
		C5*cos(Angle*0.0174533)^5
	return(V)
}

RB_fit <- function(D) {
	nls(Energy~RB(C0,C1,C2,C3,C4,C5,Angle), 
		start=list(C0=0,C1=300,C2=-30,C3=0,C4=10,C5=10), 
		data=D,
		weights=(1/abs(Angle+0.001)),
		nls.control(maxiter=1000)) 
}

gaussian <- read.table("~/Dropbox/OBT/0019/wb97xd_with_methyl.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="wb97xd") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<=360),Angle-360,Angle)) %>%
	arrange(Angle) 

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) 

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) 

Data <- bind_rows(gaussian, MD_scan_off, MD_scan_on) %>%
	group_by(Method) %>% 
	nest() %>%
	mutate(
		model = map(data, RB_fit),
		fit = map(model, predict)
	) %>% 
	unnest(c(data, fit))

range=90
on_range <- Data %>% 
	filter(Method=="MD_potential_on") %>%
	select(Method, Angle, Energy) %>%
	filter(Angle<=range & Angle>=-range) 

off_range <- Data %>% 
	filter(Method=="MD_potential_off") %>%
	select(Method, Angle, Energy) %>%
	filter(Angle<=range & Angle>=-range) 

QCC_range <- Data %>%
	filter(Method=="wb97xd") %>%
	select(Method, Angle, Energy) %>%
	filter(Angle<=range & Angle>=-range) 

Difference <- QCC_range %>% ungroup() %>%
	mutate(Method="Difference") %>%
	mutate(Energy= QCC_range$Energy - off_range$Energy) %>%
	RB_fit(.) %>% print()

