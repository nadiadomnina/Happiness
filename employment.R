

#load packages
library(dplyr)
library(tidyr)
library(ggplot2)
library(maps)
library(rworldmap)
library(plotly)
library(leaflet)
library(ggpmisc)

#NA
#load csv file
happy_df<- read.csv("data/happy_df.csv", stringsAsFactors = FALSE)
View(happy_df)

# Scatterplot of Unemployment vs. Happiness
ggplot(happy_df,aes(x = as.numeric(Unemployment....of.labour.force.), y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE))+
  geom_point(shape = 19, size = 5)+
  stat_smooth(method = "lm", col = "black")+
  theme_light()+
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  # scale_x_discrete("Unemployed Labor Force", seq(-100, 100, 50), seq(-100, 100, 50), c(-100, 100)) +
  labs(x = "Unemployed Labor Force", 
       y = "Happiness Score", 
       Title = "Unemployment Rate vs Happiness Score Scatterplot")

# Scatterplot of Employment in Agriculture vs. Happiness
ggplot(happy_df,aes(x = Employment..Agriculture....of.employed., y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE))+
  geom_point(shape = 19, size = 5)+
  stat_smooth(method = "lm", col = "black")+
  theme_light()+
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(x = "Employed in Agriculture", 
       y = "Happiness Score", 
       Title = "Agriculture Employment vs Happiness Score Scatterplot")

# Scatterplot of Employment in Industry vs. Happiness
ggplot(happy_df,aes(x = Employment..Industry....of.employed., y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE))+
  geom_point(shape = 19, size = 5)+
  stat_smooth(method = "lm", col = "black")+
  theme_light()+
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(x = "Employed in Industry", 
       y = "Happiness Score", 
       Title = "Industry Employment vs Happiness Score Scatterplot")

# Scatterplot of Employment in Srvices vs. Happiness
ggplot(happy_df,aes(x = Employment..Services....of.employed., y = Happiness.Score, color = Happiness.Rank, na.rm = TRUE))+
  geom_point(shape = 19, size = 5)+
  stat_smooth(method = "lm", col = "black")+
  theme_light()+
  scale_color_gradient("Happiness Rank", low = "limegreen", high = "black", na.value = "white") +
  labs(x = "Employed in Services", 
       y = "Happiness Score", 
       Title = "Services Employment vs Happiness Score Scatterplot")