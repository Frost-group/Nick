
# Get coordinates at t=0
supercell <- read_pdb2("../super_cell.pdb") %>% 
	rename(x0=x, y0=y, z0=z) %>%
	select(x0, y0, z0)

# Extract data and calculate useful properties
S001 <- read_pdb2("../001/300K/frames/frame_30000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 1")

S002 <- read_pdb2("../002/frames/frame_45000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 2")

S004 <- read_pdb2("../004/300K/frames/frame_30000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 4")


S005 <- read_pdb2("../005/frames/frame_20000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 5")

rbind(S001,S002,S004,S005) %>% 
	ggplot(aes(Part,dr, color=method)) + 
		geom_boxplot(outlier.size = 0) +
		ylim(0,12) +
		theme(axis.text.x = element_text(angle = 90)) +
		labs(y="r / A", x=" ")
	ggsave("boxplot.pdf", width=13)


S001_300 <- read_pdb2("../001/300K/frames/frame_30000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 1", Annealling_temp="300K")

S001_350 <- read_pdb2("../001/350K/frames/frame_20000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 1", Annealling_temp="350K")

S001_400 <- read_pdb2("../001/400K/frames/frame_22000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 1", Annealling_temp="400K")

S004_300 <- read_pdb2("../004/300K/frames/frame_30000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 4", Annealling_temp="300K")

S004_350 <- read_pdb2("../004/350K/frames/frame_20000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 4", Annealling_temp="350K")

S004_400 <- read_pdb2("../004/400K/frames/frame_22000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(method="Scheme 4", Annealling_temp="400K")

rbind(S001_300,S001_350,S001_400,S004_300,S004_350,S004_400) %>%
	dplyr::filter(Part=="Backbone") %>%
	ggplot(aes(method,dr, color=Annealling_temp)) + 
		geom_boxplot(outlier.size = 0) +
		ylim(0,12) +
		theme(axis.text.x = element_text(angle = 90)) +
		labs(y="r / A", x=" ")
	ggsave("boxplot_backbone.pdf", width=13)


rbind(S001_300,S001_350,S001_400,S004_300,S004_350,S004_400) %>%
	dplyr::filter(Part=="Sidechain") %>%
	ggplot(aes(method,dr, color=Annealling_temp)) + 
		geom_boxplot(outlier.size = 0) +
		ylim(0,12) +
		theme(axis.text.x = element_text(angle = 90)) +
		labs(y="r / A", x=" ")
	ggsave("boxplot_sidechain.pdf", width=13)




