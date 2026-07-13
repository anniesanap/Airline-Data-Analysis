use airline;
select * from maindata;

create view main as
select
`%Distance Group ID` as Distance_Group_ID,
`# Departures Scheduled` as Departures_Scheduled,
`# Departures Performed` as Departures_Performed,
`# Payload` as Payload,
Distance,
`# Available Seats` as Available_Seats,
`# Transported Passengers` as Transported_Passengers,
`Carrier Code` as Carrier_Code,
`Carrier Name` as Carrier_Name,
`Origin Airport Code` as Origin_Airport_Code,
`Origin City` as Origin_City,
`Origin State Code` as Origin_State_Code,
`Origin State` as Origin_State,
`Origin Country Code` as Origin_Country_Code,
`Origin Country` as Origin_Country,
`Destination Airport Code` as Destination_Airport_Code,
`Destination City` as Destination_City,
`Destination State Code` as Destination_State_Code,
`Destination State` as Destination_State,
`Destination Country Code` as Destination_Country_Code,
`Destination Country` as Destination_Country,
 Year,
`Month (#)` as Month_Number,
 Day,
`from - To City` as from_To_City
from maindata;

select * from main;

create table Airline as select * from main;

select * from Airline;

#1)
alter table airline
add column Date date;

SET SQL_SAFE_UPDATES = 0;

update airline
set Date = str_to_date(concat(Day, '-', Month_Number, '-', Year), '%d-%m-%Y');

alter table airline
add column Month_FullName varchar(10),
add column Quarters varchar(2),
add column Years_Month varchar(10),
add column Weekday_Num tinyint,
add column Weekday_Name varchar(10),
add column Financial_Month varchar(10),
add column Financial_Quarter varchar(2);

update airline
set Month_FullName = date_format(Date,'%M');

update airline
set Quarters = case
	when Month_Number between 4 and 6 then 'Q1'
    when Month_Number between 7 and 9 then 'Q2'
    when Month_Number between 10 and 12 then 'Q3'
    when Month_Number between 1 and 3 then 'Q4'
end;

update airline
set Years_Month = date_format(Date, '%Y-%b');

update airline
set Weekday_Num = case
when dayname(date) = 'Monday' then 1
when dayname(date) = 'Tuesday' then 2
when dayname(date) = 'Wednesday' then 3
when dayname(date) = 'Thursday' then 4
when dayname(date) = 'Friday' then 5
when dayname(date) = 'Saturday' then 6
when dayname(date) = 'Sunday' then 7
end;	

update airline
set Weekday_Name = dayname(date);

update airline
set Financial_Month = case
when Month_Number = '4' then 1
when Month_Number = '5' then 2
when Month_Number = '6' then 3
when Month_Number = '7' then 4
when Month_Number = '8' then 5
when Month_Number = '9' then 6
when Month_Number = '10' then 7
when Month_Number = '11' then 8
when Month_Number = '12' then 9
when Month_Number = '1' then 10
when Month_Number = '2' then 11
when Month_Number = '3' then 12
end;

update airline
set Financial_Quarter = case
	when Month_Number between 4 and 6 then 'Q1'
    when Month_Number between 7 and 9 then 'Q2'
    when Month_Number between 10 and 12 then 'Q3'
    when Month_Number between 1 and 3 then 'Q4'
end;

#2) Find the load Factor percentage on a yearly , Quarterly , Monthly basis ( Transported passengers / Available seats)
select Year,  round((sum(Transported_Passengers)/sum(Available_Seats))* 100,2) as Factor_Percentage from airline group by Year;
select Month_Number, Month_FullName,  round((sum(Transported_Passengers)/sum(Available_Seats))* 100,2) as Factor_Percentage from airline group by Month_FullName, Month_Number order by Month_Number asc;
select Quarters,  round((sum(Transported_Passengers)/sum(Available_Seats))* 100,2) as Factor_Percentage from airline group by Quarters order by Quarters ASC;
# OR
select Year, Month_Number, Month_FullName, round((sum(Transported_Passengers) / sum(Available_Seats)) * 100, 2) as Load_Factor_Percentage from airline group by Year, Month_Number, Month_FullName order by Year, Month_Number;

#3)
select Carrier_Name,  round((sum(Transported_Passengers)/sum(Available_Seats))* 100,2) as Load_Factor_Percentage from airline group by Carrier_Name order by Load_Factor_Percentage desc;

