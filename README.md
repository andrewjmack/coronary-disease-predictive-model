# coronary-disease-predictive-model
Collaborators: Jack Runge, Eric Price, Jesse Joffray, Andrew Mack

## Table of Contents
1. [Overview](#overview)
2. [Repo Contents](#repo-contents)
3. [Exploratory Data Analysis](#exploratory-data-analysis)
4. [Data Cleaning](#data-cleaning)
5. [Model Results](#model-results)
6. [Conclusions](#conclusions)
7. [Resources](#resources)

## Overview
This project is attempting to predict coronary heart disease using deep learning models as well as other classifiers to identify whether or not a patient is likely to have heart disease. In addition, the features used for in input in our models will be investigated to determine which, if any, have the most impact on the outcome of heart disease. As a result, this project will be used to both predict heart disease in patients and give recommendations to healthcare professionals to give to their patients on how to mitigate their chance for heart disease. 

## Repo Contents
- README.md
- Data_Cleaning.ipynb
- initial_EDA.ipynb
- model_optimization.ipynb
- resources

## Exploratory Data Analysis
One of the first things we noticed when exploring the data was that 172 patients had a cholesterol value of zero recorded in the data. Since this value is nonsensical for cholesterol, several methods to address this issue were implemented in the Data_Cleaning.ipynb notebook. 
> Ranges for total cholesterol in adults
    - Normal: Less than 200 mg/dL
    - Borderline high: 200 to 239 mg/dL
    - High: At or above 240 mg/dL
> 
In addition, we also noted that one patient had a resting blood pressure value of zero in the dataset so this was similarly addressed in the Data_Cleaning.ipynb notebook. 

We created a hyperband tuner using the keras tuner package in python to test a wide range of model parameters for our deep learning model. In addition, we wanted to compare how the models performed with different levels of data cleaning performed on our initial dataset. We started off with a small number of epochs (20) to give a rough picture of how each dataset impacted our model's performance. While the difference was small, the dataset in which we replaced the cholesterol values with the median value of the dataset performed the best, leading us to further optimize our model with that dataset in mind.


## Data Cleaning
To tackle the problem of zero values for cholesterol in our dataset, first we just removed all the rows with the faulty values and exported the dataset as heart_no_zeros.csv. Then, we analyzed the cholesterol variable for the remaining rows to investigate any trends. ![Box and Whisker Plot of Cholesterol](resources/images/box_whisker_cholesterol.png)

This plot reveals that the distribution of cholesterol is skewed to the right with several large outliers. This information led us to decide to replace the zero values in the dataset with the median cholesterol value. This methodology allowed us to maintain as much data as possible without throwing away valuable rows. 

## Model Results

I.) Basic summary of dataset and objectives
    a.) Overall objective
    b.) What are our variables
    b.) how did we explore discrepancies and how did we account for them
i.) i.e. Cholesterol values, touching on our analysis of mean/median and the possibility of using k-means
    c.) Maybe touch on our storage of data in SQLite here, since it’s not a main feature.
II.) Exploration of initial datasets (original, zeros dropped and zeros replaced) using hyperparamater tuner
    a.) I think this can be high level just to show that we were able to determine the csv with     
    Replaced values was the most effective.
III.) Touch on our attempts to utilize sequential models to have more control of model architecture.
    a.) Why did we choose to use certain activation functions in our initial attempt (because     
    It’s what hyperparameter model suggested…)
    b.) Maybe show how we chose to run it a few more times changing neurons, layers,     
    Activation functions, etc.
        ii.) Ultimately, even if this shows we weren’t able to get lift with this, we can
            Highlight that we explored it.
IV.) This section is either “nice to have” or “where does it fit”
    a.) PCA analysis
    b.) K-means
    c.) classification analysis
d.) Final Hyperparameter model - after concluding that sequential model wasn’t any better, do we take one more run at dialing in hyperparameter tuner?? I think keeping the hyperparameter examples simple in the early part of the project makes sense and serves it’s purpose to ask which dataset  is best(original, zeros dropped, zeros replaced). But maybe we want to circle back on one final model…

## Conclusions
    a.) which models worked based?
    b.) ST_Slope_Up and MaxHR were good negative indicators of heart disease. ST_Slope_Flat and Oldpeak were positive indicators of heart disease
    c.) bigger dataset would be better
    d.) more complete data on cholesterol would be better (show the percentage of patients
    Missing cholesterol values who did have heart disease… which was very high).
    e.) are there any other models we could try

## Resources
- Data source: https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction/data
- Related coronary medical study: https://pubmed.ncbi.nlm.nih.gov/2756873/
- [1]: Cholesterol guidance:
https://www.hopkinsmedicine.org/health/treatment-tests-and-therapies/lipid-panel#:~:text=Here%20are%20the%20ranges%20for,200%20to%20239%20mg%2FdL 
- Imputation best practices: https://www.simplilearn.com/data-imputation-article#:~:text=about%20Multiple%20Imputations.-,What%20Is%20Data%20Imputation%3F,from%20a%20dataset%20each%20time
- A Guide to any Classification Problem: https://www.kaggle.com/code/durgancegaur/a-guide-to-any-classification-problem 
