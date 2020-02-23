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
	select(-c(FileName, AtomNumber, alpha, beta, gamma, ResName)) %>% 
	mutate( dx = x-x0 , dy = y-y0 , dz = z-z0 , dr = sqrt( dx^2 + dy^2 + dz^2 ) ) %>%
	group_by(AtomName) %>%
	mutate( mean_x = mean(dx) , mean_y = mean(dy) , mean_z = mean(dz) ) %>% 
	mutate( sd_x = sd(dx) , sd_y = sd(dy) , sd_z = sd(dz) )  

# Do Density plot of dx, dy and dz
data %>% ggplot() +
		geom_density(aes(x=dr, color=Part)) +
		theme_classic() +
		labs(x="Magnitude of Atomic Displacement Vectors, A", 
			subtitle="PDF of atomic displacement vectors form inital crystalline state") 
	ggsave("dr_histogram.pdf")

# Get coordinates for image
coords <- read_pdb("../coords.pdb") %>% 
	select(x,y,z) %>%
	mutate(cmx = mean(x) , cmy = mean(y) , cmz = mean(z)) %>%
	mutate(cordx=x-cmx, cordy=y-cmy,cordz=z-cmz)  %>%
	select(cordx,cordy,cordz)

# rotations for viewing
xtheta = 0.6 
ytheta = 0.2
ztheta = 0.

# Plot average Displacement and Average Standard Deviation
data %>% ungroup() %>%
	select(-c("recname","a","b","c")) %>% 
	filter(ResNum%%2==0) %>% 
	nest(data=c(x,y,z,dx,dy,dz,dr,x0,y0,z0, ResNum)) %>% 
	bind_cols(coords) %>% 
	mutate(sd = (sd_x + sd_y + sd_z)/3 ) %>%
	select(AtomName, Element, mean_x, mean_y, mean_z, sd, cordx, cordy, cordz) %>% 
	filter(!(Element=="H")) %>%
	group_by(AtomName) %>% 
	mutate( 
		mean_x = rotatex(mean_x,mean_y,mean_z,xtheta)[1],
		mean_y = rotatex(mean_x,mean_y,mean_z,xtheta)[2],
		mean_z = rotatex(mean_x,mean_y,mean_z,xtheta)[3],
		mean_x = rotatey(mean_x,mean_y,mean_z,ytheta)[1],
		mean_y = rotatey(mean_x,mean_y,mean_z,ytheta)[2],
		mean_z = rotatey(mean_x,mean_y,mean_z,ytheta)[3],
		mean_x = rotatez(mean_x,mean_y,mean_z,ztheta)[1],
		mean_y = rotatez(mean_x,mean_y,mean_z,ztheta)[2],
		mean_z = rotatez(mean_x,mean_y,mean_z,ztheta)[3],
		cordx = rotatex(cordx,cordy,cordz,xtheta)[1],
		cordy = rotatex(cordx,cordy,cordz,xtheta)[2],
		cordz = rotatex(cordx,cordy,cordz,xtheta)[3],
		cordx = rotatey(cordx,cordy,cordz,ytheta)[1],
		cordy = rotatey(cordx,cordy,cordz,ytheta)[2],
		cordz = rotatey(cordx,cordy,cordz,ytheta)[3],
		cordx = rotatez(cordx,cordy,cordz,ztheta)[1],
		cordy = rotatez(cordx,cordy,cordz,ztheta)[2],
		cordz = rotatez(cordx,cordy,cordz,ztheta)[3],
	) %>% 
	ggplot(aes(x=cordx, y=cordy, color=Element)) +
		geom_segment(aes(xend=(cordx+mean_x), yend=(cordy+mean_y)), size=0.2,arrow = arrow(length = unit(0.01, "npc"))) +	
		geom_point(aes(x=(cordx+mean_x),y=(cordy+mean_y),size=(2*sd)), alpha=0.5) +
		coord_fixed() +
		theme_classic(base_size=15) +
 		scale_color_manual(values=c("black","blue","orange","Purple")) +
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



