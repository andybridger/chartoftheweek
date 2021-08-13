################
#Chart of the week | World container index | week 33 (13 Aug 2021)
#Data from Drewry
################

#load libraries
library(tidyverse)
library(readabs)
library(readxl)
library(ggplot2)
library(aigtheme)
library(dplyr)
library(lubridate)

#load datasets
dw33 <- read_csv("2021/week33.csv")

#plot chart
ch_w33 <- ggplot(data=dw33, aes(x = date)) +
  geom_line(aes(y=rate),size = 1, color = "#1a698a", group = 1) +
  aig_style()+
  aig_y_continuous(limits=c(0,10000),breaks = seq(0,10000, by = 2000))+
  scale_x_date(limit=c(as.Date("2020-01-01"),as.Date("2021-09-01")),
               breaks = as.Date(c("2020-01-01", "2020-04-01", "2020-07-01",
                                  "2020-10-01", "2021-01-01", "2021-04-01",
                                  "2021-07-01")),
               date_labels = "%b-%Y")+
  labs(title = "Shipping rates have continued to increase in 2021",
       subtitle = "World container index, freight rate ($USD 40ft containers)",
       caption = "Note: The world container index is a weighted freight rate assessment of eight major east-west trade routes.")
ch_w33

#finalise plot function comes from the aigtheme
finalise_plot(plot_name = ch_w33,
              source = "Source: Drewry World Container Index",
              save_filepath = "/Users/andrewbridger/Desktop/R/chartoftheweek/2021/week33.png",
              width_pixels = 640,
              height_pixels = 450,
              logo_image_path = "/Users/andrewbridger/Desktop/R/chartoftheweek/aig_logo.png")
