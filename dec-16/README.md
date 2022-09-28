Part 1
------

```
$ psql -v fields_inpath=$PWD/in-sample-p0s0.fields.csv -v tickets_inpath=$PWD/in-sample-p0s0.tickets.csv < solve-p0v1.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 6
CREATE TABLE
COPY 15
 sum 
-----
  71
(1 row)
```

```
$ psql -v fields_inpath=$PWD/in-actual.fields.csv -v tickets_inpath=$PWD/in-actual.tickets.csv < solve-p0v1.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 40
CREATE TABLE
COPY 4900
  sum  
-------
 32835
(1 row)
```

Part 2
------

```
$ psql -v fields_inpath=$PWD/in-sample-p1s0.fields.csv -v tickets_inpath=$PWD/in-sample-p1s0.tickets.csv < solve-p1v0.sql
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 6
CREATE TABLE
COPY 12
CREATE AGGREGATE
CREATE TABLE
SELECT 6
CREATE PROCEDURE
CALL
 name  | position 
-------+----------
 row   |        0
 class |        1
 seat  |        2
(3 rows)

 mul 
-----
    
(1 row)
```

```
$ psql -v fields_inpath=$PWD/in-actual.fields.csv -v tickets_inpath=$PWD/in-actual.tickets.csv < solve-p1v0.sql
Pager usage is off.
Expanded display is used automatically.
DROP TABLE
CREATE TABLE
COPY 6
DROP TABLE
CREATE TABLE
COPY 12
CREATE AGGREGATE
CREATE PROCEDURE
CALL
 name  | position 
-------+----------
 row   |        0
 class |        1
 seat  |        2
(3 rows)

 mul 
-----
    
(1 row)
```
