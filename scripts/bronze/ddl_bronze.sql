/*
    Create Bronze Layer Tables
    ==========================

    Script Purpose:
    This script creates the source tables inside the Bronze schema
    of the Retail Data Warehouse database.

    The Bronze layer stores raw data ingested from four source files:
    1. Customer Data.
    2. Product Data.
    3. Sales Data.
    4. Store Data.

    Tables Created:

    1. bronze.customer_data - Stores customer information.
    2. bronze.product_data  - Stores product information.
    3. bronze.sales_data    - Stores sales transaction details.
    4. bronze.store_data    - Stores store information.

    WARNING:
    All Bronze tables are dropped and recreated if they already exist.
    This permanently deletes their existing data.
*/
USE RetalDWH;


GO
-- =====================================================
-- CUSTOMER SOURCE TABLE
-- =====================================================
-- =====================================================
-- 1. Create Customer Data Table
-- =====================================================
-- Check if the table already exists and drop it if it does
IF OBJECT_ID('bronze.customer_data', 'U') IS NOT NULL
    DROP TABLE bronze.customer_data;

-- Create the Customer Data table
CREATE TABLE bronze.customer_data (
    customer_id NVARCHAR (50) , -- Customer ID
    age         INT           , -- Customer Age
    gender      NVARCHAR (50) , -- Customer Gender
    city        NVARCHAR (50) , -- Customer City
    email       NVARCHAR (100) -- Customer Email
);


GO
-- =====================================================
-- PRODUCT SOURCE TABLE
-- =====================================================
-- =====================================================
-- 2. Create Product Data Table
-- =====================================================
-- Check if the table already exists and drop it if it does
IF OBJECT_ID('bronze.product_data', 'U') IS NOT NULL
    DROP TABLE bronze.product_data;

-- Create the Product Data table
CREATE TABLE bronze.product_data (
    product_id NVARCHAR (50) , -- Product ID
    category   NVARCHAR (50) , -- Product Category
    color      NVARCHAR (50) , -- Product Color
    size       NVARCHAR (50) , -- Product Size
    season     NVARCHAR (50) , -- Product Season
    supplier   NVARCHAR (50) , -- Product Supplier
    cost_price DECIMAL (8, 2), -- Product Cost Price
    list_price DECIMAL (8, 2) -- Product List Price
);


GO
-- =====================================================
-- SALES SOURCE TABLE
-- =====================================================
-- =====================================================
-- 3. Create Sales Data Table
-- =====================================================
-- Check if the table already exists and drop it if it does
IF OBJECT_ID('bronze.sales_data', 'U') IS NOT NULL
    DROP TABLE bronze.sales_data;

-- Create the Sales Data table
CREATE TABLE bronze.sales_data (
    transaction_id NVARCHAR (50) , -- Transaction ID
    date           DATE          , -- Transaction Date
    product_id     NVARCHAR (50) , -- Product ID
    store_id       NVARCHAR (50) , -- Store ID
    customer_id    NVARCHAR (50) , -- Customer ID
    quantity       INT           , -- Quantity Sold
    discount       DECIMAL (3, 1), -- Discount Percentage
    returned       INT            -- Return Status
);


GO
-- =====================================================
-- STORE SOURCE TABLE
-- =====================================================
-- =====================================================
-- 4. Create Store Data Table
-- =====================================================
-- Check if the table already exists and drop it if it does
IF OBJECT_ID('bronze.store_data', 'U') IS NOT NULL
    DROP TABLE bronze.store_data;

-- Create the Store Data table
CREATE TABLE bronze.store_data (
    store_id      NVARCHAR (50), -- Store ID
    store_name    NVARCHAR (50), -- Store Name
    region        NVARCHAR (50), -- Store Region
    store_size_m2 INT           -- Store Size in Square Meters
);
