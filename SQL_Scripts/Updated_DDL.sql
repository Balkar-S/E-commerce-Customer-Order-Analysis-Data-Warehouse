-- ===========================
-- Table: date_dim (Date Dimension)
-- Stores details related to dates for analysis and reporting.
-- ===========================
DROP TABLE IF EXISTS date_dim;

-- CREATE TABLE date_dim (
--     date_id INTEGER PRIMARY KEY,                          -- Unique ID for each date (surrogate key)
--     date_actual TIMESTAMP UNIQUE NOT NULL,                -- Actual date and time (unique)
--     date_day VARCHAR(20) NOT NULL,                       -- Name of the day (e.g., Monday)
--     date_month VARCHAR(20) NOT NULL,                     -- Name of the month (e.g., January)
--     date_day_number INTEGER NOT NULL,                   -- Day of the month (1-31)
--     date_month_number INTEGER NOT NULL,                -- Month number (1-12)
--     date_quarter INTEGER NOT NULL,                    -- Quarter of the year (1-4)
--     date_quarter_start TIMESTAMP NOT NULL,            -- Start date of the quarter
--     date_quarter_end TIMESTAMP NOT NULL,              -- End date of the quarter
--     date_year INTEGER NOT NULL                       -- Year (e.g., 2025)
-- );

CREATE TABLE date_dim (
    date_id INT PRIMARY KEY,
    date_actual DATE NOT NULL,
    date_day VARCHAR(20) NOT NULL,
    date_month VARCHAR(20) NOT NULL,
    date_day_month INT NOT NULL,
    date_month_number INT NOT NULL,
    date_quarter INT NOT NULL,
    date_quarter_start DATE NOT NULL,
    date_quarter_end DATE NOT NULL,
    date_year INT NOT NULL
);

-- ===========================
-- Table: product_dim (Product Dimension)
-- Stores product-related details.
-- ===========================

DROP TABLE IF EXISTS product_dim;

-- CREATE TABLE product_dim (
--     product_id INTEGER PRIMARY KEY,                     -- Unique ID for each product
--     product_key VARCHAR(50) UNIQUE NOT NULL,            -- Unique identifier for the product
--     product_name VARCHAR(100) NOT NULL,                 -- Name of the product
--     product_category VARCHAR(100) NOT NULL,            -- Category of the product (e.g., Electronics)
--     product_importance VARCHAR(20),                    -- Importance level (e.g., High, Medium, Low)
--     base_price DECIMAL(10, 2) NOT NULL,               -- Base price of the product
--     weight_class VARCHAR(50) NOT NULL,               -- Weight category (e.g., Light, Heavy)
--     storage_req VARCHAR(100) NOT NULL               -- Storage requirements (e.g., Dry, Refrigerated)
-- );

CREATE TABLE product_dim (
    Product_ID INT PRIMARY KEY,
    Product_Key VARCHAR(50) UNIQUE NOT NULL,
    Product_Name VARCHAR(255) NOT NULL,
    Product_Category VARCHAR(100) NOT NULL,
    Product_Importance VARCHAR(50),
    Base_Price DECIMAL(10, 2) NOT NULL,
    Weight_Class VARCHAR(50),
    Storage_Req VARCHAR(255)
);

-- ===========================
-- Table: warehouse_dim (Warehouse Dimension)
-- Stores details related to warehouses.
-- ===========================
DROP TABLE IF EXISTS warehouse_dim;

-- CREATE TABLE warehouse_dim (
--     warehouse_id INTEGER PRIMARY KEY,                    -- Unique ID for each warehouse
--     warehouse_block VARCHAR(20) NOT NULL,                -- Block or section identifier (e.g., A1, B2)
--     warehouse_capacity INTEGER NOT NULL,                -- Capacity of the warehouse in units or volume
--     warehouse_location VARCHAR(100) NOT NULL,                    -- Physical location (e.g., city or address)
--     temperature_control VARCHAR(50) NOT NULL,         -- Type of temperature control (e.g., Ambient, Refrigerated)
--     staff_count INTEGER NOT NULL                     -- Number of staff assigned to the warehouse
-- );

