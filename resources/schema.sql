-- If not in standard Python library, install sqlite3 module from terminal
% pip install sqlite

-- Run sqlite and create db from terminal
% sqlite3 heart.sqlite
-- Alternatively:
-- CREATE DATABASE heart.sqlite;

-- Create table for original CSV file data
sqlite>
CREATE TABLE IF NOT EXISTS original (
    Age TINYINT,
    Sex CHAR,
    ChestPainType CHAR(3),
    RestingBP INT,
    Cholesterol INT,
    FastingBS INT,
    RestingECG VARCHAR,
    MaxHR INT,
    ExerciseAngina VARCHAR(1),
    Oldpeak FLOAT,
    ST_Slope VARCHAR,
    HeartDisease TINYINT(1)
);

-- Confirm table creation and schema
sqlite> .table
sqlite> .schema

-- Import CSV dataset from file directory
-- “skip 1” ignores the CSV headers
sqlite> .mode csv
sqlite> .import -skip 1 heart.csv original

-- Alternative to using .mode 
sqlite> .import --csv --skip 1 heart.csv original

-- Example queries to confirm successful import
SELECT * FROM original LIMIT(5);
SELECT * FROM original WHERE (age = 40) LIMIT(5);

-- Repeat steps for creation of table without zeros
sqlite>
CREATE TABLE IF NOT EXISTS noZeros (
    Age TINYINT,
    Sex CHAR,
    ChestPainType CHAR(3),
    RestingBP INT,
    Cholesterol INT,
    FastingBS INT,
    RestingECG VARCHAR,
    MaxHR INT,
    ExerciseAngina VARCHAR(1),
    Oldpeak FLOAT,
    ST_Slope VARCHAR,
    HeartDisease TINYINT(1)
);

-- Import CSV dataset from file directory
-- “skip 1” ignores the CSV headers
sqlite> .import --csv --skip 1 heart_no_zeros.csv noZeros

-- Repeat steps for creation of table with replaced values
sqlite>
CREATE TABLE IF NOT EXISTS replaced (
    Age TINYINT,
    Sex CHAR,
    ChestPainType CHAR(3),
    RestingBP INT,
    Cholesterol INT,
    FastingBS INT,
    RestingECG VARCHAR,
    MaxHR INT,
    ExerciseAngina VARCHAR(1),
    Oldpeak FLOAT,
    ST_Slope VARCHAR,
    HeartDisease TINYINT(1)
);

-- Import CSV dataset from file directory
-- “skip 1” ignores the CSV headers
sqlite> .import --csv --skip 1 heart_replaced_values.csv replaced