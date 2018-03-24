#Author @ Mohammed 17/03/2017
#Code used to determine head feature importance

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
              "Total_Operations_Costs","Product_Line","Product_Type","Number_of_Deliveries",
              "Average_Delivery_Batch_Size_units","Customer_Class","Turnover_Range_EURO",
              "Geographical_Area","Gross_Margin","Total_Overheads","Operational_Profit")

ndat <- dat[,colnames(dat) %in% NameList] 

View(head(ndat))

# Awesome now that we have data lets see which variable is the most important

#=============================================================================
# Total_Cost_of_Distribution
plot(dat$Total_Cost_of_Distribution,ndat$Cost_of_Goods_Sold_EURO)
max(ndat$Cost_of_Goods_Sold_EURO)
max(ndat$Total_Cost_of_Distribution)
# This is quite interesting we have an interesting outlier here
ndat[ndat$Total_Cost_of_Distribution==max(ndat$Total_Cost_of_Distribution),]
# Is this our magical customer?
ndat[ndat$Cost_of_Goods_Sold_EURO==max(ndat$Cost_of_Goods_Sold_EURO),]
#Ok step 1 complete kind of linear relationship exists

cor(ndat$Cost_of_Goods_Sold_EURO,ndat$Total_Cost_of_Distribution, method = "pearson")
# Pearsons correlation approaches 1 (In this case its 0.9 which means there is a good 
#linear relationship)

modelSLR <- lm(ndat$Cost_of_Goods_Sold_EURO~ndat$Total_Cost_of_Distribution)
modelSLR
# equation
# Salary=22.81+(1.62*Experience)

summary(modelSLR)
# P value for coeffiecient and intercept is quite good as it is less than 0.05
# standard error for our coefficient is small which is a good sign. The intercepts value is good
# Residual standard error is low
# R squared is 0.9 which is fantastic
# Overall f statistic value of our model is significant as it is less than 0.05

# Conclusion Total cost of distribution is an awesome variable to contribute to cost


#=================================================================================================
# Total_Customer_Order_Management_Costs
plot(dat$Total_Customer_Order_Management_Costs,ndat$Cost_of_Goods_Sold_EURO)
#Ok step 1 complete kind of linear relationship exists

cor(ndat$Cost_of_Goods_Sold_EURO,ndat$Total_Customer_Order_Management_Costs, method = "pearson")
# Pearsons correlation approaches 1 (In this case its 0.86 which means there is a good 
#linear relationship)

modelSLR <- lm(ndat$Cost_of_Goods_Sold_EURO~ndat$Total_Customer_Order_Management_Costs)
modelSLR

summary(modelSLR)
# P value for coeffiecient and intercept is quite good as it is less than 0.05
# standard error for our coefficient is small which is a good sign. The intercepts value is good
# Residual standard error is low
# R squared is 0.7 which is fantastic
# Overall f statistic value of our model is significant as it is less than 0.05

# Conclusion Total_Customer_Order_Management_Costs is an good variable to contribute to cost
# However cost of distribution is still better

#=================================================================================================
# Customer_related_Issues_Costs
plot(dat$Customer_related_Issues_Costs,ndat$Cost_of_Goods_Sold_EURO)
#Ok step 1 complete kind of linear relationship exists

cor(ndat$Cost_of_Goods_Sold_EURO,ndat$Customer_related_Issues_Costs, method = "pearson")
# Pearsons correlation is 0.3 so no linear pattern
# Customer related issues cost doesnt add to predicting true costs



#=============================================================================
# Total_Operations_Costs
plot(dat$Total_Operations_Costs,ndat$Cost_of_Goods_Sold_EURO)

cor(ndat$Cost_of_Goods_Sold_EURO,ndat$Total_Operations_Costs, method = "pearson")
# Pearsons correlation approaches 1 (In this case its 0.9 which means there is a good 
#linear relationship)

modelSLR <- lm(ndat$Cost_of_Goods_Sold_EURO~ndat$Total_Operations_Costs)
modelSLR

summary(modelSLR)
# P value for coeffiecient and intercept is quite good as it is less than 0.05
# standard error for our coefficient is small which is a good sign. The intercepts value is good
# Residual standard error is low
# R squared is 0.8 which is fantastic
# Overall f statistic value of our model is significant as it is less than 0.05

# Conclusion Total_Operations_Costs is an awesome variable to contribute to cost



# Lets try with a general model and see which additional variables make sense!
mlr<-lm(Cost_of_Goods_Sold_EURO~Turnover_EURO
        +Total_Cost_of_Distribution+
        +Total_Operations_Costs+Product_Line+Product_Type,dat=ndat)

summary(mlr)


aggregate(dat$Turnover_EURO, by=list(Category=dat$Product_Line), FUN=mean)

#=============================================================================
# Now we know that these are the best cost drivers ! but we cannot determine a new customer
# by how much he will cost
# We know a knew customer by his geographical area
dat$Geographical_Area<-as.factor(dat$Geographical_Area)
summary(dat$Geographical_Area)

# We know a knew customer by class and by Turnoverrange
dat$Customer_Class<-as.factor(dat$Customer_Class)
summary(dat$Customer_Class)

dat$Turnover_Range_EURO<-as.factor(dat$Turnover_Range_EURO)
summary(dat$Turnover_Range_EURO)

# and the plant that will be closest to him (Assuming)
dat$Plant<-as.factor(dat$Plant)
summary(dat$Plant)

#### Can I use this for modeling -> Yes!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!1
mlr<-lm(Cost_of_Goods_Sold_EURO~Gross_Margin+Geographical_Area
        +Customer_Class+Turnover_Range_EURO+Plant+Product_Line+Product_Type,dat=dat)
summary(mlr)

save(mlr, file = "FinalPredModel.rda")
load("FinalPredModel.rda")

mlr<-lm(Cost_of_Goods_Sold_EURO~Gross_Margin+Geographical_Area
        +Customer_Class+Turnover_Range_EURO+Plant+Product_Line+Product_Type,dat=dat)
summary(mlr)
a<-predict(mlr,newdata=data.frame(Gross_Margin=474,
                               Geographical_Area="FRA",Customer_Class="Strategic",Turnover_Range_EURO="Strategic",Plant="Northern Italy",Product_Line="Plugs and Caps",Product_Type="Spare Parts"))
toString(a)
