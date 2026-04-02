-- ============================================================
-- UBER RIDE ANALYSIS - SQL QUERIES
-- Dataset: 150,000 Uber Rides (2024)
-- ============================================================

-- ============================================================
-- 1. DATABASE SETUP
-- ============================================================

CREATE DATABASE uber_analysis;
USE uber_analysis;

-- ============================================================
-- 2. OVERVIEW ANALYSIS
-- ============================================================

-- Total Rides
SELECT COUNT(*) AS Total_Rides FROM uber;

-- Booking Status Distribution
SELECT 
    `Booking Status`, 
    COUNT(*) AS Total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM uber), 2) AS Percentage
FROM uber
GROUP BY `Booking Status`
ORDER BY Total DESC;

-- Total Revenue (Completed Rides only)
SELECT ROUND(SUM(`Booking Value`), 2) AS Total_Revenue
FROM uber
WHERE `Booking Status` = 'Completed';

-- ============================================================
-- 3. VEHICLE TYPE ANALYSIS
-- ============================================================

-- Ride Count by Vehicle Type
SELECT 
    `Vehicle Type`, 
    COUNT(*) AS Total_Rides
FROM uber
GROUP BY `Vehicle Type`
ORDER BY Total_Rides DESC;

-- Revenue by Vehicle Type
SELECT 
    `Vehicle Type`, 
    ROUND(SUM(`Booking Value`), 2) AS Total_Revenue
FROM uber
WHERE `Booking Status` = 'Completed'
GROUP BY `Vehicle Type`
ORDER BY Total_Revenue DESC;

-- Average Driver Rating by Vehicle Type
SELECT 
    `Vehicle Type`, 
    ROUND(AVG(`Driver Ratings`), 2) AS Avg_Driver_Rating
FROM uber
WHERE `Driver Ratings` IS NOT NULL
GROUP BY `Vehicle Type`
ORDER BY Avg_Driver_Rating DESC;

-- ============================================================
-- 4. REVENUE ANALYSIS
-- ============================================================

-- Revenue by Payment Method
SELECT 
    `Payment Method`, 
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(`Booking Value`), 2) AS Total_Revenue,
    ROUND(AVG(`Booking Value`), 2) AS Avg_Booking_Value
FROM uber
WHERE `Booking Status` = 'Completed'
GROUP BY `Payment Method`
ORDER BY Total_Revenue DESC;

-- Average Booking Value by Vehicle Type
SELECT 
    `Vehicle Type`, 
    ROUND(AVG(`Booking Value`), 2) AS Avg_Booking_Value
FROM uber
WHERE `Booking Status` = 'Completed'
GROUP BY `Vehicle Type`
ORDER BY Avg_Booking_Value DESC;

-- Monthly Revenue Trend
SELECT 
    MONTH(Date) AS Month_Number,
    MONTHNAME(Date) AS Month_Name,
    COUNT(*) AS Total_Rides,
    ROUND(SUM(`Booking Value`), 2) AS Monthly_Revenue
FROM uber
WHERE `Booking Status` = 'Completed'
GROUP BY MONTH(Date), MONTHNAME(Date)
ORDER BY Month_Number;

-- ============================================================
-- 5. CANCELLATION ANALYSIS
-- ============================================================

-- Cancellation by Customer - Reasons
SELECT 
    `Reason for cancelling by Customer` AS Reason, 
    COUNT(*) AS Total
FROM uber
WHERE `Reason for cancelling by Customer` IS NOT NULL
GROUP BY `Reason for cancelling by Customer`
ORDER BY Total DESC;

-- Cancellation by Driver - Reasons
SELECT 
    `Driver Cancellation Reason` AS Reason, 
    COUNT(*) AS Total
FROM uber
WHERE `Driver Cancellation Reason` IS NOT NULL
GROUP BY `Driver Cancellation Reason`
ORDER BY Total DESC;

-- Incomplete Rides - Reasons
SELECT 
    `Incomplete Rides Reason` AS Reason, 
    COUNT(*) AS Total
FROM uber
WHERE `Incomplete Rides Reason` IS NOT NULL
GROUP BY `Incomplete Rides Reason`
ORDER BY Total DESC;

-- ============================================================
-- 6. LOCATION ANALYSIS
-- ============================================================

-- Top 10 Pickup Locations
SELECT 
    `Pickup Location`, 
    COUNT(*) AS Total_Rides
FROM uber
GROUP BY `Pickup Location`
ORDER BY Total_Rides DESC
LIMIT 10;

-- Top 10 Drop Locations
SELECT 
    `Drop Location`, 
    COUNT(*) AS Total_Rides
FROM uber
GROUP BY `Drop Location`
ORDER BY Total_Rides DESC
LIMIT 10;

-- ============================================================
-- 7. RATINGS ANALYSIS
-- ============================================================

-- Average Driver & Customer Ratings
SELECT 
    ROUND(AVG(`Driver Ratings`), 2) AS Avg_Driver_Rating,
    ROUND(AVG(`Customer Rating`), 2) AS Avg_Customer_Rating
FROM uber
WHERE `Booking Status` = 'Completed';

-- Driver Rating Distribution
SELECT 
    `Driver Ratings`, 
    COUNT(*) AS Total
FROM uber
WHERE `Driver Ratings` IS NOT NULL
GROUP BY `Driver Ratings`
ORDER BY `Driver Ratings` DESC;