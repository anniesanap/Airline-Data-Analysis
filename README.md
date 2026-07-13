# Airline Operations Analysis using SQL & Tableau

## Project Overview
This project analyses airline operational data using SQL and Tableau to uncover insights regarding aircraft utilisation, passenger demand, carrier performance metrics, and route activity. The objective is to demonstrate how SQL can be used to transform raw operational data into actionable business insights, followed by visualisation through an interactive dashboard on Tableau.

## Project Objectives
•	Evaluate airline operational performance using historical real-time flight data.

•	Measure aircraft utilization through load factor analysis.

•	Identify passenger travel patterns across different time periods.

•	Compare carrier performances based on most passenger uses.

•	Build an interactive dashboard to support business decision-making.

## Project Workflow

1. Imported and explored the airline dataset.
2. Cleaned and transformed the data using excel.
3. Created calculated fields for date and time analysis.
4. Performed SQL analysis to answer key business questions.
5. Developed SQL Views and Stored Procedures for reusable analysis.
6. Visualized the results in Tableau through an interactive dashboard.
7. Derived business insights and recommendations based on the findings.

## SQL Skills Demonstrated

•	Joins

•	Views

•	Stored Procedures

•	Aggregate Functions

•	CASE Statements

•	Date Functions

•	Window Functions

•	GROUP BY

•	ORDER BY

•	Views

## Limitations

•	Dataset represents historical data only.

•	Analysis does not account for weather disruptions.

•	No ticket pricing or revenue information was available.

•	Results are dependent on the provided dataset. 

## Dataset

•	110852 records

•	54 columns

•	The original dataset could not be added due file size limitations on github. 

## Data Dictionary
(Note: Since there are 54 columns, only the important ones are listed)

<img width="710" height="677" alt="image" src="https://github.com/user-attachments/assets/22beb749-999b-4d80-b782-d22e35d84b65" />



## Business Objectives and Analysis

**1.	Aircraft Utilisation Analysis**

Calculated the load factor percentage (Transported Passengers ÷ Available Seats × 100) on yearly, quarterly, and monthly levels to identify trends in aircraft occupancy and seasonal demand.

**Key Findings**

-	Load factor generally increased between 2008 and 2013, indicating improved seat utilization over time. 

-	The highest load factors consistently occurred during June, July, and August, with elevated values often continuing into May and September, depending on the year. 

-	Quarterly analysis reflected the same seasonal trend, with the quarter containing the summer months showing the strongest aircraft utilization. 

-	Overall, flights became progressively fuller over the years, suggesting increasing passenger demand.

**Business Insights and Recommendations**

-	The consistently higher load factors during the summer months suggest increased travel demand, likely associated with school holidays and vacation periods. 

-	Airlines could consider increasing flight frequency or deploying larger-capacity aircraft during peak travel months to better accommodate demand. 

-	Monitoring future years' data would help determine whether the upward trend continues and whether additional capacity planning is required. 

_________________________________________________________________________________
**2.	Carrier Performance Analysis**

Calculated the load factor percentage (Transported Passengers ÷ Available Seats × 100) for each carrier to compare aircraft seat utilization across airlines. Yearly comparisons of the top-performing carriers were also conducted to evaluate consistency in performance over time.

**Key Findings**

-	Allegiant Air consistently ranked among the top-performing carriers across multiple years, maintaining high load factors while operating more than 2,000 flights annually.

-	Several carriers achieved very high load factors (close to or at 100%) on specific international routes, but these were isolated cases and did not represent an overall trend across countries or regions.

-	Most carriers maintained relatively high load factors (generally above 80%), suggesting strong seat utilization across the majority of airlines in the dataset.

**Business Insights and Recommendations**

-	Evaluating carrier performance should consider both load factor and operational scale. Airlines operating thousands of flights while maintaining high load factors demonstrate stronger and more sustainable performance than airlines with only a small number of flights.

-	Allegiant Air represents a strong benchmark for operational efficiency, as it consistently maintained high aircraft occupancy across a large flight network.


_________________________________________________________________________________
**3.	Route Analysis**

Analyzed flight routes by calculating the total number of flights between origin and destination locations. Route activity was also examined across distance groups to identify high-traffic travel patterns.

**Key Findings**

-	The busiest routes were predominantly domestic routes within the United States with them being on the top 5 list for different distance groups.

-	The United States recorded the highest number of flights, with approximately 2 million domestic flights, while international routes to other countries generally recorded significantly fewer flights of about 150k.

-	Overall, flight activity was heavily concentrated on domestic U.S. travel rather than international routes.

**Business Insights and Recommendations**

-	As flight distance increases, both the number of flights and passenger volumes decrease. This suggests that airlines are already matching flight frequency to demand, reducing the risk of operating underutilized long-haul routes.

-	Load factor percentages remain relatively similar for domestic U.S. flights (approximately 76%) and international flights (approximately 77%). Since aircraft are not consistently operating at full capacity, the current number of scheduled flights appears sufficient, and there is no immediate indication that additional flights are required.

-	Airlines should continue monitoring passenger demand and load factor trends over time. If seat occupancy begins to approach capacity on specific routes, flight frequency or aircraft size can then be adjusted accordingly while maintaining efficient resource utilization.

_________________________________________________________________________________

**4.	Passenger Demand Analysis**

Analyzed load factor by destination country, month, and year to identify destinations and time periods with consistently high passenger demand.

**Key Findings**

-	Routes to Kosovo and South Africa recorded high load factors despite having relatively few departures, suggesting strong demand relative to available flight capacity.

-	December consistently showed higher load factors for destinations including India, UAE, Nigeria, Haiti, and Ecuador, indicating increased seasonal travel demand during the holiday period. 

-	In the most recent year of the dataset, international flights departing from the United States to overseas destinations experienced particularly high load factors during December, suggesting increased outbound international travel during the holiday season. 

**Business Insights & Recommendations**

-	Airlines should further evaluate routes to Kosovo and South Africa to determine whether increasing flight frequency or deploying larger aircraft would better meet passenger demand while remaining commercially viable. 

-	The recurring increase in December demand suggests that airlines should consider expanding flight schedules or increasing seat capacity on high-demand international routes during the holiday season. 

-	Since outbound international flights from the United States experienced particularly high occupancy in December, airlines should proactively plan operational resources for this period. This may include:

- Scheduling additional flight crews (pilots and cabin crew).

- Increasing ground staff at airports, including check-in, baggage handling, and gate operations.

- Ensuring aircraft availability and maintenance schedules support increased flight frequency.
  
- Allocating larger aircraft or additional flights to destinations that consistently experience high passenger demand.
  
