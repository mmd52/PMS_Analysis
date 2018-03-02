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

# Start Feature Engineering =============================================

# Contribution Margin/Gross profit = revenues - cost of goods
dat$Gross_Margin <- dat$Turnover..EURO.- dat$Cost.of.Goods.Sold..EURO.

# operational Profit = revenues - TC (Overheads included)
dat$Total_Overheads <- dat$Total.Cost.of.Distribution + dat$Total.Customer...Order.Management.Costs + dat$Customer.related.Issues.Costs + dat$Total.Operations.Costs 

# Deleted portion
###### dat$Transportations  + dat$Manage.Orders.to.Suppliers + dat$Inbound.Logistics + dat$Inspect.goods + dat$Manage.Foreign.Relationships

dat$Operational_Profit <- dat$Turnover..EURO. - dat$Cost.of.Goods.Sold..EURO. - dat$Total_Overheads

# ROS = op/revenues 

#dat$ROS <- dat$Operational_Profit/dat$Turnover..EURO.

# Renaming few columns
names(dat)<-c("Material_Code","Plant","Customer_Code","Quantity_units","Turnover_EURO","Cost_of_Goods_Sold_EURO","Total_Cost_of_Distribution","Sales_Transportation","Packing","Distribution_Activities","Trading_Transportation","Custom_Duties_Trading","Warehouse_Rent","Outbound_Logistics_Local_Branches","Total_Customer_Order_Management_Costs","Sales_Comissions","Sales_Development","Offer_Development","Order_Management","Customer_Service","Manage_Account_Receivables","Customer_Order_Management_Local_Branches","Customer_related_Issues_Costs","Rebate","Bad_Debt","Cost_of_Poor_Quality","Total_Operations_Costs","Manufacturing_Costs","Internal_Logistics_Costs","Supply_Chain_Management_Costs","Transportations","Manage_Orders_to_Suppliers","Inbound_Logistics","Inspect_goods","Manage_Foreign_Relationships","Product_Line","Product_Type","N_Parts","Assembly_Labour_Minutes","Machinery_Minutes","Number_of_Deliveries","Average_Delivery_Batch_Size_units","Customer_Class","Turnover_Range_EURO","Geographical_Area","Gross_Margin","Total_Overheads","Operational_Profit")
              #"ROS")

# Data cleaning complete ======================================================================
View(head(dat))
summary(dat)

# There is some problem with assembly labour minutes and machinery minutes
dat$Assembly_Labour_Minutes<-as.numeric(dat$Assembly_Labour_Minutes)
dat$Machinery_Minutes<-as.numeric(dat$Machinery_Minutes)
dat[is.na(dat)] <- 0
summary(dat)

write.csv(dat,"FinalPMSData.csv")

# Script update 02/03/2018
# Now adding the unit prices everywhere
dat$Turnover_EURO_Unit<-dat$Turnover_EURO/dat$Quantity_units

dat$Cost_of_Goods_Sold_EURO_Unit<-dat$Cost_of_Goods_Sold_EURO/dat$Quantity_units

dat$Total_Cost_of_Distribution_Unit<-dat$Total_Cost_of_Distribution/dat$Quantity_units

dat$Total_Customer_Order_Management_Costs_Unit<-dat$Total_Customer_Order_Management_Costs/dat$Quantity_units

dat$Customer_related_Issues_Costs_Unit<-dat$Customer_related_Issues_Costs/dat$Quantity_units

dat$Total_Operations_Costs_Unit<-dat$Total_Operations_Costs/dat$Quantity_units

dat$Gross_Margin_Unit<-dat$Gross_Margin/dat$Quantity_units

dat$Total_Overheads_Unit<-dat$Total_Overheads/dat$Quantity_units

dat$Operational_Profit_Unit<-dat$Operational_Profit/dat$Quantity_units

write.csv(dat,"FinalPMS_UnitINC_Data.csv")