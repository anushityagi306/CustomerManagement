-- 7 .Write a query to display carton id, (len*width*height) as carton_vol and identify the
-- optimum carton (carton with the least volume whose volume is greater than the total
-- volume of all items (len * width * height * product_quantity)) for a given order whose order
-- id is 10006, Assume all items of an order are packed into one single carton (box). (1 ROW)
use orders;
show tables;
select * from carton;

SELECT C.CARTON_ID, (C.LEN*C.WIDTH*C.HEIGHT) as VOL FROM
ORDERS.CARTON C
WHERE (C.LEN*C.WIDTH*C.HEIGHT) >= (
select
SUM(P.LEN*P.WIDTH*P.HEIGHT*PRODUCT_QUANTITY) as VOL
FROM ORDERS.ORDER_HEADER OH
INNER JOIN ORDERS.ORDER_ITEMS OI ON OH.ORDER_ID = OI.ORDER_ID
INNER JOIN ORDERS.PRODUCT P ON OI.PRODUCT_ID =
P.PRODUCT_ID
WHERE OH.ORDER_ID =10006 ## Filtered the only address
)
ORDER BY (C.LEN*C.WIDTH*C.HEIGHT) ASC
LIMIT 1 ## Order by descending will arrange the out come in decreasing order  of Product  of Len*Width*Height, and Limit 1 will display only 1 record;


 
 