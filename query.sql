use sec01gr12db;

-- No#1 SQL Query 1: The List of Customers in stay in Chicago or Los Angeles
select customer_ID, concat(first_name, ' ', last_name) as 'full name', city from Customer
where (city = 'Chicago' or city ='Los Angeles');

-- No#2 SQL Query 2: The List of Customers with Full Name and Address
select concat(customer_ID) as ID, 
	concat(first_name, ' ', last_name) as full_name, 
	concat(street, ', ', city, ', PIN: ', pin_code) as full_address
from Customer;


-- No#3 SQL Query 3: The List of Products with Total Price Greater Than 100
select product_name, sum(price) as sum_price from Product
group by product_name having sum(price) > 100
order by sum_price;

-- No#4 SQL Query 4: The List of Products with Categories and Details
select p.product_num, pc.prod_category, p.product_name, p.price, p.manufactured_date  from Product p
inner join ProductCategory pc on p.product_num = pc.product_num;

-- No#5 SQL Query 5: The List of Companies with Address and Phone Numbers
select c.company_name, c.city, c.street, c.pincode, cpn.customer_phone from Company c
left outer join CompanyPhoneNumber cpn on c.company_name = cpn.company_name;

-- *************

-- No#6 SQL Query 1: Company TaxInvoice details and province from CA and NY
select tax_ID, company_name, province, postal_code, district, subdistrict from TaxInvoice
where province = 'CA' or province = 'NY';

-- No#7 SQL Query 2: The List of Account’s Details 
select Concat(acc_name, '  has account Id is  ', account_ID) as 'Account name and ID',
	concat('gender is (M is male, F is female -->)  ', gender) as Gender, 
    year(curdate()) - year(bdate) as Age 
from Account;

-- No#8 SQL Query 3: The list max and min of price each order number and max order value exceeds 500
-- To display max and min price in order
SELECT o.order_num,
    MIN(o.total_item * p.price) AS min_order_value,
    MAX(o.total_item * p.price) AS max_order_value
FROM Orders o
JOIN Product p ON o.product_num = p.product_num
GROUP BY o.order_num HAVING MAX(o.total_item * p.price) > 500;

-- No#9 SQL Query 4: The List of Customer who purchase each Product
select P.product_name as 'Product name', P.customer_ID as 'customer ID', concat(C.first_name, ' ',C.last_name) as 'full name' 
from Product P inner join Customer C on P.customer_ID = C.customer_ID;

-- No#10 SQL Query 5: List Account_identifier is Account used details
select AI.account_ID as 'Account ID', AI.phone_num, AI.email, year(curdate()) - year(A.bdate) as Age, A.acc_name as 'Account name'
from Account_identifier AI left outer join Account A on AI.account_ID = A.account_ID
union all
select AI.account_ID as 'Account ID', AI.phone_num, AI.email, year(curdate()) - year(A.bdate) as Age, A.acc_name as 'Account name'
from Account_identifier AI right outer join Account A on AI.account_ID = A.account_ID
where AI.account_ID is null;

-- *************


-- No#11 Query 1: List the products that were manufactured in First week of the month and and price more than 50
select product_num as 'Product Name',product_name as 'Product Name',manufactured_date as 'Manufactured Date', price
from product where day(manufactured_date) <= '7' and price > 50;

-- No#12 Query 2: List All bank names used by each customer
select c.customer_ID as 'ID' , concat(c.first_name,' ',c.last_name) as Fullname , group_concat(distinct b.bank_name order by b.bank_name) as BanksUsed
FROM Customer c inner join BankTransfer b on c.first_name = b.first_name
group by c.customer_ID;

-- No#13 SQL Query 3: List the total accounts created each year
select year(bdate) as 'Year', count(year(bdate)) as 'total account'
from account group by  year(bdate) 
having  count(year(bdate)) > 0 
order by year(bdate) asc;

-- No#14 SQL Query 4: List customers who used a credit card for payment without a discount code and total price more than 100
select po.payment_num as 'Payment Number' ,concat(cd.first_name,' ',cd.last_name) as 'Full name',cd.card_type, cd.card_number
from PaymentOption po inner join CreditCard cd on po.payment_num = cd.payment_num where coupon_code is null and total_price > 100;

-- No#15 SQL Query 5:  List accounts from oldest to youngest
select a.account_ID, a.acc_name as 'account name', m.member_ID ,concat(year(now()) - year(bdate))  as Age  
from account a left outer join Member m on  m.account_ID = a.account_ID order by Age desc;

-- *************

-- No#16 SQL Query 1: List TopsPrimeMembership that use fast_delivery.
select member_ID, fast_delivery, subscription_date from TopsPrimeMembership where fast_delivery = 'Y';

