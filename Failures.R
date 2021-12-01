library(tidyverse)
library(here)
library(readxl)

tele <- read_csv("TelemetryConfig.csv") %>% 
    mutate(LoggerOS = as.factor(LoggerOS)) %>% 
    select(Site, LoggerOS) %>% 
    mutate(Well = Site, .keep = "unused") %>% 
    na.omit() %>% 
    arrange(Well) %>% 
    select(Well, LoggerOS)

fails <- read_xlsx(here("2021 WIPP PT Failures.xlsx")) %>% 
    select(Well) %>% 
    arrange(Well) %>% 
    group_by(Well) %>% 
    summarize(no_fails = n())

all_OS_fails <- inner_join(tele, fails) %>% 
    group_by(LoggerOS) %>% 
    summarize(no_fails = n())

