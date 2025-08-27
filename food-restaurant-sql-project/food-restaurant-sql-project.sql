select * from orders;


#top 3 outlet by cuisine type without using limit and top function

with cte as (select cuisine,restaurant_id,count(*) as order_count
from orders
group by cuisine, Restaurant_id)


select * from  
(select *, row_number() over (partition by cuisine order by order_count desc) as rn
 from cte) as tt
where rn<3


#find the daily new customer count from the lauch date(everyday how many new customers are we acquring)

with cte as (select customer_code,cast(min(placed_at) as date) as order_date
from orders
group by customer_code)

select order_date, count(*)
from cte 
group by  order_date 


  #count of all the cusomter that were acquired on january and only ordered once in january and did not place any other order 
  
  
select customer_code,count(*)
from orders
where month(placed_at)=1 and  year(placed_at)=2025 and customer_code  not in (select customer_code
from orders
where month(placed_at)!=1)
group by customer_code
having count(*)=1
  
#list all the customers with no orders in the last 7 days but were acquired one month ago with their first order


with cte as(select customer_code,max(placed_at) last_order,min(placed_at) first_order
from orders
group by customer_code)

select cte.*,o.promo_code_name  as first_order_promo
from cte join orders o 
on cte.customer_code=o.customer_code and cte.first_order=o.placed_at
where last_order< date_sub(now(), interval 7 day)
and first_order< date_sub(now(), interval 1 month) and 
o.promo_code_name is not null



#growth team is palnning to create a trigger that will target customers after their 
#every third order with a personalized communicattion and they have asked you to create a query for this:

with cte as (select *, row_number() over(partition by customer_code order by placed_at) as rn
from orders)

select * from cte 
where rn %3=0 and cast(placed_at as date)=cast(current_timestamp() as date)



#list customer who placed more than 1 order and all  their orders are on promo only

select customer_code, count(*),count(promo_code_name) as promo_orders
from orders
group by customer_code
having count(*)>1 and count(*)=count(promo_code_name)


# what percentage of customer were originally acquired  in jan 2025. (placed their first order without promo code)

with cte as (select *,row_number() over(partition by customer_code order by placed_at) rn
from orders
where month(placed_at)=1)

select round(count( case when rn=1 and promo_code_name is null then customer_code end)*100.0/count(distinct customer_code),2) percentage
from cte 
