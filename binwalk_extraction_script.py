%% To crack open a proprietary file format using Binwalk

First install binwalk off github and required python packages

binwalk -E -J IC_19_01_260886_week006_r01.cta
binwalk -e IC_19_01_260886_week006_r01.cta

binwalk -e IC_19_01_260886_week006_r01.ctw | wc -l
binwalk -D='.*' IC_19_01_260886_week006_r01.ctw




## ON PC ---Batch extraction first step

#find /Users/valfred/Desktop/Gait_Analysis/GAIT_DATA_LARGE/WT/* -maxdepth 1 -type f -exec binwalk -e option {} \; > results.out
shopt -s nullglob
for file in /Users/valfred/Desktop/Gait_Analysis/GAIT_DATA_LARGE/WT/*
do
 binwalk -e "$file" >> results1.out
done
shopt -u nullglob #revert nullglob back to it's normal default state

# move all the ctw files to new folder and batch extract them again
mkdir CTW_files
mv **/*.ctw /Users/valfred/Desktop/Gait_Analysis/GAIT_DATA_LARGE/WT/CTW_files

# extract CTW files now
cd CTW_files/

shopt -s nullglob
for file in /Users/valfred/Desktop/Gait_Analysis/GAIT_DATA_LARGE/WT/CTW_files/*
do
 binwalk -D='.*' "$file" >> results2.out
done
shopt -u nullglob




## Extraction performed on external hard drive due to file size
# FOR WILD TYPE

cd /Volumes/Victor_Data/GAIT_DATA_LARGE/WT


for file in /Volumes/Victor_Data/GAIT_DATA_LARGE/WT/*
do
 binwalk -e "$file" >> results1.out
done


mkdir CTW_files
mv **/*.ctw /Volumes/Victor_Data/GAIT_DATA_LARGE/WT/CTW_files

cd CTW_files/
ls

for file in /Volumes/Victor_Data/GAIT_DATA_LARGE/WT/CTW_files/*
do
 binwalk -D='.*' "$file" >> results2.out
done


# FOR MUTANT

cd /Volumes/Victor_Data/GAIT_DATA_LARGE/MUT


for file in /Volumes/Victor_Data/GAIT_DATA_LARGE/MUT/*
do
 binwalk -e "$file" >> results1.out
done

mkdir CTW_files
mv **/*.ctw /Volumes/Victor_Data/GAIT_DATA_LARGE/MUT/CTW_files

cd CTW_files/
ls

for file in /Volumes/Victor_Data/GAIT_DATA_LARGE/MUT/CTW_files/*
do
 binwalk -D='.*' "$file" >> results2.out
done






> dat_num <- data.frame(readr::parse_number(as.character(dat$labels)))
> View(dat_num)
> colnames(dat_num) = 'labels_num'
> dat_num$new_lab = seq(1, length(dat_num), by=1 )
dat_num$new_lab = seq.int(nrow(dat_num))


str_sub("5233          0x1471          JPEG image data, JFIF standard 1.01", 17, 25) %>% str_squish

id_nums <- str_replace(ids, "ID#: ", "")

str_squish("1471   ")
str_trim("1471   ")



"13048732      0xC71B9C        JPEG image data, JFIF standard 1.01"

# pipe the output to str_squish

str_sub("5233          0x1471          JPEG image data, JFIF standard 1.01", 17, 25) %>% str_squish


library(stringr)
dat_num <- data.frame(str_sub(dat$labels, 17, 25) %>% str_squish)
colnames(dat_num) = 'labels_num'
> dat_num$new_lab = seq.int(nrow(dat_num))
> write.csv(dat_num, "labels.csv")


# USE THIS FOR THE ANALYSIS
setwd("~/Desktop/Gait_Analysis/GAIT_DATA_LARGE/month010/_spastin_RW2015_81023_month010_r01.cta.extracted")
library(stringr)
dat = data.frame(read.csv('data_1.csv'))
dat_num <- data.frame(str_sub(dat$labels, 17, 25) %>% str_squish)
colnames(dat_num) = 'Old_labels'
dat_num$New_labels = seq.int(nrow(dat_num))
write.csv(dat_num, "labels.csv", row.names=F)




import os
import csv

with open('jpeg_labels_new.csv') as f:
    lines = csv.reader(f)
    for line in lines:
        os.rename(line[0], line[1])


import os
import csv

with open('jpeg_labels_new.csv', 'rb') as csvfile:
    csvreader = csv.reader(csvfile, delimiter=',', quotechar='"')
    for row in csvreader:
        name = row[0]
        new = row[1]
        if os.path.exists(name):
            os.rename(name, new)
        else:
            print name + " does not exist"


sed 's/"//g' jpeg_labels_new.csv | while IFS=, read orig new; do echo mv "$orig" "$new"; done 
sed 's/"//g' jpeg_labels_new.csv | while IFS=, read orig new; do echo mv "$new" "$orig" ; done
sed 's/"//g' jpeg_labels_new.csv | while IFS=, read orig new; do echo mv "$orig" "$new"; done 

sed 's/^@//.$//' jpeg_labels_new.csv | while IFS=, read orig new; do mv "$new" "$orig"; done 
sed 'sed/.$//' jpeg_labels_new.csv

perl -pi -e 's/\r\n/\n/;' jpeg_labels_new.csv
