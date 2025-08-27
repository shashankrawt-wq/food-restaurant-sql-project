Food & Restaurant SQL Project  

I built this project to practice SQL while answering **real business-style questions** about restaurant orders.  
Instead of random `SELECT * FROM table;`, the queries here focus on **growth, customer behavior, and promotions**.  


## Data Model  

The dataset is simple — just **one table** called `Orders`:  

![Orders ERD](orders_table_erd.png)  

Columns: 
- Order_id → unique ID for each order  
- Customer_code → customer identifier  
- Placed_at → when the order was placed (datetime)  
- Restaurant_id → outlet identifier  
- Cuisine
 → type of cuisine (Indian, Italian, etc.)  
- Order_status → status of the order  
- Promo_code_Name → promo code applied (if any)  



##  Business Questions Solved  

Some of the queries in this project: 

1. Which outlets are leading by cuisine type?
   → Find the top 3 restaurants for each cuisine without using `LIMIT`.  

2. How many new customers are acquired each day?
   → Track first-time buyers over time.  

3. Which customers churned?
   → Customers who haven’t ordered in the last 7 days.  

4. Promo hunters 
   → Customers who placed all their orders using only promo codes.  

5. Targeting after the 3rd order
   → Find customers at their 3rd, 6th, 9th… order (for personalized campaigns).  

6. How many were acquired in Jan 2025 without promo codes?
   → Growth team question: “What % of new customers came organically?”  



