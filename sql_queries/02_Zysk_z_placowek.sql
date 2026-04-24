select
	s.store_id,
	SUM(p.amount) as suma_przychodu,
	ROUND(AVG(p.amount), 2) as srednia_przychodu
from store s
join staff st on st.store_id = s.store_id
join payment p on p.staff_id = st.staff_id
group by 1
order by suma_przychodu desc; 
