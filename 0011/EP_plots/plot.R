

data1 <- read_pdb2("alk3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("EP_alk3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Part=="Terminal")) %>%
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red",
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,8)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_alk.pdf")


		 
data1 <- read_pdb2("gly3.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("EP_gly3.txt"))[[1]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Part=="Terminal")) %>%
	dplyr::filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(
			low="blue", 
			mid="lightgreen", 
			high="red", 
			limits=c(-0.5,0.5)
		) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_gly.pdf")
