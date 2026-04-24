SELECT 
    c.first_name,
    c.last_name,
    SUM(p.amount) AS suma_przychodu
FROM customer c 
JOIN payment p ON p.customer_id = c.customer_id
GROUP BY c.customer_id, c.last_name, c.first_name
ORDER BY suma_przychodu DESC
LIMIT 10;
