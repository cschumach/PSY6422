## PSY6422 Data Visualization

### IEM Katowice 2020 Visualization
Repository for project with important details.
### Data Origin 
The data sets were acquired via **[Kaggle](https://www.kaggle.com/datasets/mateusdmachado/csgo-professional-matches?resource=download)** 
(link to the initial data collectors profile **[here](https://www.kaggle.com/mateusdmachado)**). 

The intial set consisted of three different csv files; player data, results and, economy. This project utilized the player results, while used the results.csv win column for
dummy coding refrence.
### Important
If you down load this respo and run the r script or markdown, you MUST go to rawdata folder in main and docs and unzip the players.csv, the file is too large to add to github if not compressed.

The animated plot could not be added to either the PDF or the git.io due to LaTeX issues, the plot is located in the 'figs' folder, and is called 'anifig' 



### Codebook
**date** = date of tournament

**player_name** = name of the player

**team** = team which the player plays for

**opponent** = team which the player is playing **against**

**kast** = Kills, Assists, Survial and Trades, measured from 0-100%

**adr** = Average Damage per Round, how much damage the player deals to the other death, it is a continous variable.

**winner** = Was the match a win or a loss? 0 = win, 1 = loss

### Project Details
**Coded in R version 4.2.0**

**Packages Used**:
* gganimate 1.07
* gifski 1.6.6
* ggthemes 4.2.4
* here 1.0.1
* ggplot2 3.3.5
* knitr 1.39
* RColorBrewer 1.1-3
* tidyverse 1.3.1
* PNG  (version NA)
### Folder Structure
* data = contains filtered and cleaned data
* rawdata = 2 raw data sets from kaggle pre cleaning
* figs = 2 figures, one gganimation and one ggplot
* docs = files for the github.io page
* index_files/figure-html = files for the github.io page

