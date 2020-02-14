library("tidyverse")

atom_number <- 450

########################################################################################
########################################################################################

source("~/Dropbox/library/R_functions.R")

########################################################################################
########################################################################################

files <- dir(pattern="*rot.gro")
 
supercell <- read_gro2("../super_cell_rot.gro", time=-1) %>% 
	select(Time, Element, ResName, AtomName, AtomNumber, Part, x, y, z) %>%
	rename(Element0=Element,ResName0=ResName, AtomName0=AtomName, AtomNumber0=AtomNumber, Part0=Part, x0=x, y0=y, z0=z) %>% 
	nest(super_cell_data=c(Element0,ResName0, AtomName0, AtomNumber0, Part0, x0, y0, z0)) %>% print() 

ran=10

data <- enframe(files, name=NULL) %>%  
	rename(FileName=value) %>% 
	mutate(gro = map(FileName, read_gro2)) %>% 
	unnest(c(gro)) %>% 
	select(Time, Element,ResName, AtomName, AtomNumber, Part, x, y, z) %>% 
	nest(data=c(Element, ResName, AtomName, AtomNumber, Part, x, y, z)) %>% 
	mutate(super_cell = supercell$super_cell_data) %>% 
	unnest(c(data, super_cell)) %>%
	select(Element,Part,AtomName, x,y,z,x0,y0,z0) %>% 
	mutate(dx=(x-x0), dy=(y-y0), dz=(z-z0)) %>% 
	mutate(dr = sqrt(dx**2 + dy**2 + dz**2)) %>%
	mutate(dx=if_else((dx>ran| dx< -ran),NaN,dx),dy=if_else((dy>ran | dy< -ran),NaN,dy),dz=if_else((dz>ran|dz< -ran),NaN,dz),dr=if_else(dr>ran,NaN,dr)) %>%
	select(Element,Part,AtomName, dr, dx, dy, dz) %>% 
	group_by(Element,AtomName, Part) %>% 
	mutate(dxm = mean(dx,na.rm=TRUE),dym = mean(dy,na.rm=TRUE),dzm = mean(dz,na.rm=TRUE),drm = mean(dr,na.rm=TRUE)) %>%
	mutate(sd = sd(dr,na.rm=TRUE)) %>%
	ungroup() %>%
	group_by(Element,AtomName,Part,sd,drm,dxm, dym, dzm) %>%
	nest()  

atom_number <- 90

coords <- read_gro2("../coords.gro", time=-1) %>% 
	select(x,y,z) %>%
	mutate(y=y-7.5, x=x-4) %>%
	rename(cordx=x, cordy=y,cordz=z) 

data <- bind_cols(data, coords) %>%
	filter(!(Element=="H")) %>%
	ggplot(aes(x=cordx, y=cordy, color=Element)) +
	geom_segment(aes(xend=(cordx+dxm), yend=(cordy+dym)), size=0.4) +
	geom_point(aes(x=(cordx+dxm),y=(cordy+dym),size=(2*sd)),alpha=0.4) +   
	coord_fixed() +
	theme_classic() +	
	scale_color_manual(values=c("black","blue","orange","Purple")) +
	scale_radius(limits=c(0,3), range=c(0,46)) +
	xlim(-8,8) +
	ylim(-7,7) + 
	labs(x="x, A", y="y, A", size="Radius of Space Occupied by \n Atom 95% of the time , A") + 
	theme(
#		axis.title.x=element_blank(),
#		axis.title.y=element_blank(),
#		axis.text.x=element_blank(),
#		axis.text.y=element_blank(),
#		axis.line.x=element_blank(),
#		axis.line.y=element_blank(),
#		axis.ticks.x=element_blank(),
#		axis.ticks.y=element_blank()
	)  
	ggsave("Average_Displacement.pdf")



