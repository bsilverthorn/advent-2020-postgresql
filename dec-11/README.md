Part 1
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p0v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 100
CREATE FUNCTION
CREATE FUNCTION
 adv_state_to_fp 
-----------------
 
(1 row)

 string_agg 
------------
 #.#L.L#.##
 #LLL#LL.L#
 L.#.L..#..
 #L##.##.L#
 #.#L.LL.LL
 #.#L#L#.##
 ..L.L.....
 #L#L##L#L#
 #.LLLLLL.L
 #.#L#L#.##
(10 rows)

 count 
-------
    37
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p0v0.sql 
Pager usage is off.                                                                                      
Expanded display is used automatically.                                                                  
CREATE TABLE                                                                                             
COPY 8190                                                                                                
CREATE FUNCTION                                                                                          
CREATE FUNCTION                                                                                          
 adv_state_to_fp                                                                                         
-----------------                                                                                        
                                                                                                         
(1 row)                                                                                                  
                                                                                                         
                                         string_agg                                          
---------------------------------------------------------------------------------------------
 #L#L#L#L#.#L#L#L#.#L#L##L#L#.#L#L#.#L#LL#.#L#LL#L#.#.#L#L#L..#.#L#L#.#L#L##L#L#.#L#L#L#L#L#
 LLLLLLLLL.LLLLLL..LLLLLLLLLL.LLLLL.LLLLLLLL.LLL.LL.LLLLLLLL#LLLLLLLL.LLLLLLLLLL.LLLLLLLLLLL
 #L#L#L#L#.#L##L#L#L#L#.#L#L#.#L#L#L#L#.###L#L#..L#L#L#L#L#LLL#L#L##L#L#L#L#L#L#.#L#.#L#L#L#
 LLLLLLLLLLLLLLLLL.LLLL.#LLLL.LLLL#.LLLLLL.LLLL.#LL.LLLLLLLL#.LLLLLLL.LLLL.LLLLL.LLLLLLLLLLL
 #.#L#L#L#.#L#L#L#.##L#.LL.L#L#L#L..##LLL#.#L#LLLL#.#L#L#L#LL.#L#L#L#L#L#L#.####.#L#L#L#L#L#
 LLLLLLLLLLLLLLLLL.LLLL.#L#LL.LLLLL.LLL#LL.LLL.#LLL.#LLLLLLL#.LLLLLLLLLLL.L.L.LLLLLLLLLLLLLL
 #L#L.#L#L#L#L#L#L#L##.LL.LL#L#L#L#.##..L#.#L#LLLL#..L#L#L#.L..L#L.L#.#L#L#L#L#L.#L#L#L#L#L#
 LLLLLLL.LLLLLLLLL.L#LL.#L#LL..LLLL.LLL#LL.LLLL#LLLL#LLLLLLL#.#LLL#LL.#LLLL.LLLL.LLLLLLLLLLL
 ##L#L#L#L.#L#L#L#L.#L#..L#L#.#L#L#L##LLL#.#L#LLLL#L#L#L#L#LL.LL#L#L#L#L#L#.#LL#.#L##L#L##L#
 .L.....L......L.L.L...L...LL..........#....L..##.....L.L....#.....L......L.......L...L..L.L
 #L#L#L.L#.#L#L#L#L##L#L#L#L#.#L#L#.#LLLL#L#L#LLLL#.#L#L#L#LL.LL#L#L#.#L#L#L#L#L#L#L#L##L#L#
 LLLLLL#LL.LLLLLLLLLLLL.#LLLL.LLLLLLLLL#LL.LLLL#LLL.LLLLLLLL#.#LL.LLLLLLLLL.LLLLLLLLL.LLLLLL
 #L#L#L#L#L#L#L#L##L#L#.LLL#L#L#.#L#.#LLL#.#L#LLL#.L#L#L#.#LLL#L#L##L.L#L#L#L#LL.#L#L#L#.#L#
 LLLLLLLLL.LLLLLLL#LLLL.#LLLL.LL.LL.L##LLL.LLLL#LLLLLLL.L.LL#.L.LLLLL#LLLLL.LLL#LLLLLLLLLLLL
 #L#L#L#L#.LL##L#L.L#L#.#L#L#.#L#L#.LL#L##L#L#L.L##..##L###LL.#L#L#LL.L#L#L.L#LLL#L#L#L#L#L#
 LLLLLLLLL.#LLL.LL#LLLL.LLLLL.L.LLL.#LLLLL.LLLLLLLL.LLLLL.LL#.LLL.LL#.LLLLL#LLL#..LLL.LLLLLL
 #L#L#L#L#LLL#L#L#.L#L#L#L#L#L#L##L..LL#.#L#L#L#L#L#L#L#L#L#LL#L#L#LL.##L#LLL#LL.#L#L#L#L#L#
 ..LLL.....#...L.L....L.L.L.L.LL...#.#L.L..LLL......L.....L.L...L..L#.LL...#L..#....L.......
 ...
 #L#L#L#L#.#LLL#L#.#L#L.LLLLLLL#L#..#L#L#L.L#L#L#L#L#L#LLLLLL#L#L###L#.#.#L.L#L#..L#L#LLL#L.
 LLLLLLLLL.LL#L.L#..LLL.#L#L#..LLLLL.LLLLL#LL.LLL.L.LLLL#L#L##L#L.LLL.LLLLL.LLLL.#LLLLL#L#L#
 #L#L#L#L#.#LLLLLL.L#L#.LLLLLL#L#L#.#L#L.LL.L#L#L#L####LLLL.LLLL.L#LL.L#L#L.L#L#.LL#L#LLLLLL
 LLLLLLLLLLLL#L#L#LLLLL.L###LL.LLLL.LLLLL#L#LLLLLLL.LLLL#L#L#.#L#L#.##LL.#L#LLLL.#LLLLL#L#L#
 #L#L#L#L##LLLLLLLL#L#L#LLLLL#L#LL#.#L#LLL.LLL#L#.#.#L#LLLLLLL.LLLLLLLLLL.L.LL#L.LLL#.LLLLLL
 #L#L#L#LL..#L#L#L.#L#L.L#L#L.L#LL#L#L#L#..L#LLLLLLLLL#L#L#L#.#L#L#L#.L#.L#.#L#L#L#LLLL#L#L#
 LLLLLLLL#.LLLLLLLLLLLL.LLLLLLLLLLLLL.LLLL#LLLLLLL#.#LLLLLLLL.LLLLLLLLLLLLL..LLL.LLLL#LLLLLL
 #L#L#L#LL.#L#L#L#.#L#L#L#L#L#L#L#L#LL#L#L.L#L#L#LL.LL#L#L#L#.#L#L#L#.L#L#L##L#L#L#LLLL#L#L#
 LLLLLLLL#.LLLLLLL.LLLL.LLLLL.LLLLL.LLLLLL.LLLLLLLL##LLLLLLL..LLLLL.L.LLLLL.LLLLLLLLL#LLLLLL
 #L#L#L#L#L#L#L#L#.#LL#.#L#L#.#L#.#.#L##L#.#L#L#L#L...#L#L#L##L#LL#L#.#L#L#.#L#..#L#L.L#L#L#
