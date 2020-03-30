

data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("EP_002.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	dplyr::filter(!(Part=="Terminal")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1,1)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		xlim(-5, 5) + 
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_002.pdf")


		 
data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("EP_001.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	dplyr::filter(!(Part=="Terminal")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-0.5,0.5)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		xlim(-5, 5) + 
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_001.pdf")


data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("EP_003.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	dplyr::filter(!(Part=="Terminal")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1,1)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		xlim(-5, 5) + 
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_003.pdf")


data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z, Part) %>% 
	mutate(Charge = as_tibble(read.table("EP_004.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	dplyr::filter(!(Part=="Terminal")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1,1)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		xlim(-5, 5) + 
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_004.pdf")


EP005 <- read.table("EP_005_temp.txt") %>% as_tibble() %>%
	rename(num=V1, Element=V2, Charge=V3, Angle=V4, Energy=V5) %>%
	nest(data=c(num, Element,Charge)) %>%
	mutate(
		Energy	= Energy*27211.4/10.36,
		Energy	= Energy - min(Energy),
		BF	= exp( -Energy/(300*0.08617) ),
		BF	= BF / sum(BF)
	) %>% 
	unnest(cols = c(data)) %>% 
	mutate(
		mod_Charge = Charge*BF
	) %>% 
	select(num, Element, mod_Charge, Angle) %>%
	group_by(num) %>%
	arrange(num) %>%
	mutate(Charge = sum(mod_Charge) ) %>%  
	nest(data = c(Angle, mod_Charge) ) %>% 
	ungroup() %>%
	select(Element, Charge) %>% 
	write.table("EP_005_2.txt", col.names=FALSE, row.names=FALSE) 
	
	
data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z,Part) %>% 
	mutate(Charge = as_tibble(read.table("EP_005.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	dplyr::filter(!(Element=="H")) %>%
	dplyr::filter(!(Part=="Terminal")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1,1)) +
		xlim(-5, 5) + 
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_005.pdf")
