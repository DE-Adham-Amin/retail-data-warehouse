/*
    Create Database and Schemas
    =====:
    Script Purpose:
    This script creates a new database named 'RetalDWH' after checking if it already exists.
    If the database exists, it is dropped and recreated. Additionally, the script sets up three schemas within the database: 'bronze', 'silver', and 'gold'
    WARNING:
    Running this script will drop the entire 'RetalDWH' database if it exists.
    All data in the database will be permanently deleted. Proceed with caution and ensure you have proper backups before running this script.
*/
USE master;

-- Check if the database already exists and drop it if it does
IF EXISTS (SELECT 1
           FROM   sys.databases
           WHERE  name = 'RetalDWH')
    BEGIN
        DROP DATABASE RetalDWH;
    END

-- Create the database
CREATE DATABASE RetalDWH;


GO
-- Use the newly created database
USE RetalDWH;


GO
-- Create the schemas
CREATE SCHEMA bronze;


GO
CREATE SCHEMA silver;


GO
CREATE SCHEMA gold;
