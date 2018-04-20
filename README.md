# PMS 3X
3X PMS is a Perfomance Measurmenet System project created by 6 students completing their Masters in Data Science at the Bologna Business School


* The topic for 3X PMS is Cost driver detection and prediction. 
* *The main business problem that is being solved here is how can we predict the Total cost helping the customer to determine whether he should accept the proposition from a client or not*
 
 The project members are
  - Mohammed Topiwalla
  - Sanchita Kumari
  - Luca Pedretti
  - Vallerio Trotta
  - Marco Lantermo
  - Guilia Capestro

* Powerpoint for the project is [here](https://github.com/mmd52/PMS_Analysis/blob/master/PMS%20Final%20Assignment.pdf)
* Regression output for the project is [here](https://github.com/mmd52/PMS_Analysis/blob/master/Regressions%20Output.pdf)

### PMS Analysis

*Note: 3X PMS project uses only R 3.4.X and Tableau 10.X and above for analysis and prediction*

#### Installation
```
install.packages("shinydashboard")
install.packages("Boruta")
install.packages("data.table")
install.packages("ggplot2")
```

#### Approach to solve the problem
* Understanding the data, the tableau result is [here](https://github.com/mmd52/PMS_Analysis/blob/master/PMS_TableauEda_Trial1_23_02_2018.pdf)
* Cleaning and preparing the data
* - Some of the cleaning was first done manually in excel - for instance removing rows with negative numbers
* - The pending cleaning was done in R. The code is [here](https://github.com/mmd52/PMS_Analysis/blob/master/DataCleaning.R)
* - *Note:* The code that loads all libraries is [here](https://github.com/mmd52/PMS_Analysis/blob/master/Libraries.R)
* Next step was to find the cost drivers, for which multiple techniques were used
* - [Boruta](https://github.com/mmd52/PMS_Analysis/blob/master/EDA_TRIAL_1.R) (Random forest featue selection technique). The reults of boruta are [here](https://github.com/mmd52/PMS_Analysis/blob/master/Boruta_Results.jpeg) 
* - [Checking correletarion among major cost drivers](https://github.com/mmd52/PMS_Analysis/blob/master/EDA_TRIAL_2.R)
* - [Boruta on unit costs](https://github.com/mmd52/PMS_Analysis/blob/master/EDA_TRIAL_3.R) . The results of boruta are [here](https://github.com/mmd52/PMS_Analysis/blob/master/Boruta_Unit.jpeg)
* -  To find the most imporatnt cost drivers we ran a few regressions. The code sits [here](https://github.com/mmd52/PMS_Analysis/blob/master/RegressionUnderstanding.R). The results are [here](https://github.com/mmd52/PMS_Analysis/blob/master/Findings.md)
* - Finally after running few other regressions, we understood our cost driver. The output is [here](https://github.com/mmd52/PMS_Analysis/blob/master/Regressions%20Output.pdf)
* Once we undertsood the cost drivers the next task was to be able to predict the total cost based on a few entered parameters.
* - To try it out go to [https://mohammedtopiwalla.shinyapps.io/PMS_Analysis/](https://mohammedtopiwalla.shinyapps.io/PMS_Analysis/)
* - upload the data from [here](https://github.com/mmd52/PMS_Analysis/blob/master/FinalPMSData.csv)
* - Enter the parameters you like and change them dynamically to see the reults change.
* - The code for Rshiny is [here](https://github.com/mmd52/PMS_Analysis/blob/master/Shiny_Framework.R)