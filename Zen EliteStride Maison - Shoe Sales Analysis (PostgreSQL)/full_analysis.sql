-- ============================================================
-- Zen EliteStride Maison — Full SQL Analysis (PostgreSQL / pgAdmin)
-- ============================================================
--
-- This script:
--   1. Creates the database schema (tables)
--   2. Cleans inconsistent text data via views
--   3. Answers all 7 core Business Questions with commented queries
--   4. Answers 5 advanced-SQL questions (window functions,
--      indexes, a stored procedure, and roles/privileges)
--
-- ============================================================
-- SECTION 1: SCHEMA
-- ============================================================
-- These CREATE TABLE statements define the structure your imported
-- CSV data will live in.
--
DROP TABLE IF EXISTS shoe_sales;
DROP TABLE IF EXISTS price;

-- "price" is the lookup/reference table: one row per product, holding
-- its selling price and unit cost.
CREATE TABLE price (
    product     VARCHAR(50) PRIMARY KEY,   -- unique product name, used to join to shoe_sales
    price       NUMERIC(10,2) NOT NULL,    -- selling price per unit
    cost        NUMERIC(10,2) NOT NULL     -- cost per unit (for profit calculations)
);

-- "shoe_sales" is the transaction table: one row per individual sale.
CREATE TABLE shoe_sales (
    sale_id       SERIAL PRIMARY KEY,      -- auto-incrementing unique ID for each sale
    sale_date     DATE NOT NULL,           -- date the sale happened
    product       VARCHAR(50) NOT NULL,    -- links to price.product
    category      VARCHAR(50),             -- e.g. Formal, Casual, Utility
    color         VARCHAR(30),
    brand         VARCHAR(50),
    country       VARCHAR(50),             -- where the sale happened
    quantity      INTEGER NOT NULL,        -- units sold in this transaction
    payment_type  VARCHAR(30)              -- e.g. Card, Cash, Bank Transfer, Mobile Money
);