CREATE TABLE warehouse_dim (
    Warehouse_ID INT PRIMARY KEY,
    Warehouse_block VARCHAR(50) NOT NULL,
    Warehouse_Location VARCHAR(255) NOT NULL,
    Warehouse_Manager VARCHAR(100),
    Capacity INT,
    Size_in_acres DECIMAL(10, 2),
    Opening_Date DATE,
    Closing_Date DATE,
    Security_Features TEXT,
    Total_Staff_Count INT
);

-- ===========================
-- Table: customer_dim (Customer Dimension)
-- Stores customer-related details.
-- ===========================
DROP TABLE IF EXISTS customer_dim;

-- CREATE TABLE customer_dim (
--     customer_id INTEGER PRIMARY KEY,                     -- Unique ID for each customer
--     customer_firstname VARCHAR(100) NOT NULL,            -- First name of the customer
--     customer_lastname VARCHAR(100) NOT NULL,             -- Last name of the customer
--     gender VARCHAR(20),                                  -- Gender of the customer (e.g., Male, Female, Other)
--     city VARCHAR(100) NOT NULL,                         -- City of residence
--     province VARCHAR(100) NOT NULL,                    -- Province or state of residence
--     email VARCHAR(150) UNIQUE NOT NULL,               -- Customer email address (unique)
--     subscription_status VARCHAR(20) NOT NULL,        -- Subscription status (e.g., Active, Inactive)
--     customer_rating INTEGER,                        -- Rating score (e.g., 1-5)
--     customer_calls INTEGER NOT NULL               -- Number of customer service calls made by the customer
-- );


CREATE TABLE customer_dim (
    customer_id INT PRIMARY KEY,
    Customer_FirstName VARCHAR(50) NOT NULL,
    Customer_LastName VARCHAR(50) NOT NULL,
    customer_gender VARCHAR(10),
    customer_city VARCHAR(100),
    customer_province VARCHAR(100),
    customer_email VARCHAR(255) UNIQUE,
    customer_subscription_status BOOLEAN, -- changed from booleab to int
    Customer_Rating DECIMAL(3, 2),
    Customer_Calls INT
);


-- ===========================
-- Table: shipping_fact (Fact Table)
-- Stores detailed shipment-related information and links to dimension tables.
-- ===========================
DROP TABLE IF EXISTS shipping_fact;

-- CREATE TABLE shipping_fact (
--     shipping_id INTEGER PRIMARY KEY,                           -- Unique ID for each shipment
--     shipping_quantity INTEGER NOT NULL,                      -- Number of items shipped
--     shipping_cost DECIMAL(10, 2) NOT NULL,                  -- Cost of shipping
--     insurance_cost DECIMAL(10, 2),                        -- Cost of insurance (if applicable)
--     total_value DECIMAL(10, 2) NOT NULL,                 -- Total value of the shipment
--     return_cost DECIMAL(10, 2),                        -- Cost incurred if shipment is returned
--     estimated_weight_g INTEGER NOT NULL,              -- Estimated weight of the shipment in grams
--     warehouse_id INTEGER NOT NULL,                  -- Foreign key linking to warehouse_dim table
--     customer_id INTEGER NOT NULL,                 -- Foreign key linking to customer_dim table
--     product_id INTEGER NOT NULL,                -- Foreign key linking to product_dim table
--     shipping_mode VARCHAR(50) NOT NULL,        -- Mode of shipping (e.g., Ground, Air)
--     carrier_name VARCHAR(100) NOT NULL,      -- Name of the carrier (e.g., FedEx, UPS)
--     service_level VARCHAR(50) NOT NULL,     -- Service level (e.g., Standard, Express)
--     expected_delivery_date_id INTEGER NOT NULL, -- Foreign key linking to date_dim table (Expected delivery)
--     actual_delivery_date_id INTEGER,         -- Foreign key linking to date_dim table (Actual delivery)
--     transit_period INTEGER,                  -- Duration of the shipment in days
--     delivery_location_city VARCHAR(100) NOT NULL,  -- City of delivery
--     delivery_province VARCHAR(100) NOT NULL,      -- Province of delivery
--     FOREIGN KEY (warehouse_id) REFERENCES warehouse_dim(warehouse_id),
--     FOREIGN KEY (customer_id) REFERENCES customer_dim(customer_id),
--     FOREIGN KEY (product_id) REFERENCES product_dim(product_id),
--     FOREIGN KEY (expected_delivery_date_id) REFERENCES date_dim(date_id),
--     FOREIGN KEY (actual_delivery_date_id) REFERENCES date_dim(date_id)
-- );