WITH CarrierLoadFactor AS (
    SELECT
        Year,
        Carrier_Name,
        ROUND((SUM(Transported_Passengers) / SUM(Available_Seats)) * 100, 2) AS Load_Factor_Percentage
    FROM airline
    GROUP BY Year, Carrier_Name
)

SELECT
    Year,
    Carrier_Name,
    Load_Factor_Percentage
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Year
               ORDER BY Load_Factor_Percentage DESC
           ) AS rn
    FROM CarrierLoadFactor
) ranked
WHERE rn <= 5
ORDER BY Year, rn;

WITH CarrierLoadFactor AS (
    SELECT
        Year,
        Carrier_Name,
        SUM(Departures_Performed) AS Total_Departures,
        ROUND((SUM(Transported_Passengers) / SUM(Available_Seats)) * 100, 2) AS Load_Factor_Percentage
    FROM airline
    GROUP BY Year, Carrier_Name
)

SELECT
    Year,
    Carrier_Name,
    Total_Departures,
    Load_Factor_Percentage
FROM (
    SELECT *,
           ROW_NUMBER() OVER (
               PARTITION BY Year
               ORDER BY Load_Factor_Percentage DESC
           ) AS rn
    FROM CarrierLoadFactor
) ranked
WHERE rn <= 5
ORDER BY Year, rn;

#4)
select sum(Transported_Passengers) as Top_Passengers, Carrier_Name from airline group by Carrier_Name order by Top_Passengers desc limit 10;


#5)
select sum(Departures_Performed) as Number_of_Flights, From_To_City from airline group by From_To_City order by Number_of_Flights desc;


select Distance_Group_ID, sum(Departures_Performed) as Number_of_Flights, From_To_City from airline group by Distance_Group_ID, From_To_City order by Number_of_Flights desc;

SELECT
    Distance_Group_ID,
    From_To_City,
    SUM(Departures_Performed) AS Number_of_Flights
FROM airline
GROUP BY Distance_Group_ID, From_To_City having Distance_Group_ID = 5
ORDER BY Distance_Group_ID, Number_of_Flights DESC;

select Origin_Country, Destination_Country, sum(Departures_Performed) as Number_of_Flights, ROUND((SUM(Transported_Passengers) / SUM(Available_Seats)) * 100, 2) AS Load_Factor_Percentage 
from airline group by Origin_Country, Destination_Country order by Load_Factor_Percentage desc, Number_of_Flights desc;

select
case
when Destination_Country = 'United States' then 'US'
else 'Others'
END AS Cntry,
sum(Departures_Performed) as Number_of_Flights from airline group by Cntry;

select Distance_Group_ID, sum(Transported_Passengers) as Top_Passengers from airline group by Distance_Group_ID ORDER BY Top_Passengers desc;

#6)

select
    case
        when DAYOFWEEK(Date) in (1, 7) then 'Weekend'
        else 'Weekday'
    END AS Day_Type,
    round((sum(Transported_Passengers)/sum(Available_Seats))* 100,2) AS Load_Factor_Percentage
FROM airline
GROUP BY Day_Type;

select sum(Transported_Passengers) as Passengers_Travel, Destination_Country, round((sum(Transported_Passengers)/sum(Available_Seats))* 100,2) AS Load_Factor_Percentage,
SUM(Departures_Performed) AS Number_of_Flights
 from airline group by Destination_Country order by Load_Factor_Percentage desc;
 
 select Origin_Country, Destination_Country, Month_FullName, Year, 
 round((sum(Transported_Passengers)/sum(Available_Seats))* 100,2) AS Load_Factor_Percentage,
 sum(Transported_Passengers) as Passengers_Travel from airline group by Year, Origin_Country, Destination_Country, Month_FullName having Month_FullName = 'December' and year = 2013 order by Load_Factor_Percentage desc;

#7)
delimiter $$
create procedure SearchFlights(
	in place varchar(20))
begin
	select distinct Origin_Country, Origin_State, Origin_City, Destination_Country, Destination_State, Destination_City, From_To_City from airline
    where 
    Origin_Country = place OR
    Origin_State = place OR
    Origin_City = place OR
    Destination_Country = place OR
    Destination_State = place OR
    Destination_City = place OR
    From_To_City = place;
end $$

delimiter ;

call SearchFlights('Texas');
    
#8)
select Distance_Group_ID, count(Departures_Performed) as Flights from airline group by Distance_Group_ID order by Distance_Group_ID asc;


select * from main where Departures_Scheduled = 2;