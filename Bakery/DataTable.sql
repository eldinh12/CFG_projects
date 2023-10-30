CREATE DATABASE IF NOT EXISTS lizzies_bakery;
USE lizzies_bakery;

-- I am using this database to imitate a working bakery (as I myself work in a bakery) and decreace and increase stock as required when certain recipes are used.alter
-- This program is used to predict how much stock is used and predict when a certain stock of ingredient requires restocking.


-- Table for a list of recipes
CREATE TABLE IF NOT EXISTS recipes (
    recipe_id integer NOT NULL UNIQUE,
    recipe_name varchar(50) NOT NULL,
    product integer,-- how much product we make
    price float,
    CONSTRAINT pk_recipe_id
	PRIMARY KEY (recipe_id)
);

-- List of ingredients and their stock inc stok in weight measurements
CREATE TABLE IF NOT EXISTS ingredients_stock (
    ingredient_id integer NOT NULL UNIQUE,
    ingredient_name varchar (50),
    amount_per_unit float,
    unit_id integer NOT NULL,
    stock_count float,
    total_quantity float AS (amount_per_unit * stock_count),-- how much stock is left in weight measurements
    price_per_unit float,
    CONSTRAINT pk_ingredient_id
    PRIMARY KEY (ingredient_id)
);

-- table for unit measures
CREATE TABLE IF NOT EXISTS unit_measure (
    unit_id integer NOT NULL UNIQUE,
    unit_name varchar(50),
    unit_shorthand varchar(10),
    CONSTRAINT pk_unit_id
    PRIMARY KEY (unit_id)
);

-- table for each ingredients and thir amounts to fullfill a specific recipe. Normalised data having seperated each column into seperate tables.
CREATE TABLE IF NOT EXISTS recipe_ingredients (
	id integer NOT NULL UNIQUE,
    recipe_id integer NOT NULL,
    ingredient_id integer NOT NULL,
    unit_id integer NOT NULL,
    amount float(2),
    stock_unit_conversion float(2), -- amount of ingredients reletive to stock
    CONSTRAINT pk_id
    PRIMARY KEY (id)
);

-- inserting data
INSERT INTO recipes 
(recipe_id, recipe_name, product, price)
VALUES
(1, 'Cinnamon Buns', 0, 150),
(2, 'Patissaries', 0, 200),
(3, 'Babka', 0, 45),
(4, 'Foccacia', 0, 70),
(5, 'Sourdough Loaf', 0, 230),
(6, 'Brownie', 0, 125);

-- inserting data
INSERT INTO ingredients_stock
(ingredient_id, ingredient_name, amount_per_unit, unit_id, stock_count, price_per_unit)
VALUES
(1, 'Flour', 25, '1', 50, 15),
(2, 'Butter', 1, '1', 25, 10),
(3, 'Dark Chocolate', 4, '1', 1, 20),
(4, 'Dry Yeast', 500, '6', 2, 3),
(5, 'Eggs', 1, 11, 300, 10),
(6, 'Milk', 2, '3', 20, 10),
(7, 'Cinnamon', 25, '1', 3, 40),
(8, 'Sugar', 25, '1', 5, 20),
(9, 'Salt', 2, '1', 8, 5),
(10, 'Olive Oil', 3, '2', 7, 50);

-- inserting data
INSERT INTO unit_measure
(unit_id, unit_name, unit_shorthand)
VALUES
(1, 'kilograms', 'kg'),
(2, 'litres', 'l'),
(3, 'pints', 'pt'),
(4, 'ounce', 'oz'),
(5, 'gallon', 'gal'),
(6, 'grams', 'g'),
(7, 'teaspoon', 'tsp'),
(8, 'tablespoon', 'tbsp'),
(9, 'cups', NULL),
(10, 'millerlitres', 'ml'),
(11, 'egg', NULL);


-- inserting data using ID from other tables
INSERT INTO recipe_ingredients
(id, recipe_id, ingredient_id, unit_id, amount, stock_unit_conversion)
VALUES
(1, 1, 1, 6, 800, 0.032),
(2, 1, 5, 11, 6, 6),
(3, 1, 2, 6, 540, 0.54),
(4, 1, 8, 6, 300, 1.2),
(5, 1, 6, 10, 300, 0.27),
(6, 1, 9, 7, 1, 0.0006),
(7, 1, 7, 6, 150, 0.2),
(8, 1, 4, 8, 3, 0.3),
(9, 2, 1, 1, 10.32, 0.45),
(10, 2, 2, 1, 3, 3),
(11, 2, 8, 1, 3, 0.3),
(12, 2, 9, 6, 150, 0.16),
(13, 2, 6, 2, 2.7, 2.5),
(14, 2, 4, 6, 120, 0.3),
(15, 3, 1, 1, 6.23, 0.2),
(16, 3, 8, 5, 400, 0.23),
(17, 3, 9, 7, 3, 0.0012),
(18, 3, 4, 8, 2, 0.05),
(19, 4, 1, 1, 12.3, 0.5),
(20, 4, 9, 6, 270, 0.125),
(21, 4, 4, 6, 135, 0.54),
(22, 4, 10, 10, 750, 0.25),
(23, 5, 1, 1, 32.4, 1.2),
(24, 5, 9, 6, 800, 0.45),
(25, 6, 3, 6, 500, 3),
(26, 6, 1, 6, 400, 0.07),
(27, 6, 2, 6, 500, 0.5),
(28, 6, 6, 10, 150, 0.26),
(29, 6, 5, 11, 7, 7),
(30, 6, 9, 6, 70, 0.0043);

-- refering to recipe_id from recipes table in recipe_ingredients
ALTER TABLE recipe_ingredients
ADD CONSTRAINT fk_recipe_id
FOREIGN KEY(recipe_id)
REFERENCES recipes(recipe_id);

-- refering to ingredient_id from ingredients_stock table in recipe_ingredients
ALTER TABLE recipe_ingredients
ADD CONSTRAINT fk_ingredient_id
FOREIGN KEY(ingredient_id)
REFERENCES ingredients_stock(ingredient_id);

-- refering to unit_id from unit_measure table in recipe_ingredients
ALTER TABLE recipe_ingredients
ADD CONSTRAINT fk_unit_id
FOREIGN KEY(unit_id)
REFERENCES unit_measure(unit_id);

-- refering to ingredient_id from ingredients_stock table in ingredients_stock
ALTER TABLE ingredients_stock
ADD CONSTRAINT fk_ingredient_unit_id
FOREIGN KEY(unit_id)
REFERENCES unit_measure(unit_id);

-- retrieves data and shows recipe_ingredients in a readable format using inner join to refer to relating table
SELECT r.recipe_name, i.ingredient_name, ri.amount, u.unit_shorthand, ri.stock_unit_conversion 
FROM recipe_ingredients ri
INNER JOIN recipes r
ON ri.recipe_id = r.recipe_id
INNER JOIN ingredients_stock i
ON ri.ingredient_id = i.ingredient_id
INNER JOIN unit_measure u
ON ri.unit_id = u.unit_id
ORDER BY r.recipe_name;






