SELECT
    c.customer_id,
    c.first_name,
    c.last_name,
    MAX(r.rental_date) AS ostatnia_wizyta
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING MAX(r.rental_date) <= '2022-05-01'
ORDER BY ostatnia_wizyta ASC;
