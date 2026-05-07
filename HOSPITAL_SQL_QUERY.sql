-- CREATE DATABASE

create database hospital_diabetesDB;
use hospital_diabetesDB;

-- CREATE TABLE

create table patient(
age varchar(30),
gender varchar(30),
time_in_hospital int,
num_lab_procedures int,
num_medications int,
number_inpatient int,
number_emergency int,
insulin varchar(30),
diabetesMed varchar(20),
readmitted_flag int
);


-- BUSINESS QUESTION: WHAT IS THE TOTAL NUMBER OF PATIENTS IN THE DATASET?

-- SQL QUERY:
SELECT COUNT(*) AS TOTAL_PATIENTS FROM patient;

-- INSIGHTS: Dataset contains 9,999 patient records used for analysis.


-- BUSINESS QUESTION: WHAT IS READMISSION RATE?

-- SQL QUERY:
SELECT ROUND(SUM(readmitted_flag)*100.0/count(*),2) as readmission_rate FROM patient;

-- INSIGHTS: The overall readmission rate is 10.98%, indicating that roughly 1 in 10 patients returns to the hospital, highlighting a significant area for healthcare improvement.


-- BUSINESS QUESTION: COUNT PATIENTS BY GENDER.

-- SQL QUERY:
SELECT gender, count(gender) as total from patient
group by gender;

-- INSIGHTS: Female patients (5363) slightly outnumber male patients (4636), but gender alone does not appear to be a strong predictor of readmission.


-- BUSINESS QUESTION: COUNT PATIENTS BY AGE GROUP. 

-- SQL QUERY:
SELECT age, COUNT(age) as TOTAL from patient
group by age;

-- INSIGHTS: Older patients represent the largest proportion of readmissions, suggesting that age is a critical risk factor due to increased comorbidities and health complications. 


-- BUSINESS QUESTIONS: WHICH AGE GROUP HAS HIGHEST READMISSION?

-- SQL QUERY:
SELECT age, count(age) from patient
where readmitted_flag = 1
group by age;

-- INSIGHTS: Old age group patients show the highest readmission rates, making age a key risk factor.


-- BUSINESS QUESTION: DOES NUMBER OF HOSPITAL VISITS AFFECT READMISSION?

-- SQL QUERY:
SELECT number_inpatient, count(*) as total from patient
where readmitted_flag=1
group by number_inpatient
order by total desc;

-- INSIGHTS: Patients with longer hospital stays tends to have higher readmission rates, suggesting severity of illness.
             

-- BUSINESS QUESTIONS: TOP FIVE HIGH RISK PATIENT CATEGORIES. 

-- SQL QUERY:
SELECT age, gender, count(*) as total from patient
where readmitted_flag=1
group by age, gender
order by total desc
limit 5;

-- INSIGHT: This sjows that older age group appear most frequently among high categories, indicating that older patients are more prone to readmission.


-- BUSINESS QUESTIONS: AVERAGE MEDICATIONS FOR READMITTED VS NOT.

-- SQL QUERY:
SELECT 
case
when readmitted_flag=1 then 'readmitted'
else 'not readmitted'
end as status,
avg(num_medications) as avg_meds
from patient
group by status;

-- INSIGHTS: Patients who are readmitted have a higher average number of medications, indicating that treatment complexity is strongly associated with readmission risk.



-- BUSINESS QUESTION: CREATE RISK CATEGORY.

-- SQL QUERY:
SELECT *,
CASE
WHEN number_inpatient > 4 then 'high risk'
when number_inpatient between 3 AND 4 then 'medium risk'
else 'low risk'
end as risk_category
from patient;

-- INSIGHTS: Patients classified as high risk show a higher liklihood of readmission, highlighting the need for targeted monitoring.


-- BUSINESS QUESTIONS: WHICH INSULIN USAGE GROUP HAS HIGHEST READMISSION?

-- SQL QUERY:
select insulin, count(*) as total from patient
where readmitted_flag =1 
group by insulin
order by total desc;

-- INSIGHTS: Patients on insulin show higher readmission counts, suggesting the need for improved monitoring and follow-up care for insulin-dependent individuals.


-- BUSINESS QUESTIONS: FIND PERCENTAGE OF READMITTED PATIENTS PER AGE GROUP.

-- SQL QUERY:
SELECT age, round(sum(readmitted_flag)*100/count(*),2) as readmission_rate from patient
group by age;

-- INSIGHT: Readmission rates increase with age, with old patients showing the highest percentage, making age a key factor in risk prediction.


-- BUSINESS QUESTIONS: FIND PATIENTS WITH HIGHEST HOSPITAL STAYS.

-- SQL QUERY:
SELECT * from patient
order by time_in_hospital desc
limit 10;

-- INSIGHTS: patients with longer hospital stays are more likely to be readmittes, suggesting that severity of impacts readmission risk.
