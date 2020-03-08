
# Get coordinates at t=0
supercell <- read_pdb2("../super_cell.pdb") %>% 
	rename(x0=x, y0=y, z0=z) %>%
	select(x0, y0, z0) %>% 
	nest(data = c(x0,y0,z0)) 

# Extract data and calculate useful properties 
data <- dir(path="../frames/",pattern="*.pdb") %>%  
	enframe(name=NULL) %>% 
	rename(FileName = value) %>% 
	mutate(FileName=paste("../frames/",FileName,sep="")) %>% 
	mutate(pdb = map(FileName, read_pdb2)) %>% 
	mutate(t0 = supercell$data) %>% 
	unnest(c(pdb, t0)) %>%  
	select(-c(FileName, AtomNumber, alpha, beta, gamma, ResName)) %>% 
	mutate( dx = x-x0 , dy = y-y0 , dz = z-z0 , dr = sqrt( dx^2 + dy^2 + dz^2 ) ) %>%
	mutate( mean_x = mean(dx) , mean_y = mean(dy) , mean_z = mean(dz), mean_r = mean(dr) ) %>% 
	mutate( sd_x = sd(dx) , sd_y = sd(dy) , sd_z = sd(dz),  sd_r = sd(dr) ) %>%
	group_by(mean_x,mean_y,mean_z,mean_r,sd_x,sd_y,sd_z,sd_r) %>%
	nest()  %>% 
	write_delim("displacements.tsv")

