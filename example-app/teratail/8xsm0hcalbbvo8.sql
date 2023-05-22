https://learn.microsoft.com/ja-jp/sql/t-sql/statements/drop-table-transact-sql?view=sql-server-ver15#c-dropping-a-temporary-table

-- CSV取込用の一時テーブルを作成する
CREATE TABLE #SourceTable (col1 INT)
(
  Col1 INT NOT NULL PRIMARY KEY,
  Col2 VARCHAR(20) NOT NULL
);

-- 取込先の対象テーブルを作成する
CREATE TABLE TargetTable
(
  Col1 INT NOT NULL PRIMARY KEY,
  Col2 VARCHAR(20) NOT NULL
);

-- CSV取込を実行する
BULK INSERT #SourceTable  
FROM 'c:\Source.csv'
WITH
(
   FIELDTERMINATOR = ',', --区切り文字をカンマに指定
   ROWTERMINATOR = '\n' --行の終わり文字を\nに指定
)
;
-- 一時テーブルと対象テーブルをマージする
MERGE INTO TargetTable AS TGT
USING #SourceTable AS SRC ON TGT.Col1 = SRC.Col1
WHEN MATCHED
  THEN UPDATE SET TGT.Col2 = SRC.Col2
WHEN NOT MATCHED
  THEN INSERT (Col1, Col2)
  VALUES (SRC.Col1, SRC.Col2)
;

-- 一時テーブルのSourceTableが存在する場合に削除する
IF OBJECT_ID(N'dbo..#SourceTable', N'U') IS NOT NULL  
   DROP TABLE #SourceTable
;  

-- 更新されたテーブルを確認する
SELECT * FROM TargetTable
;  