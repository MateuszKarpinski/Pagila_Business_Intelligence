# Pagila_Business_Intelligence

## O projekcie
Projekt symuluje pracę na stanowisku Data Analyst w fikcyjnej sieci wypożyczalni filmów. Głównym celem analizy jest nie tylko pisanie bardziej skomplikowanych zapytań SQL, ale również dostarczenie konkretnych wniosków biznesowych, które pomogą w optymalizacji kosztów, zwiększeniu retencji klientów i lepszym zarządzaniu asortymentem.

**Wykorzystane technologie:**

* PostgreSQL (Analiza danych, CTE, funkcje okna, agregacje)
* pgAdmin/DBeaver (Środowisko pracy)

---

## Najważniejsze wnioski

* **Martwy kapitał operacyjny:** W systemie widnieje 500 zarejestrowanych sklepów, jednak 100% przychodów generują tylko 2 placówki.
* **Aktywni klienci:** W systemie nie widnieje klient, który nie wypożyczył przez ostatni miesiąc żadnego filmu.

## Dziennik Analityczny (Zrealizowane zadania)

### Zadanie 1: Miesięczne przychody firmy
**Cel biznesowy:** Zrozumienie, jak rozkładają się przychody firmy w poszczególnych miesiącach.
**Wniosek:** Przychody są nierównomierne, co może wymagać wprowadzenia systemu subskrypcyjnego.
<details>
<summary>Wciśnij, żeby pokazać kod</summary>
```sql
SELECT 
    DATE_TRUNC('month', payment_date)::DATE AS miesiac,
    SUM(amount) AS suma
FROM payment
GROUP BY 1
ORDER BY miesiac DESC;
```
</details>

### Zadanie 2:
**Cel biznesowy:** Weryfikacja, które placówki generują największy zysk i jaka jest średnia wartość transakcji
**Wniosek:** Wyniki pokazały transakcje tylko z 2 placówek. Po głębszej weryfikacji okazało się, że w bazie istnieje 500 placówek, z czego 498 nie generuje żadnego przychodu.
<details>
<summary>Wciśnij, żeby pokazać kod</summary>
```sql
SELECT 
    st.store_id,
    SUM(p.amount) AS suma_przychodu,
    ROUND(AVG(p.amount), 2) AS srednia_przychodu
FROM payment p 
JOIN staff st ON p.staff_id = st.staff_id
GROUP BY 1
ORDER BY suma_przychodu DESC;
```
</details>

**Zadanie 3:**
**Cel biznesowy:** Wyłonienie 10 klientów, którzy podczas istnienia wypożyczalni wydali najwięcej pieniędzy 
**Wniosek:** Analiza pozwoliła wyłonić 10 najważniejszych klientów w bazie. Dzięki bezpośredniemu użycia JOIN na płatności i danych klientów gwarantuje skalowalność tego raportu w przyszłości.
<details>
<summary>Wciśnij, żeby pokazać kod</summary>
```sql
select 
	c.first_name,
	c.last_name,
	SUM(p.amount) as suma_przychodu
from customer c 
join payment p on p.customer_id = c.customer_id
group by c.customer_id, c.last_name, c.first_name
order by suma_przychodu desc
limit 10;
```
</details>

**Zadanie 4:**
**Cel biznesowy:** Wytypowanie klientów, krórzy przestali korzystać z usług wypożyczalni, a w przeszłości wypożyczyli więcej niż 30 filmów.
**Wniosek:** Kluczowe w poprawnym wykonaniu zadania było użycie MAX(), aby wyodrębnić tylko ostatnie wypożyczenie.
<details>
<summary>Wciśnij, żeby pokazać kod</summary>
```sql
select
    c.customer_id,
    c.first_name,
    c.last_name,
    count(r.rental_id) as ilosc_wypozyczen,
    MAX(r.rental_date) AS ostatnia_wizyta
FROM customer c
JOIN rental r ON c.customer_id = r.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING MAX(r.rental_date) <= '2022-09-01' and count(r.rental_id) > 30
ORDER by ilosc_wypozyczen DESC;
```
</details>

**Zadanie 5:**
**Cel biznesowy:** Zrozumienie, które kategorie filmów są najbardziej rentowne i jak to się przekłada na ilość wypożyczeń.
**Wniosek:** Skonstruowano złożone zapytanie relacyjne łączące 6 tabel. Wykazano korelację między ilością wypożyczeń, a sumą przychodów dla poszczególnych kategorii.
<details>
<summary>Wciśnij, żeby pokazać kod</summary>
```sql
select 
	c.name as kategoria,
	sum(p.amount) as suma_przychodu,
	count(i.inventory_id) as ilosc_wypozyczen
	from category c
	join film_category fc on c.category_id = fc.category_id
	join film f on fc.film_id = f.film_id
	join inventory i on f.film_id = i.film_id
	join rental r on i.inventory_id = r.inventory_id
	join payment p on r.rental_id = p.rental_id
	group by c."name" 
	order by suma_przychodu desc;
```

</details>

**Zadanie 6:**
**Cel biznesowy:**
**Wniosek:**
<details>
<summary>Wciśnij, żeby pokazać kod</summary>


</details>

**Zadanie :**
**Cel biznesowy:**
**Wniosek:**
<details>
<summary>Wciśnij, żeby pokazać kod</summary>


</details>