CREATE TABLE shipping_fact (
    Shipping_ID INTEGER PRIMARY KEY,                           -- Unique ID for each shipment
    Shipping_Quantity INTEGER NOT NULL,                      -- Number of items shipped
    Shipping_Cost DECIMAL(10, 2) NOT NULL,                  -- Cost of shipping
    Insurance_Cost DECIMAL(10, 2),                        -- Cost of insurance (if applicable)
    Total_Value DECIMAL(10, 2) NOT NULL,                 -- Total value of the shipment
    Return_Cost DECIMAL(10, 2),                        -- Cost incurred if shipment is returned
    estimated_weight_g INTEGER NOT NULL,              -- Estimated weight of the shipment in grams
    Warehouse_ID INTEGER NOT NULL,                  -- Foreign key linking to WarehouseDimension table
    Customer_ID INTEGER NOT NULL,                 -- Foreign key linking to CustomerDimension table
    Product_ID INTEGER NOT NULL,                -- Foreign key linking to ProductDimension table
    Shipping_Mode VARCHAR(50) NOT NULL,        -- Mode of shipping (e.g., Ground, Air)
    Carrier_Name VARCHAR(100) NOT NULL,      -- Name of the carrier (e.g., FedEx, UPS)
    Service_Level VARCHAR(50) NOT NULL,     -- Service level (e.g., Standard, Express)
    Expected_Delivery_Date_id INTEGER NOT NULL, -- Foreign key linking to DateDimension table (Expected delivery)
    Actual_Delivery_Date_id INTEGER,         -- Foreign key linking to DateDimension table (Actual delivery)
    Transit_Period INTEGER,                  -- Duration of the shipment in days
    Delivery_Location_City VARCHAR(100) NOT NULL,  -- City of delivery
    Delivery_Province VARCHAR(100) NOT NULL,      -- Province of delivery
    FOREIGN KEY (Warehouse_ID) REFERENCES warehouse_dim (Warehouse_ID),
    FOREIGN KEY (Customer_ID) REFERENCES customer_dim (customer_id),
    FOREIGN KEY (Product_ID) REFERENCES product_dim (Product_ID),
    FOREIGN KEY (Expected_Delivery_Date_id) REFERENCES date_dim (date_id),
    FOREIGN KEY (Actual_Delivery_Date_id) REFERENCES date_dim (date_id)
);

-- ALTER TABLE customer_dim
-- ALTER COLUMN customer_subscription_status TYPE INTEGER
-- USING customer_subscription_status::integer;

SELECT conname
FROM pg_constraint
WHERE conrelid = 'customer_dim'::regclass
  AND contype = 'u';  -- 'u' stands for UNIQUE

ALTER TABLE customer_dim DROP CONSTRAINT customer_dim_customer_email_key;

ALTER TABLE date_dim
ALTER COLUMN date_quarter_start TYPE INTEGER USING EXTRACT(YEAR FROM date_quarter_start)::INT * 10000
                                           + EXTRACT(MONTH FROM date_quarter_start)::INT * 100
                                           + EXTRACT(DAY FROM date_quarter_start)::INT;

ALTER TABLE date_dim
ALTER COLUMN date_quarter_end TYPE INTEGER USING EXTRACT(YEAR FROM date_quarter_end)::INT * 10000
                                         + EXTRACT(MONTH FROM date_quarter_end)::INT * 100
                                         + EXTRACT(DAY FROM date_quarter_end)::INT;

ALTER TABLE date_dim
ALTER COLUMN date_quarter_end DROP NOT NULL;


ALTER TABLE warehouse_dim
ALTER COLUMN opening_date TYPE INTEGER
USING EXTRACT(YEAR FROM opening_date)::INT * 10000 +
      EXTRACT(MONTH FROM opening_date)::INT * 100 +
      EXTRACT(DAY FROM opening_date)::INT;

ALTER TABLE warehouse_dim
ALTER COLUMN closing_date TYPE INTEGER
USING EXTRACT(YEAR FROM closing_date)::INT * 10000 +
      EXTRACT(MONTH FROM closing_date)::INT * 100 +
      EXTRACT(DAY FROM closing_date)::INT;


DELETE FROM shipping_fact WHERE customer_id = 1640;