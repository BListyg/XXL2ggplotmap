#########################

#Packages and stuff
library(rvest)
library(reshape2)
library(ggmap)

#Linking to the the voting website for all the nominees also GO VOTE FOR PLAYBOI CARTI HE AINT A BROKE BOI
links = read_html("http://freshmen.xxlmag.com/10th-spot/")

link = links %>% 
  #HTML Node (I think that's the right term? I don't know, I'm not a web comp sci person)
  html_nodes(".desc2") %>% 
  html_text()
link = melt(link)
link = table(link)
link = melt(link)
link = cbind(geocode(as.character(link$link)),link)

#Naming the columns of the rapper's city and how many come from there so it's pretty
colnames(link)[3] = paste("RapperArea")
colnames(link)[4] = paste("RapperCount")

#USA Map data
usa <- map_data("usa")

#Plotting the rapper coordinates on the USA map
ggplot() + geom_polygon(data = usa, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3) +
  coord_map() +
  #making it red because that's XXL's color scheme
  geom_point(data=link, aes(x=lon, y=lat, size=RapperCount), color="red") +
  xlim(-130,-60)

#####################################
#XXL Link = http://freshmen.xxlmag.com/10th-spot/
  
#XXL HTML Node = .desc2