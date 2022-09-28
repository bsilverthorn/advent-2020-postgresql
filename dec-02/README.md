Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 3
 count 
-------
     2
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1000
 count 
-------
   410
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 3
 count 
-------
     1
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 1000
 count 
-------
   694
(1 row)
```
