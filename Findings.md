# PMS

Regression understanding
  - Total cost of distribution plays a significant role to determine cost of goods sold
```
> cor(ndat$Cost_of_Goods_Sold_EURO,ndat$Total_Cost_of_Distribution, method = "pearson")
[1] 0.949001
> summary(modelSLR)

Call:
lm(formula = ndat$Cost_of_Goods_Sold_EURO ~ ndat$Total_Cost_of_Distribution)

Residuals:
    Min      1Q  Median      3Q     Max 
-902378   -1137    -684    -542 2386980 

Coefficients:
                                 Estimate Std. Error t value Pr(>|t|)    
(Intercept)                     522.20107  185.24717   2.819  0.00482 ** 
ndat$Total_Cost_of_Distribution  21.53751    0.03977 541.616  < 2e-16 ***
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 33230 on 32376 degrees of freedom
Multiple R-squared:  0.9006,	Adjusted R-squared:  0.9006 
F-statistic: 2.933e+05 on 1 and 32376 DF,  p-value: < 2.2e-16
```
  - similarly Total_Customer_Order_Management_Costs,Total_Operations_Costs is also extremely significant with cor value of 0.86 and significant coefficients upon doing regression
  - Customer related issue costs doesnt contribute at all 
 ```
> cor(ndat$Cost_of_Goods_Sold_EURO,ndat$Customer_related_Issues_Costs, method = "pearson")
[1] 0.3325234
```

#### Therefore running a regression with only these input values
###### Best model EVER!!!!
```
> mlr<-lm(Cost_of_Goods_Sold_EURO~Turnover_EURO
+         +Total_Cost_of_Distribution+
+         +Total_Operations_Costs+Product_Line+Product_Type,dat=ndat)
> summary(mlr)

Call:
lm(formula = Cost_of_Goods_Sold_EURO ~ Turnover_EURO + Total_Cost_of_Distribution + 
    +Total_Operations_Costs + Product_Line + Product_Type, data = ndat)

Residuals:
     Min       1Q   Median       3Q      Max 
-1120211       14      202      252   473633 

Coefficients: (1 not defined because of singularities)
                                               Estimate Std. Error t value Pr(>|t|)    
(Intercept)                                   4.896e+03  6.562e+03   0.746  0.45564    
Turnover_EURO                                 5.588e-01  1.753e-03 318.680  < 2e-16 ***
Total_Cost_of_Distribution                    2.498e+00  4.174e-02  59.848  < 2e-16 ***
Total_Operations_Costs                        8.295e-01  1.574e-02  52.703  < 2e-16 ***
Product_LineBuilding Materials               -1.866e+03  6.341e+03  -0.294  0.76855    
Product_LineCables                            2.024e+03  5.195e+03   0.390  0.69687    
Product_LineCables China                     -3.907e+03  5.409e+03  -0.722  0.47004    
Product_LineHigh-Tech Cables                  5.611e+03  5.677e+03   0.988  0.32297    
Product_LineMIVI                              9.817e+03  4.476e+03   2.193  0.02830 *  
Product_LinePlugs and Caps                    5.717e+03  4.395e+03   1.301  0.19334    
Product_LineProfiles                          5.204e+03  1.157e+04   0.450  0.65299    
Product_LineProfiles Trading                  6.002e+03  1.161e+04   0.517  0.60515    
Product_LinePull Cables                      -2.155e+03  6.707e+03  -0.321  0.74791    
Product_LinePull Cables China                -2.277e+04  6.970e+03  -3.267  0.00109 ** 
Product_LineResidual Springs                 -7.104e+03  6.573e+03  -1.081  0.27982    
Product_LineSprings                          -6.081e+03  6.563e+03  -0.927  0.35417    
Product_LineSprings China                    -1.009e+04  6.601e+03  -1.529  0.12639    
Product_LineSprings Trading                  -1.393e+03  6.555e+03  -0.213  0.83170    
Product_LineTP 821                            1.406e+04  6.375e+03   2.206  0.02740 *  
Product_LineTP 821-822                       -6.877e+04  7.282e+03  -9.443  < 2e-16 ***
Product_TypeAnti-Vibration Mounts             1.086e+04  2.615e+03   4.153 3.28e-05 ***
Product_TypeBasic Pads                        6.277e+03  8.451e+02   7.428 1.13e-13 ***
Product_TypeBumpers                           2.646e+03  6.343e+02   4.172 3.02e-05 ***
Product_TypeCable Entry Frames               -1.012e+04  6.676e+03  -1.515  0.12974    
Product_TypeCable Entry Systems              -9.935e+03  6.514e+03  -1.525  0.12720    
Product_TypeCable Glands                     -1.284e+04  6.631e+03  -1.937  0.05275 .  
Product_TypeCable Protectors                 -1.588e+04  8.985e+03  -1.768  0.07712 .  
Product_TypeCaps                             -1.131e+04  4.881e+03  -2.318  0.02048 *  
Product_TypeCasters                          -6.551e+03  1.002e+04  -0.654  0.51319    
Product_TypeClamping Levers                  -1.330e+04  7.322e+03  -1.817  0.06929 .  
Product_TypeConstruction Anti-Vibration Pads -9.969e+04  6.224e+03 -16.018  < 2e-16 ***
Product_TypeDampers                          -5.273e+03  1.384e+03  -3.809  0.00014 ***
Product_TypeFeedthroughs                     -7.275e+03  8.090e+03  -0.899  0.36853    
Product_TypeFeet                             -1.201e+04  6.530e+03  -1.840  0.06579 .  
Product_TypeGas Springs                       9.870e+01  4.350e+02   0.227  0.82050    
Product_TypeHandles                          -3.946e+03  7.415e+03  -0.532  0.59464    
Product_TypeHandwheels                       -9.552e+03  7.535e+03  -1.268  0.20493    
Product_TypeKnobs                            -4.588e+04  9.626e+03  -4.767 1.88e-06 ***
Product_TypeLevers                           -4.546e+03  7.593e+03  -0.599  0.54943    
Product_TypeMetal Profiles                   -1.062e+04  1.176e+04  -0.903  0.36672    
Product_TypeModular Structure Fittings       -1.173e+04  1.178e+04  -0.996  0.31927    
Product_TypeNot Defined                      -1.072e+04  5.018e+03  -2.136  0.03265 *  
Product_TypePlugs                            -7.913e+03  7.661e+03  -1.033  0.30166    
Product_TypePull Cables                              NA         NA      NA       NA    
Product_TypeRotary Dampers                    6.603e+02  1.943e+03   0.340  0.73401    
Product_TypeShock Dampers                     7.481e+02  4.052e+03   0.185  0.85350    
Product_TypeSpare Parts                      -1.087e+04  4.873e+03  -2.230  0.02577 *  
Product_TypeSpeed Control Dampers            -2.977e+03  9.688e+02  -3.073  0.00212 ** 
Product_TypeStops                             9.257e+04  3.879e+03  23.865  < 2e-16 ***
Product_TypeThrust Pads                      -3.168e+04  2.049e+03 -15.458  < 2e-16 ***
Product_TypeWheels                           -4.054e+03  6.660e+03  -0.609  0.54276    
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 10710 on 32328 degrees of freedom
Multiple R-squared:  0.9897,	Adjusted R-squared:  0.9897 
F-statistic: 6.34e+04 on 49 and 32328 DF,  p-value: < 2.2e-16
```

