USE lizzies_bakery;

-- The bakery is starting thier veganising plan !! were gonna remove eggs in all out products from now on.
-- this code deletes a certain ingredient in all recipes
SELECT COUNT(ingredient_id) -- counts number of rows in column. This is used to check how many changes occour and if there are many changes
FROM recipe_ingredients;
DELETE FROM recipe_ingredients 
WHERE ingredient_id = 5;-- deletes any ingredientt called eggs
SELECT COUNT(ingredient_id)-- recoounts number of rows are in the column
FROM recipe_ingredients;