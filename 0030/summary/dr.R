
# Get coordinates at t=0
supercell <- read_pdb2("../super_cell.pdb") %>% 
	rename(x0=x, y0=y, z0=z) %>%
	select(x0, y0, z0)

# Extract data and calculate useful properties
K300 <- read_pdb2("../300K/frames/frame_2000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(Anneal_temp="300K")

K350 <- read_pdb2("../350K/frames/frame_8000.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(Anneal_temp="350K")

K400 <- read_pdb2("../400K/frames/frame_11600.pdb") %>%
	mutate(
		dx	= x - supercell$x0, 
		dy	= y - supercell$y0, 
		dz	= z - supercell$z0,
		dr	= sqrt( dx**2 + dy**2 + dz**2 )
	) %>% 
	select(AtomName,ResNum,Part,dx,dy,dz,dr) %>% 
	mutate(Anneal_temp="400K")


rbind(K300,K350,K400) %>% 
	ggplot(aes(Part,dr, color=Anneal_temp)) + 
		geom_boxplot(outlier.size = 0) +
		ylim(0,11) +
		theme(axis.text.x = element_text(angle = 90)) +
		labs(y="r / A", x=" ")
	ggsave("boxplot.pdf", width=11)
