Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1
 max 
-----
 357
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 932
 max 
-----
 947
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 932
 id  | occupied | id  | occupied | id  | occupied 
-----+----------+-----+----------+-----+----------
 636 | f        | 635 | t        | 637 | t
(1 row)
```
