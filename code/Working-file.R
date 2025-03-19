## install if needed (do this exactly once):
## install.packages("usethis")

library(usethis)
use_git_config(user.name = "Sydney Russo", user.email = "Sydney.russo@my.jcu.edu.au")

usethis::use_github()
install.packages("tidyverse")
library(tidyverse)

mpg

####Creating my First Plot####
ggplot(data = mpg) + 
  geom_point(mapping = aes(x = displ, y = hwy, colour=class))
#this graph shows a negative relationship between engine size and fuel efficiency

#changing the appearance of the graph
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy), color = "blue")

#what happens if you map an aesthetic to something other than a variable name
ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y = hwy, colour = displ < 5))

####using Facet Wraps####
ggplot(data=mpg) + 
  geom_point(mapping =aes(x = displ, y = hwy)) +
  facet_wrap (~class, nrow = 2)

####using facet grids####
#this allows the facet to split by more than one variable

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, colour = class))+
  facet_grid(drv ~ cyl)

ggplot(data = mpg) + 
  geom_point(mapping = aes(x=displ, y=hwy, colour = class))+
  facet_grid(.~ cyl)

####Exercise:####
#what does nrow do? what does ncol do? what other options control the layout of the individual panels?
#nrow and ncol are the number or rows and columns that are present
#there are scales, shrinking (will shrink scales to fit output of statistics not raw data if true, if false it will be a range of raw data before statistical summary), switch function allows for the X and Y to switch to top, bottom, right or left. there are many more aswell.








             