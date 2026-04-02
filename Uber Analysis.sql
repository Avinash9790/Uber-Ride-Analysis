-- ============================================================
-- UBER RIDE ANALYSIS - SQL QUERIES
-- Dataset: 150,000 Uber Rides (2024)
-- ============================================================

-- 1. OVERVIEW

-- Total Rides
SELECT COUNT(*) AS Total_Rides FROM Uber;

-- Booking Status Distribution
SELECT 
    Booking_Status,
    COUNT(*) AS Total,
    ROUND(COUNT(*) * 100.0 / (SELECT COUNT(*) FROM Uber), 2) AS Percentage
FROM Uber
GROUP BY Booking_Status
ORDER BY Total DESC;

-- Total Revenue
SELECT ROUND(SUM(Booking_Value), 2) AS Total_Revenue
FROM Uber
WHERE Booking_Status = 'Completed';

-- ============================================================
-- 2. VEHICLE TYPE ANALYSIS

-- Ride Count by Vehicle Type
SELECT Vehicle_Type, COUNT(*) AS Total_Rides
FROM Uber
GROUP BY Vehicle_Type
ORDER BY Total_Rides DESC;

-- Revenue by Vehicle Type
SELECT Vehicle_Type, ROUND(SUM(Booking_Value), 2) AS Total_Revenue
FROM Uber
WHERE Booking_Status = 'Completed'
GROUP BY Vehicle_Type
ORDER BY Total_Revenue DESC;

-- Avg Driver Rating by Vehicle Type
SELECT Vehicle_Type, ROUND(AVG(Driver_Ratings), 2) AS Avg_Driver_Rating
FROM Uber
WHERE Driver_Ratings IS NOT NULL
GROUP BY Vehicle_Type
ORDER BY Avg_Driver_Rating DESC;

-- ============================================================
-- 3. REVENUE ANALYSIS

-- Revenue by Payment Method
SELECT 
    Payment_Method,
    COUNT(*) AS Total_Transactions,
    ROUND(SUM(Booking_Value), 2) AS Total_Revenue,
    ROUND(AVG(Booking_Value), 2) AS Avg_Booking_Value
FROM Uber
WHERE Booking_Status = 'Completed'
GROUP BY Payment_Method
ORDER BY Total_Revenue DESC;

-- Monthly Revenue Trend
SELECT 
    MONTH(Date) AS Month_Number,
    MONTHNAME(Date) AS Month_Name,
    COUNT(*) AS Total_Rides,
    ROUND(SUM(Booking_Value), 2) AS Monthly_Revenue
FROM Uber
WHERE Booking_Status = 'Completed'
GROUP BY MONTH(Date), MONTHNAME(Date)
ORDER BY Month_Number;

-- ============================================================
-- 4. CANCELLATION ANALYSIS

-- Customer Cancellation Reasons
SELECT Reason_for_Cancelling_by_Customer AS Reason, COUNT(*) AS Total
FROM Uber
WHERE Reason_for_Cancelling_by_Customer IS NOT NULL
GROUP BY Reason_for_Cancelling_by_Customer
ORDER BY Total DESC;

-- Driver Cancellation Reasons
SELECT Driver_Cancellation_Reason AS Reason, COUNT(*) AS Total
FROM Uber
WHERE Driver_Cancellation_Reason IS NOT NULL
GROUP BY Driver_Cancellation_Reason
ORDER BY Total DESC;

-- Incomplete Rides Reasons
SELECT Incomplete_Rides_Reason AS Reason, COUNT(*) AS Total
FROM Uber
WHERE Incomplete_Rides_Reason IS NOT NULL
GROUP BY Incomplete_Rides_Reason
ORDER BY Total DESC;

-- ============================================================
-- 5. LOCATION ANALYSIS

-- Top 10 Pickup Locations
SELECT Pickup_Location, COUNT(*) AS Total_Rides
FROM Uber
GROUP BY Pickup_Location
ORDER BY Total_Rides DESC
LIMIT 10;

-- Top 10 Drop Locations
SELECT Drop_Location, COUNT(*) AS Total_Rides
FROM Uber
GROUP BY Drop_Location
ORDER BY Total_Rides DESC
LIMIT 10;

-- ============================================================
-- 6. RATINGS ANALYSIS

-- Avg Driver & Customer Ratings
SELECT 
    ROUND(AVG(Driver_Ratings), 2) AS Avg_Driver_Rating,
    ROUND(AVG(Customer_Rating), 2) AS Avg_Customer_Rating
FROM Uber
WHERE Booking_Status = 'Completed';

-- ============================================================
-- 7. RIDE DISTANCE ANALYSIS

-- Avg Ride Distance by Vehicle Type
SELECT Vehicle_Type, ROUND(AVG(Ride_Distance), 2) AS Avg_Distance_KM
FROM Uber
WHERE Booking_Status = 'Completed'
GROUP BY Vehicle_Type
ORDER BY Avg_Distance_KM DESC;

-- ============================================================
-- 8. TIME ANALYSIS

-- Rides by Hour of Day
SELECT HOUR(Time) AS Hour_of_Day, COUNT(*) AS Total_Rides
FROM Uber
GROUP BY HOUR(Time)
ORDER BY Hour_of_Day;