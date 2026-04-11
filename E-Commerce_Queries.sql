-- Query to find the revenue for the different locations

SELECT c.customer_zip_code, ROUND(SUM(oi.price)) AS revenue  
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN customer_data c ON o.customer_id = c.customer_id
GROUP BY c.customer_zip_code
ORDER BY revenue DESC
OFFSET 18

-- Gets the top 10 best selling categories

SELECT DATE(o.order_purchase_timestamp) as purchase_date,
pt.product_category_name_english, ROUND(SUM(oi.price)) AS revenue
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt ON p.product_category = pt.product_category_name
GROUP BY purchase_date, pt.product_category_name_english
HAVING pt.product_category_name_english IN (SELECT pt.product_category_name_english
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt ON p.product_category = pt.product_category_name
GROUP BY pt.product_category_name_english
ORDER BY  ROUND(SUM(oi.price)) DESC
LIMIT 10)
ORDER BY pt.product_category_name_english, purchase_date

-- Bottom 10 selling categories
SELECT DATE(o.order_purchase_timestamp) as purchase_date,
pt.product_category_name_english, ROUND(SUM(oi.price)) AS revenue
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt ON p.product_category = pt.product_category_name
GROUP BY purchase_date, pt.product_category_name_english
HAVING pt.product_category_name_english IN (SELECT pt.product_category_name_english
FROM orders o
LEFT JOIN order_items oi ON o.order_id = oi.order_id
LEFT JOIN products p ON oi.product_id = p.product_id
LEFT JOIN product_category_translation pt ON p.product_category = pt.product_category_name
GROUP BY pt.product_category_name_english
ORDER BY  ROUND(SUM(oi.price))
LIMIT 10)
ORDER BY pt.product_category_name_english, purchase_date


-- Revenue per month excluding the 2 months there is not enough data
SELECT TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM') AS month, ROUND(SUM(oi.price)) FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.order_id
GROUP BY TO_CHAR(o.order_purchase_timestamp, 'YYYY-MM')
ORDER BY month
LIMIT 23






-- Get Seller lat and lon (getting average lon and lat because there are multiple entries in geolocaiton
-- for the same zip code)
SELECT DISTINCT o.order_id, sd.zip_code, g.latitude, g.longitude
FROM orders o
INNER JOIN order_items oi ON o.order_id = oi.order_id
INNER JOIN seller_data sd ON oi.seller_id = sd.seller_id
INNER JOIN (
    SELECT zip_code,
           AVG(latitude) AS latitude,
           AVG(longitude) AS longitude
    FROM geolocation
    GROUP BY zip_code
) g ON sd.zip_code = g.zip_code




-- Get customer lat and lon
SELECT DISTINCT o.order_id, cd.customer_zip_code, g.latitude, g.longitude
FROM orders o
INNER JOIN customer_data cd ON o.customer_id = cd.customer_id
INNER JOIN (
    SELECT zip_code,
           AVG(latitude) AS latitude,
           AVG(longitude) AS longitude
    FROM geolocation
    GROUP BY zip_code
) g ON cd.customer_zip_code = g.zip_code




-- Gets the distance between seller and buyer, the days the delivery was late, review score and product weight to make a correlation chart.
WITH distance_table AS (SELECT cl.order_id, cl.zip_code AS customer_zip_code, sl.zip_code AS seller_zip_code, 
ROUND(6371 * 2 * ASIN(
        SQRT(
            POWER(SIN(RADIANS(sl.latitude - cl.latitude) / 2), 2) +
            COS(RADIANS(cl.latitude)) * 
            COS(RADIANS(sl.latitude)) *
            POWER(SIN(RADIANS(sl.longitude - cl.longitude) / 2), 2)
        )
    )) AS distance_km,
	r.review_score
FROM seller_loc sl
INNER JOIN  customer_loc cl ON cl.order_id = sl.order_id
INNER JOIN reviews r ON r.order_id = sl.order_id),

days_late AS (SELECT o.order_id, cl.distance_km, o.order_delivered_customer_date - o.order_estimated_delivery_date
AS days_late, r.review_score
FROM orders o
LEFT JOIN distance_table cl ON cl.order_id = o.order_id
LEFT JOIN reviews r ON r.order_id = cl.order_id
WHERE o.order_delivered_customer_date IS NOT NULL AND o.order_delivered_customer_date IS NOT NULL)

-- Gets the weight of the products in the order
SELECT dl.order_id, dl.distance_km, dl.days_late, dl.review_score, p.product_weight_g FROM days_late dl
LEFT JOIN order_items oi ON oi.order_id = dl.order_id
LEFT JOIN products p ON oi.product_id = p.product_id







-- Total average percentage of on time deliveries and review scores
SELECT ROUND(AVG(CASE WHEN o.order_delivered_customer_date - o.order_estimated_delivery_date > 0
THEN 0 ELSE 1 END), 2) AS percentage_on_time, ROUND(AVG(r.review_score), 1) AS avg_review_score FROM orders o
LEFT JOIN reviews r ON r.order_id = o.order_id
ORDER BY percentage_on_time



-- Gets the average review scores for the sellers who always deliver on time. Skips the NULL seller using OFFSET 1
WITH best_sellers AS (SELECT COUNT(*), oi.seller_id AS seller, ROUND(AVG(r.review_score), 1) AS avg_review FROM orders o
LEFT JOIN order_items oi ON oi.order_id = o.order_id
LEFT JOIN reviews r ON r.order_id = o.order_id
GROUP BY oi.seller_id
HAVING COUNT(*) > 10 AND ROUND(AVG(CASE WHEN o.order_delivered_customer_date - o.order_estimated_delivery_date > 0
THEN 0 ELSE 1 END), 2) = 1.00)

SELECT * FROM best_sellers
OFFSET 1





