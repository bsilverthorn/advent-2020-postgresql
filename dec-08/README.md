Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 9
 acc 
-----
   0
   0
   1
   1
   2
   2
   5
   5
(8 rows)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 625
 acc  
------
    0
   17
   54
   41
  ...
 1716
 1752
 1752
 1752
 1752
 1752
 1797
 1797
(193 rows)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 9
 acc 
-----
   8
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 625
 acc  
------
 1036
(1 row)
```
