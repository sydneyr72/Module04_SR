## install if needed (do this exactly once):
## install.packages("usethis")

library(usethis)
use_git_config(user.name = "Sydney Russo", user.email = "Sydney.russo@my.jcu.edu.au")

usethis::use_github()
install.packages("tidyverse")
library(tidyverse)
library(dplyr)

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


####Fitting Lines####
ggplot(data = mpg) +
  geom_smooth(mapping = aes (x=displ, y=hwy))

ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy))+
  geom_smooth(mapping = aes(x=displ, y=hwy, linetype = drv))

#setting the group aesthetic
ggplot(data = mpg)+
  geom_smooth(mapping=aes(x=displ, y=hwy, group=drv))

#changing the colour
ggplot(data=mpg)+
  geom_smooth(
    mapping = aes(x = displ, y = hwy, color = drv),
    show.legend=FALSE)

#mapping multiple geoms on one plot
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy))+
  geom_smooth(mapping = aes(x = displ, y = hwy))

#an easier way to do above if I wanted to change anything
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth()

#adding colors
ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point(mapping = aes(color=class))+
  geom_smooth(data = filter (mpg, class =="subcompact"), se =FALSE)

####Excercise####
#1. line: geom_line  , Boxplot:geom_boxplot  , Histogram: geom_histogram, an area chart: geom_area
#2. I predict that the graphs will all look different becuase they are asking for the data to be laid out in different forms.
ggplot(data = mpg, mapping = aes(x=displ, y=hwy))+
  geom_line()
ggplot(data = mpg, mapping = aes(x=displ, y=hwy))+
  geom_boxplot()
#3. I would assume that these two graphs are saying the same thing just in 2 different ways. and yes they are the same.

ggplot(data = mpg, mapping = aes(x = displ, y = hwy))+
  geom_point()+
  geom_smooth()
ggplot(data = mpg)+
  geom_point(mapping = aes(x = displ, y = hwy))+
  geom_smooth(mapping = aes(x = displ, y = hwy))

####plotting statistics####
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x =cut))

####overriding defaults in ggplot####


ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, y = freq), stat = "identity")

diamonds
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, y = stat(prop), group = 1))

####plotting statistical details####
ggplot(data=diamonds)+
  stat_summary(
    mapping =aes(x = cut, y = depth),
    fun.min = min,
    fun.max = max,
    fun = median
  )

#making it pretty
ggplot(data = diamonds) +
  geom_bar(mapping = aes(x = cut, colour = cut))
ggplot(data = diamonds)+
  geom_bar(mapping = aes (x = cut, fill = cut))
ggplot(data=diamonds)+
  geom_bar(mapping = aes(x=cut, fill = clarity))

#altering transparency
ggplot(data=diamonds, mapping = aes(x=cut, fill=clarity))+
  geom_bar(alpha=1/5, position = "identity")

#to color the bar outlines with no fill color
ggplot(data=diamonds, mapping = aes(x=cut, color=clarity))+
  geom_bar(fill=NA, position = "identity")

ggplot(data=diamonds, mapping = aes(x=cut, color=clarity))+
  geom_bar(fill=NA, position = "fill")


ggplot(data=diamonds, mapping = aes(x=cut, color=clarity))+
  geom_bar(fill=NA, position = "dodge")


ggplot(data=diamonds, mapping = aes(x=cut, color=clarity))+
  geom_bar(fill=NA, position = "jitter")


####Workshop 2####

####labels####
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color=class))+
  geom_smooth(se.e = FALSE)+
  labs(title = "Fuel efficiency generally decreases with engine size")
#subtitle adds additional detail in a smaller font beneath the title and caption adds text at the bottom right of the plot
#caption adds text at the bottom right of the plot, often used to describe the source of the data

ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color=class))+
  geom_smooth(se.e = FALSE)+
  labs(title = "Fuel efficiency generally decreases with engine size",
       subtitle = "Two seaters (sports cars) are an exception becuse of their light weight",
       caption = "Data from Feuleconomy.gov")

#you can also use labs to change the labels on the axis and legend titles         
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color=class))+
  geom_smooth(se.e = FALSE)+
  labs(
    x = "Engine displacement (L)",
    y = "Highway fueleconomy (mpg)",
    colour = "car type"
  )

####Annotations####
best_in_class <- mpg |>
  group_by(class) |>
  filter(row_number(desc(hwy))==1)

ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color=class))+
  geom_text(aes(label = model), data = best_in_class)

####Scales####
ggplot(mpg, aes(displ, hwy))+
  geom_point(aes(color = class))+
  scale_x_continuous()+
  scale_y_continuous()+
  scale_color_discrete()

####Axis ticks####
ggplot(mpg, aes(displ, hwy))+
  geom_point()+
  scale_y_continuous(breaks = seq(15,40, by = 5))

ggplot(mpg, aes(displ, hwy))+
  geom_point()+
  scale_x_continuous(labels = NULL)+
  scale_y_continuous(lables = NULL)
##NEED TO FIGURE OUT WHAT IS WRONG WITH THIS

####legends and color schemes####
base <- ggplot (mpg, aes(displ, hwy))+
  geom_point(aes(color=class))
base + theme(legand.position ="left")
base+theme(legand.position = "top")





