library("tidyverse")
library("nortest")
library("Rpdb")

########################################################################################
########################################################################################

source("~/Dropbox/library/R_functions.R")
setwd("/Users/nicholassiemons/Dropbox/OBT/0029/EP_plots")

########################################################################################
########################################################################################



data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z) %>% 
	mutate(Charge = as_tibble(read.table("EP_000.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1.2,1.2)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_000.pdf")


data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z) %>% 
	mutate(Charge = as_tibble(read.table("EP_002.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1.2,1.2)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_002.pdf")


		 
data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z) %>% 
	mutate(Charge = as_tibble(read.table("EP_001.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1.2,1.2)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_001.pdf")


data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z) %>% 
	mutate(Charge = as_tibble(read.table("EP_003.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1.2,1.2)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_003.pdf")


data1 <- read_pdb2("GS.pdb") %>%
	select(AtomName, Element, x,y,z) %>% 
	mutate(Charge = as_tibble(read.table("EP_004.txt"))[[2]]) %>%
	mutate(radius = if_else(Element=="H", 0.54, NaN) ) %>% 
	mutate(radius = if_else(Element=="C", 1.7, radius) ) %>% 
	mutate(radius = if_else(Element=="O", 1.52, radius) ) %>% 
	mutate(radius = if_else(Element=="Sn", 2.25, radius) ) %>% 
	mutate(radius = if_else(Element=="S", 1.84, radius) ) %>% 
	filter(!(Element=="H")) %>%
	ggplot(aes(x=x,y=y, color=Charge, size=radius)) +
		geom_point() + 	
		scale_color_gradient2(low="blue", mid="lightgreen", high="red", limits=c(-1.2,1.2)) +
		scale_radius(limits=c(0,2.25), range=c(0,10)) + 
		coord_fixed() +
		stripped() +
		guides(size=FALSE) +
		geom_text(aes(label=Element), color="white", size=3)
	ggsave("map_004.pdf")


