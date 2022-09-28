Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv -v moves=10 < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1
CREATE FUNCTION
     solution      
-------------------
 {9,2,6,5,8,3,7,4}
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv -v moves=100 < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1
CREATE FUNCTION
     solution      
-------------------
 {2,8,9,4,6,7,5,3}
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv -v total_cups=1000000 -v moves=10000000 < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1
CREATE FUNCTION
 simulate_crab_game 
--------------------
       149245887792
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv -v total_cups=1000000 -v moves=10000000 < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1
CREATE FUNCTION
 simulate_crab_game 
--------------------
       519044017360
(1 row)
```
