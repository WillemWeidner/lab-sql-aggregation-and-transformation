USE sakila;

-- Challenge 1
-- 1.1 Determine the shortest and longest movie durations and name the values as 
-- max_duration and min_duration.

SELECT *
FROM sakila.film;

SELECT MAX(length) AS max_duration, MIN(length) AS min_duration
FROM sakila.film;

-- 1.2. Express the average movie duration in hours and minutes. Don't use decimals.
-- Hint: Look for floor and round functions.

SELECT AVG(length) AS Overall_Average_Length
FROM sakila.film;
-- Average length in minutes without formatting for comparison 115 min 

SELECT FLOOR(AVG(length) / 60) AS Hours, FLOOR(AVG(length)) % 60 AS Minutes
FROM sakila.film;
-- I have the Average lenght given in minutes, therefore /60 gives me the hours
-- % remainder of the division by 60 = minutes left for full hour
-- Floor function: round down a numeric value to the nearest integer less than or equal to the original value


-- 2. You need to gain insights related to rental dates:
-- 2.1 Calculate the number of days that the company has been operating.
-- Hint: To do this, use the rental table, and the DATEDIFF() function to subtract the earliest date in the rental_date column from the latest date.

SELECT DATEDIFF(MAX(rental_date), MIN(rental_date)) AS number_of_days_operating
FROM sakila.rental;

-- 2.2 Retrieve rental information and add two additional columns to show the month and weekday of the rental. Return 20 rows of results.
SELECT rental_id, rental_date
FROM sakila.rental;

SELECT rental_date, DATE_FORMAT(rental_date, '%M') AS 'month', DATE_FORMAT(rental_date, '%d') AS 'weekday'
FROM sakila.rental
LIMIT 20;
-- DATE_FORMAT function is used to format the rental_date column
-- Specifier %M represents the full month name, and %d represents the day of the month 
-- LIMIT 20 returns 20 rows of result

-- 3. You need to ensure that customers can easily access information about the movie collection. 
	-- To achieve this, retrieve the film titles and their rental duration. If any rental duration value is NULL, replace it with the string 'Not Available'. Sort the results of the film title in ascending order.
	-- If renteal duration = Null replace witrh not available use IF Null function
	-- There is no NULL value, therefore nothing has to be replaced

SELECT film_id, title, rental_duration
FROM sakila.film;

SELECT IFNULL(rental_duration, 'Not Available') AS 'rental_duration'
FROM sakila.film;
-- Syntax of the function
-- SELECT IFNULL(column_with_nulls, 'Default Value') AS result FROM your_table;


-- Challenge 2 
-- 1. Next, you need to analyze the films in the collection to gain some more insights. 
-- Using the film table, determine:
-- 1.1 The total number of films that have been released.

SELECT COUNT(release_year)
FROM sakila.film;
-- Result 1000
-- Counts the number of rows, that fullfill the condition to be released

-- 1.2 The number of films for each rating.
SELECT DISTINCT rating
FROM sakila.film;
-- creates my list with all possible unique ratings

SELECT COUNT(film_id), rating
FROM sakila.film
WHERE rating IN ('PG', 'G', 'NC-17', 'PG-13', 'R')
GROUP BY rating;
-- Created the list out of distinct ratings --> value IN (List)
-- The GROUP BY statement groups rows that have the same values into summary rows
-- Example from lesson:
	-- SELECT account_id AS 'Account', amount, k_symbol AS 'Type of Payment' FROM bank.order
	-- WHERE (k_symbol IN ('SIPO','LEASING','UVER')) AND (amount > 1000); 

-- 1.3 The number of films for each rating, sorting the results in descending order of the number of films. 
-- This will help you to better understand the popularity of different film ratings and adjust purchasing decisions accordingly.

SELECT COUNT(film_id) AS number_of_films, rating
FROM sakila.film
WHERE rating IN ('PG', 'G', 'NC-17', 'PG-13', 'R')
GROUP BY rating
ORDER BY number_of_films DESC;

-- 2. Using the film table, determine:
-- 2.1 The mean film duration for each rating, and sort the results in descending order of the mean duration. Round off the average lengths to two decimal places. This will help identify popular movie lengths for each category.

SELECT rating, ROUND(AVG(length)/60,2) AS 'mean_each_rating'
FROM sakila.film
GROUP BY rating 
ORDER BY mean_each_rating DESC;

-- The ROUND function is used to round a numeric value to a specified number of decimal places.
	-- Round(number, Decimal_places)
-- The GROUP BY clause is used to group the results by the values in the rating column. 
	-- This means that the calculations will be performed for each unique rating value
-- HAVING is used to filter the groups (here ratings) after the grouping has been performed.
	-- In this case, it filters groups where the calculated "mean_each_rating" descending (DESC).
    
    
  -- 2.2 Identify which ratings have a mean duration of over two hours in order to help select films
	-- for customers who prefer longer movies.  
    
SELECT rating, ROUND(AVG(length) / 60, 2) AS 'mean_each_rating'
FROM sakila.film
GROUP BY rating
HAVING mean_each_rating > 2;
    
-- HAVING is used to filter the groups (here ratings) after the grouping has been performed.
	-- In this case, it filters groups where the calculated "mean_each_rating" is greater than 2.
    


    
    