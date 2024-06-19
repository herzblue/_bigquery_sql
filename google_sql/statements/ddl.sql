-- https://cloud.google.com/bigquery/docs/reference/standard-sql/data-definition-language#create_table_like

#1. CREATE SCHEMA
#2. CREATE TABLE
#3. CREATE TABLE LIKE
#4. CREATE TABLE COPY
#5. CREATE SNAPSHOT TABLE
#6. CREATE TABLE CLONE
#7. CREATE VIEW
#8. CREATE MATERIALIZED VIEW
#9. CREATE MATERIALIZED VIEW AS REPLICA OF
#10. CREATE EXTERNAL SCHEMA
#11. CREATE EXTERNAL TABLE
#12. CREATE FUNCTION
#13. CREATE AGGREGATE FUNCTION
#14. CREATE TABLE FUNCTION
#15. CREATE PROCEDURE
#16. CREATE ROW ACCESS POLICY 
#17. CREATE CAPACITY 
#18. CREATE RESERVATION 
#19. CREATE ASSIGNMENT 
#20. CREATE SEARCH INDEX
#21. CREATE VECTOR INDEX 
#22. ALTER SCHEMA SET DEFAULT COLLATE 
#23. ALTER SCHEMA SET OPTIONS 
#24. ALTER SCHEMA ADD REPLICA 
#25. ALTER SCHEMA DROP REPLICA 
#26. ALTER TABLE SET OPTIONS 
#27. ALTER TABLE ADD COLUMN 
#28. ALTER TABLE ADD FOREIGN KEY 
#29. ALTER TABLE ADD PRIMARY KEY 
#30. ALTER TABLE RENAME TO 
#31. ALTER TABLE RENAME COLUMN 
#32. ALTER TABLE DROP COLUMN 
#33. ALTER TABLE DROP CONSTRAINT 
#34. ALTER TABLE DROP PRIMARY KEY 
#35. ALTER TABLE SET DEFAULT COLLATE 
#36. ALTER COLUMN SET OPTIONS 
#37. ALTER COLUMN DROP NOT NULL 
#39. ALTER COLUMN SET DATA TYPE 
#40. ALTER COLUMN SET DEFAULT 
#41. ALTER COLUMN DROP DEFAULT 
#42. ALTER VIEW SET OPTIONS 
#43. ALTER MATERIALIZED VIEW SET OPTIONS
#44. ALTER ORGANIZATION SET OPTIONS
#45. ALTER PROJECT SET OPTIONS
#46. ALTER BI_CAPACITY SET OPTIONS
#47. ALTER CAPACITY SET OPTIONS
#48. ALTER RESERVATION SET OPTIONS
#49. DROP SCHEMA
#50. UNDROP SCHEMA
#51. DROP TABLE
#52. DROP SNAPSHOT TABLE
#53. DROP EXTERNAL TABLE
#54. DROP VIEW
#55. DROP MATERIALIZED VIEW
#56. DROP FUNCTION
#57. DROP TABLE FUNCTION
#58. DROP PROCEDURE
#59. DROP ROW ACCESS POLICY
#60. DROP CAPACITY
#61. DROP RESERVATION
#62. DROP ASSIGNMENT
#63. DROP SEARCH INDEX
#64. DROP VECTOR INDEX
#65. TABLE PATH SYNTAX

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 



