-- 9 .Write a query to display the order_id, customer id and cutomer full name of customers
-- along with (product_quantity) as total quantity of products shipped for order ids > 10060. (6
-- ROWS)
-- [NOTE: TABLES TO BE USED - online_customer, order_header, order_items]



SELECT OI.ORDER_ID, OC.CUSTOMER_ID, CONCAT(OC.CUSTOMER_FNAME,' ',OC.CUSTOMER_LNAME) AS CUSTOMER_NAME,OI.TOTAL_QUANTITY
FROM ORDERS.ORDER_HEADER OH
INNER JOIN
(
SELECT ORDER_ID,SUM(PRODUCT_QUANTITY) AS TOTAL_QUANTITY FROM ORDERS.ORDER_ITEMS
GROUP BY ORDER_ID
HAVING order_id >10060
) OI ## Pulling all the orders which are created after 10060
ON OH.ORDER_ID = OI.ORDER_ID AND OH.ORDER_STATUS = 'SHIPPED' ## from the above collection considering only those which are having order status as shipped
INNER JOIN ORDERS.ONLINE_CUSTOMER OC ON OH.CUSTOMER_ID = OC.CUSTOMER_ID;