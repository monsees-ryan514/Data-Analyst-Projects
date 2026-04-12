# [Link To Tableau Dashboards](https://public.tableau.com/app/profile/ryan.monsees/viz/Book2_17720687463460/Dashboard1?publish=yes)
This repository contains SQL-based data analysis projects focused on extracting business insights and building dashboards in Tableau using real-world datasets.

# Brazilian E-Commerce Project 
[Link to E-Commerce data](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

All queries are in the E-Commerce_Queries.sql

The Brazilian E-Commerce Public Dataset by Olist consists of real commercial data of 100,000 orders from 2016 to 2018 from multiple marketplaces in Brazil.

The goals of this project are to:
- Analyze revenue over time
- Geographic sales distribution
- Product category performance
  

## Dashboard 1: Product Sales

The dashboard analyzes revenue changes over time and the performance of different categories of products. 

- Aggregated revenue for all the zip codes so I could map in Tableau where the sales are most successful.
- Calculated the top 10 highest and lowest revenue categories of products and displayed their sales over time.
- Calculated the revenue per month by using SUM() and grouping by month.
- Excluded 2 incomplete months to ensure accuracy of trend analysis.

## Dashboard 2: Delivery Analysis

This is where I checked how often deliveries arrived on time and how different factors of the delivery could be affecting review scores.

- Conducted a correlation analysis of the different aspects of deliveries to check for relations.
- Got the overall rate of on time deliveries and average review score.
- Analyzed review scores of the sellers who always deliver on time.

### Recommendations based on the data
- Test demand for low-performing categories (e.g., CDs, fashion, flowers) through targeted promotions; consider discontinuation if performance remains weak.
- Expand marketing efforts in central and northern Brazil, where sales are currently underrepresented compared to the southeast.
- Promote the seller who have the highest reviews and best track record for delivering on time.

# LA Crime Statistics Project
[Link to crime data](https://catalog.data.gov/dataset/crime-data-from-2020-to-present)

All queries are in the Crime_Data_Queries.sql

This crime data for the city of Los Angeles, CA comes from the USA government catalog of data. It has records from 2020 to 2024.

The goals of this project are to:
- Analyze the trends of crime categories
- Show geographical distribution of crime
- Discover when crime is likely to occur

## Dashboard 3: Top Crime Categories

I wanted to see which categories of crime are the most significant.

- Found the total number of crimes reported from 2020-2023.
- Identified the top 10 crimes that increased the most during that period.
- Showed how the top 10 most reported crimes changed over time.

## Dashboard 4: When crimes occur

- Analyzed what day of the week the top 10 crimes occur.
- Found the time of the day the top 10 crimes occur.

## Dashboard 5: Where crimes occur

- Made a map of where all the top 10 crimes have occurred.

### Recommendations based on the data

- Identity theft is increasing significantly; recommend allocating more resources to cybercrime investigation and prevention.
- Vehicle theft remains the most frequent crime, with peaks on Fridays between 4:00 PM–12:00 AM in central/southern Los Angeles; recommend increasing patrol presence during these periods.
- Petty theft is rising steadily; recommend increasing enforcement in high-density areas such as downtown Los Angeles, the airport, and Hollywood.