-- #1. CREATE SCHEMA
CREATE SCHEMA [ IF NOT EXISTS ]
[project_name.]dataset_name
[DEFAULT COLLATE collate_specification]
[OPTIONS(schema_option_list)]
-- IF NOT EXISTS: 동일한 이름의 스키마가 이미 존재하는 경우 오류를 발생시키지 않고 무시
-- DEFAULT COLLATE: 스키마에 저장된 문자열 데이터의 기본 정렬 순서를 지정
-- OPTIONS: 스키마에 대한 추가 옵션을 지정
--  schema_option_list
-- default_kms_key_name: 스키마에 저장된 데이터를 암호화하는 데 사용할 기본 Cloud KMS 키의 이름
-- default_rounding_mode: 스키마에 저장된 데이터의 기본 반올림 모드
-- default_table_expiration_days : 스키마에 저장된 테이블의 기본 만료 기간(일)
-- description : 스키마에 대한 설명
-- friendly_name : 스키마에 대한 사용자 지정 이름
-- is_case_insensitive : 스키마의 이름이 대/소문자를 구분하는지 여부
-- labels : 스키마에 대한 라벨 세트
-- location : 스키마의 데이터 센터 위치
-- max_time_travel_hours : 스키마에 저장된 데이터의 최대 시간 이동(시간)
-- primary_replica : 스키마의 기본 복제본
-- is_primary : 스키마가 기본 스키마인지 여부
-- failover_reservation : 스키마에 대한 장애 조치 예약
-- storage_billing_model : 스키마의 저장소 요금 청구 모델

-- Example
CREATE SCHEMA IF NOT EXISTS `my_schema` ;
-- Example: 기본 테이블 만료 시간과 라벨 세트가 포함
CREATE SCHEMA mydataset
OPTIONS(
  location="us",
  default_table_expiration_days=3.75,
  labels=[("label1","value1"),("label2","value2")]
  )
-- Example: 대소문자를 구분하지 않는 데이터세트 만들기
CREATE SCHEMA mydataset
OPTIONS(
  is_case_insensitive=TRUE
)


-- #2. CREATE TABLE
CREATE [ OR REPLACE ] [ TEMP | TEMPORARY ] TABLE [ IF NOT EXISTS ]
table_name
[(
  column | constraint_definition[, ...]
)]
[DEFAULT COLLATE collate_specification]
[PARTITION BY partition_expression]
[CLUSTER BY clustering_column_list]
[OPTIONS(table_option_list)]
[AS query_statement]

column:=
column_definition

constraint_definition:=
[primary_key]
| [[CONSTRAINT constraint_name] foreign_key, ...]

primary_key :=
PRIMARY KEY (column_name[, ...]) NOT ENFORCED

foreign_key :=
FOREIGN KEY (column_name[, ...]) foreign_reference

foreign_reference :=
REFERENCES primary_key_table(column_name[, ...]) NOT ENFORCED

-- OR REPLACE: 동일한 이름의 테이블이 있으면 대체합니다. IF NOT EXISTS. 와 함께 나타날 수 없습니다 
-- TEMP | TEMPORARY: 임시 테이블을 생성합니다 .
-- IF NOT EXISTS: 동일한 이름을 가진 테이블이 있으면 명령문은 CREATE 아무 효과가 없습니다. 와 함께 나타날 수 없습니다 OR REPLACE.
-- table_name: 생성할 테이블의 이름입니다. 테이블 경로 구문을 참조하세요 . 임시 테이블의 경우 프로젝트 이름이나 데이터세트 이름을 포함하지 마세요.
-- column: 테이블의 스키마 정보입니다.
-- constraint_definition: 테이블 제약 조건을 정의하는 표현식입니다.
-- collation_specification: 명시적인 데이터 정렬 사양 없이 테이블에 새 열이 추가되면 해당 열은 유형 에 대해 이 데이터 정렬 사양을 상속합니다 STRING. 나중에 문을 사용하여 이 데이터 정렬 사양을 제거하거나 변경하는 경우 ALTER TABLE이 테이블의 기존 데이터 정렬 사양은 변경되지 않습니다. 테이블의 기존 데이터 정렬 사양을 업데이트하려면 해당 사양이 포함된 열을 변경해야 합니다.
-- 테이블이 데이터 세트의 일부인 경우 이 테이블의 기본 데이터 정렬 사양이 데이터 세트의 기본 데이터 정렬 사양을 재정의합니다.
-- partition_expression: 테이블을 분할하는 방법을 결정하는 표현식입니다.
-- clustering_column_list: 테이블을 클러스터링하는 방법을 결정하는 쉼표로 구분된 열 참조 목록입니다. 이 목록의 열에는 데이터 정렬을 사용할 수 없습니다.
-- table_option_list: 테이블 생성을 위한 옵션 목록입니다.
-- query_statement: 테이블을 생성해야 하는 쿼리입니다. 쿼리 구문은 SQL 구문 참조 를 참조하세요 . 이 테이블에 데이터 정렬 사양이 사용되는 경우 데이터 정렬은 이 쿼리 문을 통해 전달됩니다.
-- primary_key: 기본 키 테이블 제약 조건을 정의하는 표현식입니다.
-- foreign_key: 외래 키 테이블 제약 조건을 정의하는 표현식입니다.


