Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v1.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 2
CREATE FUNCTION
 device | public_key | loops |  keyval  | loops |  keyval  
--------+------------+-------+----------+-------+----------
      1 |    5764801 |     8 |  5764801 |    11 | 14897079
      2 |   17807724 |    11 | 17807724 |     8 | 14897079
(2 rows)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v1.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 2
CREATE FUNCTION
 device | public_key |  loops   |  keyval  |  loops   | keyval 
--------+------------+----------+----------+----------+--------
      1 |   11239946 |  1665442 | 11239946 | 18474687 | 711945
      2 |   10464955 | 18474687 | 10464955 |  1665442 | 711945
(2 rows)
```

Part 2
------

There is no part 2! 🎄
