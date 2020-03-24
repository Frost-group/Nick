library("tidyverse")
library("Rpdb")
source("~/Dropbox/library/R_functions.R")

data <- read_pdb2("../super_cell.pdb") %>%
	filter( ResNum==1 | ResNum==161 | ResNum==7 | ResNum==25 ) %>% 
	select(ResNum, AtomName, Element, Part, x, y, z) %>%
	group_by(ResNum) %>%
	filter(!(Element=="H") & Part=="Backbone") %>%
	mutate(
		com_x = mean(x),
		com_y = mean(y),
		com_z = mean(z)
	) %>% 
	ungroup() %>%
	nest(data = c(AtomName, Element, x,y,z)) %>% 
	mutate(
		rx = com_x - .$com_x[1],
		ry = com_y - .$com_y[1],
		rz = com_z - .$com_z[1]
	) %>%	
	filter(ResNum==161 | ResNum==7 | ResNum==25) %>%
	select(rx,ry,rz) %>% print()

alpha=angle(data[[3,1]], data[[3,2]], data[[3,3]], data[[2,1]], data[[2,2]], data[[2,3]])
beta=angle(data[[2,1]], data[[2,2]], data[[2,3]], data[[1,1]], data[[1,2]], data[[1,3]])
gamma=angle(data[[3,1]], data[[3,2]], data[[3,3]], data[[1,1]], data[[1,2]], data[[1,3]])

print(paste("Alpha is",alpha))
print(paste("Beta is",beta))
print(paste("Gamma is",gamma))
