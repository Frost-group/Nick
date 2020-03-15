dat <- read_pdb2("../NPT.pdb") %>% 
	select(AtomNumber,AtomName,Part,ResName,ResNum,x,y,z) %>%
	mutate(
		PolymerNumber = floor(seq(from=1, to=30.99999, length.out=60060))
	) %>%
	group_by(ResNum, PolymerNumber) %>% 
	mutate(
		x = x - mean(x),
		y = y - mean(y),
		z = z - mean(z)
	) %>% 
	ungroup() %>% 
	group_by(AtomName) %>%	
	mutate(
		x = mean(x),
		y = mean(y),
		z = mean(z)
	) %>%
	select(AtomName,x,y,z, AtomNumber) %>% 
	ungroup() %>%
	nest(data=c(AtomNumber)) %>% 
	select(-c(data)) %>%
	write_delim("cell_coords.txt")  


