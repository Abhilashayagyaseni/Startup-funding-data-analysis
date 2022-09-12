select * from projects.startup_fundings;

#################################################   DATA FROM JAN-2015 TO JAN-2020  ####################################################


#####  TOP 10 START-UPS, WHICH RAISED HIGHEST FUND FROM MARKET  #####
select a.startup_name, round((sum(a.amount_usd)/1000000),0 )as fund_million_USD
from projects.startup_fundings as a
group by a.startup_name
order by fund_million_USD desc
limit 10;



####  MOST FAVOURABLE CITY FOR START-UPS IN INDIA  ####
select a.City_Location, count(a.Startup_Name) as total_startups
from projects.startup_fundings as a
group by a.City_Location
order by total_startups desc
LIMIT 3;



####  STARTUP THAT RAISED MONEY MORE THAN 1'S IN A YEAR  ####
select DISTINCT(extract(year from a.date)) as year, a.Startup_Name
from projects.startup_fundings as a
join  projects.startup_fundings as b
on a.startup_name = b.startup_name 
and extract(year from a.date) = extract(year from b.date);




####  START-UPS RELATED TO ECOMMERCE SERVICES  ####
select a.Startup_Name, a.Industry_Vertical
from projects.startup_fundings as a
where a.Industry_Vertical like '%ecommerce%';



####  TOP 3 HIGHEST FUNDED START-UPS IN EACH CITY  ####
with top_rank as(
select a.City_Location, 
       a.Startup_Name,
       dense_rank() over(partition by a.City_Location order by a.Amount_USD desc) as _rank
from projects.startup_fundings as a)

select * from top_rank
where _rank <= 3 ;



####  START_UPS THAT RAISED MONEY MORE THAN 5 TIMES  ####
select a.Startup_Name, count(a.Amount_USD) as tot_no_fund
from projects.startup_fundings as a
group by a.Startup_Name
having count(a.Amount_USD) > 5
order by tot_no_fund desc;



####  YEAR WISE INDUSTRY VERTICALS THAT ARE BEING FUNDED MOST NUMBER OF TIMES ####
with vertical 
as  (select extract(year from a.date) as year, a.Industry_Vertical, count(a.Industry_Vertical) as total
from projects.startup_fundings as a
where a.Industry_Vertical not like 'nan'
group by extract(year from a.date), a.Industry_Vertical)

select year, industry_vertical
from vertical
group by year
having max(total);



####  START-UPS THAT RAISED TOTAL MONEY MORE THAN 100M USD  ####
select a.startup_name, round((SUM(a.Amount_USD)/1000000),0) as tot_fund, count(a.Amount_USD) as funding_round
from projects.startup_fundings as a
group by a.Startup_Name
having tot_fund >= 100
order by tot_fund desc;



####  START-UPS THAT RAISED MORE THAN 200M USD IN SINGLE ROUND ####
select a.startup_name, round((a.Amount_USD/1000000),0) as fund, count(a.Amount_USD) as funding_round
from projects.startup_fundings as a
group by a.Startup_Name
having fund >= 200 AND funding_round = 1
order by fund desc;



####  ALL INVESTOR'S NAME OF HIGHEST FUNDED START-UP "PAYTM"  ####
select a.Investors_Name
from projects.startup_fundings as a
where a.Startup_Name = "PAYTM";



####  CROWD FUNDED START-UPS AND INVESTOR'S NAME  #### 
select a.Startup_Name, a.Investors_Name, a.Investment_Type
from projects.startup_fundings as a
where a.Investment_Type like '%crowd%';



####  WHAT TYPE OF INVESTMENT HAPPENS MOST  ##### 
select a.investment_type, count(a.investment_type) as total_no
from projects.startup_fundings as a
group by a.investment_type
order by total_no desc ;



####  START-UPS IN WHICH TATA GROUP INVESTED  ####
select a.Startup_Name, a.Investors_Name
from projects.startup_fundings as a
where a.Investors_Name like '%tata%';








