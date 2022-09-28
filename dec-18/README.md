Part 1
------

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 373
CREATE FUNCTION
     sum      
--------------
 209335026987
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 373
CREATE FUNCTION
CREATE FUNCTION
      sum       
----------------
 33331817392479
(1 row)
```
