library("tidyverse")
library("Rpdb")
source("~/Dropbox/library/R_functions.R")

geom_center <- function(data){
	x0 <- mean(data$x)
	y0 <- mean(data$y)
	z0 <- mean(data$z)
	a <- data.frame(x0=x0, y0=y0, z0=z0) %>% as_tibble()
	return(a)
}

angle <- function(x1,y1,z1,x2,y2,z2){
	theta <- 57.2958*acos( (x1*x2 + y1*y2 + z1*z2 )/( sqrt(x1^2+y1^2+z1^2)*sqrt(x2^2+y2^2+z2^2) ) )
	return(theta)
}

data <- read_pdb2("NPT_56000ps.pdb") %>% 
	select(-c("alpha", "beta", "gamma", "recname","a","b","c","Part", "ResName")) %>%
	filter(
		( ResNum==4 | ResNum==1 | ResNum==21 | ResNum==169 )   
	) %>%
	nest(data = c("x","y","z", "AtomNumber","AtomName","Element")) %>% 
	mutate(geom_center = map(data, geom_center)) %>% 
	unnest(c(geom_center))  %>% 
	mutate(dx=x0-x0[[1]], dy=y0-y0[[1]], dz=z0-z0[[1]]) %>% 
	filter(ResNum==4 | ResNum==21 | ResNum==169) %>% 
	select(dx,dy,dz) 

alpha=angle(data[[3,1]], data[[3,2]], data[[3,3]], data[[2,1]], data[[2,2]], data[[2,3]])
beta=angle(data[[2,1]], data[[2,2]], data[[2,3]], data[[1,1]], data[[1,2]], data[[1,3]])
gamma=angle(data[[3,1]], data[[3,2]], data[[3,3]], data[[1,1]], data[[1,2]], data[[1,3]])

print(paste("Alpha is",alpha))
print(paste("Beta is",beta))
print(paste("Gamma is",gamma))


