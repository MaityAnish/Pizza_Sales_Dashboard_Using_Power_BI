select * from pizza_sales

---1. Find the total revenue
select sum(total_price) as Total_revenue from pizza_sales

---2. Average order Value
select sum(total_price)/count(distinct(order_id)) as Average_order_values from pizza_sales

---3. Total_pizza_sold
select sum(quantity) as Tota_pizza_sold from pizza_sales

---4.Total_order_place
select count(distinct(order_id)) as Total_order_place from pizza_sales

---5.Average pizzas per order
select cast(cast(sum(quantity) as decimal(10,2))/cast(count(distinct(order_id)) as decimal(10,2)) as decimal(10,3)) as Average_pizza_per_order from pizza_sales

---6.Daily trends for total order
select datename(dw,order_date) as order_day, count(distinct(order_id)) as total_orders
from pizza_sales
group by datename(dw,order_date)

---7. monthly trends for the total order
select DATENAME(month,order_date) as order_month,count(distinct(order_id)) as Total_orders
from pizza_sales
group by DATENAME(month,order_date) 
order by Total_orders Desc

--8. Percentage of Pizza Category
select pizza_category,sum(total_price) as Total_sales,sum(total_price)*100/(select sum(total_price) from pizza_sales where MONTH(order_date)=1) as percentage_of_total_sales
from pizza_sales
where MONTH(order_date)=1
group by pizza_category

--9.Percentage of sales by pizza sizes
select pizza_size,cast(sum(total_price)as decimal(10,2)) as Total_sales,cast(sum(total_price)*100/(select sum(total_price) from pizza_sales where MONTH(order_date)=1) as decimal(10,2)) as percentage_of_total_sales
from pizza_sales
where datepart(Quarter,order_date)=1
group by pizza_size
order by percentage_of_total_sales Desc

--10. Top 5 best sellers by revenue, total quantity and total orders
  select top 5 pizza_name,sum(total_price) as Total_revenue from pizza_sales
  group by pizza_name
  order by Total_revenue desc

  select top 5 pizza_name,sum(quantity) as Total_quantity from pizza_sales
  group by pizza_name
  order by Total_quantity  desc

  select top 5 pizza_name,count(distinct order_id) as Total_orders from pizza_sales
  group by pizza_name
  order by Total_orders  desc

---11.