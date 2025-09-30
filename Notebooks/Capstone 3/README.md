![Metaverse Fraud Image](/images/Metaverse%20Fraud.jpg)

# Metaverse Fraud Prediction

[View Documentation for Details](/Notebooks/Capstone%203/Capstone_Final_Report.pdf)

## Table of Contents
- [Introduction](#introduction)
- [Data](#data)
- [Method](#method)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
- [Machine Learning Models](#machine-learning-models)
- [Recommendations](#recommendations)
- [Future Improvements](#future-improvements)
- [Credits](#credits)

## Introduction

With the rapid growth of the Metaverse, financial transactions in virtual environments have increased significantly. However, this also introduces new avenues for fraudulent transactions. Unlike traditional banking systems, transactions in the Metaverse lack stringent regulatory frameworks, making them prone to fraud. This project aims to develop a predictive model that identifies and flags potential fraudulent transactions within the Metaverse.

The primary stakeholders are financial regulators within the Metaverse, virtual asset service providers, and end-users who engage in transactions within the Metaverse. Secondary stakeholders include researchers and developers working on digital security solutions.

## Data
Data was sourced from Metaverse platforms that record transaction details such as user IDs, transaction amounts, timestamps, and asset types. This data will be accessed through a Kaggle Dataset called "Metaverse Financial Transactions Dataset". 

- [Kaggle Metaverse Fraud Dataset](https://www.kaggle.com/datasets/faizaniftikharjanjua/metaverse-financial-transactions-dataset)

## Method
[Data Cleaning Report](/Notebooks/Capstone%203/01_Data_Wrangling.ipynb)

I utilized Python with libraries such as Pandas, NumPy, and Scikit-learn throughout the project. I conducted extensive data cleaning of the dataset before undertaking further analysis. I leveraged visualizations to identify potential outliers and feature correlations, generated statistical summaries, and uncovered the nature of distributions for each variable. I also engineered some critical features, and checked for missing values (there were none, due to it being a clean financial transactions dataset). 

**The solution focused on building a machine learning model that uses pattern recognition and anomaly detection techniques to identify irregular transaction behaviors that deviate from the norm**. The success of the project was measured by the model’s accuracy in identifying fraudulent transactions, capturing all the true fraud cases, and its adaptability to new, unknown types of fraud that may evolve as the Metaverse grows.

## Exploratory Data Analysis (EDA)
[EDA Report](/Notebooks/Capstone%203/02_Exploratory_Data_Analysis.ipynb)

I leveraged visualizations to identify potential outliers and feature correlations, generated statistical summaries, and uncovered the nature of distributions for each variable. I also uncovered some interesting patterns related to fraudsters' transaction tendencies. 

![Fraud by Purchase Pattern](/images/fraud_instances_by_purchase_pattern.png)

![Fraud By Age Group](/images/fraud_by_age_group.png)

After visualizing fraud instances by the various categories using bar plots, I found that there are no meaningful differences in fraud instances within any of the categorical variables, but with two big exceptions: Purchase Pattern and Age Group.    
- **Of the three purchase patterns, the only one with fraud is the random purchase pattern**. This indicates that the random purchase pattern may be more indicative of fraud than other types such as "high_value" or "focused". This makes sense for a few reasons: 
    - High value transactions involve significantly larger monetary amounts compared to the typical transactions, and thus could be more scrutinized for fraud as they represent larger financial risks.
    - The "focused" category could refer to transactions that consistently involve specific types of goods or services, or transactions that occur in a regular, predictable manner. This might indicate a customer with specific shopping habits or preferences, and predictability is less likely to be associated with fraud. 
    - "Random" transactions might show no clear pattern in terms of timing, amount, or the goods/services involved. This could be seen in sporadic purchases that are unpredictable, which might be flagged for further review since unpredictable transaction patterns can sometimes indicate fraudulent activity.
- **Of the three age groups, the only one with fraud is "new"**. This indicates that fraudsters are more likely to be new to the Metaverse based on their activity history, and unlikely to be established or veterans in the Metaverse. 

![Login Frequency by Fraud Status](/images/login_frequency_by_fraud_status_density_plot.png)

![Amount Per Login by Fraud Status](/images/amount_per_login_by_fraud_status_density_plot.png)

These two density plots yield some interesting insights: 
- **Login Frequency by Fraud Status**: The non-fraud distribution shows a pattern of smaller peaks at specific lower frequencies, likely indicating common login behaviors among users. The fraud distribution shows two clear peaks on the left, compared to the wider and more uniform distribution of non-fraud.
- **Amount Per Login by Fraud Status**: The non-fraud distribution shows a peak at a very low amount per login, suggesting regular users have many logins relative to the amount transacted (frequent but small transactions). The fraud distribution is much flatter with a lower peak, suggesting either larger amounts transacted per login or fewer logins for the amount transacted, which could be indicative of attempts to maximize the transaction value in fewer logins.
- **TAKEAWAY: Both density plots suggest fraudsters login less frequently (only 1-2 times) for higher average amounts per login compared to legitimate metaverse transactors**. 

## Machine Learning Models
[Preprocessing Report](/Notebooks/Capstone%203/03_Preprocessing_Training_Data.ipynb)

[ML Report](/Notebooks/Capstone%203/04_Modeling.ipynb)

I compared the performance of four different models to determine which one provided superior results. The models tested included Linear Regression, Random Forest, Gradient Boosting, and Support Vector Machine (SVM). I also performed cross-validation to evaluate how well a model is likely to perform on unseen data. 

**The model that best balanced precision and recall while minimizing false negatives was the Random Forest classifier with class weighting set to 'balanced' (10 feature set)**. Minimizing false negatives is essential in fraud prediction to ensure no fraudulent transactions slip through, and this model did the best job of this. 

[Model Metrics File](/Notebooks/Capstone%203/model_overview.csv)

![Feature Importances Image](/images/top_feature_importances_graph_fraud.png)

The feature importance analysis revealed that the five most important features for the model, by a wide margin, are: duration_per_login, amount_per_login, login_frequency, amount, and session_duration. 

This yields a few insights: 
- **Duration Per Login**: this is of prime importance since there tends to be a slightly higher duration per login for fraudulent transactions, indicating fraudsters take their time for enacting their criminal activities. 
- **Login Frequency and Session Duration**: It's unsurprising that both are among the top five most important features, since we discovered during EDA that both display moderate negative correlations with fraud. This implies that lower login frequencies as well as lower total session durations are associated with fraud. So fraudsters login less frequently, and thus their cumulative session durations are lower than average, but they have longer session times per each individual login (hence the importance of duration per login). 
- **Amount Per Login**: We discovered during our EDA section that Amount Per Login shows a moderate positive correlation with fraud, and we now see it as among the top two most important features. This indicates that larger but less frequent transactions are associated with fraudulent behavior. 

## Recommendations

Based on the modeling results and overall analysis, here are three concrete recommendations: 

1. **Implement Real-Time Monitoring**: Integrate the fraud prediction model into your transaction processing system to enable real-time fraud detection, allowing for immediate action on suspicious transactions, thereby reducing potential losses from delayed fraud identification.
2. **Continuous Model Updates**: Regularly update the fraud prediction model with new transaction data to adapt to evolving fraud patterns and techniques, ensuring that the model remains effective over time and reduces the incidence of both false positives and missed fraud cases.
3. **Enhanced Customer Verification Measures**: Based on insights from the model, especially from features heavily influencing fraud predictions, implement stronger verification processes for transactions identified as high-risk, such as two-factor authentication or manual reviews, to further safeguard against fraud.

## Future Improvements
1. **Feature Engineering**: Explore additional features or interactions that may improve the model's ability to discriminate between classes, which would ideally increase our currently low precision to allow for a greater balance between this and recall. 
2. **Alternative Algorithms**: Investigate other algorithms known for handling imbalanced data well, such as XGBoost or LightGBM, which might offer improvements in precision.
3. **Incremental Learning**: Consider models that support incremental learning, allowing the system to evolve as new data becomes available.
4. **Deployment Strategy**: Develop a deployment strategy that includes real-time analysis and the ability to retrain the model periodically with new transaction data.
5. **Cost-Benefit Analysis**: Perform a detailed cost-benefit analysis to better understand the implications of false positives versus false negatives, potentially adjusting the class weights or threshold accordingly.

## Credits
Thanks to my Springboard mentor Pizon Shetu for his continued help and boundless enthusiasm. 

