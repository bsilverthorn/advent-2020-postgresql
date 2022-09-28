Parts 1 & 2
-----------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 4
SELECT 7
SELECT 3
SELECT 5
CREATE TABLE
CREATE PROCEDURE
CALL
 count 
-------
     5
(1 row)

     string_agg      
---------------------
 mxmxvkd,sqjhc,fvjkl
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 36
SELECT 199
SELECT 8
SELECT 20
CREATE TABLE
CREATE PROCEDURE
CALL
 count 
-------
  2075
(1 row)

                     string_agg                     
----------------------------------------------------
 zfcqk,mdtvbb,ggdbl,frpvd,mgczn,zsfzq,kdqls,kktsjbh
(1 row)
```
