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
dat$Total_Overheads <- dat$Total.Cost.of.Distribution + dat$Total.Customer...Order.Management.Costs + dat$Customer.related.Issues.Costs + dat$Total.Operations.Costs + dat$Transportations + dat$Manage.Orders.to.Suppliers + dat$Inbound.Logistics + dat$Inspect.goods + dat$Manage.Foreign.Relationships 

dat$Operational_Profit <- dat$Turnover..EURO. - dat$Cost.of.Goods.Sold..EURO. - dat$Total_Overheads

# ROS = op/revenues 

dat$ROS <- dat$Operational_Profit/dat$Turnover..EURO.

# Data cleaning complete ======================================================================
write.csv(dat,"FinalPMSData.csv")
