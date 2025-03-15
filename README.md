# Churn-Analysis

# Churn-Analysis

# Introduction
Customer churn is a major concern for businesses, especially those in subscription-based industries. Losing customers not only impacts revenue but also increases acquisition costs for new customers. This project aims to analyze and predict customer churn using a data-driven approach by integrating SQL Server for data processing, Power BI for visualization, and Machine Learning (Random Forest) for predictive modeling.

The goal is to:

•	Understand why customers leave by analyzing patterns in their demographics, service usage, and payment behaviors.

•	Visualize insights through interactive Power BI dashboards to identify key churn factors.

•	Develop a machine learning model to predict customers at risk of churning.

•	Provide actionable strategies to reduce churn and improve customer retention.

The project follows six key phases:
1.	ETL Process & Data Cleaning in SQL Server
2.	Data Transformation & Visualization in Power BI
3.	Exploratory Data Analysis (EDA) in Power BI
4.	Building a Machine Learning Model in Jupyter Notebook (Random Forest)
5.	Predicting At-Risk Customers
6.	Visualizing Predictions in Power BI (Predicted Churner Profile)
________________________________________
# ETL Process in SQL Server
 
The first step in the project was to extract, transform, and load (ETL) data in SQL Server. The dataset contained information about customers, their subscription details, payment history, and churn status.
![image](https://github.com/user-attachments/assets/cb4b5a68-159a-48f0-9f53-7a61ef4a58dd)

## Data Extraction & Staging
•	The dataset was imported into SQL Server and stored in a staging table (stg_Churn).

•	An initial exploratory analysis was conducted to understand customer distribution, missing values, and key trends.
![image](https://github.com/user-attachments/assets/e737bc70-916d-403c-9b65-6f15450df191)

 
select customer_status,count(customer_status)as TotalCount, round(sum(Total_revenue),2) as Total_Rev,
sum(Total_revenue)/(select sum(Total_Revenue) from stg_Churn) *100 as RevPercentage
from stg_Churn
group by customer_status

---- Which state has highest percentage in our entire data

select state, count(state) as TotalCount,
count(state)*100/ (select COUNT(*) from stg_Churn) as percentage
from stg_Churn
group by state
order by percentage desc

## Data Cleaning & Transformation
•	Checked for null values and handled them appropriately by either removing or imputing missing data.

 ![image](https://github.com/user-attachments/assets/b5f5ef62-1439-43c1-964d-2bb707764dff)

Standardized categorical variables (e.g., state, payment_method) to ensure consistency.
•	Filtered out duplicate or irrelevant records.
•	Inserted cleaned data into a production table (prod_Churn) for further processing.

![image](https://github.com/user-attachments/assets/6dd0a6c6-85b5-4110-966a-790267ccafed)

 
## Creating Views for Power BI
To make data extraction seamless, SQL Views were created for direct Power BI integration:
**vw_ChurnData → Contains customers who stayed or churned for churn analysis.**
Create View vw_ChurnData as
select * from prod_Churn where Customer_Status In ('Churned', 'Stayed')

**vw_JoinData → Contains customers who recently joined for acquisition trend analysis.**
Create View vw_JoinData as
select * from prod_Churn where Customer_Status = 'Joined'


________________________________________
# Data Transformation & Visualization in Power BI
Once the data was structured, it was imported into Power BI for further transformation and analysis.
•	New calculated columns were created, including Churn_Status to classify customers as churned or retained.
 ![image](https://github.com/user-attachments/assets/5bae4cd2-de16-4414-8ca2-87af1250fc2e)

•	Aggregations were performed to derive total revenue per customer segment.

•	Relationships were established between tables to enable interactive drill-down analysis.

•	Data normalization was applied to improve filtering and segmentation capabilities.

![image](https://github.com/user-attachments/assets/128e03b8-2a51-4d77-94c9-efa291e93824)


# Power BI Visualization & Key Insights
The Power BI dashboard provides a detailed view of customer churn, helping businesses understand trends and behaviors.

## Key Visualizations & Insights
## Total Customers, New Joiners, and Churn Rate
•	The total number of customers analyzed was 6,418, out of which 411 were new joiners.

•	1,732 customers churned, leading to a 27.0% churn rate.

•	The high churn rate emphasizes the need for improved customer engagement strategies.

## Churn Rate by Age Group
•	Customers over 50 years old had the highest churn rate at 31%.

•	Older customers may struggle with service usability or switch to competitors with better pricing.

•	Younger customers (20-35 years old) had lower churn rates, indicating better retention among this demographic.

## Geographic Analysis of Churn
•	The highest churn rates were in Jammu & Kashmir (57.2%), followed by Assam (38.1%).

•	This suggests that regional factors such as service quality, competition, or economic conditions influence customer decisions.

## Churn by Payment Method
•	Customers using Mailed Checks (37.8%) and Bank Withdrawals (34.4%) had the highest churn rates.

•	Credit Card users had the lowest churn rate (14.8%), indicating that customers who automate payments are more likely to stay.

•	Encouraging auto-payment options may help reduce churn.

## Churn by Contract Type
•	Customers on Month-to-Month contracts had a churn rate of 46.5%, compared to just 11.0% for One-Year contracts and 2.7% for Two-Year contracts.

•	This suggests that customers with longer commitments are significantly more likely to stay, and offering incentives for longer contracts can improve retention.

## Service-Based Churn
•	Customers who did not subscribe to Online Security and Online Backup services churned at a higher rate.

•	Internet and Phone Services were essential, with higher retention rates.

•	Promoting bundled services could encourage retention.

## Reasons for Churn
•	The top reason for churn was competition (761 customers switched to competitors).

•	Other major reasons included customer dissatisfaction (300 cases), price concerns (196 cases), and poor customer support (301 cases).

•	Competitive pricing and improved customer service could help reduce churn.
________________________________________
# Machine Learning Model - Random Forest (Jupyter Notebook)
The final phase of the project involved developing a machine learning model to predict customer churn. The goal of this model was to identify at-risk customers before they churn, allowing businesses to take proactive retention measures.

For this, we used the Random Forest Classifier, a robust ensemble learning method that handles large datasets well and provides reliable predictions. The model was trained and tested in Jupyter Notebook using Python and the Scikit-Learn library.



## Model Building Process
**1.	Feature Engineering**
o	Selected key features such as Monthly Charges, Total Revenue, Payment Method, Tenure, and Contract Type.

o	Encoded categorical variables using One-Hot Encoding.

o	Split the data into 80% training and 20% testing.

**3.	Training the Model**
o	Used a Random Forest Classifier, known for handling large datasets with high accuracy.

o	Tuned hyperparameters to improve model performance.

**4.	Model Evaluation**
o	Achieved high accuracy and recall, ensuring reliable predictions.

o	Evaluated using Confusion Matrix, Precision, Recall, and F1-Score.

**5.	Prediction & Export**
o	Predicted customers likely to churn and exported the data to Power BI.

# Visualizing Predicted Churn in Power BI
The Predicted Churner Dashboard was developed to analyze high-risk customers.

![image](https://github.com/user-attachments/assets/18e8dc75-7da6-45f7-a45d-b6870ea12706)
