-- 8 .Write a query to display details (customer id,customer fullname,order id,product
-- quantity) of customers who bought more than ten (i.e. total order qty) products per shipped
-- order.
-- (11 ROWS) [NOTE: TABLES TO BE USED - online_customer, order_header, order_items,] 

Select * from order_header;
select* from order_items;


SELECT C.CUSTOMER_ID, C.CUSTOMER_FULLNAME, OUT_QRY.PRODUCT_QUANTITY,
H.ORDER_ID FROM
(
SELECT ORDER_ID, PRODUCT_QUANTITY FROM
ORDERS.ORDER_ITEMS GROUP BY ORDER_ID
HAVING SUM(PRODUCT_QUANTITY) > 10
) OUT_QRY
INNER JOIN ORDERS.ORDER_HEADER H ON OUT_QRY.ORDER_ID = H.ORDER_ID AND
H.ORDER_STATUS = 'SHIPPED'
INNER JOIN
(
SELECT DISTINCT CUSTOMER_ID,
CONCAT(CUSTOMER_FNAME,' ',CUSTOMER_LNAME) AS CUSTOMER_FULLNAME
FROM ORDERS.ONLINE_CUSTOMER
) C ON H.CUSTOMER_ID = C.CUSTOMER_ID
ORDER BY C.CUSTOMER_ID;