-- 04_create_project_output_tables.sql
-- Healthcare Insurance Big Data Project
-- Purpose: Create final Redshift output tables for all capstone business use cases.

DROP TABLE IF EXISTS project_output.disease_max_claims;
CREATE TABLE project_output.disease_max_claims AS
SELECT disease_name, COUNT(*) AS total_claims
FROM silver_healthcare.claims
GROUP BY disease_name
ORDER BY total_claims DESC
LIMIT 1;

DROP TABLE IF EXISTS project_output.subscribers_under_30;
CREATE TABLE project_output.subscribers_under_30 AS
SELECT s.subscriber_id, p.patient_id, p.first_name, p.last_name, p.age, gs.subgroup_id, gs.subgroup_name
FROM silver_healthcare.subscriber s
JOIN silver_healthcare.patients p ON s.patient_id = p.patient_id
JOIN silver_healthcare.group_subgroup gs ON s.subgroup_id = gs.subgroup_id
WHERE p.age < 30;

DROP TABLE IF EXISTS project_output.group_with_max_subgroups;
CREATE TABLE project_output.group_with_max_subgroups AS
SELECT pg.group_id, pg.group_name, COUNT(gs.subgroup_id) AS total_subgroups
FROM silver_healthcare.policy_groups pg
JOIN silver_healthcare.group_subgroup gs ON pg.group_id = gs.group_id
GROUP BY pg.group_id, pg.group_name
ORDER BY total_subgroups DESC
LIMIT 1;

DROP TABLE IF EXISTS project_output.hospital_most_patients;
CREATE TABLE project_output.hospital_most_patients AS
SELECT h.hospital_id, h.hospital_name, COUNT(DISTINCT c.patient_id) AS total_patients
FROM silver_healthcare.claims c
JOIN silver_healthcare.hospitals h ON c.hospital_id = h.hospital_id
GROUP BY h.hospital_id, h.hospital_name
ORDER BY total_patients DESC
LIMIT 1;

DROP TABLE IF EXISTS project_output.most_subscribed_subgroup;
CREATE TABLE project_output.most_subscribed_subgroup AS
SELECT gs.subgroup_id, gs.subgroup_name, COUNT(s.subscriber_id) AS total_subscribers
FROM silver_healthcare.subscriber s
JOIN silver_healthcare.group_subgroup gs ON s.subgroup_id = gs.subgroup_id
GROUP BY gs.subgroup_id, gs.subgroup_name
ORDER BY total_subscribers DESC
LIMIT 1;

DROP TABLE IF EXISTS project_output.total_rejected_claims;
CREATE TABLE project_output.total_rejected_claims AS
SELECT COUNT(*) AS total_rejected_claims
FROM silver_healthcare.claims
WHERE claim_status = 'Rejected';

DROP TABLE IF EXISTS project_output.claims_by_city;
CREATE TABLE project_output.claims_by_city AS
SELECT p.city, COUNT(c.claim_id) AS total_claims
FROM silver_healthcare.claims c
JOIN silver_healthcare.patients p ON c.patient_id = p.patient_id
GROUP BY p.city
ORDER BY total_claims DESC;

DROP TABLE IF EXISTS project_output.policy_type_subscription_count;
CREATE TABLE project_output.policy_type_subscription_count AS
SELECT pg.policy_type, COUNT(s.subscriber_id) AS total_subscribers
FROM silver_healthcare.subscriber s
JOIN silver_healthcare.group_subgroup gs ON s.subgroup_id = gs.subgroup_id
JOIN silver_healthcare.policy_groups pg ON gs.group_id = pg.group_id
GROUP BY pg.policy_type
ORDER BY total_subscribers DESC;

DROP TABLE IF EXISTS project_output.average_monthly_premium;
CREATE TABLE project_output.average_monthly_premium AS
SELECT ROUND(AVG(premium_amount), 2) AS average_monthly_premium
FROM silver_healthcare.premium_payments
WHERE payment_status = 'Paid';

