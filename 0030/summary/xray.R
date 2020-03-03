
K300 <- read.table("../300K/xray/large.xq", skip=2) %>% as_tibble() %>% rename(q=V1, S=V2) %>% mutate(T="300K")
K350 <- read.table("../350K/xray/large.xq", skip=2) %>% as_tibble() %>% rename(q=V1, S=V2) %>% mutate(T="350K")
K400 <- read.table("../400K/xray/large.xq", skip=2) %>% as_tibble() %>% rename(q=V1, S=V2) %>% mutate(T="400K")

rbind(K300,K350,K400) %>% 
	ggplot(aes(x=q,y=S, color=T)) +
		geom_line(size=1) +	
		labs(x="q/A", y="S(q)") +
	ggsave("xray.pdf", width=12) 	
