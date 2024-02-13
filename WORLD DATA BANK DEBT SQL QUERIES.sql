-- Create database
CREATE DATABASE international_debt;
--- USE DATABASE
use international_debt;

/* Let's first SELECT all of the columns 
from the international_debt table. Also, we'll limit the output to the 
first ten rows to keep the output clean. */
select * from international_debt
limit 10;


# 2 _Finding the number of distinct countries
/*  From the first ten rows, we can see the amount of debt owed by Afghanistan in the different debt indicators.
But we do not know the number of different countries we have on the table.There are repetitions in the country names
because a country is most likely to have debt in more than one debt indicator.

Without a count of unique countries, we will not be able to perform our statistical analyses holistically. 
In this section, we are going to extract the number of unique countries present in the table. */
select * from international_debt;
select count(distinct(country_name)) as Total_Distinct_Country from international_debt;


# 3 _Finding out the distinct debt indicators
/* We can see there are a total of 124 countries present on the table. 

As we saw in the first section, there is a column called indicator_name that briefly specifies the purpose 
of taking the debt. Just beside that column, there is another column called indicator_code which symbolizes 
the category of these debts. 

Knowing about these various debt indicators will help us to understand the areas 
in which a country can possibly be indebted to.
 */
 select * from international_debt;
select distinct(indicator_name)  from international_debt;


# 4_Totaling the amount of debt owed by the countries
/* As mentioned earlier, the financial debt of a particular country represents its economic state. 
But if we were to project this on an overall global scale, how will we approach it?

Let's switch gears from the debt indicators now and find out the total amount of debt (in USD) 

that is owed by the different countries. This will give us a sense of how the overall economy of the entire world
is holding up.*/
select 
concat('$' ,round((sum(debt))/1000000 ,2)) as Total_Debt_in_Million 
from international_debt;


#5_Total_Debt_By_Each_Country
/* As we have seen in previous data which is Total the amount of debt owed by the countries globally .
Now we have to be specific for further insights that how much total debt own by each country.

So we understand which country is in how much total debt ?
*/
select * from international_debt;
select country_name, sum(debt) as total_Debt
from international_debt
group by country_name
order by total_Debt desc;



#6_top 5_Country with the highest debt
/* 
That is more than 3 million million USD, an amount which is really hard for us to fathom.

Now that we have the exact total of the amounts of debt owed by several countries, 
let's now find out the country that owns the highest amount of debt along with the amount. 

Note that this debt is the sum of different debts owed by a country across several categories. 
This will help to understand more about the country in terms of its socio-economic scenarios. 
We can also find out the category in which the country(top 5) owns its highest debt. But we will leave that for now.
*/
select country_name, sum(debt) as total_Debt
from international_debt
group by country_name
order by total_Debt desc
limit 5;

# 7_Average amount of debt across indicators
/*
So, it was China , Brazil,South Asia,Least developed countries: UN classification , Russian Federation are the 
top 5 in debt.

We now have a brief overview of the dataset and a few of its summary statistics. 
We already have an idea of the different debt indicators in which the countries owe their debts. 
We can dig even further to find out on an average how much debt a country owes? This will give us a 
better sense of the distribution of the amount of debt across different indicators.

*/
select * from international_debt;
select 
	indicator_code as debt_indicator , 
	indicator_name , 
	avg(debt) as Average_amount_Debt
from international_debt
group by 1 ,2
order by 3 Desc;

# 8_The highest amount of principal repayments
/*
We can see that the indicator DT.AMT.DLXF.CD tops the chart of average debt. 
This category includes repayment of long term debts. Countries take on long-term debt to acquire immediate capital. 

An interesting observation in the above finding is that there is a huge difference in the amounts of the 
indicators after the second one. This indicates that the first two indicators might be the most severe categories in 
which the countries owe their debts.

We can investigate this a bit more so as to find out which country owes the highest amount of debt in
the category of long term debts (DT.AMT.DLXF.CD). Since not all the countries suffer from the same kind of 
economic disturbances, this finding will allow us to understand that particular country's economic condition 
a bit more specifically.
*/
Select * from international_debt;

#using order by and limit
select 
country_name,
indicator_name,
debt as highest_debt
from international_debt
where indicator_code = 'DT.AMT.DLXF.CD'
order by highest_debt desc
limit 1;

#Using Subquery
select 
country_name,
indicator_name,
debt
from international_debt
where debt = 
(select max(debt)from international_debt
	where  indicator_code = 'DT.AMT.DLXF.CD');



# 9_ The most common debt indicator
/*
China has the highest amount of debt in the long-term debt (DT.AMT.DLXF.CD) category. 
This is verified by The World Bank. It is often a good idea to verify our analyses like this 
since it validates that our investigations are correct.

We saw that long-term debt is the topmost category when it comes to the average amount of debt. 
But is it the most common indicator in which the countries owe their debt? Let's find that out.*/
select * from international_debt;

select indicator_code,
indicator_name,
count(indicator_code) as indicator_count
	from international_debt
	group by indicator_code , indicator_name
	order by indicator_count DESC;
    
    
    
 # 10_Other viable debt issues and conclusion
 /* 
There are a total of six debt indicators in which all the (124)countries listed in our dataset have taken debt. 
The indicator DT.AMT.DLXF.CD is also there in the list. So, this gives us a clue that all these countries are 
suffering from a common economic issue. But that is not the end of the story, a part of the story rather.

Let's change tracks from debt_indicators now and focus on the amount of debt again.

Let's find out the maximum amount of debt across the indicators along with the respective country names. 
With this, we will be in a position to identify the other plausible economic issues a country might be going through.
By the end of this section, we will have found out the debt indicators in which a country owes its highest debt.

In this notebook, we took a look at debt owed by countries across the globe. 
We extracted a few summary statistics from the data and unraveled some interesting facts and figures. 
We also validated our findings to make sure the investigations are correct.

in simple term here we have find out For which indicator each country has maximum debt */
select * from international_debt;
 select 
country_name,
indicator_code,
indicator_name,
max(debt) as Maximum_debt
	from international_debt
    group by country_name,indicator_code,indicator_name
    order by Maximum_debt DESC;