DROP TABLE IF EXISTS project_output.most_profitable_group;
CREATE TABLE project_output.most_profitable_group AS
WITH premium_by_group AS (
    SELECT pg.group_id, pg.group_name, SUM(pp.premium_amount) AS total_premium_collected
    FROM silver_healthcare.policy_groups pg
    JOIN silver_healthcare.group_subgroup gs ON pg.group_id = gs.group_id
    JOIN silver_healthcare.subscriber s ON gs.subgroup_id = s.subgroup_id
    LEFT JOIN silver_healthcare.premium_payments pp ON s.subscriber_id = pp.subscriber_id
    GROUP BY pg.group_id, pg.group_name
),
claims_by_group AS (
    SELECT pg.group_id, SUM(c.approved_amount) AS total_claim_paid
    FROM silver_healthcare.policy_groups pg
    JOIN silver_healthcare.group_subgroup gs ON pg.group_id = gs.group_id
    JOIN silver_healthcare.subscriber s ON gs.subgroup_id = s.subgroup_id
    LEFT JOIN silver_healthcare.claims c ON s.subscriber_id = c.subscriber_id
    GROUP BY pg.group_id
)
SELECT p.group_id, p.group_name,
       COALESCE(p.total_premium_collected, 0) AS total_premium_collected,
       COALESCE(c.total_claim_paid, 0) AS total_claim_paid,
       COALESCE(p.total_premium_collected, 0) - COALESCE(c.total_claim_paid, 0) AS estimated_profit
FROM premium_by_group p
LEFT JOIN claims_by_group c ON p.group_id = c.group_id
ORDER BY estimated_profit DESC
LIMIT 1;

DROP TABLE IF EXISTS project_output.cancer_patients_under_18;
CREATE TABLE project_output.cancer_patients_under_18 AS
SELECT p.patient_id, p.first_name, p.last_name, p.age, c.disease_name, c.claim_date, h.hospital_name
FROM silver_healthcare.patients p
JOIN silver_healthcare.claims c ON p.patient_id = c.patient_id
JOIN silver_healthcare.hospitals h ON c.hospital_id = h.hospital_id
WHERE p.age < 18 AND c.disease_name = 'Cancer';

DROP TABLE IF EXISTS project_output.cashless_claims_above_50000;
CREATE TABLE project_output.cashless_claims_above_50000 AS
SELECT p.patient_id, p.first_name, p.last_name, c.claim_id, c.claim_type, c.total_charges, c.claim_status
FROM silver_healthcare.patients p
JOIN silver_healthcare.claims c ON p.patient_id = c.patient_id
WHERE c.claim_type = 'Cashless' AND c.total_charges >= 50000;

DROP TABLE IF EXISTS project_output.female_knee_surgery_over_40;
CREATE TABLE project_output.female_knee_surgery_over_40 AS
SELECT p.patient_id, p.first_name, p.last_name, p.gender, p.age, c.disease_name, c.claim_date, h.hospital_name
FROM silver_healthcare.patients p
JOIN silver_healthcare.claims c ON p.patient_id = c.patient_id
JOIN silver_healthcare.hospitals h ON c.hospital_id = h.hospital_id
WHERE p.gender = 'Female'
AND p.age > 40
AND c.disease_name = 'Knee Surgery'
AND c.claim_date >= '2025-01-01';

SELECT * FROM project_output.disease_max_claims;
SELECT * FROM project_output.subscribers_under_30 LIMIT 10;
SELECT * FROM project_output.group_with_max_subgroups;
SELECT * FROM project_output.hospital_most_patients;
SELECT * FROM project_output.most_subscribed_subgroup;
SELECT * FROM project_output.total_rejected_claims;
SELECT * FROM project_output.claims_by_city;
SELECT * FROM project_output.policy_type_subscription_count;
SELECT * FROM project_output.average_monthly_premium;
SELECT * FROM project_output.most_profitable_group;
SELECT * FROM project_output.cancer_patients_under_18;
SELECT * FROM project_output.cashless_claims_above_50000 LIMIT 10;
SELECT * FROM project_output.female_knee_surgery_over_40;
