# [Link To Tableau Dashboards](https://public.tableau.com/app/profile/ryan.monsees/viz/Book2_17720687463460/Dashboard1?publish=yes)
# Brazilian E-Commerce Project 
[Link to the data](https://www.kaggle.com/datasets/olistbr/brazilian-ecommerce)

All queries are in the E-Commerce_Queries.sql

The Brazilian E-Commerce Public Dataset by Olist consists of real commercial data of 100,000 orders from 2016 to 2018 from multiple marketplaces in Brazil.

## Dashboard 1: Product Sales

The first business insight I wanted to explore is how the overall sales are going and the performance of different categories of products. 

- I started by getting the sum of the revenue for all the zip codes so I could map in Tableau where the sales are most successful. The Offset 18 is used to skip the zip codes with null revenue

- Then, I wanted to discover which categories of products are generating the most revenue and how sales of them have changed over time. So in the HAVING clause, I made sure that only the
top 10 selling products would appear by using a subquery to see which products have the highest revenue. I then got the date of each order for the top 10 products and grouped the revenue by month.
So the HAVING clause looks like this:
```
HAVING pt.product_category_name_english IN (SELECT pt.product_category_name_english
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt ON p.product_category = pt.product_category_name
GROUP BY pt.product_category_name_english
ORDER BY  ROUND(SUM(oi.price)) DESC
LIMIT 10)
```


