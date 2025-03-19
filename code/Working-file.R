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
  geom_point(mapping = aes(x = displ, y = hwy))
#this graph shows a negative relationship between engine size and fuel efficiency

