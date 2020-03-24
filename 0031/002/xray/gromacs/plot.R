library(pracma)

Lor <- function(q,q0,h,w=0.01){
	S <- h * w/((q-q0)**2 + (1/4)*(w**2))
	return(S)
}

a <- read.table("sq.xvg",skip=17) %>% 
	as_tibble() %>% 
	rename(q=V1,S=V2) %>%
	mutate(q=q/10) %>% print() 

a %>% ggplot(aes(x=q,y=S)) + 
	geom_line() + 
	labs(y="S(q)",x="q/A") + 
	ggsave("raw.pdf")

q_series <- linspace(0.2,2,1000) %>%
	enframe(name=NULL) %>% 
	rename(q=value) %>% 
	nest(data=c(q)) %>% print()

findpeaks(a$S, minpeakheight=3) %>% 
	as_tibble() %>% 
	rename(
		h	= V1,
		index	= V2,
		start	= V3,
		end	= V4
	) %>% 
	mutate(
		width	= end - start,
		q0	= a$q[index],
		q	= q_series$data
	) %>%
	unnest() %>%
	group_by(q0) %>%
	mutate(fit = Lor(q=q,q0=q0,h=h)) %>% 
	ungroup() %>%
	group_by(q) %>% 
	mutate(fit2 = sum(fit)) %>% 
	ggplot(aes(x=q,y=fit2)) +
		geom_line() +
		labs(x="q/A",y="S(q), A.U")
	ggsave("smooth1.pdf", width=12)
	

