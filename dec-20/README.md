Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.tiles.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 9
    ?column?    
----------------
 20899048083289
 20899048083289
 20899048083289
 20899048083289
 20899048083289
 20899048083289
 20899048083289
 20899048083289
(8 rows)
```

```
$ psql -v inpath=$PWD/in-actual.tiles.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 144
    ?column?    
----------------
 16937516456219
 16937516456219
 16937516456219
 16937516456219
 16937516456219
 16937516456219
 16937516456219
 16937516456219
(8 rows)
```

Part 2
------

```
$ psql -v tiles_inpath=$PWD/in-sample-p0s0.tiles.csv -v monster_inpath=$PWD/in-actual.monster.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 9
CREATE TABLE
COPY 15
 monsters | roughness | solution 
----------+-----------+----------
        0 |       303 |      303
        0 |       303 |      303
        0 |       303 |      303
        2 |       303 |      273
        0 |       303 |      303
        0 |       303 |      303
        0 |       303 |      303
        0 |       303 |      303
(8 rows)
```

```
$ psql -v tiles_inpath=$PWD/in-actual.tiles.csv -v monster_inpath=$PWD/in-actual.monster.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 144
CREATE TABLE
COPY 15
 monsters | roughness | solution 
----------+-----------+----------
        0 |      2248 |     2248
        0 |      2248 |     2248
        0 |      2248 |     2248
       26 |      2248 |     1858
        0 |      2248 |     2248
        0 |      2248 |     2248
        0 |      2248 |     2248
        0 |      2248 |     2248
(8 rows)
```
