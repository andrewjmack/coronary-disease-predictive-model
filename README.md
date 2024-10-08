# coronary-disease-predictive-model
Collaborators: Jack Runge, Eric Price, Jesse Joffray, Andrew Mack

## Table of Contents
1. [Overview](#overview)
2. [Repo Contents](#repo-contents)
3. [Exploratory Data Analysis](#exploratory-data-analysis)
4. [Feature Information](#feature-information)
5. [Data Cleaning](#data-cleaning)
6. [Model Results](#model-results)
7. [Conclusions](#conclusions)
8. [Resources](#resources)

## Overview
![Heart Disease](https://github.com/andrewjmack/coronary-disease-predictive-model/blob/main/resources/images/CHD.png "[1] Source: Heart Disease Facts, US Centers for Disease Control & Prevention")

Understanding the outsized impact of heart disease on health outcomes in the U.S., this project was an attempt to predict a patient's diagnosis of coronary heart disease ("CHD") using deep learning models as well as other classifiers. In addition, the features used for input in our models were investigated to determine which, if any, could have the most impact on occurences of heart disease. As a result, the goal was to both predict heart disease in patients and potentially deliver recommendations that healthcare professionals could give to their patients to mitigate their chances of developing heart disease.

## Repo Contents
- README.md
- Data_Cleaning.ipynb
- initial_EDA.ipynb
- model_optimization.ipynb
- resources holding our data files
    - various data files and SQLite database
    - resources/images folder of graphs and charts pertitent to the analysis
- model_tracking
    - folder containing model metrics and their iterative improvements
- initial_data holds all our trials for our hyperband tuner

![ETL & Modeling](https://github.com/andrewjmack/coronary-disease-predictive-model/blob/main/resources/images/ETL_modeling_flow.png "ETL & Modeling")

## Exploratory Data Analysis
One of the first things we noticed when exploring the data was that 172 patients had a cholesterol value of zero recorded in the data. Since this value is nonsensical for cholesterol, several methods to address this issue were implemented in the Data_Cleaning.ipynb notebook. 
> Ranges for total cholesterol in adults
    - Normal: Less than 200 mg/dL
    - Borderline high: 200 to 239 mg/dL
    - High: At or above 240 mg/dL
> 
In addition, we also noted that one patient had a resting blood pressure value of zero in the dataset so this was similarly addressed in the Data_Cleaning.ipynb notebook. 

We created a hyperband tuner using the keras tuner package in python to test a wide range of model parameters for our deep learning model. In addition, we wanted to compare how the models performed with different levels of data cleaning performed on our initial dataset. We started off with a small number of epochs (20) to give a rough picture of how each dataset impacted our model's performance. While the difference was small, the dataset in which we replaced the cholesterol values with the median value of the dataset performed the best, leading us to further optimize our model with that dataset in mind.

## Feature Information
1. Age: age of the patient [years]
2. Sex: sex of the patient [M: Male, F: Female]
3. ChestPainType: chest pain type [TA: Typical Angina, ATA: Atypical Angina, NAP: Non-Anginal Pain, ASY: Asymptomatic]
4. RestingBP: resting blood pressure [mm Hg]
5. Cholesterol: serum cholesterol [mm/dl]
6. FastingBS: fasting blood sugar [1: if FastingBS > 120 mg/dl, 0: otherwise]
7. RestingECG: resting electrocardiogram results [Normal: Normal, ST: having ST-T wave abnormality (T wave inversions and/or ST elevation or depression of > 0.05 mV), LVH: showing probable or definite left ventricular hypertrophy by Estes' criteria]
8. MaxHR: maximum heart rate achieved [Numeric value between 60 and 202]
9. ExerciseAngina: exercise-induced angina [Y: Yes, N: No]
10. Oldpeak: oldpeak = ST [Numeric value measured in depression]
11. ST_Slope: the slope of the peak exercise ST segment [Up: upsloping, Flat: flat, Down: downsloping]
12. HeartDisease: output class [1: heart disease, 0: Normal]

## Data Cleaning
To tackle the problem of zero values for cholesterol in our dataset, first we just removed all the rows with the faulty values and exported the dataset as heart_no_zeros.csv. Then, we analyzed the cholesterol variable for the remaining rows to investigate any trends. ![Box and Whisker Plot of Cholesterol](resources/images/box_whisker_cholesterol.png)

This plot reveals that the distribution of cholesterol is skewed to the right with several large outliers. This information led us to decide to replace the zero values in the dataset with the median cholesterol value. This methodology allowed us to maintain as much data as possible without throwing away valuable rows. 

## Model Optimization

### PHASE I
* This initial phase of testing was designed to run light hyperparameter tuner models (limited epochs, iterations and range of layers/neurons)
* The goal of these attempts was to determine which dataset would be the best to move forward with
* Each attempt ran 30 trials

![Attempt 1](resources/images/attempt_1_1.jpg)

#### Results
* Attempt 1 (original dataset, unaltered) - Accuracy: 87.83%, Loss: .3509
* Attempt 2 (patients with no cholesterol value dropped) - Accuracy: 87.70%, Loss: .3734
* Attempt 3 (cholesterol value replaced) – Accuracy: 88.26%, Loss: .3902

* Based on these results, we decided to move forward with the dataset using replaced cholesterol values

### PHASE II
* Goal of Phase II was to use sequential modeling to see if we could improve upon the initial hyperparameter tuner model (Attempt 3)
* Tried to maintain a “scientific” approach by changing one thing at a time
* Attempt 4 - Utilized “Best Model” output
* This model was created by attempting to mirror the optimal model that came out of our hyperparamter tuning attempt #3
* Utilized 6 hidden layers with the tanh activation function and a sigmoid output layer.

![Attempt 4_1](resources/images/attempt_4_1.jpg)

![Attempt 4_2](resources/images/attempt_4_2.jpg)

#### Attempt 4 (Base Model) - 86.96% accuracy, .5190 loss

* Attempts 5-8 use model 4 as a base model and control one aspect of model architecture at a time
Layers, Activation Functions, Number of Neurons and Epochs

#### Attempt 5 (Manipulating Layers) - 88.04% accuracy, .3711 loss
* Changing number of layers - 
* Adding additional layers can give the model additional capacity to capture intricate relationships within the data. Each layer can learn different levels of abstraction, and potentially improving accuracy. Additional layers can be highly beneficial in solving complex problems. Conversely, too many layers may lead to overfitting of the data to the training set. Though we are showing just one attempt at changing the number of layers, we did find that adding additional layers beyond what we show in attempt #4 lead to a decrease in accuracy. Here we reduced the number of layers to see if that creates higher accuracy within the test set; interestingly, accuracy increased by roughly 1%.

#### Attempt 6 (Increased Epochs) - 84.78% accuracy, .4190 loss
* Changed number of epochs, 20 to 80 - 
In attempt #6 we used the same base architecture as attempt 4 to isolate epochs and control the other variables.
Controlling those variables and keeping them the same would allows us to isolate the number of epochs and see if that would result in higher accuracy.
An increased number of epochs gives the model more opportunities to learn from the data and adjust weights, but too many may overfit the model to the training dataset.
As can be seen, increasing the number of epochs from 20 to 80 instead yielded a decrease in accuracy over attempt #4, and thus still unable to achieve the results of attempt #3 with the hyperparamter tuner.
#### Attempt 7 (More Activation Functions) - 84.78% accuracy, .4190 loss
* Changing activation functions:¶
* 1st hidden layer - tanh
* 2nd hidden layer - tanh
* 3rd hidden layer - relu
*  4th hidden layer - sigmoid
* 5th hidden layer - tanh
* 6th hidden layer - tanh
* output layer - sigmoid

* In attempt #7 we attempted to utilize different activation functions, such as relu and sigmoid in the hidden layers. This can affect how the model interprets and transforms the inputs. Different activation functions have different properties and can capture different types of non-linearities, that may better suit the problem at hand, potentially leading to increased accuracy. In this case, it did not yield a meaningful increase in accuracy over prior attempts, while loss of roughly .55 indicates increased prediction error in this model variation over prior attempted configurations.

#### Attempt 8 (More Neurons) - 86.41% accuracy, .5504 loss
* Changing the number of Neurons in each layer - 
With attempt #8, we looked at the effect of increasing the number of neurons. All other variables we kept the same as attempt #4 to isolate the change in results.
By increasing the number of neurons in a layer, the model can potentially capture more complex patterns in the data. This allows for better representation of the underlying relationships between the features and the target variable, potentially leading to higher accuracy.
An increase in neurons appears to have an affect in reducing the error, given the reduced loss over many previous attempts; however, accuracy remains roughly that of the prior attempts.

### Results: No increase in accuracy. 
**note - even through various attempts not recorded (there were many), overfitting was a consistent issue.

## PHASE III - More Robust Hyperparameter Attempts

* Attempts 9-10 (with several runs in each) focused on running more robust models with more epochs, a larger range of layers, initial neurons and iterations tested.
* Up to 200 epochs
* Upper limit of first layer neurons increased from 10 to 100
* Upper limit of layers increased from 6 to 10
* Up to 3 iterations vs 1
* Ran 508-762 trials with some run times over 1 hour!

 ### Attempts 9.1-9.4 done using dataset with replaced cholesterol values

![Attempt 9_1](resources/images/attempt_9_1.jpg)

![Attempt 9_2](resources/images/attempt_9_2.jpg)

#### Attempt 9.1 - 88.04% accuracy, .4489 loss, 508 trials, 26 mins 49 secs
#### Attempt 9.2- 88.59% accuracy, .3700 loss, 762 trials, 45 mins 24 secs
#### Attempt 9.3 - 88.04% accuracy, .8813 loss, 508 trials, 27 mins, 27 secs
#### Attempt 9.4 - 91.30% accuracy, 35.91% loss, 508 trials, 29 mins 36 secs
 

* As you can see Attempt 9.4 yielded the best model so far, resulting in 91.3% accuracy
**** We may want to look at the output here and comment on it. ****

## Attempt 10…

Our very first attempt at running any models was a more robust hyperparameter tuner model run on the original dataset which ran for over 30 minutes with no end in site. To the point that we actually had to stop it. It resulted in accuracy of about 91%
This guided us to our approach in attempts 1-3 to use a simple model for the sake of time.
After attempts 3-9.3 never reached that level of accuracy, we decided to use a similar model to attempts 9 on the original, unaltered dataset (attempt 10.1 came before attempt 9.4)

* Attempt 10.1: 92.93% accuracy: .4741 loss, 508 trials, 1 hour, 14 mins, 21 secs
* Attempt 10.1: 90.70% accuracy, 36.92% loss, 508 trials, 52 mins, 32 secs

Hypothesis: Perhaps somewhere in the 508 trials the tuner ran a model that either ignored or put less weight on cholesterol values, resulting in much higher accuracy. With more time, we would like to understand this better and determine if possibly dropping the cholesterol column altogether gets better results, which is counter intuitive.

![Attempts](https://github.com/andrewjmack/coronary-disease-predictive-model/blob/main/model_tracking/model_results_barchart.png "Attempts: Accuracy & Loss")


## Conclusions

#### What to do about cholesterol??:
* Our dataset included 918 patients and 172 (18.72%) were missing a cholesterol value.
* Of the 518 patients who had heart disease, 152 were part of the population missing the value (29.29%).
* Those 152 patients represented 88.37% of 172 patients with no cholesterol value.
* In summary, that’s a large percentage of the overall population and the population with heart disease, to create a more accurate model, we would recommend this value is prioritized and recorded for all patients moving forward.
* As far as further optimizing our model with the given dataset, though counterintuitive, we would possibly look at dropping this column entirely vs. trying to replace the value.

#### Size of the dataset
* 918 patients is not a particularly large dataset and a larger population would give any models that we created a better opportunity to both learn from the data (train) and test it’s accuracy.
* Data replacement or substitution methodologies such as k-means may be better able to account for missing values with a larger dataset.

#### More input values
* In researching the topic we found other datasets that included other variables of interest such as:
* Whether or not other health conditions were present (i.e. diabetes, asthma, etc.)
* Was the patient a smoker or tobacco user?
* Is the patient active or do they exercise regularly?
* Our dataset seemed to focus more specifically on certain health metrics, but additional data like this may create new insights.

#### Weighting or bucketing
* With more time or a better understanding of the outputs of our models, we may be able to assign different weights to certain variables and get the model to prioritize them more in training.
* Similarly, bucketing of certain numeric values may give the model a better ability to focus on key relationships and not get bogged down with processing a wide range of unique values.

#### A better understanding of hyperparameter tuning modeling and it’s outputs
* Though we did change some of the parameters of our hyperparameter tuners between phases I and III, a better understanding of how these tuners work and other methodologies we could use may yield better results, i.e. different optimizers or activation functions we might use, or how to better control steps and iterations.

### OVERALL CONCLUSION: 
* Though we were able to achieve over 90% accuracy (92.93% best result), in a medical context, we think this model would not be sufficient for practical use. 
* Of note, it did appear in our logistic regression and random forest data exploration that those tended to err more on the side of false positives, which is the favorable direction of false prediction in this case, but any amount of false negatives have life or death consequences. Ideally, we would like to create a model with at least 97-98% accuracy and that simply doesn’t appear to be possible with this dataset and it’s missing values. 


## Resources
- [1]: “Heart Disease Facts”, US Centers for Disease Control & Prevention (“CDC”), https://www.cdc.gov/heart-disease/data-research/facts-stats/index.html (August 6, 2024)
- Data source: https://www.kaggle.com/datasets/fedesoriano/heart-failure-prediction/data
- Related coronary medical study: https://pubmed.ncbi.nlm.nih.gov/2756873/
- Cholesterol guidance:
https://www.hopkinsmedicine.org/health/treatment-tests-and-therapies/lipid-panel#:~:text=Here%20are%20the%20ranges%20for,200%20to%20239%20mg%2FdL 
- Imputation best practices: https://www.simplilearn.com/data-imputation-article#:~:text=about%20Multiple%20Imputations.-,What%20Is%20Data%20Imputation%3F,from%20a%20dataset%20each%20time
- A Guide to any Classification Problem: https://www.kaggle.com/code/durgancegaur/a-guide-to-any-classification-problem 