-- No#17 SQL Query 2: List Payment & Credit Card Information in the first week of November.
select P.payment_num, P.total_price, P.delivery_date, concat(C.first_name,' ' ,C.last_name) as 'full name', C.card_type, C.card_number
from PaymentOption P join CreditCard C on P.payment_num = C.payment_num
where day(P.delivery_date) < 8 and month(P.delivery_date) = 11;


-- No#18 SQL Query 3: Find select delivery_fee average total_item from orders that product_num = 110 and delivery_fee > 4.99
select delivery_fee, avg(total_item) from orders where product_num = 110 
group by delivery_fee having delivery_fee > 4.99;

-- No#19 SQL Query 4: The list of Orders with Paymentoption
select o.order_num,o.delivery_fee, p.total_price, o.total_item, p.delivery_date, p.note from orders o inner join paymentoption p on o.order_num = p.order_num
where p.total_price > 150;

-- No#20 SQL Query 5: List orders table left outer join with paymentoption and delivery_fee more than 7$
select o.product_num, o.total_item, p.total_price, o.delivery_fee, p.coupon_code
from orders o left OUTER JOIN paymentoption p on o.order_num = p.order_num where o.delivery_fee > 7;


-- *************

-- No#21 SQL Query 1: The list of orders that have price over 100 and have coupon discount
-- To display information on paymentoption that has total_price over 100 and has coupon_code
SELECT * FROM paymentoption
WHERE total_price > 100 AND coupon_code != "null";


-- No#22 SQL Query 2: The list of tax invoice of each customer
-- To display customer ID and customer name with tax invoice details
SELECT c.customer_ID, CONCAT(c.first_name, ' ', c.last_name) AS full_name, o.order_num, t.tax_ID, 
    CONCAT(t.subdistrict, ', ', t.district, ', ', t.province) AS customer_address, t.postal_code
FROM taxinvoice t
JOIN Customer c ON t.customer_id = c.customer_ID
JOIN orders o ON t.order_num = o.order_num;


-- No#23 SQL Query 3: The List of Order Numbers that have more than 5 Items
select order_num as 'Order number', concat(sum(total_item), ' item') as 'total of item ' from Orders
group by order_num having sum(total_item) > 5
order by order_num;


-- 
-- No#24 SQL Query 4: The list Name of customer buy total each product 
-- To display total products of each customer
select sum(O.total_item) as 'total item', P.product_num, P.product_name, CONCAT(C.first_name, ' ' , C.last_name) AS full_name
from Orders O inner join Product P on O.product_num = P.product_num inner join Customer C on P.customer_ID = C.customer_ID
group by P.product_num, P.product_name;

-- No#25 SQL Query 5: The list of BankTransfer and CreditCard on payment of customer
-- To display information on BankTransfer and CreditCard of payment
select B.payment_num, B.bank_name, B.bank_num, CONCAT(B.first_name, ' ', B.last_name) AS 'full name', C.card_type, C.card_number
from BankTransfer B join CreditCard C on B.payment_num = C.payment_num
union all 
select B.payment_num, B.bank_name, B.bank_num, CONCAT(B.first_name, ' ', B.last_name) AS 'full name', C.card_type, C.card_number
from BankTransfer B right outer join CreditCard C on B.payment_num = C.payment_num
where  B.payment_num is null limit 10;



-- *************


-- No#26 SQL Query 1: The List of Customer’s Bank Details who pay using Wells Fargo Bank and stay at Main street 
select b.payment_num as PaymentNumber, c.customer_ID as ID, concat(c.first_name, ' ', c.last_name) as Fullname,
	b.bank_num as Bank_Number, b.bank_name as BankName, b.payment_receipt as Receipt, c.street
from Customer c inner join BankTransfer b on c.first_name = b.first_name
where b.bank_name = 'Wells Fargo' and c.street = 'Main St'; 

-- No#27 SQL Query 2: The List of Order Details order by Product Number
select concat('Date ',day(date),'/ ', month(date)) as Date,
product_num as Product_Number,
total_item as Total_Item,
delivery_fee as Delivery_Fee
from Orders
order by product_num ;

-- No#28 SQL Query 3: The List of Type of Coupon that use in more than 2 Orders
select note as TypeOfCoupon, sum(total_price) as Total_Price, count(total_price) as Total_order
from paymentoption group by note having Total_order > 1;

-- No#29 SQL Query 4:The List of Customer who have a membership 
select c.customer_ID,m.member_ID, account_ID, concat(c.first_name, ' ', c.last_name) as Fullname,
concat(m.mem_privilege, 'es') as member
from customer c inner join member m on c.customer_ID = m.customer_ID
where m.mem_privilege = 'Y';

-- No#30 SQL Query 5: The List of Customer’s Order Details
select concat(c.first_name, ' ', c.last_name) as Fullname, o.order_num, o.date, o.delivery_fee, o.total_item
from Customer c left outer join Orders o on c.customer_ID = o.order_num;



