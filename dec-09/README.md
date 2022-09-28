Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv -v prelen=5 < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 20
 seq | number | valid 
-----+--------+-------
   5 |     40 | t
   7 |     55 | t
   6 |     62 | t
   8 |     65 | t
   9 |     95 | t
  10 |    102 | t
  11 |    117 | t
  12 |    150 | t
  13 |    182 | t
  15 |    219 | t
  17 |    277 | t
  16 |    299 | t
  18 |    309 | t
  19 |    576 | t
  14 |    127 | f
(15 rows)
```

```
$ psql -v inpath=$PWD/in-actual.csv -v prelen=25 < solve-p0v0.sql
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1000
 seq |     number     | valid 
-----+----------------+-------
  25 |              3 | t
  28 |              4 | t
  30 |              5 | t
  31 |              9 | t
 ...
 996 | 61564837913766 | t
 999 | 63402538855401 | t
 977 | 65018616493585 | t
 989 | 67945113116859 | t
 990 | 68892410832496 | t
 997 | 87342693503967 | t
 998 | 92101686313779 | t
 511 |       18272118 | f
(975 rows)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv -v target=127 < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 20
 ?column? 
----------
       62
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv -v target=18272118 < solve-p1v0.sql
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1000
 ?column? 
----------
  2186361
(1 row)
```
