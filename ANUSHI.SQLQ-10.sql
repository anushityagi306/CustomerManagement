-- 10.Write a query to display product class description ,total quantity
-- (sum(product_quantity),Total value (product_quantity * product price) and show which class
-- of products have been shipped highest(Quantity) to countries outside India other than USA?
-- Also show the total value of those items.
-- (1 ROWS)[NOTE:PRODUCT TABLE,ADDRESS TABLE,ONLINE_CUSTOMER
-- TABLE,ORDER_HEADER TABLE,ORDER_ITEMS TABLE,PRODUCT_CLASS TABLE]

Select* from product_class;

SELECT OUT_QRY.PRODUCT_CLASS_DESC, SUM(OUT_QRY.PRODUCT_QUANTITY) PRODUCT_QUANTITY,
SUM(OUT_QRY.TOTAL_VALUE) TOTAL_VALUE, OUT_QRY.PRODUCT_CLASS_CODE

FROM
(
SELECT PC.PRODUCT_CLASS_DESC, OI.PRODUCT_QUANTITY,
(OI.PRODUCT_QUANTITY * P.PRODUCT_PRICE) TOTAL_VALUE, PC.PRODUCT_CLASS_CODE
FROM ORDERS.ORDER_ITEMS OI

INNER JOIN ORDERS.ORDER_HEADER OH
ON OH.ORDER_ID = OI.ORDER_ID AND OH.ORDER_STATUS = 'SHIPPED' ## Only interested in orders for which current status is marked as 'Shipped'

INNER JOIN

ORDERS.ONLINE_CUSTOMER OC ON OH.CUSTOMER_ID = OC.CUSTOMER_ID
INNER JOIN ORDERS.ADDRESS A ON OC.ADDRESS_ID = A.ADDRESS_ID AND A.COUNTRY NOT IN
('India','USA') ## Pulling the orders which are tied to an address which is not an India address or USA address

LEFT JOIN ORDERS.PRODUCT P ON OI.PRODUCT_ID = P.PRODUCT_ID

LEFT JOIN ORDERS.PRODUCT_CLASS PC ON P.PRODUCT_CLASS_CODE =

PC.PRODUCT_CLASS_CODE

) OUT_QRY

GROUP BY OUT_QRY.PRODUCT_CLASS_CODE, OUT_QRY.PRODUCT_CLASS_DESC ORDER BY
SUM(OUT_QRY.PRODUCT_QUANTITY) DESC
LIMIT 1 ## Order by descending will arrange the out come in decreasing order of Product Quantity, and Limit 1 will display only 1 record;