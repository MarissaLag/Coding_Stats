#Week 1 Coding-Stats: 
#Normality ----

#Source: https://www.datanovia.com/en/lessons/normality-test-in-r/
#Also sourced from EcoStats notes at UVic

#Load packages

library(tidyverse)
library(ggpubr)
library(rstatix)

#set seed - what is it for?
set.seed(1234) #any random number (just has to be the same number every time)

#Look at data - this data is already loaded in R, we will practice loading your own data another time
ToothGrowth
#This is a built-in dataset in R that contains information 
#about the effect of vitamin C on tooth growth in guinea pigs.
#Len = length of tooth
#supp = supplment type
#dose = dose of VitC

#Don't like data name? Lets rename it

Data <- ToothGrowth

#mulitple ways to look at data or subset of data
Data #one way
head(Data) #another way
View(Data) #in a new window
Data[1, 3] #look at column 1 in row 3
Data[1:5, 1:2]  # Access the first 5 rows and first two columns

#Want to look at a certain column (by name) in the data?
Data$len

#I actually don't like the name "Data", lets change it back

ToothGrowth <- Data 

# This "%>%" is called a pipe
# Its where you perform a function on your data (here "sample_n_by") and on the other end of the pipe
#you'll get your new data!
#Lets see what this does

ToothGrowth %>% sample_n_by(supp, dose, size = 1)
#size = 1: one sample (one row) should be taken from each group defined by supp and dose.

#How did the data change?
#Look up "sample_n_by" in "help" tab

#Is the data normal??

# Density plot
ggdensity(ToothGrowth$len, fill = "lightgray")
#Bah, I can't see all of the density plot. Lets change the x axis limits

ggdensity(ToothGrowth$len, fill = "lightgray") + xlim(-5,45)
#better. Density plot is not a perfect bell curve, but looks okay. Lets see the
#another way to look at normality: Q-Q plots

# QQ plot
ggqqplot(ToothGrowth$len)
#Do the points approx follow the line? 

#Hmm, lets also test with the Shapiro wilk test

#Try a shapiro-wilk test
ToothGrowth %>% shapiro_test(len)

#Summary - data is normal 

#Lets say we want to test if dose and supp effect len
#We have 2 independent variables (categorical)
#And 1 dependent variable (continuous)
#So, we could use a 2-way ANOVA

#If we wanted to test ONLY dose or supp we would use a one-way ANOVA

#Oh no... ANOVAs have more assumptions
#Independence of observation
#Normality
#Outliers (not actually an assumption, but presence of outliers can make data non normal and other issues)


#Outliers ----
#Is a good sanitation check - 

#Equality of variances ----



