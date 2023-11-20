SELECT
    --sales.orders.order_status,
    --sales.order_items.quantity,
    --sales.order_items.list_price,
    production.products.product_name,
    SUM(sales.order_items.quantity * sales.order_items.list_price) AS "TotalPrice",
    SUM(sales.order_items.quantity) AS "TotalSold"
FROM sales.orders
  INNER JOIN sales.order_items ON sales.orders.order_id = sales.order_items.order_id
  INNER JOIN production.products ON sales.order_items.product_id = production.products.product_id
GROUP BY production.products.product_id
ORDER BY "TotalSold" DESC
LIMIT 10
;

-- Another way to write it.
SELECT
	pp.product_name,
	q."TotalSold"
FROM
	(SELECT
		pp.product_id,
		SUM(sales.order_items.quantity) AS "TotalSold"
	FROM sales.orders
	  INNER JOIN sales.order_items ON sales.orders.order_id = sales.order_items.order_id
	  INNER JOIN production.products AS pp ON sales.order_items.product_id = pp.product_id
	GROUP BY pp.product_id

	) AS q
    INNER JOIN production.products AS pp ON q.product_id = pp.product_id
ORDER BY "TotalSold" DESC
LIMIT 10
;