##### Important thought
```
> #=============================================================================
> # Now we know that these are the best cost drivers ! but we cannot determine a new customer
> # by how much he will cost
> # We know a knew customer by his geographical area
> dat$Geographical_Area<-as.factor(dat$Geographical_Area)
> summary(dat$Geographical_Area)
 APA  CEU  CIN  CSI  FRA  IAM  ITA  NAM  SAM  SCA  UKE 
1015 4919  127 1729 2493 1621 9156 5762 1498 1581 2477 
> 
> # We know a knew customer by class and by Turnoverrange
> dat$Customer_Class<-as.factor(dat$Customer_Class)
> summary(dat$Customer_Class)
Nationals    Others Strategic 
    12306     16917      3155 
> 
> dat$Turnover_Range_EURO<-as.factor(dat$Turnover_Range_EURO)
> summary(dat$Turnover_Range_EURO)
   a 0-20  b 20-100 c 100-250 d 250-500    e >500 Strategic 
     3173      4038      4476      4666     12870      3155 
> 
> # and the plant that will be closest to him (Assuming)
> dat$Plant<-as.factor(dat$Plant)
> summary(dat$Plant)
        Brasil          China            FRA            IND Northern Italy Southern Italy 
           912             56             49             18           6234           6187 
         Spain             UK            USA 
         12112           1937           4873 
> 
> mlr<-lm(Cost_of_Goods_Sold_EURO~Gross_Margin+Geographical_Area
+         +Customer_Class+Turnover_Range_EURO+Plant+Product_Line+Product_Type,dat=dat)
> summary(mlr)

Call:
lm(formula = Cost_of_Goods_Sold_EURO ~ Gross_Margin + Geographical_Area + 
    Customer_Class + Turnover_Range_EURO + Plant + Product_Line + 
    Product_Type, data = dat)

Residuals:
     Min       1Q   Median       3Q      Max 
-4223152     -845      514     1520  1981721 

Coefficients: (2 not defined because of singularities)
                                               Estimate Std. Error t value Pr(>|t|)    
(Intercept)                                   4.827e+04  2.203e+04   2.191 0.028450 *  
Gross_Margin                                  1.978e+00  4.462e-03 443.379  < 2e-16 ***
Geographical_AreaCEU                         -4.954e+02  1.310e+03  -0.378 0.705424    
Geographical_AreaCIN                         -5.782e+03  4.451e+03  -1.299 0.193973    
Geographical_AreaCSI                          2.392e+02  1.455e+03   0.164 0.869410    
Geographical_AreaFRA                         -5.424e+02  1.381e+03  -0.393 0.694545    
Geographical_AreaIAM                         -2.508e+02  1.463e+03  -0.171 0.863877    
Geographical_AreaITA                         -5.940e+02  1.205e+03  -0.493 0.622169    
Geographical_AreaNAM                         -7.938e+03  1.726e+03  -4.600 4.23e-06 ***
Geographical_AreaSAM                         -2.532e+03  1.893e+03  -1.337 0.181098    
Geographical_AreaSCA                         -8.174e+02  1.505e+03  -0.543 0.586973    
Geographical_AreaUKE                         -1.432e+03  1.947e+03  -0.735 0.462145    
Customer_ClassOthers                         -2.674e+02  4.908e+02  -0.545 0.585945    
Customer_ClassStrategic                       7.794e+03  1.043e+03   7.472 8.11e-14 ***
Turnover_Range_EUROb 20-100                  -1.002e+03  8.638e+02  -1.160 0.246239    
Turnover_Range_EUROc 100-250                 -1.023e+03  8.647e+02  -1.184 0.236604    
Turnover_Range_EUROd 250-500                 -5.935e+02  8.811e+02  -0.674 0.500580    
Turnover_Range_EUROe >500                    -8.808e+01  7.991e+02  -0.110 0.912234    
Turnover_Range_EUROStrategic                         NA         NA      NA       NA    
PlantChina                                    5.323e+03  7.357e+03   0.724 0.469349    
PlantFRA                                     -5.231e+02  7.214e+03  -0.073 0.942198    
PlantIND                                     -2.267e+03  1.284e+04  -0.176 0.859909    
PlantNorthern Italy                          -9.491e+02  2.000e+03  -0.474 0.635179    
PlantSouthern Italy                           3.288e+02  2.006e+03   0.164 0.869803    
PlantSpain                                   -1.091e+03  1.954e+03  -0.558 0.576671    
PlantUK                                      -4.794e+02  2.611e+03  -0.184 0.854356    
PlantUSA                                      2.695e+03  2.413e+03   1.117 0.264118    
Product_LineBuilding Materials               -2.438e+04  2.118e+04  -1.152 0.249530    
Product_LineCables                            1.862e+02  1.735e+04   0.011 0.991436    
Product_LineCables China                      1.226e+02  1.807e+04   0.007 0.994585    
Product_LineHigh-Tech Cables                  4.577e+03  2.017e+04   0.227 0.820491    
Product_LineMIVI                              1.139e+04  1.498e+04   0.760 0.447048    
Product_LinePlugs and Caps                    8.551e+02  1.468e+04   0.058 0.953562    
Product_LineProfiles                         -4.458e+03  3.865e+04  -0.115 0.908164    
Product_LineProfiles Trading                 -1.186e+03  3.876e+04  -0.031 0.975584    
Product_LinePull Cables                       5.739e+04  2.240e+04   2.562 0.010402 *  
Product_LinePull Cables China                -6.698e+02  2.375e+04  -0.028 0.977500    
Product_LineResidual Springs                 -4.837e+04  2.195e+04  -2.204 0.027538 *  
Product_LineSprings                          -4.740e+04  2.192e+04  -2.163 0.030585 *  
Product_LineSprings China                    -4.597e+04  2.204e+04  -2.085 0.037040 *  
Product_LineSprings Trading                  -3.392e+04  2.189e+04  -1.550 0.121199    
Product_LineTP 821                            2.239e+04  2.129e+04   1.051 0.293103    
Product_LineTP 821-822                       -6.264e+04  2.729e+04  -2.295 0.021732 *  
Product_TypeAnti-Vibration Mounts             4.390e+04  8.733e+03   5.027 5.01e-07 ***
Product_TypeBasic Pads                        2.085e+04  2.827e+03   7.375 1.68e-13 ***
Product_TypeBumpers                           8.336e+03  2.130e+03   3.914 9.11e-05 ***
Product_TypeCable Entry Frames               -5.402e+04  2.230e+04  -2.422 0.015426 *  
Product_TypeCable Entry Systems              -5.104e+04  2.175e+04  -2.347 0.018942 *  
Product_TypeCable Glands                     -6.290e+04  2.214e+04  -2.841 0.004503 ** 
Product_TypeCable Protectors                 -7.428e+04  3.001e+04  -2.475 0.013325 *  
Product_TypeCaps                             -4.812e+04  1.631e+04  -2.951 0.003170 ** 
Product_TypeCasters                          -4.721e+04  3.345e+04  -1.411 0.158173    
Product_TypeClamping Levers                  -5.285e+04  2.445e+04  -2.162 0.030628 *  
Product_TypeConstruction Anti-Vibration Pads -2.142e+05  2.079e+04 -10.302  < 2e-16 ***
Product_TypeDampers                          -5.959e+03  4.584e+03  -1.300 0.193670    
Product_TypeFeedthroughs                     -4.748e+04  2.701e+04  -1.758 0.078811 .  
Product_TypeFeet                             -4.923e+04  2.181e+04  -2.257 0.023995 *  
Product_TypeGas Springs                       7.877e+02  1.455e+03   0.541 0.588283    
Product_TypeHandles                          -2.353e+04  2.476e+04  -0.950 0.341894    
Product_TypeHandwheels                       -3.236e+04  2.516e+04  -1.286 0.198434    
Product_TypeKnobs                            -2.239e+04  3.214e+04  -0.697 0.485927    
Product_TypeLevers                           -2.298e+04  2.535e+04  -0.906 0.364681    
Product_TypeMetal Profiles                   -4.264e+04  3.927e+04  -1.086 0.277562    
Product_TypeModular Structure Fittings       -4.421e+04  3.932e+04  -1.124 0.260828    
Product_TypeNot Defined                      -4.754e+04  1.676e+04  -2.837 0.004560 ** 
Product_TypePlugs                            -4.742e+04  2.559e+04  -1.853 0.063903 .  
Product_TypePull Cables                              NA         NA      NA       NA    
Product_TypeRotary Dampers                    1.914e+03  6.501e+03   0.294 0.768426    
Product_TypeShock Dampers                    -4.197e+02  1.354e+04  -0.031 0.975265    
Product_TypeSpare Parts                      -4.787e+04  1.627e+04  -2.942 0.003265 ** 
Product_TypeSpeed Control Dampers            -1.068e+04  3.243e+03  -3.293 0.000992 ***
Product_TypeStops                             1.474e+05  1.227e+04  12.010  < 2e-16 ***
Product_TypeThrust Pads                      -1.396e+05  6.810e+03 -20.493  < 2e-16 ***
Product_TypeWheels                           -4.587e+04  2.225e+04  -2.061 0.039283 *  
---
Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1

Residual standard error: 35730 on 32306 degrees of freedom
Multiple R-squared:  0.8853,	Adjusted R-squared:  0.8851 
F-statistic:  3513 on 71 and 32306 DF,  p-value: < 2.2e-16

```


#### Time to meet our outlier customer
```
> ndat[ndat$Total_Cost_of_Distribution==max(ndat$Total_Cost_of_Distribution),]
      Material_Code Plant Customer_Code Quantity_units Turnover_EURO Cost_of_Goods_Sold_EURO
20132        AK8671 Spain         81517           7764      16820211                11498660
      Total_Cost_of_Distribution Total_Customer_Order_Management_Costs Customer_related_Issues_Costs
20132                     521379                                219164                       9052.02
      Total_Operations_Costs Product_Line Product_Type Number_of_Deliveries
20132                1169331  Pull Cables  Pull Cables                   65
      Average_Delivery_Batch_Size_units Customer_Class Turnover_Range_EURO Geographical_Area
20132                               119      Strategic           Strategic               CEU
      Gross_Margin Total_Overheads Operational_Profit
20132      5321551         1918926            3402625
```
