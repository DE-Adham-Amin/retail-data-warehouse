/*
    Stored Procedure: Load Bronze Layer
    ====================================

    Script Purpose:
    This stored procedure loads raw data from four Retail CSV files
    into their corresponding tables in the Bronze layer.

    Loading Strategy:
    1. Truncate existing data from each Bronze table.
    2. Load fresh data using BULK INSERT.
    3. Measure and display the loading duration for each table.
    4. Measure and display the total batch execution time.
    5. Handle errors using TRY...CATCH.

    Source Files:
    1. customer_data.csv
    2. product_data.csv
    3. sales_data.csv
    4. store_data.csv

    Important Notes:
    - Existing data is deleted before each load.
    - CSV files are accessed from the Docker container.
    - FIRSTROW = 2 skips the CSV header.
    - TABLOCK optimizes bulk insert operations.
*/

USE RetalDWH;

GO

-- =====================================================
-- Create Stored Procedure: bronze.load_bronze
-- =====================================================
CREATE OR ALTER PROCEDURE bronze.load_bronze
AS
BEGIN
    BEGIN TRY

        -- Declare variables for tracking execution time
        DECLARE
            @start_date DATETIME,
            @end_date DATETIME,
            @batch_start_time DATETIME,
            @batch_end_time DATETIME;

        -- =====================================================
        -- Start Bronze Layer Loading
        -- =====================================================
        PRINT '=====================================================';
        PRINT '              BRONZE LAYER LOADING                  ';
        PRINT '=====================================================';

        -- Record the batch start time
        SET @batch_start_time = GETDATE();

        -- =====================================================
        -- RETAIL SOURCE FILES
        -- =====================================================
        PRINT '';
        PRINT '-----------------------------------------------------';
        PRINT '              LOADING RETAIL TABLES                  ';
        PRINT '-----------------------------------------------------';

        -- -----------------------------------------------------
        -- 1. Load Customer Data
        -- -----------------------------------------------------
        SET @start_date = GETDATE();

        PRINT '';
        PRINT '>> Loading Table: bronze.customer_data';

        -- Remove existing data before loading fresh data
        TRUNCATE TABLE bronze.customer_data;

        -- Load customer information from the source CSV file
        BULK INSERT bronze.customer_data
        FROM '/var/opt/mssql/datasets/customer_data.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_date = GETDATE();

        PRINT '   Status: SUCCESS';
        PRINT '   Duration: ' + CAST(DATEDIFF(SECOND, @start_date, @end_date) AS VARCHAR) + ' Seconds';


        -- -----------------------------------------------------
        -- 2. Load Product Data
        -- -----------------------------------------------------
        SET @start_date = GETDATE();

        PRINT '';
        PRINT '>> Loading Table: bronze.product_data';

        -- Remove existing data before loading fresh data
        TRUNCATE TABLE bronze.product_data;

        -- Load product information from the source CSV file
        BULK INSERT bronze.product_data
        FROM '/var/opt/mssql/datasets/product_data.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_date = GETDATE();

        PRINT '   Status: SUCCESS';
        PRINT '   Duration: ' + CAST(DATEDIFF(SECOND, @start_date, @end_date) AS VARCHAR) + ' Seconds';


        -- -----------------------------------------------------
        -- 3. Load Sales Data
        -- -----------------------------------------------------
        SET @start_date = GETDATE();

        PRINT '';
        PRINT '>> Loading Table: bronze.sales_data';

        -- Remove existing data before loading fresh data
        TRUNCATE TABLE bronze.sales_data;

        -- Load sales transactions from the source CSV file
        BULK INSERT bronze.sales_data
        FROM '/var/opt/mssql/datasets/sales_data.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_date = GETDATE();

        PRINT '   Status: SUCCESS';
        PRINT '   Duration: ' + CAST(DATEDIFF(SECOND, @start_date, @end_date) AS VARCHAR) + ' Seconds';


        -- -----------------------------------------------------
        -- 4. Load Store Data
        -- -----------------------------------------------------
        SET @start_date = GETDATE();

        PRINT '';
        PRINT '>> Loading Table: bronze.store_data';

        -- Remove existing data before loading fresh data
        TRUNCATE TABLE bronze.store_data;

        -- Load store information from the source CSV file
        BULK INSERT bronze.store_data
        FROM '/var/opt/mssql/datasets/store_data.csv'
        WITH (
            FIRSTROW = 2,
            FIELDTERMINATOR = ',',
            TABLOCK
        );

        SET @end_date = GETDATE();

        PRINT '   Status: SUCCESS';
        PRINT '   Duration: ' + CAST(DATEDIFF(SECOND, @start_date, @end_date) AS VARCHAR) + ' Seconds';


        -- =====================================================
        -- Batch Execution Summary
        -- =====================================================
        SET @batch_end_time = GETDATE();

        PRINT '';
        PRINT '=====================================================';
        PRINT '           BRONZE LOADING SUMMARY                   ';
        PRINT '=====================================================';
        PRINT '   Status: SUCCESS';
        PRINT '   Total Execution Time: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' Seconds';
        PRINT '=====================================================';
        PRINT '          BRONZE LAYER LOAD COMPLETED                ';
        PRINT '=====================================================';

    END TRY

    BEGIN CATCH

        -- =====================================================
        -- Error Handling
        -- =====================================================
        PRINT '';
        PRINT '=====================================================';
        PRINT '              BRONZE LOADING FAILED                  ';
        PRINT '=====================================================';
        PRINT '   Error Message: ' + ERROR_MESSAGE();
        PRINT '   Error Number: ' + CAST(ERROR_NUMBER() AS VARCHAR);
        PRINT '   Error State: ' + CAST(ERROR_STATE() AS VARCHAR);
        PRINT '   Error Line: ' + CAST(ERROR_LINE() AS VARCHAR);
        PRINT '=====================================================';

        THROW;

    END CATCH
END;

GO

-- Execute Bronze Loading Procedure
EXECUTE bronze.load_bronze;
