setwd("~/Desktop/Gait_Analysis/GAIT_DATA_LARGE/month010/_spastin_RW2015_81023_month010_r01.cta.extracted")

library(stringr)

dat = data.frame(read.csv('data_1.csv'))

dat_num <- data.frame(str_sub(dat$labels, 17, 25) %>% str_squish)

colnames(dat_num) = 'Old_labels'

dat_num$New_labels = seq.int(nrow(dat_num))

write.csv(dat_num, "labels.csv", row.names=F)
