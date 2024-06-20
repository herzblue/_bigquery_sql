-- -- #1 On-demand query size calculation
-- #1-1 Non-partitioned tables
-- #1-2 Partitioned tables

-- -- #2 INSERT statement
-- 테이블에 새 행을 추가
INSERT [INTO] target_name
 [(column_1 [, ..., column_n ] )]
 input

input ::=
 VALUES (expr_1 [, ..., expr_n ] )
        [, ..., (expr_k_1 [, ..., expr_k_n ] ) ]
| SELECT_QUERY

expr ::= value_expression | DEFAULT

-- #2-1 Omitting column names
-- 생략된 열에 기본값이 있으면 해당 값이 사용됩니다. 
-- 대상 테이블이 수집 시간으로 파티션을 나눈 테이블인 경우 열 이름을 지정해야 합니다.
-- 그렇지 않으면 열 값은 NULL입니다. 

-- #2-2 Value type compatibility

-- #2-3 INSERT examples
-- examples1
INSERT dataset.Inventory (product, quantity)
VALUES('top load washer', 10),
      ('front load washer', 20),
      ('dryer', 30),
      ('refrigerator', 10),
      ('microwave', 20),
      ('dishwasher', 30),
      ('oven', 5)

-- examples2
ALTER TABLE dataset.NewArrivals ALTER COLUMN quantity SET DEFAULT 100;

INSERT dataset.NewArrivals (product, quantity, warehouse)
VALUES('top load washer', DEFAULT, 'warehouse #1'),
      ('dryer', 200, 'warehouse #2'),
      ('oven', 300, 'warehouse #3');

-- examples3
INSERT dataset.Warehouse (warehouse, state)
SELECT *
FROM UNNEST([('warehouse #1', 'WA'),
      ('warehouse #2', 'CA'),
      ('warehouse #3', 'WA')])

-- examples4: INSERT SELECT를 사용할 때 WITH를 사용
INSERT dataset.Warehouse (warehouse, state)
WITH w AS (
  SELECT ARRAY<STRUCT<warehouse string, state string>>
      [('warehouse #1', 'WA'),
       ('warehouse #2', 'CA'),
       ('warehouse #3', 'WA')] col
)
SELECT warehouse, state FROM w, UNNEST(w.col)


-- -- #3 DELETE statement
-- #3-1 WHERE keyword
-- #3-2 DELETE examples

-- -- #4 TRUNCATE TABLE statement
-- #4-1 TRUNCATE TABLE examples



-- -- #5 UPDATE statement
-- UPDATE테이블 내의 기존 행을 업데이트
UPDATE target_name [[AS] alias]
SET set_clause
[FROM from_clause]
WHERE condition

set_clause ::= update_item[, ...]

update_item ::= column_name = expression
-- target_name: 업데이트할 테이블의 이름입니다.
-- update_item: 업데이트할 열의 이름과 업데이트된 값을 평가할 표현식입니다. 표현식에는 DEFAULT해당 열의 기본값으로 대체되는 키워드가 포함될 수 있습니다.
-- 열이 STRUCT유형 인 경우 점 표기법을 사용하여 column_name필드를 참조할 수 있습니다 STRUCT. 예를 들어, struct1.field1.



-- #5-1 WHERE keyword
-- #5-2 FROM keyword
-- #5-3 UPDATE examples

-- examples1: 문자열이 포함된 모든 제품에 대해 필드 Inventory값을 10씩 줄여 명명된 테이블을 업데이트
UPDATE dataset.Inventory
SET quantity = quantity - 10,
    supply_constrained = DEFAULT
WHERE product like '%washer%'






-- -- #6 MERGE statement
-- #6-1 Omitting column names
-- #6-2 MERGE examples

-- -- #7 Tables used in examples
-- #7-1 Inventory table
-- #7-2 NewArrivals table
-- #7-3 Warehouse table
-- #7-4 DetailedInventory table





-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- 
-- -- #1 On-demand query size calculation
-- #1-1 Non-partitioned tables
-- #1-2 Partitioned tables

-- -- #2 INSERT statement
-- 테이블에 새 행을 추가
-- #2-1 Omitting column names
-- 생략된 열에 기본값이 있으면 해당 값이 사용됩니다. 
-- 대상 테이블이 수집 시간으로 파티션을 나눈 테이블인 경우 열 이름을 지정해야 합니다.
-- 그렇지 않으면 열 값은 NULL입니다. 
-- #2-2 Value type compatibility
-- #2-3 INSERT examples

-- -- #3 DELETE statement
-- #3-1 WHERE keyword
-- #3-2 DELETE examples

-- -- #4 TRUNCATE TABLE statement
-- #4-1 TRUNCATE TABLE examples

-- -- #5 UPDATE statement
-- #5-1 WHERE keyword
-- #5-2 FROM keyword
-- #5-3 UPDATE examples

-- -- #6 MERGE statement
-- #6-1 Omitting column names
-- #6-2 MERGE examples

-- -- #7 Tables used in examples
-- #7-1 Inventory table
-- #7-2 NewArrivals table
-- #7-3 Warehouse table
-- #7-4 DetailedInventory table