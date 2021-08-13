################
#Chart of the week | Australian export and import prices this century | week 31 (30 July 2021)
#Data from Australian Bureau of Statistics International Trade Price Indexes
################

#load libraries
library(tidyquant)
library(tidyverse)
library(readabs)
library(readxl)
library(ggplot2)
library(aigtheme)
library(dplyr)
library(lubridate)
library(zoo)

#export trade price index series id: A2294886K
#import trade price index series id: A2295765J
#load abs series id
d_trade_export <- read_abs(series_id = "A2294886K")
d_trade_import <- read_abs(series_id = "A2295765J")
d_trade_prices <- rbind(d_trade_export, d_trade_import)

#check to see if created
x<-unique(d_trade_prices$table_title)
x

#Index to March-2000
d_trade_prices <- d_trade_prices %>% group_by(table_title) %>% 
  mutate(index=(value/value[date=="2000-03-01"])*100) %>% ungroup()

#create chart
ch_trade_prices <- ggplot(data=d_trade_prices, aes(x = date, y = index, group = table_title, colour = table_title)) +
  geom_line(size = 1)+
  geom_hline(yintercept = 100, size=0.5, color = "black")+
  #note aig_style is from aigtheme which is the Ai Group theme I have created.
  aig_style()+
  aig_y_continuous(limits=c(50,300),breaks = seq(50,300, by = 50))+
  scale_color_manual(values = c("#1ab0d4","#1a698a"))+
  scale_x_date(limit=c(as.Date("2000-03-01"),as.Date("2021-06-01")),
               breaks = as.Date(c("2000-03-01", "2005-03-01",
                                  "2010-03-01","2015-03-01","2020-03-01")),
               date_labels = "%Y")+
  labs(title = "The prices Australia receives for its exports have increased\nsubstantially this century relative to the prices Australia pays\nfor its imports",
       subtitle = "Index 100 = Q1-2000") +
  geom_label(aes(x=as.Date("2018-06-15"), y=275, label = "Export price\nindex"),
             size = 5,
             lineheight = 1,
             label.size = NA,
             colour = "#1a698a",
             fill = NA)+
  geom_label(aes(x=as.Date("2018-06-15"), y=75, label = "Import price\nindex"),
             size = 5,
             lineheight = 1,
             label.size = NA,
             colour = "#1ab0d4",
             fill = NA)

#finalise plot function comes from the aigtheme
finalise_plot(plot_name = ch_trade_prices,
              source = "Source: Australian Bureau of Statistics",
              save_filepath = "/Users/andrewbridger/Desktop/R/chartoftheweek/2021/week31.png",
              width_pixels = 640,
              height_pixels = 450,
              logo_image_path = "/Users/andrewbridger/Desktop/R/chartoftheweek/aig_logo.png")


