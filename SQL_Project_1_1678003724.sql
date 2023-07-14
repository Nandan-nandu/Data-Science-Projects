# 1.Create new schema as ecommerce
CREATE SCHEMA ecommerce;

# 2.Import .csv file users_data into MySQL USING
# (right click on ecommerce schema -> Table Data import Wizard -> Give path of the file -> Next -> choose options : Create a new table , select delete if exist -> next -> next)

#using the schema
USE ecommerce;

# 3.Run SQL command to see the structure of table
DESC users_data;

# 4.Run SQL command to select first 100 rows of the database
SELECT 
    *
FROM
    users_data
LIMIT 100;

# 5.how many distinct values exist in table for field country and language
SELECT 
    COUNT(DISTINCT country) country,
    COUNT(DISTINCT language) language
FROM
    users_data;

# 6.Check whether male users are having maximum followers or female users.
SELECT 
    SUM(socialNbFollowers) Followers_count, gender
FROM
    users_data
GROUP BY gender;

# 7.Calculate the total users those
#a.Uses Profile Picture in their Profile
#b.Uses Application for Ecommerce platform
#c.Uses Android app
#d.Uses ios app
SELECT 
    'Profile_pictures', COUNT(hasProfilePicture) COUNT
FROM
    users_data
WHERE
    hasProfilePicture = 'TRUE' 
UNION SELECT 
    'Application_uses', COUNT(hasAnyApp)
FROM
    users_data
WHERE
    hasAnyApp = 'TRUE' 
UNION SELECT 
    'Android_users', COUNT(hasAndroidApp)
FROM
    users_data
WHERE
    hasAndroidApp = 'TRUE' 
UNION SELECT 
    'Ios_users', COUNT(hasIosApp)
FROM
    users_data
WHERE
    hasIosApp = 'TRUE';
    
    
# 8.Calculate the total number of buyers for each country and sort the result in descending order of total number of buyers. (Hint: consider only those users having at least 1 product bought.)

SELECT 
    COUNT(productsBought), country
FROM
    users_data
WHERE
    productsBought >= 1
GROUP BY country
ORDER BY COUNT(productsBought) desc;

# 9.Calculate the total number of sellers for each country and sort the result in ascending order of total number of sellers. (Hint: consider only those users having at least 1 product sold.)

SELECT 
    COUNT(productsSold) sellers,country
FROM
    users_data
WHERE
    productsSold > 0
GROUP BY country
ORDER BY COUNT(productsSold) ASC;

# 10.Display name of top 10 countries having maximum products pass rate.
SELECT 
    COUNT(productsPassRate) pass_rate, country
FROM
    users_data
GROUP BY country
ORDER BY COUNT(productsPassRate) DESC
LIMIT 10;

#11.Calculate the number of users on an ecommerce platform for different language choices.
SELECT 
    COUNT(language) number_of_users, language
FROM
    users_data
GROUP BY language;

#12.Check the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform. (Hint: use UNION to answer this question.)
SELECT
' whishlist_products',
COUNT(productsWished) choices
FROM
users_data
WHERE
productsWished > 0 AND gender = 'F'
UNION SELECT
'Socially', COUNT(socialProductsLiked) choices2
FROM
users_data
WHERE
socialProductsLiked > 0 AND gender = 'F';

#13.Check the choice of male users about being seller or buyer. (Hint: use UNION to solve this question.)
SELECT 
    'SELLER', COUNT(productsSold) CHOICE
FROM
    users_data
WHERE
    productsSold > 0 AND gender = 'M' 
UNION SELECT 
    'BUYER', COUNT(productsBought) CHOICE2
FROM
    users_data
WHERE
    productsBought > 0 AND gender = 'M';

# 14.Which country is having maximum number of buyers?
SELECT 
    COUNT(productsBought) buyer, country
FROM
    users_data
WHERE
    productsBought > 0
GROUP BY country
ORDER BY COUNT(productsBought) DESC
LIMIT 1;

#15.List the name of 10 countries having zero number of sellers.
SELECT 
    productsSold, country
FROM
    users_data
WHERE
    productsSold = 0
GROUP BY country
LIMIT 10;


# 16.Display record of top 110 users who have used ecommerce platform recently.
SELECT 
    *
FROM
    users_data
ORDER BY daysSinceLastLogin ASC
LIMIT 110;

#17.Calculate the number of female users those who have not logged in since last 100 days.
SELECT 
    COUNT(daysSinceLastLogin) Number_of_Female_employees_not_loged_in_last100_days
FROM
    users_data
WHERE
    daysSinceLastLogin >= 100
        AND gender = 'F';

#18.Display the number of female users of each country at ecommerce platform.
SELECT 
    COUNT(gender) female_count, country
FROM
    users_data
WHERE
    gender = 'F' AND hasAnyApp='TRUE'
GROUP BY country;

#19.Display the number of male users of each country at ecommerce platform.
SELECT 
    COUNT(gender) male_count, country
FROM
    users_data
WHERE
    gender = 'M' AND hasAnyApp='TRUE'
GROUP BY country;

#20.Calculate the average number of products sold and bought on ecommerce platform by male users for each country.

SELECT 
    AVG(productsSold) PRODUCT_SOLD,
    AVG(productsBought) PRODUCT_BOUGHT,
    country COUNTRY
FROM
    users_data
WHERE
    gender = 'M' AND hasAnyApp = 'TRUE'
GROUP BY country;



