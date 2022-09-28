Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 6
 ?column? 
----------
   514579
   514579
(2 rows)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 200
 ?column? 
----------
   252724
   252724
(2 rows)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 6
 ?column?  
-----------
 241861950
 241861950
 241861950
 241861950
 241861950
 241861950
(6 rows)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 200
 ?column?  
-----------
 276912720
 276912720
 276912720
 276912720
 276912720
 276912720
(6 rows)
```
