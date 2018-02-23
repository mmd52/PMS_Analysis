# Data Exploration
# Trial Script 1

#Author @ Mohammed 23/02/2018

#Load Libraries
source("Libraries.R")

#Load Data
dat<-read.csv("FinalPMSData.csv",header = T)
dat<-dat[,-1]
summary(dat)
View(head(dat))
# Selecting only data we need 
train <- dat[,-c(3,8,9,10,11,12,13,14,16,17,18,19,20,21,22,24,25,26,28,29,30,31,32,33,34,35)]
View(head(train))

# confused about Boruta ?
# read it here - https://www.analyticsvidhya.com/blog/2016/03/select-important-variables-boruta-package/
# Word of advice do not run the code below if your machine has below 8 GB ran and no GPU
# Approx time to run Boruta - 1 hr 30 minutes

#Running Boruta on data as is
# Lets control randomness of shadows

set.seed(999)
boruta.train <- Boruta(Cost_of_Goods_Sold_EURO~., data = train, doTrace = 2)
print(boruta.train)
# ================================================================================
# Boruta performed 99 iterations in 1.899128 hours.
# 15 attributes confirmed important: Customer_related_Issues_Costs, Gross_Margin, N_Parts,
# Number_of_Deliveries, Operational_Profit and 10 more;
# 5 attributes confirmed unimportant: Average_Delivery_Batch_Size_units,
# Geographical_Area, Machinery_Minutes, Material_Code, Plant;
# 2 tentative attributes left: Assembly_Labour_Minutes, Customer_Class;
# ================================================================================
plot(boruta.train, xlab = "", xaxt = "n")
lz<-lapply(1:ncol(boruta.train$ImpHistory),function(i)
  boruta.train$ImpHistory[is.finite(boruta.train$ImpHistory[,i]),i])
names(lz) <- colnames(boruta.train$ImpHistory)
Labels <- sort(sapply(lz,median))
axis(side = 1,las=2,labels = names(Labels),
     at = 1:ncol(boruta.train$ImpHistory), cex.axis = 0.7)

final.boruta <- TentativeRoughFix(boruta.train)
print(final.boruta)


boruta.df <- attStats(final.boruta)
print(boruta.df)

write.csv(boruta.df,"BorutaResults.csv")

#According to Boruta 
# Material_Code                          Rejected
# Plant                                  Rejected
# Quantity_units                        Confirmed
# Turnover_EURO                         Confirmed
# Total_Cost_of_Distribution            Confirmed
# Total_Customer_Order_Management_Costs Confirmed
# Customer_related_Issues_Costs         Confirmed
# Total_Operations_Costs                Confirmed
# Product_Line                          Confirmed
# Product_Type                          Confirmed
# N_Parts                               Confirmed
# Assembly_Labour_Minutes               Confirmed
# Machinery_Minutes                      Rejected
# Number_of_Deliveries                  Confirmed
# Average_Delivery_Batch_Size_units      Rejected
# Customer_Class                         Rejected
# Turnover_Range_EURO                   Confirmed
# Geographical_Area                      Rejected
# Gross_Margin                          Confirmed
# Total_Overheads                       Confirmed
# Operational_Profit                    Confirmed
# ROS                                   Confirmed