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
		start=list(C0=0,C1=300,C2=-30,C3=0,C4=10,C5=10), 
		data=D,
		weights=(1/(Error^2+1))) 
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
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="B3LYP") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<360),Angle-360,Angle)) %>%
	filter(Angle>-131, Angle<131) %>%
	arrange(Angle) %>%
	mutate(Error=1)

gaussian_w <- read.table("w_data.txt") %>% 
	rename(Angle=V1, Energy=V2) %>%
	mutate(Angle = round(Angle)) %>% 
	mutate(Method="WB97XD") %>%
	mutate(Energy= Energy*27211.4/10.36) %>%
	mutate(Energy = Energy - min(Energy)) %>%
	mutate(Angle = ifelse((Angle>180 & Angle<360),Angle-360,Angle)) %>%
	filter(Angle>-131, Angle<131) %>%
	arrange(Angle) %>%
	mutate(Error=1) 

MD_scan_off <- read.table("MD_scan_off.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_off") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	filter(Angle>-131, Angle<131) %>%
	mutate(Error=1)

MD_scan_on <- read.table("MD_scan_on.txt") %>%
	rename(Angle=V1, Energy=V2) %>%
	mutate(Method="MD_potential_on") %>%
	mutate(Energy = Energy - min(Energy)) %>%
	filter(Angle < 131 & Angle > -131) %>%
	mutate(Error=1)

QCC_MD_Diff <- as_tibble(data.frame(matrix(nrow=27,ncol=2))) %>%
	rename(Angle=X1, Energy=X2) %>%
	mutate(Angle = MD_scan_off$Angle) %>% 
	mutate(Energy = gaussian_b3lyp$Energy - MD_scan_off$Energy) %>%	
	mutate(Method="Difference") %>%
	mutate(Error=1)

Data <- bind_rows(gaussian_b3lyp, MD_scan_off, QCC_MD_Diff, MD_scan_on) %>%
	group_by(Method) %>% 
	nest() %>%
	mutate(
		model = map(data, RB_fit),
		fit = map(model, predict)
	) %>% 
	unnest(c(data, fit))

Data %>% filter(Energy < 60) %>% 
	ggplot(aes(x=Angle, color=Method)) +
		geom_point(aes(y=Energy)) +
		geom_line(aes(y=Energy), linetype="dashed") + 
		geom_line(aes(y=fit)) + 
		theme_classic() 
		ggsave("Energy_MD.pdf") 

Data %>% filter(Method=="Difference") %>%
	group_by(Method) %>%
	nest() %>%
	mutate(model = map(data,RB_fit),
                coefs = map(model,coefficients),
                C0 = coefs[[1]][[1]],
                C1 = coefs[[1]][[2]],
                C2 = coefs[[1]][[3]],
                C3 = coefs[[1]][[4]],
	        C4 = coefs[[1]][[5]],
                C5 = coefs[[1]][[6]]) %>% print()


#as_tibble(data.frame(matrix(nrow=27,ncol=2))) %>%
#	rename(Angle=X1, Energy=X2) %>%
#	mutate(Angle = MD_scan_off$Angle) %>% 
#	mutate(Energy = gaussian_b3lyp$Energy - MD_scan_off$Energy) %>%
#	filter(Energy>-60) %>%
#	mutate(Method="Difference") %>% 
#	group_by(Method) %>% 
#	nest() %>%
#	mutate(model = map(data,RB_fit),
#		coefs = map(model,coefficients),
#		C0 = coefs[[1]][[1]],
#		C1 = coefs[[1]][[2]],
#		C2 = coefs[[1]][[3]],
#		C3 = coefs[[1]][[4]],
#		C4 = coefs[[1]][[5]],
#		C5 = coefs[[1]][[6]]) %>% print() 

 
QCCdata <- bind_rows(gaussian_b3lyp,gaussian_w) %>%
	filter(Energy < 60) %>%
	ggplot(aes(x=Angle, y=Energy, color=Method)) + 
		geom_point() +
		geom_line(linetype="dashed") +   
		labs(y="Energy, Kj/mol", x="Angle, degrees") +
		theme_classic()
		ggsave("Energy_QCC.pdf")
 
