-- 02_create_redshift_silver_tables.sql
-- Healthcare Insurance Big Data Project
-- Purpose: Create Redshift Silver layer tables to store cleaned data from S3.

DROP TABLE IF EXISTS silver_healthcare.patients;
CREATE TABLE silver_healthcare.patients (
    patient_id VARCHAR(20),
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    gender VARCHAR(20),
    date_of_birth DATE,
    age INT,
    city VARCHAR(100),
    province VARCHAR(20),
    blood_group VARCHAR(10),
    patient_status VARCHAR(50)
);

DROP TABLE IF EXISTS silver_healthcare.subscriber;
CREATE TABLE silver_healthcare.subscriber (
    subscriber_id VARCHAR(20),
    patient_id VARCHAR(20),
    subgroup_id VARCHAR(20),
    enrollment_date DATE,
    premium_frequency VARCHAR(50),
    subscription_status VARCHAR(50)
);

DROP TABLE IF EXISTS silver_healthcare.claims;
CREATE TABLE silver_healthcare.claims (
    claim_id VARCHAR(20),
    subscriber_id VARCHAR(20),
    patient_id VARCHAR(20),
    hospital_id VARCHAR(20),
    disease_name VARCHAR(100),
    claim_date DATE,
    claim_type VARCHAR(50),
    total_charges DECIMAL(12,2),
    claim_status VARCHAR(50),
    approved_amount DECIMAL(12,2),
    severity VARCHAR(50)
);

DROP TABLE IF EXISTS silver_healthcare.group_subgroup;
CREATE TABLE silver_healthcare.group_subgroup (
    subgroup_id VARCHAR(20),
    group_id VARCHAR(20),
    subgroup_name VARCHAR(100),
    coverage_description VARCHAR(255),
    annual_premium DECIMAL(12,2),
    status VARCHAR(50)
);

DROP TABLE IF EXISTS silver_healthcare.policy_groups;
CREATE TABLE silver_healthcare.policy_groups (
    group_id VARCHAR(20),
    group_name VARCHAR(100),
    policy_type VARCHAR(50),
    description VARCHAR(255),
    profit_margin_rate DECIMAL(5,2)
);

DROP TABLE IF EXISTS silver_healthcare.hospitals;
CREATE TABLE silver_healthcare.hospitals (
    hospital_id VARCHAR(20),
    hospital_name VARCHAR(150),
    city VARCHAR(100),
    province VARCHAR(20),
    hospital_type VARCHAR(50)
);

DROP TABLE IF EXISTS silver_healthcare.premium_payments;
CREATE TABLE silver_healthcare.premium_payments (
    payment_id VARCHAR(50),
    subscriber_id VARCHAR(20),
    payment_date DATE,
    premium_amount DECIMAL(12,2),
    payment_status VARCHAR(50)
);