(90 rows)

 count 
-------
  2108
(1 row)
```

Part 2
------

```
$ psql -v inpath=$PWD/in-sample-p0s0.csv < solve-p1v0.sql 
Pager usage is off.
Expanded display is used automatically.
CREATE TABLE
COPY 100
CREATE FUNCTION
CREATE FUNCTION
 adv_state_to_fp 
-----------------
 
(1 row)

 string_agg 
------------
 #.L#.L#.L#
 #LLLLLL.LL
 L.L.L..#..
 ##L#.#L.L#
 L.L#.LL.L#
 #.LLLL#.LL
 ..#.L.....
 LLL###LLL#
 #.LLLLL#.L
 #.L#LL#.L#
(10 rows)

 count 
-------
    26
(1 row)
```

```
$ psql -v inpath=$PWD/in-actual.csv < solve-p1v0.sql 
Pager usage is off.                                                                                      
Expanded display is used automatically.                                                                  
CREATE TABLE                                                                                             
COPY 8190                                                                                                
CREATE FUNCTION                                                                                          
CREATE FUNCTION                                                                                          
 adv_state_to_fp                                                                                         
-----------------                                                                                        
                                                                                                         
(1 row)                                                                                                  
                                                                                                         
                                         string_agg                                          
---------------------------------------------------------------------------------------------
 #L#L#L#L#.L#L#L#L.#L#L#L#L#L.#L#L#.L#L#L#.L#L#L#L#.L.#L#L#L..#.L#L#L.#L#L#L#L#L.#L#L#L#L#L#
 LLLLLLLLL.#LLLLL..LLLLLLLLLL.LLLLL.#LLLLLLL.LLL.LL.#LLLLLLL#LLLLLLL#.LLLLLLLLL#.LLLLLLLLLLL
 #L#L#L#L#.LL#L#LLL#L#L.#L#LL.#L#L#LLL#.L#L#L##..L#LLL#L#L#LLL#L#L#LLLL#L#L#L#LL.##L.#L#L#L#
 LLLLLLLLLL#LLLLL#.LLLL.LLLL#.LLLLL.#L#L#L.#LLL.LLL.#LLLLLLL#.LLLLLL#.LLLL.LLLL#.LL#LLLLLLLL
 #.L#L#L#L.LL#L#LL.#L#L.#L.LLL#L#L..LLLLLL.LL#L#L##.LL#L#L#LL.#L#L#LLL#L#L#.L#LL.#LLL#L#L#L#
 LL#LLLLLL#L#LLLL#.LLLL.LL##L.LLLLL.#L#L#L.#L#.LLLL.#LLLLLLL#.LLLLLL#LLLL.L.L.L#LLL#LLLLLLLL
 #LLL.#L#LLLLL#LLLL#L#.L#.LLL#L#L#L.LL..LL.LLLL#L##..L#L#L#.L..#L#.LL.L#L#L#LLLL.#LLL#L#L#L#
 LL#L#LL.L#L#LLL#L.LLLL.LLL#L..LLLL.#LL#L#.L##LLLLL#LL#LLLLL#.LLLL#L#.LLLLL.L#L#.LL#LLLLLLLL
 #LLLLLLLL.LLL#LLL#.L#L..#L#L.#L#L#LLL#LLL.LLLL#L#LLLLLL#L#LL.#L#LLLL#L#L#L.LLLL.#L#L#L#L#L#
 .L.....#......L.L.L...#...LL..........L....#..LL.....#.L....#.....L......#.......L...L..L.L
 LL#L#L.LL.#L#L#L#LL#L#LLL#L#.L#L#L.L#L#L#LLLL#L#L#.#LL#L#L#L.LLL#LLL.#L#LLL#L#L#L#L#L#L#LL#
 #LLLLL#L#.LLLLLLLLLLLL.#L#L#.L#LLL#LLLLLL.##LLLLLL.L#LLLLLL#.L#L.L#LLLLLL#.LLLLLLLL#.LLLLLL
 LL#L#LLLLL#L#L#L#L#LL#.LLLLLLLL.#LL.L#L#L.LLL#L#L.#LLL#L.#LLLLLLLLLL.#L#LL#L#L#.L#LLLLL.#L#
 #LLLLL#L#.LLLLLLLLLLLL.#L#L#.L#.LL.#LLLLL.#LLLLLLLLL#L.#.LLL.#.L#L##LLLLLL.LLLLLLLLL#L#LLLL
 LL#L#LLLL.#L#L#L#.L#L#.LLLLL.#LLL#.LL#L#L#LL#L.#L#..LLLLL#L#.L#LLLLL.#L#L#.L#L#L#L#LLLLL#L#
 #LLLLL#L#.LLLL.LLL#LLL.#L#L#.L.#LL.#LLLLL.LLLLLLLL.#L#L#.LLL.LLL.#L#.LLLLLLLLLL..LLL.L#LLLL
 LLLL#LLLLL#L#LLL#.LL#LLLLLLLL#LLL#..L#L.LL#L#L#L#L#LLLLLL#L##LL#LLLL.#L#L#L##LL.LL#L#L#L#L#
 ..#LL.....L...#.L....L.#.L.#.LL...L.LL.#..LLL......L.....L.L...L..L#.LL...LL..#....L.......
 ...
 LLLLLLLLL.#LLLL#L.LLLL.#L#L#L#L#L..LLLLL#.L#L#LL#LL##LLLLLLLLLLLL#L#L.L.L#.LLLL..##L#LLLLL.
 #L#L#L#L#.LL#L.#L..L#L.LLLL#..LLLLL.#L#LLLLL.LLL.L.LLL#L#L#L#L#L.LLL.#LLLL.L#L#.LLLLLL#L#L#
 LLLLLLLLL.#LLLLLL.#LLL.#L#LLLL#LL#.LLLL.#L.L#L#LLL##L#LLLL.LLLL.L#L#.LL#L#.LLLL.##LL#LLLLLL
 #L#L#L#L#LLL#L#L#LLL#L.LLL#L#.LLLL.##L#LLL#LLLLL#L.LLLL#L#LL.#L#LL.LLL#.LLLL#L#.LLL#LL#L#L#
 LLLLLLLLLL#LLLLLLL#LLL#L#LLLLLLL#L.LLLLL#.LL##LL.L.#L#LLLLL#L.LLLL#L#LLL.#.LLLL.#LLL.LLLLLL
 #L#L#L#L#..L#L#L#.LL#L.LL#L#.L#LLL#L#L#L..#LLLL#L#LLLLL#L#LL.L#L#LLL.L#.LL.L#L#LLL#L#L#L#L#
 LLLLLLLLL.#LLLLLLL#LLL.#LLLLLLLL#LLL.LLLLLLL#LLLLL.##LLLLLL#.LLLLLL#L#LLL#..LLL.#LLLLLLLLLL
 #L#L#L#L#.L#L#L##.LL#LLLL#LL#L#LLLL#L#L#L.#LLL#L##.LLL#L#L#L.L#L#L#L.LL#LLL#L#LLLL#L#L#L#L#
 LLLLLLLLL.LLLLLLL.#LLL.#LLLL.LLLL#.LLLLLL.LL#LLLLLL#LLLLLLL..LLLLL.L.LLLL#.LLLL#LLLLLLLLLLL
 #L#L#L#L#L#L#L#L#.L#L#.L#L#L.#L#.L.#L#L#L.#L#L#L#L...#L#L#L#L#L#L#L#.L#L#L.#L#..L#L#.L#L#L#
(90 rows)

 count 
-------
  1897
(1 row)
```
