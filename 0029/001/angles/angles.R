geom_center <- function(data){
	x0 <- mean(data$x)
	y0 <- mean(data$y)
	z0 <- mean(data$z)
	a <- data.frame(x0=x0, y0=y0, z0=z0) %>% as_tibble()
	return(a)
}

data <- read_pdb2("../frames/frame_30000.pdb") %>% as_tibble() %>% 
	group_by(ResNum) %>%
	select(ResNum, Element, Part, AtomName, x, y, z) %>%
	nest() %>% 
	mutate(com = map(data,geom_center) ) %>% 
	unnest(c(com)) %>% 
	select(ResNum, x0, y0, z0) %>% 
	print()

data <- bind_rows( data[data$ResNum==2,], 
		data[data$ResNum==10,], 
		data[data$ResNum==42,],
		data[data$ResNum==202,]
	) %>% 
	mutate(
		x0 = x0 - .[[1,2]],
		y0 = y0 - .[[1,3]],
		z0 = z0 - .[[1,4]]
	) %>%  
	print()

gamma=angle(data[[4,2]], data[[4,3]], data[[4,4]], data[[3,2]], data[[3,3]], data[[3,4]])
alpha=angle(data[[3,2]], data[[3,3]], data[[3,4]], data[[2,2]], data[[2,3]], data[[2,4]])
beta=angle(data[[4,2]], data[[4,3]], data[[4,4]], data[[2,2]], data[[2,3]], data[[2,4]])
#
print(paste("Alpha is",alpha))
print(paste("Beta is",beta))
print(paste("Gamma is",gamma))
