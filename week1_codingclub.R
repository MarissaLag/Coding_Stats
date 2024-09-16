#Coding-Stats
#Marissa WL

#Resources
#statistics guide: https://learningstatisticswithr.com/book/ttest.html#onesamplettest
#Pirate's guide to R: https://bookdown.org/ndphillips/YaRrr/plotting1.html 


#Week 1 ----
#Note: Dashes to organize code
#Note: Use of hashes to write notes

#Making a GitHub account and accessing R scripts

#Downloading R: https://posit.co/download/rstudio-desktop/ 

#load packages
install.packages("ggResidpanel")
install.packages("ggplot2")
library(ggResidpanel)
library(ggplot2)


#Making a data matrix (a type of "object" in R)

# Create a vector of data
data_vector <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12)

# Create a 3x4 matrix
data_matrix <- matrix(data_vector, nrow = 3, ncol = 4)

rownames(data_matrix) <- c("Row1", "Row2", "Row3")
colnames(data_matrix) <- c("Col1", "Col2", "Col3", "Col4")

# Print the matrix - different methods for viewing an object
print(data_matrix)
data_matrix
View(data_matrix) #open in new window

#looking at the data structure 
str(data_matrix)
#After viewing object structure, what does "chr" mean? 

#load example data from R
#stored in R
data(mtcars)
head(mtcars)
str(mtcars)

#want to know what mtcars is about? Look it up in the "Help" tab. 

#rename your data, i.e., renaming an object
car_data <- mtcars

#check data structure
str(car_data)

#access a column within your data with the $ sign
car_data$mpg
#View another column, notice how R will autofill column name?

#We want to test how transmission type effects mpg
#1st, check data structure:
#Notice that transmission type (am) is listed as a "num" - we want to change that into a "factor"

car_data$am <- as.factor(car_data$am)
str(car_data) #now states that factor has 2 levels (0 and 1)

#lets view the data
plot(mpg ~ am, data = car_data)

#####Student's t-test ----
#To test effect of am on mpg (1 dependent and 1 independent variable) we could run a Student's t-test
#look up the function "t.test" in help finder

#Assumptions of a t-test:
#1. Normality - we need to check this.
#2. Independence of observation (determined by experimental design)

#Lets check for data normality - i.e., is mpg normally dist'd

#quick look at the data
hist(car_data$mpg)

#To determine normality, we first build a linear model (lm)
# Build the linear model
model  <- lm(mpg ~ am, data = car_data)
# Create a QQ plot of residuals
ggqqplot(residuals(model))
#another way to look at residuals distribution
resid_panel(model)

#Another way to determine normality - Shapiro-Wilk's test
#before testing, recall that shapiro-wilk is sensitive to sample size - so first lets count number of samples
nrow(car_data) #since samples are organized into rows, can count # of rows
#since low sample size (< 50) we can most likely use shapiro wilk test
shapiro_test(car_data$mpg)


#Given our residual plots and shapiro-wilk, is the data normal?

#Now, let's do the t-test:
#raw formula - input the variables yourself
t.test(formula = y ~ x,  
       data = df)

#What are the results? How would you report it in a paper?


####Plotting features - part I----
#My favorite part: Lets make a nice plot of our results: 
#Start with the plot basics:
ggboxplot(car_data, x = "am", y = "mpg") 
#Add colours?
ggboxplot(car_data, x = "am", y = "mpg", fill = "am",
          palette = c("red", "blue"))

#what a premade colour pallete - here's one.
install.packages("RColorBrewer")
library(RColorBrewer) #contains sseveral "sets" of colour palettes. 

ggboxplot(car_data, x = "am", y = "mpg", fill = "am",
          palette = "Set1") +  # Replace "Set1" with the palette of your choice
  theme_classic()

#Add a theme built in R?
ggboxplot(car_data, x = "am", y = "mpg", fill = "am",
          palette = "Set1") +
  theme_classic()

#remove the legend
ggboxplot(car_data, x = "am", y = "mpg", fill = "am",
          palette = "Set1") +
  theme_classic() +
  theme(legend.position = "none")

#Modify text in the figure
ggboxplot(car_data, x = "am", y = "mpg", fill = "am",
          palette = "Set1") +
  theme_classic() +
  theme(legend.position = "none") +
theme(axis.text.x = element_text(size = 13, face = "bold"),
      axis.title.x = element_text(size = 13, face = "bold"),
      axis.title.y = element_text(size = 13, face = "bold"),
      axis.text.y = element_text(size = 13, face = "bold"))

#Modify ylims
ggboxplot(car_data, x = "am", y = "mpg", fill = "am",
          palette = "Set1") +
  theme_classic() +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(size = 13, face = "bold"),
        axis.title.x = element_text(size = 13, face = "bold"),
        axis.title.y = element_text(size = 13, face = "bold"),
        axis.text.y = element_text(size = 13, face = "bold")) +
  ylim(5, 40)

#How to put statistical results on a fig? For t-test use stat_means
install.packages("ggpubr")
library(ggpubr)

ggboxplot(car_data, x = "am", y = "mpg", fill = "am",
          palette = "Set1") +
  theme_classic() +
  theme(legend.position = "none") +
  theme(axis.text.x = element_text(size = 13, face = "bold"),
        axis.title.x = element_text(size = 13, face = "bold"),
        axis.title.y = element_text(size = 13, face = "bold"),
        axis.text.y = element_text(size = 13, face = "bold")) +
  ylim(5, 40) +
  stat_compare_means(method = "t.test", label = "p.signif",
                     comparisons = list(c("0", "1")),
                     size = 8)

#Save your plot (e.g., use export function)
#More plotting features to come in future meetings!

####Variations of t tests----

#What if your data was not normal?
#Use the non-parametric test: 
#Wilcoxon (one sample) or Mann-Whitney (two samples) test (function: wilcox.test)
#Make sure to look up assumptions

#One-sided versus two-sided t test

#Paired t test? (use argument paired = TRUE (default is FALSE))


