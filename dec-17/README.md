Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 5
CREATE PROCEDURE
CREATE PROCEDURE
SELECT 5
CALL
 count 
-------
   112
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 22
CREATE PROCEDURE
CREATE PROCEDURE
SELECT 22
CALL
 count 
-------
   232
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 5
CREATE PROCEDURE
CREATE PROCEDURE
SELECT 5
CALL
 count 
-------
   848
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 22
CREATE PROCEDURE
CREATE PROCEDURE
SELECT 22
CALL
 count 
-------
  1620
(1 row)
```
