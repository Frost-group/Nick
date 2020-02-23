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


data <- read_pdb2("NPT_20000ps.pdb") %>% 
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


