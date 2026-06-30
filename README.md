\# Healthcare Insurance Big Data Project



\## Project Overview



This capstone project focuses on building an end-to-end Big Data pipeline for a healthcare insurance company. The objective is to analyze healthcare insurance data such as patients, subscribers, claims, policy groups, hospitals, and premium payments to generate meaningful business insights.



The project helps the insurance company understand customer behavior, claim patterns, disease trends, hospital usage, rejected claims, policy subscriptions, and premium-related revenue performance.



\## Business Objective



The main goal of this project is to create a scalable data pipeline that can ingest, clean, transform, store, and analyze healthcare insurance data. The final output supports business decision-making by helping the company identify profitable policy groups, high-claim diseases, customer segments, rejected claims, and claim trends by city and hospital.



\## Technologies Used



\* AWS S3

\* Databricks

\* PySpark

\* AWS Redshift

\* AWS EMR Studio

\* Jira

\* GitHub

\* SQL



\## Project Architecture



```text

Raw CSV Datasets

&#x20;       ↓

AWS S3 input-data folder

&#x20;       ↓

Databricks Notebook using PySpark

&#x20;       ↓

Bronze Layer in S3

&#x20;       ↓

Silver Layer Cleaning and Transformation

&#x20;       ↓

Silver Cleaned Data in S3

&#x20;       ↓

AWS Redshift Final Tables

&#x20;       ↓

Redshift project\_output Tables

&#x20;       ↓

Business Insights and Reporting

```



\## Dataset Information



The project uses synthetic healthcare insurance datasets created for this capstone project.



Main datasets:



\* patients.csv

\* subscriber.csv

\* claims.csv

\* group\_subgroup.csv

\* policy\_groups.csv

\* hospitals.csv

\* premium\_payments.csv



Some records intentionally include null values, duplicate records, and inconsistent text formatting so that data cleaning and transformation can be performed in the Silver layer.



\## Project Layers



\### 1. Input Layer



Raw CSV files are uploaded to AWS S3 under the `input-data` folder.



```text

s3://<bucket-name>/input-data/

```



\### 2. Bronze Layer



Databricks reads raw CSV files from S3 using PySpark and stores them in the Bronze layer as raw structured data.



```text

s3://<bucket-name>/bronze/

```



\### 3. Silver Layer



PySpark transformations are applied in Databricks to clean the data.



Silver layer activities include:



\* Reading raw data from Bronze layer

\* Checking null values

\* Counting null values for each column

\* Replacing null values with `NA` or default values

\* Removing duplicate records

\* Trimming spaces

\* Standardizing text columns

\* Converting date columns into proper date format

\* Casting numeric columns into correct data types

\* Writing cleaned data back to S3



```text

s3://<bucket-name>/silver/

```



\### 4. Redshift Layer



Cleaned Silver data is loaded from S3 into AWS Redshift. Redshift is used for final storage and analytical output tables.



Schemas used:



\* `silver\_healthcare`

\* `project\_output`



\## Business Use Cases



The following business questions are answered in Redshift:



1\. Which disease has the maximum number of claims?

2\. Find subscribers under age 30 who subscribed to any subgroup.

3\. Find which policy group has the maximum number of subgroups.

4\. Find the hospital serving the most patients.

5\. Find which subgroup is subscribed to the most.

6\. Find the total number of rejected claims.

7\. Find the city where most claims are coming from.

8\. Find whether subscribers mostly subscribe to Government or Private policies.

9\. Find the average monthly premium paid by subscribers.

10\. Find the most profitable policy group.

11\. List all patients below age 18 admitted for cancer.

12\. List patients with cashless insurance and total charges greater than or equal to Rs. 50,000.

13\. List female patients over age 40 who underwent knee surgery in the past year.



\## Project Structure



