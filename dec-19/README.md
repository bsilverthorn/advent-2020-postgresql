Part 1
------

```
$ psql -v rules_inpath=$PWD/in-actual-p0.rules.csv -v messages_inpath=$PWD/in-actual.messages.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 136
CREATE TABLE
COPY 329
 count 
-------
   113
(1 row)
```

Part 2
------

(Munged the input to partially unroll the two new recursive patterns.)

```
$ psql -v rules_inpath=$PWD/in-actual-p1.rules.csv -v messages_inpath=$PWD/in-actual.messages.csv < solve-p0v0.sql
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 148
CREATE TABLE
COPY 329
 count 
-------
   253
(1 row)
```
