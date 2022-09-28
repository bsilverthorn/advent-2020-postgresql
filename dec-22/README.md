Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 2
 sum 
-----
 306
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 2
  sum  
-------
 32102
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 2
CREATE FUNCTION
 sum 
-----
 291
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 2
CREATE FUNCTION
  sum  
-------
 34173
(1 row)
```
