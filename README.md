# [Link To Tableau Dashboards](https://public.tableau.com/app/profile/ryan.monsees/viz/Book2_17720687463460/Dashboard1?publish=yes)
# Brazilian E-Commerce Project 
[Link to E-Commerce data](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

All queries are in the E-Commerce_Queries.sql

The Brazilian E-Commerce Public Dataset by Olist consists of real commercial data of 100,000 orders from 2016 to 2018 from multiple marketplaces in Brazil.

The goals of this project are to:
- Analyze revenue over time
- Geographic sales distribution
- Product category performance
  

## Dashboard 1: Product Sales

The first business insight I wanted to explore is the revenue changes over time and the performance of different categories of products. 

- I started by getting the sum of the revenue for all the zip codes so I could map in Tableau where the sales are most successful.
- I got the top 10 highest and lowest revenue categories of products and displayed their sales over time.
- I calculated the revenue per month by using SUM() and grouping by month. I skipped 2 of the months because they appeared to lack complete data of sales due to being too recent.

## Dashboard 2: Delivery Analysis

This is where I checked how often deliveries arrived on time and how different factors of the delivery could be effecting review scores.

- Made a correlation chart of the different aspects of deliveries to check for relations.
- Got the overall rate of on time deliveries and average review score.
- Made a chart to show the review scores of the sellers who always deliver on time.

# LA Crime Statistics Project
[Link to crime data](https://catalog.data.gov/dataset/crime-data-from-2020-to-present)

All queries are in the Crime_Data_Queries.sql

This crime data for the city of Los Angeles, CA comes from the USA government catalog of data. It has records from 2020 to 2024.

The goals of this project are to:
- Analyze the trends of crime categories
- Show Geographical distribution of crime
- Discover when crime is likely to occur

## Dashboard 3: Top Crime Categories

I wanted to see which categories of crime are the most significant.

- Found the total number of crimes reported from 2020-2023.
- Identified the top 10 crimes that increased the most during that period.
- Showed how the top 10 most reported crimes changed over time.

## Dashboard 4: When crimes occur
