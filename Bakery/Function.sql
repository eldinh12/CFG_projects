USE lizzies_bakery


DELIMITER //
-- creating stored prcedure to decrease ingredients stock when using a specific recipe 
-- while increasing the amount of product made and restocking when stock in any catergory goes below or equal to 2
CREATE PROCEDURE update_stock_and_product(IN recipe_id_use INT)
BEGIN
    -- Update ingredients_stock based on choosen recipe
    UPDATE ingredients_stock i
    INNER JOIN recipe_ingredients ri
    ON i.ingredient_id = ri.ingredient_id
    SET i.stock_count = i.stock_count - ri.stock_unit_conversion -- minuses amount of ingredient used in terms of stock and takes that away from total stock
    WHERE ri.recipe_id = recipe_id_use;

    -- Increase stock_count by 10 when stock_count <= 2
    UPDATE ingredients_stock
    SET stock_count = stock_count + 10
    WHERE FLOOR(stock_count) <= 2; -- using in built function to make any decimal of 2 would mean restock occours not just two
    
	-- Update quantity in recipes table
    UPDATE recipes
    SET product = product + 1
    WHERE recipe_id = recipe_id_use;

    -- Retrieve data from ingredients_stock to show change in stock
    SELECT ingredient_name, stock_count, total_quantity
    FROM ingredients_stock;
    
    -- retrieves data from recipes to show change in product
    SELECT recipe_name, product
    FROM recipes;
END //

DELIMITER ;

-- calls function and passes recipe id
CALL update_stock_and_product(3);-- CHANGE THIS TO ANY NUMBER THAT REFERS TO A RECIPES_NAME IN RECIPES (1 - 6) TO SEE CHANGES IN STOCK
