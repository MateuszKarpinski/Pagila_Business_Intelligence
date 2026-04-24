select
	date_trunc('month', payment_date)::date as miesiac,
	SUM(amount) as suma
from payment
group by 1
order by miesiac desc;
