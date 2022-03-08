
# Importing packages ------------------------------------------------------

library(tidyverse)
library(ggplot2)

# Reading csv file --------------------------------------------------------

stream_data = read.csv(file='streaming_data.csv')
summary(stream_data)
glimpse(stream_data)

# Converting date column to seperate year, month, date columns ------------