```text

bde84-capstone-project-bde84capstoneproject-s497912/

│

├── documents/

│   ├── Healthcare\_Insurance\_Big\_Data\_SRS\_Bipina\_Poudel.docx

│   ├── Healthcare\_Insurance\_Big\_Data\_Solution\_Design\_Bipina\_Poudel.docx

│   └── Healthcare\_Insurance\_Big\_Data\_Database\_Schema\_Design\_Bipina\_Poudel.docx

│

├── input-data/

│   ├── patients.csv

│   ├── subscriber.csv

│   ├── claims.csv

│   ├── group\_subgroup.csv

│   ├── policy\_groups.csv

│   ├── hospitals.csv

│   └── premium\_payments.csv

│

├── notebooks/

│   └── healthcare\_bronze\_to\_silver\_pyspark.ipynb

│

├── sql/

│   ├── 01\_create\_redshift\_schemas.sql

│   ├── 02\_create\_redshift\_silver\_tables.sql

│   ├── 03\_copy\_silver\_from\_s3.sql

│   └── 04\_create\_project\_output\_tables.sql

│

├── screenshots/

│   ├── Capstone\_Project\_Screenshot\_Documentation\_Bipina\_Poudel.docx

│

└── README.md

```



\## Documentation



The `documents` folder contains the main project documentation:



1\. Requirement Specification Document

2\. Solution Design Document

3\. Database Schema Design Document



These documents describe the business requirements, solution architecture, database design, Redshift tables, primary key and foreign key relationships, project assumptions, and implementation plan.



\## Data Processing Steps



\### Step 1: Upload Data to S3



Raw CSV files are uploaded into the S3 `input-data` folder.



\### Step 2: Read Data in Databricks



Databricks with PySpark reads the raw CSV files from S3.



\### Step 3: Create Bronze Layer



Raw data is written into the Bronze layer for traceability.



\### Step 4: Perform Silver Layer Cleaning



PySpark is used to clean and standardize the data by handling nulls, duplicates, formatting issues, and data type conversions.



\### Step 5: Write Silver Data to S3



Cleaned datasets are written back to S3 under the `silver` folder.



\### Step 6: Load Silver Data into Redshift



AWS Redshift `COPY` command is used to load Silver data from S3 into Redshift tables.



\### Step 7: Create Output Tables



SQL queries are used in Redshift to create separate output tables for each business use case.



\## Redshift Schemas



```sql

CREATE SCHEMA IF NOT EXISTS silver\_healthcare;

CREATE SCHEMA IF NOT EXISTS project\_output;

```



\## Main Redshift Tables



\### Silver Tables



\* silver\_healthcare.patients

\* silver\_healthcare.subscriber

\* silver\_healthcare.claims

\* silver\_healthcare.group\_subgroup

\* silver\_healthcare.policy\_groups

\* silver\_healthcare.hospitals

\* silver\_healthcare.premium\_payments



\### Output Tables



\* project\_output.disease\_max\_claims

\* project\_output.subscribers\_under\_30

\* project\_output.group\_with\_max\_subgroups

\* project\_output.hospital\_most\_patients

\* project\_output.most\_subscribed\_subgroup

\* project\_output.total\_rejected\_claims

\* project\_output.claims\_by\_city

\* project\_output.policy\_type\_subscription\_count

\* project\_output.average\_monthly\_premium

\* project\_output.most\_profitable\_group

\* project\_output.cancer\_patients\_under\_18

\* project\_output.cashless\_claims\_above\_50000

\* project\_output.female\_knee\_surgery\_over\_40



\## Jira Project Management



Jira is used to manage the capstone project tasks using a simple Scrum-style workflow.



Workflow statuses:



\* To Do

\* In Progress

\* Done



Planned work includes:



\* Requirement documentation

\* Solution design

\* Database schema design

\* Dataset preparation

\* S3 ingestion

\* Databricks PySpark transformation

\* Redshift table creation

\* Output table generation

\* Testing and validation

\* Final presentation preparation



\## Testing and Validation



Testing includes:



\* Validating dataset row counts

\* Checking null values before and after cleaning

\* Verifying duplicate removal

\* Confirming correct data type conversions

\* Validating Redshift table loads

\* Running SQL queries for all required business use cases

\* Comparing output results with expected business logic



\## Screenshots for Submission



The `screenshots` folder can include:



\* S3 bucket and input-data folder

\* Uploaded raw CSV files

\* Databricks notebook execution

\* Null count reports

\* Silver layer output in S3

\* Redshift schemas and tables

\* Final SQL output results

\* Jira board

\* GitHub repository structure



\## Author



\*\*Bipina Poudel\*\*



\## Project Status



Completed



