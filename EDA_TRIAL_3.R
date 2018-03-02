# Data Exploration Confirming if Unit cost prices make a difference
# Trial Script 3

#Author @ Mohammed 02/03/2018

#Load Libraries
source("Libraries.R")

#Load Data
dat<-read.csv("FinalPMSData.csv",header = T)
dat<-dat[,-1]
summary(dat)
View(head(dat))

# Selecting only data we need 
NameList <- c("Material_Code","Plant","Customer_Code","Quantity_units","Turnover_EURO",
              "Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution",
              "Total_Customer_Order_Management_Costs","Customer_related_Issues_Costs",
              "Total_Operations_Costs","Product_Line","Product_Type","N_Parts",
              "Number_of_Deliveries","Customer_Class","Turnover_Range_EURO","Geographical_Area",
              "Gross_Margin","Total_Overheads","Operational_Profit","Turnover_EURO_Unit",
              "Cost_of_Goods_Sold_EURO_Unit","Total_Cost_of_Distribution_Unit",
              "Total_Customer_Order_Management_Costs_Unit","Customer_related_Issues_Costs_Unit",
              "Total_Operations_Costs_Unit","Gross_Margin_Unit","Total_Overheads_Unit",
              "Operational_Profit_Unit")
idx <- match(NameList, names(dat))
idx <- sort(c(idx-1, idx))
train <- dat[,unique(idx)] 

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
# Boruta performed 99 iterations in 3.654824 hours.
# 18 attributes confirmed important: Cost_of_Goods_Sold_EURO.1,
# Customer_Order_Management_Local_Branches, Customer_related_Issues_Costs, Gross_Margin,
# Gross_Margin.1 and 13 more;
# 30 attributes confirmed unimportant: Average_Delivery_Batch_Size_units,
# Cost_of_Poor_Quality, Customer_Class, Customer_Class.1, Customer_Code and 25 more;
# 8 tentative attributes left: Cost_of_Goods_Sold_EURO_Unit,
# Cost_of_Goods_Sold_EURO_Unit.1, Manage_Foreign_Relationships, Product_Type,
# Product_Type.1 and 3 more;
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

write.csv(boruta.df,"BorutaResults_Unit.csv")

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