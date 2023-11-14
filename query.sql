CREATE OR REPLACE PROCEDURE GetMountainBikesByBrand(_brand VARCHAR(255), INOUT result refcursor)
LANGUAGE 'plpgsql'
AS $BODY$
BEGIN
    open result for
        SELECT
          product_name,
          model_year,
          list_price
        FROM production.products
          INNER JOIN production.brands ON production.brands.brand_id = production.products.brand_id
        WHERE brand_name=_brand
        ORDER BY product_name ASC
    ;
END;
$BODY$;

BEGIN;
CALL GetMountainBikesByBrand('Trek',  'test');
fetch all in "test";
COMMIT;

/*
SELECT
  product_name,
  model_year,
  list_price
FROM production.products
  INNER JOIN production.brands ON production.brands.brand_id = production.products.brand_id
WHERE brand_name=@brand
ORDER BY product_name ASC;
*/
