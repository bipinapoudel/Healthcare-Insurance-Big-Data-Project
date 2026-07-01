-- 03_copy_silver_from_s3.sql
-- Healthcare Insurance Big Data Project
-- Purpose: Load cleaned Silver CSV files from S3 into Redshift Silver tables.

TRUNCATE TABLE silver_healthcare.patients;
COPY silver_healthcare.patients
FROM 's3://healthcare-insurance-bigdata-bipina/silver/patients/'
IAM_ROLE 'arn:aws:iam::447444645163:role/admin-redshift'
CSV
IGNOREHEADER 1
DATEFORMAT 'auto'
EMPTYASNULL
BLANKSASNULL;

TRUNCATE TABLE silver_healthcare.subscriber;
COPY silver_healthcare.subscriber
FROM 's3://healthcare-insurance-bigdata-bipina/silver/subscriber/'
IAM_ROLE 'arn:aws:iam::447444645163:role/admin-redshift'
CSV
IGNOREHEADER 1
DATEFORMAT 'auto'
EMPTYASNULL
BLANKSASNULL;

TRUNCATE TABLE silver_healthcare.claims;
COPY silver_healthcare.claims
FROM 's3://healthcare-insurance-bigdata-bipina/silver/claims/'
IAM_ROLE 'arn:aws:iam::447444645163:role/admin-redshift'
CSV
IGNOREHEADER 1
DATEFORMAT 'auto'
EMPTYASNULL
BLANKSASNULL;

TRUNCATE TABLE silver_healthcare.group_subgroup;
COPY silver_healthcare.group_subgroup
FROM 's3://healthcare-insurance-bigdata-bipina/silver/group_subgroup/'
IAM_ROLE 'arn:aws:iam::447444645163:role/admin-redshift'
CSV
IGNOREHEADER 1
DATEFORMAT 'auto'
EMPTYASNULL
BLANKSASNULL;

TRUNCATE TABLE silver_healthcare.policy_groups;
COPY silver_healthcare.policy_groups
FROM 's3://healthcare-insurance-bigdata-bipina/silver/policy_groups/'
IAM_ROLE 'arn:aws:iam::447444645163:role/admin-redshift'
CSV
IGNOREHEADER 1
DATEFORMAT 'auto'
EMPTYASNULL
BLANKSASNULL;

TRUNCATE TABLE silver_healthcare.hospitals;
COPY silver_healthcare.hospitals
FROM 's3://healthcare-insurance-bigdata-bipina/silver/hospitals/'
IAM_ROLE 'arn:aws:iam::447444645163:role/admin-redshift'
CSV
IGNOREHEADER 1
DATEFORMAT 'auto'
EMPTYASNULL
BLANKSASNULL;

TRUNCATE TABLE silver_healthcare.premium_payments;
COPY silver_healthcare.premium_payments
FROM 's3://healthcare-insurance-bigdata-bipina/silver/premium_payments/'
IAM_ROLE 'arn:aws:iam::447444645163:role/admin-redshift'
CSV
IGNOREHEADER 1
DATEFORMAT 'auto'
EMPTYASNULL
BLANKSASNULL;

SELECT 'patients' AS table_name, COUNT(*) AS row_count FROM silver_healthcare.patients
UNION ALL SELECT 'subscriber', COUNT(*) FROM silver_healthcare.subscriber
UNION ALL SELECT 'claims', COUNT(*) FROM silver_healthcare.claims
UNION ALL SELECT 'group_subgroup', COUNT(*) FROM silver_healthcare.group_subgroup
UNION ALL SELECT 'policy_groups', COUNT(*) FROM silver_healthcare.policy_groups
UNION ALL SELECT 'hospitals', COUNT(*) FROM silver_healthcare.hospitals
UNION ALL SELECT 'premium_payments', COUNT(*) FROM silver_healthcare.premium_payments;
