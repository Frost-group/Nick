
S001 <- read.table("../001/300K/xray/large.xq", skip=2) %>% as_tibble() %>% rename(q=V1, S=V2) %>% mutate(method="Scheme 1")
S002 <- read.table("../002/xray/large.xq", skip=2) %>% as_tibble() %>% rename(q=V1, S=V2) %>% mutate(method="Scheme 2")
S004 <- read.table("../004/300K/xray/large.xq", skip=2) %>% as_tibble() %>% rename(q=V1, S=V2) %>% mutate(method="Scheme 4")
S005 <- read.table("../005/xray/large.xq", skip=2) %>% as_tibble() %>% rename(q=V1, S=V2) %>% mutate(method="Scheme 5")

rbind(S001,S002,S004,S005) %>% 
	ggplot(aes(x=q,y=S, color=method)) +
		geom_line(size=1) +	
		ylim(0,500) + 
		labs(x="q/A", y="S(q)") +
	ggsave("xray.pdf", width=12) 	