-- Example: _PARTITIONDATE로 파티션을 나눈 테이블 만들기
CREATE TABLE mydataset.newtable
(
  x INT64 OPTIONS(description="An optional INTEGER field"),
  y STRUCT<
    a ARRAY<STRING> OPTIONS(description="A repeated STRING field"),
    b BOOL
  >
)
PARTITION BY _PARTITIONDATE
OPTIONS(
  expiration_timestamp=TIMESTAMP "2025-01-01 00:00:00 UTC",
  partition_expiration_days=1,
  description="a table that expires in 2025, with each partition living for 24 hours",
  labels=[("org_unit", "development")]
)

-- Example: 테이블이 존재하지 않는 경우에만 테이블 생성
CREATE TABLE IF NOT EXISTS mydataset.newtable (x INT64, y STRUCT<a ARRAY<STRING>, b BOOL>)
OPTIONS(
  expiration_timestamp=TIMESTAMP "2025-01-01 00:00:00 UTC",
  description="a table that expires in 2025",
  labels=[("org_unit", "development")]
)

-- Example: 테이블 생성 또는 바꾸기
CREATE OR REPLACE TABLE mydataset.newtable (x INT64, y STRUCT<a ARRAY<STRING>, b BOOL>)
OPTIONS(
  expiration_timestamp=TIMESTAMP "2025-01-01 00:00:00 UTC",
  description="a table that expires in 2025",
  labels=[("org_unit", "development")]
)

-- Example: REQUIRED열이 있는 테이블 만들기
CREATE TABLE mydataset.newtable
(
  x INT64,
  y STRING NOT NULL
);

CREATE TABLE mydataset.newtable (
  x INT64 NOT NULL,
  y STRUCT<
    a ARRAY<STRING>,
    b BOOL NOT NULL,
    c FLOAT64
  > NOT NULL,
  z STRING
);

-- Example: 파티션을 나눈 테이블 만들기
CREATE TABLE mydataset.newtable (transaction_id INT64, transaction_date DATE)
PARTITION BY transaction_date
OPTIONS(
  partition_expiration_days=3,
  description="a table partitioned by transaction_date"
)

-- Example: 클러스터링된 테이블 만들기 이름이 지정된 열로 클러스터링된 분할된 테이블
CREATE TABLE mydataset.myclusteredtable
(
  timestamp TIMESTAMP,
  customer_id STRING,
  transaction_amount NUMERIC
)
PARTITION BY DATE(timestamp)
CLUSTER BY customer_id
OPTIONS (
  partition_expiration_days=3,
  description="a table clustered by customer_id"
)
s
-- Example: 클러스터링된 테이블을 만듭니다 . 테이블은 수집 시간으로 파티션을 나눈 테이블
CREATE TABLE mydataset.myclusteredtable
(
  customer_id STRING,
  transaction_amount NUMERIC
)
PARTITION BY DATE(_PARTITIONTIME)
CLUSTER BY
  customer_id
OPTIONS (
  partition_expiration_days=3,
  description="a table clustered by customer_id"
)

-- Example: 
-- Example: 


-- #3. CREATE TABLE LIKE
-- 다른 테이블의 동일한 메타데이터가 모두 포함된 새 테이블

-- Example:동일한 메타데이터를 사용하여 이름이 newtable인 새 테이블
CREATE TABLE mydataset.newtable
LIKE mydataset.sourcetable

