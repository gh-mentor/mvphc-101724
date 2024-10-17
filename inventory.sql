/*
This file contains a script of Transact SQL (T-SQL) command to interact with a database 'Inventory'.
Requirements:
- SQL Server 2022 is installed and running
- database 'Inventory' already exists.
Details:
- Check if the database 'Inventory' exists, if not, exit with an error message.
- Sets the default database to 'Inventory'.
- Create a 'categories' table and related 'products' table if they do not already exist.
- Remove all rows from the tables.
- Populate the 'categories' table with sample data.
- Populate the 'products' table with sample data.
- Create stored procedures 'GetAllCategories' to get all categories.
- Create a stored procedure to get all products in a specific category.
- Create a stored procudure to get all products in a specific price range sorted by price in ascending order.
*/

-- Check if the database 'Inventory' exists, if not, exit with an error message.
IF NOT EXISTS (SELECT name FROM master.dbo.sysdatabases WHERE name = N'Inventory')
BEGIN
    PRINT 'Database [Inventory] does not exist. Please create the database and run this script again.'
    RETURN
END

-- Sets the default database to 'Inventory'.
USE Inventory
GO

-- Create a 'categories' table if it does not already exist.
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'categories')
BEGIN
    CREATE TABLE categories (
        category_id INT PRIMARY KEY,
        category_name NVARCHAR(50) NOT NULL,
        -- add a description column that is text type max 255 characters
        description NVARCHAR(255)
    )
END

-- Create a 'products' table if it does not already exist.
IF NOT EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'products')
BEGIN
    CREATE TABLE products (
        product_id INT PRIMARY KEY,
        product_name NVARCHAR(50) NOT NULL,
        category_id INT NOT NULL,
        price DECIMAL(10, 2) NOT NULL,
        stock_quantity INT NOT NULL,
        FOREIGN KEY (category_id) REFERENCES categories(category_id),
        -- add a description column that is text type max 255 characters
        description NVARCHAR(255),
        -- add a column for the date the product was added
        -- add a created_at column that is a datetime type
        created_at DATETIME,
        -- add an updated_at column that is a datetime type
        updated_at DATETIME

    )
END

-- Remove all rows from the tables. Remove Products first to avoid foreign key constraint violation.
DELETE FROM products WHERE 1=1 
DELETE FROM categories WHERE 1=1

-- Populate the 'categories' table with sample data.
INSERT INTO categories (category_id, category_name, description) VALUES
(1, 'Electronics', 'Electronic devices and accessories'),
(2, 'Clothing', 'Apparel and accessories'),
(3, 'Home Goods', 'Household items and decor'),
(4, 'Books', 'Literature and educational materials'),
(5, 'Toys', 'Children''s playthings')

-- Populate the 'products' table with sample data.
INSERT INTO products (product_id, product_name, category_id, price, stock_quantity, description, created_at, updated_at) VALUES
(1, 'Laptop', 1, 999.99, 10, 'High-performance laptop', GETDATE(), GETDATE()),
(2, 'Smartphone', 1, 599.99, 20, 'Latest smartphone model', GETDATE(), GETDATE()),
(3, 'T-shirt', 2, 19.99, 50, 'Cotton t-shirt', GETDATE(), GETDATE()),
(4, 'Jeans', 2, 39.99, 30, 'Denim jeans', GETDATE(), GETDATE()),
(5, 'Couch', 3, 499.99, 5, 'Comfortable couch', GETDATE(), GETDATE()),
(6, 'Dining Table', 3, 299.99, 10, 'Wooden dining table', GETDATE(), GETDATE()),
(7, 'Harry Potter', 4, 14.99, 100, 'Fantasy novel', GETDATE(), GETDATE()),
(8, 'LEGO Set', 5, 29.99, 25, 'Building blocks set', GETDATE(), GETDATE())

-- Create a stored procedure 'GetAllCategories' to get all categories.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'GetAllCategories' AND type = 'P')
BEGIN
    DROP PROCEDURE GetAllCategories
END

CREATE PROCEDURE GetAllCategories
AS
BEGIN
    SELECT * FROM categories
END

-- Create a stored procedure to get all products in a specific category.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'GetProductsByCategory' AND type = 'P')
BEGIN
    DROP PROCEDURE GetProductsByCategory
END

CREATE PROCEDURE GetProductsByCategory
    @category_id INT
AS
BEGIN
    SELECT * FROM products WHERE category_id = @category_id
END

-- Create a stored procedure to get all products in a specific price range sorted by price in ascending order.
IF EXISTS (SELECT * FROM sysobjects WHERE name = 'GetProductsByPriceRange' AND type = 'P')
BEGIN
    DROP PROCEDURE GetProductsByPriceRange
END

CREATE PROCEDURE GetProductsByPriceRange
    @min_price DECIMAL(10, 2),
    @max_price DECIMAL(10, 2)
AS
BEGIN
    SELECT * FROM products WHERE price BETWEEN @min_price AND @max_price ORDER BY price ASC
END

PRINT 'Inventory database setup completed.'


