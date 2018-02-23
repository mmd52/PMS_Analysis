# Data Exploration
# Trial Script 2

#Author @ Mohammed 23/02/2018

# This script exists to see which variable plays an important role to predict 
#      total cost of distribution

#Load Libraries
source("Libraries.R")

#Load Data
dat<-read.csv("FinalPMSData.csv",header = T)
dat<-dat[,-1]

# Filtering only data needed
train<-dat[,c(1,2,7,8,9,10,11,12,13,14,45)]
View(head(train))

summary(train)

cor<-cor(train[,-c(1,2,11)])
cor.plot(cor)

cor(train$Total_Cost_of_Distribution,train$Sales_Transportation, method = "pearson")
# 0.8758262
cor(train$Total_Cost_of_Distribution,train$Packing, method = "pearson")
# 0.7144267
cor(train$Total_Cost_of_Distribution,train$Distribution_Activities, method = "pearson")
# 0.5354423
cor(train$Total_Cost_of_Distribution,train$Trading_Transportation, method = "pearson")
# 0.1711705
cor(train$Total_Cost_of_Distribution,train$Custom_Duties_Trading, method = "pearson")
# 0.1753613
cor(train$Total_Cost_of_Distribution,train$Warehouse_Rent, method = "pearson")
# 0.9391639
cor(train$Total_Cost_of_Distribution,train$Outbound_Logistics_Local_Branches, method = "pearson")
# 0.6562341

# Lets make a mini regression here to check importance
# PC Broke will have to be a bit more carefull
# model<-lm(Total_Cost_of_Distribution~.,data=train)
