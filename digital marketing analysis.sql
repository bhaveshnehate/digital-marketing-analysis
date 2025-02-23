-- creating database and imoprting data from excel --

create database masrketing_analysis;

use masrketing_analysis;

-- solve kpi for Campaign Effectiveness--
-- How many people are clicking on ads? (Click-Through Rate - CTR) --
SELECT 
    campaign_name, 
    (SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0)) AS CTR
FROM marketing
GROUP BY campaign_name;

-- Are ads generating leads or sales? (Conversion Rate) --
SELECT 
    campaign_name, 
    (SUM(leads + orders) * 100.0 / NULLIF(SUM(clicks), 0)) AS Conversion_Rate
FROM marketing
GROUP BY campaign_name;

-- How much we are paying for each click? (Cost Per Click - CPC) --
SELECT 
    campaign_name, 
    (SUM(mark_spent) / NULLIF(SUM(clicks), 0)) AS CPC
FROM marketing
GROUP BY campaign_name;

-- How much does it cost to acquire a lead? (Cost Per Lead - CPL) --
SELECT 
    campaign_name, 
    (SUM(mark_spent) / NULLIF(SUM(leads), 0)) AS CPL
FROM marketing
GROUP BY campaign_name;

-- What is the cost of acquiring a customer/order? (Cost Per Order - CPO) --
SELECT 
    campaign_name, 
    (SUM(mark_spent) / NULLIF(SUM(orders), 0)) AS CPO
FROM marketing
GROUP BY campaign_name;

-- ROI & Profitabilit --
-- are we getting more revenue than my ad spend? (Return on Ad Spend - ROAS) --
SELECT 
    campaign_name, 
    (SUM(revenue) / NULLIF(SUM(mark_spent), 0)) AS ROAS
FROM marketing
GROUP BY campaign_name;

-- How profitable is our campaign? (Profitability Ratio) --
SELECT 
    campaign_name, 
    ((SUM(revenue) - SUM(mark_spent)) * 100.0 / NULLIF(SUM(mark_spent), 0)) AS Profitability_Ratio
FROM marketing
GROUP BY campaign_name;

-- What is total revenue generated from the campaign? (Total Revenue) --
 SELECT 
    SUM(revenue) AS Total_Revenue 
FROM marketing;

-- Engagement & Reach --
-- How many people who saw ad became leads? (Impression-to-Lead Ratio) --
SELECT 
    campaign_name, 
    (SUM(leads) * 100.0 / NULLIF(SUM(impressions), 0)) AS Impression_to_Lead_Ratio
FROM marketing
GROUP BY campaign_name
ORDER BY Impression_to_Lead_Ratio DESC;

-- What percentage of leads turn into actual buyers? (Lead-to-Order Ratio) --
SELECT 
    campaign_name, 
    (SUM(orders) * 100.0 / NULLIF(SUM(leads), 0)) AS Lead_to_Order_Ratio
FROM marketing
GROUP BY campaign_name
ORDER BY Lead_to_Order_Ratio DESC;

-- Which campaign category is performing the best? (Campaign Performance Comparison) --

SELECT 
    category, 
    SUM(revenue) AS Total_Revenue, 
    (SUM(clicks) * 100.0 / NULLIF(SUM(impressions), 0)) AS CTR,
    (SUM(leads) * 100.0 / NULLIF(SUM(impressions), 0)) AS Impression_to_Lead_Ratio,
    (SUM(orders) * 100.0 / NULLIF(SUM(leads), 0)) AS Lead_to_Order_Ratio
FROM marketing
GROUP BY category
ORDER BY Total_Revenue DESC, CTR DESC;

 
