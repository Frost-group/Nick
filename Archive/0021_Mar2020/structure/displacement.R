library("tidyverse")
#library("ggpubr")
library("nortest")
library("Rpdb")

########################################################################################
########################################################################################

source("~/Dropbox/library/R_functions.R")

########################################################################################
########################################################################################

# Get coordinates at t=0
supercell <- read_pdb2("../super_cell.pdb") %>% 
	rename(x0=x, y0=y, z0=z) %>%
	select(x0, y0, z0) %>% 
	nest(data = c(x0,y0,z0))

# Extract data and calculate useful properties 
data <- dir(pattern="*.pdb") %>% 
	enframe(name=NULL) %>% 
	rename(FileName = value) %>%
	mutate(pdb = map(FileName, read_pdb2)) %>% 
	mutate(t0 = supercell$data) %>% 
	unnest(c(pdb, t0)) %>% 
	select(-c(FileName, AtomNumber, alpha, beta, gamma, ResNum, ResName)) %>% 
	mutate( dx = x-x0 , dy = y-y0 , dz = z-z0 , dr = sqrt( dx^2 + dy^2 + dz^2 ) ) %>%
	group_by(AtomName) %>%
	mutate( mean_x = mean(dx) , mean_y = mean(dy) , mean_z = mean(dz) ) %>% 
	mutate( sd_x = sd(dx) , sd_y = sd(dy) , sd_z = sd(dz) ) 


# Do Density plot of dx, dy and dz
data %>% ggplot() +
		geom_density(aes(x=dr, color=Part)) +
		theme_classic() +
		labs(x="Magnitude of Atomic Displacement Vectors, A", 
			subtitle="PDF of atomic displacement vectors, dx (blue), dy(black) and dz (red)") 
	ggsave("dr_histogram.pdf")

data %>% ungroup() %>%
	select(dx,dy,dz) %>% 
	mutate(mean_x = mean(dx), mean_y = mean(dy), mean_z = mean(dz)) %>% 
	mutate(sd_x = sd(dx), sd_y = sd(dy), sd_z = sd(dz)) %>% 
	group_by(mean_x, mean_y, mean_z, sd_x, sd_y, sd_z) %>%
	nest() %>% print
