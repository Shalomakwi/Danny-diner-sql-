select s.customer_id, 
sum(
case
when s.order_date >= mem.join_date
and s.order_date < date_add(mem.join_date, interval 7 Day)
then
case
when m.product_name = 'sushi'
then m.price * 20 * 2
else m.price * 10 * 2
end
when m.product_name = 'sushi'
then m.price * 20
else m.price * 10
end
) as total_points
from sales s
join members mem
on s.customer_id = mem.customer_id
join menu m
on s.product_id = m.product_id
where s.order_date <= '2021-01-31'
group by s.customer_id 