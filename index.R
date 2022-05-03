library("tidyverse")
library("png")
library("gifski")
library('gganimate')
library("ggthemes")
library("here")
library('RColorBrewer')
library('ggplot2')

#converts the datasets into dataframes
dfr <- read.csv(here::here('rawdata',"results.csv"))
dfp <- read.csv(here::here('rawdata',"players.csv"))
#new data frame from imputed data, link to csv can be found in markdown
katoplayerwins <- read.csv(here::here('data',"katoplayerresults.csv"))
#the data frame below was created based on the katoPGRT data frame, missing data was filled in.
fullkatoplayerdf <- read.csv(here::here('data','fullkatoplayersdata.csv'))
#filtering the data via match ID (4901) to only include matches and players during 2020 katowice
dfrkato <- dfr%>%filter(event_id == 4901)
dfpkato <- dfp%>%filter(event_id == 4901)


#filtering teams and adding players to track the teams and the matches who ended up in the finals
dfnaviP <- dfpkato%>%filter(team == "Natus Vincere" | team == "G2" | opponent == "Natus Vincere" | opponent == "G2")
#did the same for new data set with all dates added
filfullkatoplayerdf <- fullkatoplayerdf %>%filter(team == "Natus Vincere" | team == "G2" | opponent == "Natus Vincere" | opponent == "G2")
#arranging data by team for animation render time decrease filfullkatoplayerdf is becoming AFFKPdf
filfullkatoplayerdf <- filfullkatoplayerdf %>%group_by(date) %>% arrange(date)
filfullkatoplayerdf$date <- as.Date(filfullkatoplayerdf$date)
#arranging dataset so players are grouped into their teams
dfteamgrouping<- dfnaviP %>% group_by(team) %>% arrange(team)

#arranging entire tournament into groups by team for ease of interpretation
katoPRGT <- dfpkato %>% group_by(team) %>% arrange(team)



#adding columnn of wins for overall player grouped stats, cols were dummy coded from dfrkato to be generalizable
katoPRGT["winner"] <- c(0,0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
                     0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1,
                     1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1, 1, 1, 1,
                     1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 0, 0, 0, 0, 0
)
#adding col for winner tracked kato matches
dfg2navi <- katoPRGT %>% filter(team == "Natus Vincere" | team == "G2" | opponent == "Natus Vincere" | opponent == "G2")
#Creating custom color palette
mycolors <- c("#6A00FF", "#FF00FF", "#FF0040", "#FF9500", "#FFFF00", "#AAFF00","#00FF15", "#00FFFF", "#0095FF")


#TEST FOR EDIT TESTING:scatterplot tracking winners (g2 & navi) for kato
#d <- ggplot(filfullkatoplayerdf, aes(x = kast, y = hs, color = team)) +
 #  geom_point(size = 4, alpha = .7, aes(shape = factor(winner))) +
  
  #theme_dark() +
  
  #theme(axis.title = element_text(face = 'bold'),
   #     title = element_text(face = 'bold'), plot.title = element_text(hjust = .5), 
    #    panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  
    
  
   #scale_shape_discrete(labels = c("Win", "Loss"), name = 'Wins and Losses') +
  
  
  
  #scale_color_manual(values = mycolors)  + 
  #scale_shape_manual(values = c(1,7)) +
  
  
  #geom_label_repel(aes(label = player_name))+
  #vline and hline intercept values decided due to the median scores of both ratings
  #geom_vline(xintercept = 70)+ #1.04) +
  
 #geom_hline(yintercept = 18.00) +
  
  #labs(title = element_text("IEM Katowice 2020 G2 and Natus Vincere Performance"), 
   #    x = "KAST", 
    #   y = "Headshots")
#d
  

  



#full kato player scatter plot to test which visualization works better

e <- ggplot(filfullkatoplayerdf, aes(x = kast, y = adr, color = team)) +
  
  geom_point(size = 4, alpha = .6, aes(shape = factor(winner))) +
  
  theme_dark() +
  
  theme(text = element_text (size = 15), title = element_text(face = 'bold'), 
        plot.title = element_text(hjust = .5), panel.grid.minor = element_blank()) +
  
  scale_shape_discrete(labels = c("Win", "Loss"), name = 'Wins and Losses') +
  
  scale_color_manual(name = "CSGO Teams", values = mycolors) + #using custom color palette
  
  geom_vline(xintercept = 68.95)+ 
  
  geom_hline(yintercept = 71.90) +
  
  labs(title = "IEM Katowice 2020 Team Performance Spread", 
       x = "Kills, Assists, Survival and Trades",
       y = "Average Damage Per Round")

  
 
e
ggsave(here('figs', 'scatterplot.png'))


# TEST FOR EDITING : building blocks to set up animation
#graph1.animation = c + 
 # transition_time(as.Date(katoPRGT$date)) +
  #labs(subtitle = "Tournament Date: {frame_time}") +
  #shadow_wake(wake_length = .1)
#full player data vizualization
graph2.animation <- e +  
  
  transition_time(filfullkatoplayerdf$date) +
  
  labs(subtitle = "Tournament Date: {frame_time}") +
  
  theme(plot.subtitle = element_text(color = "maroon", hjust = .5)) +
  
  shadow_mark()

  
  
 
  
#making the animation
animate(graph2.animation, height = 650, width = 800, detail = 15, fps = 15, nframes = 675,  duration = 45, 
        end_pause = 75, res = 100) 

#saving ani-graph
anim_save(here::here('figs','anifig.gif'))

 


      