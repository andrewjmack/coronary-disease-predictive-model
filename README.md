# coronary-disease-predictive-model

Team members: Jack Runge, Eric Price, Jesse Joffray, Andrew Mack

Project Description: This project is attempting to predict coronary heart disease using logistic regression to identify whether or not a patient is likely to have heart disease. In addition, PCA will be conducted in order to identify which parameters have the most impact on the outcome of heart disease. As a result, this project will be used to both predict heart disease in patients and give recommendations to healthcare professionals to give to their patients on how to mitigate their chance for heart disease. 

Resources:
Data Source: https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction/data
Medical Study: https://pubmed.ncbi.nlm.nih.gov/2756873/
Additional Resources:
https://www.kaggle.com/code/tanmay111999/heart-failure-prediction-cv-score-90-5-models
https://www.kaggle.com/code/durgancegaur/a-guide-to-any-classification-problem 

Task Roadmap:
Conduct EDA on dataset
Data cleaning
May need to consider imputation for some data
E.g., preponderance of zero Cholesterol values cannot simply be ignored or removed
Reference: https://www.simplilearn.com/data-imputation-article#:~:text=about%20Multiple%20Imputations.-,What%20Is%20Data%20Imputation%3F,from%20a%20dataset%20each%20time
Normalize or standardize data?
Normalization may be better for non-Gaussian distributed data
Address categorical (non-numerical) variables
Create SQLite database (?)
Requirement: “The model utilizes data retrieved from SQL or Spark (5 points)
SQLite could be locally run (wouldn’t need to create API endpoint, launch .py app each time, CORS, etc.) using with engine.connect():
Run PCA on data to determine which parameters explain the variability in the data the best
Develop a logistic regression machine learning model which predicts the outcome of heart disease 
Edit the model for different hyperparameters to optimize accuracy 
Make a presentation to convey findings


Potential Visualizations: Maybe visualize the factors that have the most impact on the outcome in a small bar chart
