# Data Cleaning 
# 21/02/2018

# Loading all packages ============================================================
source("Libraries.R")

# Loading Data ============================================================
dat<-read.table(file.choose(),header = T,sep = ";")
View(head(dat))
sum(dat$Quantity..units.)
sum(dat$Turnover..EURO.)

summary(dat)

# Converting our NA's to 0 
dat[is.na(dat)] <- 0

# Making our categorical variables =====================================
dat$Plant<-as.factor(dat$Plant)
dat$Product.Line<-as.factor(dat$Product.Line)
dat$Product.Type<-as.factor(dat$Product.Type)
dat$Turnover.Range...000.EURO.<-as.factor(dat$Turnover.Range...000.EURO.)
dat$Geographical.Area<-as.factor(dat$Geographical.Area)

# Data cleaning complete
write.csv(dat,"FinalPMSData.csv")

# Gross Profit = revenues - cost of goods
# 