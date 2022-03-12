
# Importing packages ------------------------------------------------------

library(tidyverse)
library(ggplot2)
library(RColorBrewer)

# Reading csv file --------------------------------------------------------

stream_data = as_tibble(read.csv(file='streaming_data.csv'))
summary(stream_data)
glimpse(stream_data)

# Converting date column to seperate year, month, date columns ------------
stream_data <- stream_data %>%
  separate(endTime, sep='-', into=c('year', 'month', 'day')) %>%
  separate(day, sep=" ", into=c('day', 'time'))


View(stream_data)


# Plotting for one month --------------------------------------------------

stream_dist <- stream_data %>%
  filter(year=='2021' & month=='02')%>%
  group_by(artistName)%>%
  summarise(count = n())%>%
  arrange(desc(count))%>%
  slice(1:5)

stream_dist$fraction <- stream_dist$count/sum(stream_dist$count)
stream_dist$ymax = cumsum(stream_dist$fraction)
stream_dist$ymin = c(0, head(stream_dist$ymax, n=-1))
stream_dist$labelPosition <- (stream_dist$ymax + stream_dist$ymin) / 2
stream_dist$label <- paste0(stream_dist$artistName, "\n", stream_dist$count, "%")
cols <- brewer.pal(5, 'PRGn')

ggplot(stream_dist, aes(ymax=ymax, ymin=ymin, xmax=4, xmin=3, fill=artistName)) +
  geom_rect() +
  geom_label( x=3.5, aes(y=labelPosition, label=label), size=2) +
  scale_fill_brewer(type='seq', palette="Purples", direction = -1) + 
  coord_polar(theta="y") + # Try to remove that to understand how the chart is built initially
  xlim(c(2, 4)) +
  theme_void() +
  theme(legend.position = "none")

