library("tidyverse")
#library("ggpubr")
library("nortest")

########################################################################################
########################################################################################

source("~/Dropbox/library/R_functions.R")

########################################################################################
########################################################################################

# Get coordinates at t=0
supercell <- read_pdb("../super_cell_rot.pdb") %>%
	rename(x0=x, y0=y, z0=z) %>%
	select(x0, y0, z0) %>% 
	nest(data = c(x0,y0,z0))

# Extract data and calculate useful properties 
data <- dir(pattern="*rot.pdb") %>% 
	enframe(name=NULL) %>% 
	rename(FileName = value) %>%
	mutate(pdb = map(FileName, read_pdb)) %>% 
	mutate(t0 = supercell$data) %>% 
	unnest(c(pdb, t0)) %>% 
	select(-c(FileName, AtomNumber, alpha, beta, gamma, ResNumber, Part, ResName)) %>% 
	mutate( dx = x-x0 , dy = y-y0 , dz = z-z0 ) %>%
	group_by(AtomName) %>%
	mutate( mean_x = mean(dx) , mean_y = mean(dy) , mean_z = mean(dz) ) %>% 
	mutate( sd_x = sd(dx) , sd_y = sd(dy) , sd_z = sd(dz) )  

# Do Density plot of dx, dy and dz
data %>% ggplot() +
		geom_density(aes(x=dx), color="blue") +
		geom_density(aes(x=dy), color="black") +
		geom_density(aes(x=dz), color="red") +
		theme_classic() +
		xlim(-2,2) + 
		labs(x="Magnitude of Atomic Displacement Vectors, A", 
			subtitle="PDF of atomic displacement vectors, dx (blue), dy(black) and dz (red)") 
	ggsave("histogram_of_displacement.pdf")

# Get coordinates for image
coords <- read_pdb("../AB_cryst_rot.pdb") %>% 
	select(x,y,z) %>%
	mutate(y=y+12, x=x+7) %>%
	rename(cordx=x, cordy=y,cordz=z)  

# Plot average Displacement and Average Standard Deviation
data %>% ungroup() %>%
	nest(data=c(x,y,z,dx,dy,dz,x0,y0,z0)) %>% 
	bind_cols(coords) %>% 
	mutate(sd = (sd_x + sd_y + sd_z)/3 ) %>%
	select(Element, mean_x, mean_y, sd, cordx, cordy) %>% 
	filter(!(Element=="H")) %>% 
	ggplot(aes(x=cordx, y=cordy, color=Element)) +
		geom_segment(aes(xend=(cordx+mean_x), yend=(cordy+mean_y)), size=0.2,arrow = arrow(length = unit(0.01, "npc"))) +	
		geom_point(aes(x=(cordx+mean_x),y=(cordy+mean_y),size=(2*sd)),alpha=0.5) +
		coord_fixed() +
		theme_classic(base_size=15) +
		xlim(-6,7.5) +		
 		scale_color_manual(values=c("Purple","black","blue","orange")) +
 		labs(x="x, A", y="y, A", size="Radius of Space Occupied by \n Atom 95% of the time , A") + 
 		theme(
 			axis.title.x=element_blank(),
 			axis.title.y=element_blank(),
 			axis.text.x=element_blank(),
 			axis.text.y=element_blank(),
 			axis.line.x=element_blank(),
 			axis.line.y=element_blank(),
 			axis.ticks.x=element_blank(),
 			axis.ticks.y=element_blank()
 		)  
 	ggsave("Average_Displacement.pdf")

