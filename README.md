# [Link To Tableau Dashboards](https://public.tableau.com/app/profile/ryan.monsees/viz/Book2_17720687463460/Dashboard1?publish=yes)
# Brazilian E-Commerce Project 
[Link to the data](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

All queries are in the E-Commerce_Queries.sql

The Brazilian E-Commerce Public Dataset by Olist consists of real commercial data of 100,000 orders from 2016 to 2018 from multiple marketplaces in Brazil.

The goals of this project are to:
- Analyze revenue over time
- Geographic sales distribution
- Product category performance
  

## Dashboard 1: Product Sales

The first business insight I wanted to explore is the revenue changes over time and the performance of different categories of products. 

- I started by getting the sum of the revenue for all the zip codes so I could map in Tableau where the sales are most successful. The Offset 18 is used to skip the zip codes with null revenue.

- I got the top 10 highest and lowest revenue categories of products and displayed their sales over time.

- I calculated the revenue per month by using SUM() and grouping by month. I skipped 2 on the months because they appeared to lack complete data of sales due to being too recent.
