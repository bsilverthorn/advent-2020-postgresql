Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 3
 spoken 
--------
    436
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 7
 spoken 
--------
    517
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv -v game_turns=2020 < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 3
CREATE FUNCTION
 play_memory_game 
------------------
              436
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv -v game_turns=30000000 < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 7
CREATE FUNCTION
 play_memory_game 
------------------
          1047739
(1 row)
```
