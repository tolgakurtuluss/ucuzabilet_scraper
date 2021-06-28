library(rvest)
library(tidyverse)

websitesi=read_html("https://bilet.ucuzaucak.net")%>% html_nodes("#sapper > div.mycontainer.svelte-1x3lb81 > div.itemList.svelte-z4vv7p")

nereye=c()
ucusyon=c()
ucret=c()
tarihler=c()
paylasimzamani=c()
link=c()

for (i in 1:25) {
  nereye[i]=xml_child(xml_child(xml_child(xml_child(xml_child(websitesi[[1]] %>% html_nodes("a"),i),1),1),1),1) %>% html_text() %>% str_replace_all("\n"," ")
  ucusyon[i]=xml_child(xml_child(xml_child(xml_child(xml_child(websitesi[[1]] %>% html_nodes("a"),i),1),1),1),2) %>% html_text() %>% str_replace_all("\n"," ")
  ucret[i]=xml_child(xml_child(xml_child(xml_child(websitesi[[1]] %>% html_nodes("a"),i),1),1),2)%>% html_text()%>% str_replace_all(" ","")%>% str_replace_all("\n","")
  tarihler[i]=xml_child(xml_child(xml_child(xml_child(websitesi[[1]] %>% html_nodes("a"),i),1),2),1) %>% html_text()%>% str_replace_all(" ","")
  paylasimzamani[i]=xml_child(xml_child(xml_child(websitesi[[1]] %>% html_nodes("a"),i),1),3)%>% html_text()%>% str_replace_all("\n","")
  link[i]=paste0("https://bilet.ucuzaucak.net", websitesi[[1]] %>% html_nodes("a") %>% .[[i]] %>% html_attr("href") %>% as.character())
}

data.frame(nereye,ucusyon,ucret,tarihler,paylasimzamani,link)
