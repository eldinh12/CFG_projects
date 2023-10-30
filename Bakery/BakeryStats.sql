USE lizzies_bakery;

-- retreives data from recipes in products column and counts total products produced
SELECT SUM(r.product) AS total_product_made
FROM recipes r;

-- retrieves data from recipes and finds the product of two columns to calculate the total amount that would be made from these products using the aggregate function SUM
SELECT SUM(r.product*r.price) as total_profit
FROM recipes r;

-- retrieves data from an inner join of recipe_ingredients and recipes where the amount of ingredient used reletive to stock is multipleid by the price
-- per each ingredient multiplied by the total product made so far using aggregate function SUM
SELECT SUM(ri.stock_unit_conversion * i.price_per_unit * r.product) as total_loss
FROM recipe_ingredients ri
INNER JOIN ingredients_stock i
ON ri.ingredient_id = i.ingredient_id
INNER JOIN recipes r
ON ri.recipe_id = r.recipe_id;

-- selects value with the max product and awards it best selling using aggregate function MAX
SELECT r.recipe_name, MAX(r.product) AS best_selling
FROM recipes r
GROUP BY r.recipe_name;