-- Example: 쿼리문의 데이터와 동일한 메타데이터를 사용하여 newtablein이라는 이름의 새 테이블
CREATE TABLE mydataset.newtable
LIKE mydataset.sourcetable
AS SELECT * FROM mydataset.myothertable

-- #4. CREATE TABLE COPY
-- 원본 테이블의 메타데이터와 데이터를 모두 복사
CREATE [ OR REPLACE ] TABLE [ IF NOT EXISTS ] table_name
COPY source_table_name
...
[OPTIONS(table_option_list)]

-- 새 테이블은 소스 테이블에서 분할 및 클러스터링을 상속합니다. 
-- 기본적으로 소스 테이블의 테이블 옵션 메타데이터도 상속되지만 OPTIONS 절을 사용하여 테이블 옵션을 재정의할 수 있습니다 . 
-- 이 동작은 테이블을 복사한 후 ALTER TABLE SET OPTIONS 실행하는 것과 같습니다 .

-- Example: 
CREATE TABLE IF NOT EXISTS mydataset.newtable
COPY mydataset.sourcetable

-- #5. CREATE SNAPSHOT TABLE
-- 

-- #6. CREATE TABLE CLONE
-- 기존 테이블과 신규 테이블의 공통된 데이터의 과금을 방지하기 위해 사용

#7. CREATE VIEW
#8. CREATE MATERIALIZED VIEW
#9. CREATE MATERIALIZED VIEW AS REPLICA OF
#10. CREATE EXTERNAL SCHEMA
#11. CREATE EXTERNAL TABLE
#12. CREATE FUNCTION
#13. CREATE AGGREGATE FUNCTION
#14. CREATE TABLE FUNCTION
#15. CREATE PROCEDURE
#16. CREATE ROW ACCESS POLICY 
#17. CREATE CAPACITY 
#18. CREATE RESERVATION 
#19. CREATE ASSIGNMENT 
#20. CREATE SEARCH INDEX
#21. CREATE VECTOR INDEX 
#22. ALTER SCHEMA SET DEFAULT COLLATE 
#23. ALTER SCHEMA SET OPTIONS 
#24. ALTER SCHEMA ADD REPLICA 
#25. ALTER SCHEMA DROP REPLICA 
#26. ALTER TABLE SET OPTIONS 
#27. ALTER TABLE ADD COLUMN 
#28. ALTER TABLE ADD FOREIGN KEY 
#29. ALTER TABLE ADD PRIMARY KEY 
#30. ALTER TABLE RENAME TO 
#31. ALTER TABLE RENAME COLUMN 
#32. ALTER TABLE DROP COLUMN 
#33. ALTER TABLE DROP CONSTRAINT 
#34. ALTER TABLE DROP PRIMARY KEY 
#35. ALTER TABLE SET DEFAULT COLLATE 
#36. ALTER COLUMN SET OPTIONS 
#37. ALTER COLUMN DROP NOT NULL 
#39. ALTER COLUMN SET DATA TYPE 
#40. ALTER COLUMN SET DEFAULT 
#41. ALTER COLUMN DROP DEFAULT 
#42. ALTER VIEW SET OPTIONS 
#43. ALTER MATERIALIZED VIEW SET OPTIONS
#44. ALTER ORGANIZATION SET OPTIONS
#45. ALTER PROJECT SET OPTIONS
#46. ALTER BI_CAPACITY SET OPTIONS
#47. ALTER CAPACITY SET OPTIONS
#48. ALTER RESERVATION SET OPTIONS
#49. DROP SCHEMA
#50. UNDROP SCHEMA
#51. DROP TABLE
#52. DROP SNAPSHOT TABLE
#53. DROP EXTERNAL TABLE
#54. DROP VIEW
#55. DROP MATERIALIZED VIEW
#56. DROP FUNCTION
#57. DROP TABLE FUNCTION
#58. DROP PROCEDURE
#59. DROP ROW ACCESS POLICY
#60. DROP CAPACITY
#61. DROP RESERVATION
#62. DROP ASSIGNMENT
#63. DROP SEARCH INDEX
#64. DROP VECTOR INDEX
#65. TABLE PATH SYNTAX