![Educational Inequality Image](Springboard-Data-Science/images/Educational Inequality Image.jpeg)

[View My Documentation for Detailed Info](https://docs.google.com/document/d/1tW2wNHsFHK8ZcgCYrttsSH-ExfGHWyXeZo-rgyxbkmA/edit)

# Student Success Prediction

## Table of Contents
- [Introduction](#introduction)
- [Data](#data)
- [Method](#method)
- [Exploratory Data Analysis (EDA)](#exploratory-data-analysis-eda)
- [Machine Learning Models](#machine-learning-models)
- [Predictions](#predictions)
- [Recommendations](#recommendations)
- [Future Improvements](#future-improvements)
- [Credits](#credits)

## Introduction
Educational inequities persist across various school districts in Texas, potentially impacting student academic performance and long-term success. My aim was to examine the relationship between various educational variables and student academic performance in Texas as measured by standardized test scores. By leveraging detailed financial, attendance, and academic data from the Texas Education Agency (TEA) and other sources, the project seeks to identify patterns and correlations that could inform policy decisions and interventions aimed at reducing educational disparities. 

The findings of this study will be of interest to a broad range of stakeholders, including educational policymakers, college admissions offices, school district administrators, teachers, parents, and students. It will particularly benefit decision-makers within the TEA and local educational authorities who are responsible for allocating resources and designing strategies to improve educational equity and outcomes across Texas.

## Data
The datasets for this project are drawn from a few sources such as the U.S. Census Bureau and WalletHub, but they're primarily sourced from the TEA. The TEA provides comprehensive records on school district funding, student attendance rates, and various academic performance indicators. I gathered data from 2018-2022 and analyzed on a per-school district basis. The analysis will incorporate several features, including but not limited to, funding per student, attendance rates, socioeconomic levels, teacher expertise, and student-to-teacher ratios.

- [Texas Education Agency (TEA) Datasets](https://tea.texas.gov/reports-and-data)
- [U.S. Census Bureau](https://www.census.gov/data/datasets/2022/demo/saipe/2022-school-districts.html)
- [WalletHub](https://wallethub.com/edu/e/most-least-equitable-school-districts-in-texas/77134)

## Method
[Data Cleaning Report](Notebooks/Capstone 2/01_Data_Wrangling - Student Success Prediction.ipynb)

I utilized Python with libraries such as Pandas, NumPy, and Scikit-learn throughout the project. I conducted extensive data cleaning of ten individual datasets before joining them together for further analysis. I also engineered some critical features, removed missing values, and imputed the missing median income values using the year-to-year percentage changes for the state median income. 

**The goal was to build a regression model capable of predicting standardized test scores** on a per-school district basis for the state of Texas using key educational variables, with the hope of spurring policy changes to improve educational equity. 

## Exploratory Data Analysis (EDA)
[EDA Report](/Users/joshuabe/Downloads/Capstone 2 - Student Success Prediction/02_Exploratory_Data_Analysis Capstone 2 - Student Success Prediction )

I leveraged visualizations to identify potential outliers and feature correlations, generated statistical summaries, and uncovered the nature of distributions for each variable. I also used visuals to uncover substantial inequalities within the Texas education system. 

![Average Total Funding by Income Image](Springboard-Data-Science/images/avg_total_funding_by_income.png)

The figure above illustrates that there are **disparities in district funding by median income levels, particularly with local funding amounts**. This could have implications for policy and resource allocation to address these disparities. 
- The districts with the bottom 10% median income receive significantly less local funding on average compared to both the middle 80% and the top 10%, as well as a much lower level of total funding compared to the middle 80%. Although the bottom 10% receives total funding per student that is roughly equal to that of the top 10% — thanks to higher state funding — this amount is still insufficient compared to the middle 80%. This situation highlights substantial inequalities among districts, where poorer neighborhoods face disadvantages by receiving significantly less total funding per student — thousands of dollars less than those in higher income brackets.

![Funding vs Child Poverty Image](images/funding_vs_child_poverty.png)

- The scatterplot above illustrates the relationship between total funding per attended student and child poverty rate across districts, with districts falling into the low funding and high poverty category marked in red (see Figure 3 above). The grey dashed lines indicate the thresholds for low funding (below the 25th percentile of total funding) and high child poverty (above the 75th percentile).
- Districts marked in red are of particular concern, as they represent **situations where low funding coincides with high poverty rates, potentially exacerbating educational inequities**. 

## Machine Learning Models
[Preprocessing Report](/Users/joshuabe/Downloads/Capstone 2 - Student Success Prediction/03_Preprocessing_Training_Data Capstone 2 - Student Success Prediction)
[ML Report](/Users/joshuabe/Downloads/Capstone 2 - Student Success Prediction/04_Modeling Capstone 2 - Student Success Prediction)

I compared the performance of four different models to determine which one provided superior results. The models tested included Linear Regression, Random Forest, Gradient Boosting, and Decision Trees. I also performed cross-validation to evaluate how well a model is likely to perform on unseen data. 

Looking at all the models, Random Forest and Gradient Boosting were the top performers and had similar metrics, but I chose Random Forest due to it being more interpretable, less sensitive to overfitting, and easier to tune. 

[Model Metrics File](/Users/joshuabe/Downloads/Capstone 2 - Student Success Prediction/model_overview.csv)

![Feature Importances Image](images/feature_importances.png)

- From the feature importances graphic, it's clear that child poverty and higher absenteeism (ADA – Average Daily Attendance, absenteeism rate) are among the most important features, as higher levels tend to predict lower test scores among school districts. 
- Teacher quality is among the top 4 most important features for predicting student test scores (excluding state and federal funding since these are lagging indicators, not leading indicators). 
    - NOTE on teacher quality composite: this was a metric I created during the EDA stage. Three primary variables indicate teacher quality: teacher avg years of experience, percent of teachers with masters degree, and teacher turnover ratio. 

## Predictions
[Final Predictions Notebook](/Users/joshuabe/Downloads/Capstone 2 - Student Success Prediction/05_Predictions Capstone 2 - Student Success Prediction)

The final predictions notebook demonstrates how varying our inputs can affect predictions, thereby showcasing the potential impact of interventions or policy changes. 

![Success Prediction Scenarios Image](images/success_prediction_scenarios.png)

The results show each scenario of improvement offers nearly a 1% increase in the Above TSI Both Rate, which is the percent of graduating examinees meeting the college-ready graduates TSI benchmarks for the SAT or the ACT. 

- **Incremental Impact**: Even though the percentage increase in scores seems minimal, the impact can be significant when scaled up across large numbers of students. This suggests that even small improvements in the model's key features — teacher quality, attendance, and poverty reduction — can translate into substantial benefits for many students. 
- **Cumulative Effects**: The graph shows isolated effects of each scenario, but in practice, combining several positive changes might lead to compounding effects that are not merely additive but multiplicative. For example, improving teacher quality might have synergistic effects with increasing attendance, leading to greater overall improvements than either change alone.
- **Policy Recommendations**: These findings can be used to advocate for targeted interventions. For example, if improving teacher quality shows the most significant impact on test scores, programs for teacher training and retention could be prioritized.
- **Long-term Implications**: While the immediate impact is quantified as additional students achieving college readiness, the long-term effects could include higher graduation rates, better college enrollment rates, and ultimately, greater economic opportunities for these students. 

## Recommendations
Based on the modeling results and overall analysis, I’ll present some action steps for educational policymakers, school district administrators, and the various levels of government. 

Here are three concrete recommendations: 
1. **Provide more targeted funding to high absenteeism districts**: Knowing attendance is one of the most important factors in predicting student outcomes, policymakers should identify districts with higher absenteeism and provide more funding towards: 
    - *Expanded transportation options* to ensure all students have reliable access to school, particularly in rural or underserved areas.
    - *Health and wellness programs* including mental health support to address health-related absenteeism. These can include routine health checks, counseling, emergency health services, and more. 
    - *Engagement and enrichment programs* that increase student engagement through clubs, sports, arts, and other extracurricular activities. 
    
2. **Increase equity of qualified teachers among districts**: We know that teacher quality is another important factor in predicting student outcomes, so it’s crucial to invest in our teachers. School district administrators can increase the equity of teacher quality through: 
    - *State-funded incentive programs* that attract and retain highly qualified teachers in underserved or lower-performing districts. This could include higher pay scales, signing bonuses, housing allowances, or student loan forgiveness. 
    - *Professional development and continuing education opportunities* for teachers to pursue advanced degrees, certifications, and specialized training. 
    - *Equitable funding models* that ensure that funding is specifically earmarked for initiatives that directly enhance teacher quality, such as bonuses for teachers who achieve certain professional milestones or who effectively implement innovative teaching practices.
    
3. **Enact targeted interventions for high inequality districts (low funding + high poverty)**: Despite the state’s efforts to level the playing field, substantial disparities in local funding continue to drive funding inequities across districts, and there are still districts in Texas with both low total funding AND high child poverty rates. These districts require targeted interventions to address disparities and support students from these socioeconomically challenged backgrounds. While we know that funding does not correlate to student outcomes in and of itself, and we may not be able to eliminate poverty altogether, the state and federal government can still grant more funding that focuses on reducing absenteeism and enhancing teacher quality for these poorer districts. 

## Future Improvements
- I had to impute median income values for my target years (2018-2022) using the year-to-year percentage changes for the state median income. If I had the actual per district median income data for those years, that would have been more optimal, but real world data is imperfect. 
- Further analysis could investigate the deeper reasons behind the disparities in funding across different districts, as well as its impact on educational opportunities, and potential policy implications. 
- If possible, it would be interesting to expand the scope and analyze similar data for the entire country to see if similar trends are present. 

## Credits
Thanks to my Springboard mentor Pizon Shetu for his continued help and boundless enthusiasm. 
