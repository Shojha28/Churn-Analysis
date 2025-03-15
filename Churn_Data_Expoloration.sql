Select gender, count(gender) as totalCount,
COUNT(gender)*100.0/(select count(*) from stg_Churn) as Percentage
from stg_Churn
group by Gender


----- Churn exploration

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

select distinct internet_type
from stg_Churn


