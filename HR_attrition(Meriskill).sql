
use HR_attrition;
select * from hr;
## Query to check the total number of Attrition by age
select age, count(age) as number_of_people_under_this_age,sum(if(attrition = "yes",1,0)) as Attrition,sum(if(overtime= "yes",1,0)) as overtime from hr
group by age
order by attrition desc;
## Query to reveal the interconnection between total_attrition and overtime
## and between attrition rate and environment_satisfaction ;
select Department,round((sum(if(attrition = "yes", 1,0))/count(department))*100,0) as attrition_percentage,avg(environmentsatisfaction) as env_sat,
round((sum(if(overtime = "yes", 1,0))/count(department))*100,0)as overtime_percentage from hr
group by department 
order by attrition_percentage desc;
# IN Sales department overtime percentage is the highest so as the attrition percentage
# here it also discloses that there is a strong negative correlation between attrition_percentage and environment_satisfaction
# solution : in order to curb the attrition rate its necessary for departments to take cognisance of their woring_environment their employees are working in ,
# it should be perfectly conducive,motivating and free from any sorts of coercive elements that could tamper with the mental peace of the employees and thus
# hinders growth of the overall department.overtime doesnt feel burdensome when there is a congenial working environment as evident from Research and development department.

## Query to gain clarity about the relationship between the marital_status being married and attrition rate of the departments.
select department,round(sum(if(gender= "Male",1,0))/count(department)* 100,0) as percentage_male,round(sum(if(gender= "Female",1,0))/count(department)* 100,0) as 
percentage_female,round(sum(if(Maritalstatus = "Married",1,0))/count(department) * 100,0) as married from hr
 group by department;
 ## in the department of research and development, number of people overtiming is higher than that of HUman Resource  owing to the greater number of
 ## people are married under the latter one and thus consequently the attiriton rate is also less as compared to that of the former .

## query to find out if  there exists any degree of asscoation between salaryhike and attrition rate.
select department,round(sum(percentsalaryhike)/count(department),2) as percentage_salary_hike,round(sum(if(attrition = "Yes",1,0))/count(department)*100,0) as attrition from hr 
group by department
order by percentage_salary_hike desc;
## here its totally department_specific,evidently true of R&D department.

select* from hr;
## query to show the the proportion of best performers in each of the departments.
select department, round(sum(if(rnk = 1,1,0))/count(department)*100,1)as percentageof_best_performers
 from(select department,performancerating,dense_rank()over
 (partition by department order by performancerating desc) as rnk from hr) as temp_table
 group by department 
 order by percentageof_best_performers desc;
# R&D department has the maximum number of best performers followed by sales and HUman Resource.
select* from hr;
select department,age,count(age) as numberof_employees_under_this_age, sum(numcompaniesworked)as total_companiesworked ,sum(if(attrition ="yes",1,0)) as attrition 
from hr group by department, age having attrition  =0 order by department desc;
;
## query to show wther there is any degree of linkage exists between number of companies worked in by the employees and their attrition rate.
select age,round(sum(numcompaniesworked)/count(age),0) as avg_numof_companies_worked,sum(if(attrition = "yes",1,0)) as attrition from hr
group by age
order by avg_numof_companies_worked desc;




