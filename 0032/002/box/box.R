dat <- read_pdb2("ends.pdb") %>% 
	select(AtomNumber,AtomName,Part,ResName,ResNum,x,y,z) %>%
	mutate(
		PolymerNumber = floor(seq(from=1, to=4.9999, length.out=56))
	) %>%  
	group_by(ResNum,PolymerNumber) %>%
	mutate(
		x0 = mean(x),
		y0 = mean(y),
		z0 = mean(z)
	) %>% 
	ungroup() %>%
	group_by(PolymerNumber) %>%
	mutate(
		x0 = mean(x),
		y0 = mean(y),
		z0 = mean(z),
	) %>% 
	select(-c(x,y,z, AtomNumber,Part,ResName,ResNum)) %>%  
	nest(data=c(AtomName)) %>% 
	ungroup() %>%
	select(-c(data, PolymerNumber)) %>% print()

lx = sqrt( sum( (dat[4,] - dat[1,])^2 ) )
ly = sqrt( sum( (dat[2,] - dat[1,])^2 ) )
lz = sqrt( sum( (dat[3,] - dat[1,])^2 ) )

vx = dat[4,] - dat[1,]
vy = dat[2,] - dat[1,]
vz = dat[3,] - dat[1,]

beta = 180 - angle(vx[1],vx[2],vx[3],vz[1],vz[2],vz[3])
gamma = 180 - angle(vx[1],vx[2],vx[3],vy[1],vy[2],vy[3])
alpha = 180 -  angle(vy[1],vy[2],vy[3],vz[1],vz[2],vz[3])



print(paste("a =",lx/19))
print(paste("b =",ly/3))
print(paste("c =",lz/7))

print(paste("full a =",(lx/19)*20))
print(paste("full b =",(ly/3)*4))
print(paste("full c =",(lz/7)*8))

print(paste("alpha =",alpha))
print(paste("beta =",beta))
print(paste("gamma =",gamma))
