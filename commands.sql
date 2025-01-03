➜  flights-lab git:(master) pwd
/Users/jonasmbp/Desktop/GA/code/ga/labs/flights-lab
➜  flights-lab git:(master) clear



































































➜  flights-lab git:(master) 




































































➜  flights-lab git:(master) psql
psql (16.6 (Homebrew))
Type "help" for help.

jonasmbp=# \c flights
You are now connected to database "flights" as user "jonasmbp".
flights=# SELECT * FROM airports WHERE city = 'New York' AND name != 'All Airports';
  id  |            name             |   city   |    country    | iata_faa | icao | latitude  | longitude  | altitude | utc_offset | dst |        tz        
------+-----------------------------+----------+---------------+----------+------+-----------+------------+----------+------------+-----+------------------
 3697 | La Guardia                  | New York | United States | LGA      | KLGA | 40.777245 | -73.872608 | 22       | -5         | A   | America/New_York
 3797 | John F Kennedy Intl         | New York | United States | JFK      | KJFK | 40.639751 | -73.778925 | 13       | -5         | A   | America/New_York
 3993 | Wall Street Heliport        | New York | United States | JRB      | KJRB | 40.701214 | -74.009028 | 7        | -5         | A   | America/New_York
 4032 | East 34th Street Heliport   | New York | United States | TSS      | NONE | 40.7425   | -73.971944 | 10       | -5         | A   | America/New_York
 6966 | Penn Station                | New York | United States | ZYP      | \\N  | 40.7505   | -73.9935   | 35       | -5         | A   | America/New_York
 7729 | West 30th St. Heliport      | New York | United States | JRA      | KJRA | 40.7545   | -74.0071   | 7        | -5         | A   | America/New_York
 7767 | Idlewild Intl               | New York | United States | IDL      | KIDL | 40.639751 | -73.778924 | 13       | -5         | A   | America/New_York
 7881 | Port Authority Bus Terminal | New York | United States |          | NYPA | 40.75616  | -73.9906   | 0        | -5         | A   | America/New_York
 8123 | One Police Plaza Heliport   | New York | United States |          | NK39 | 40.7126   | -73.9996   | 244      | -5         | A   | America/New_York
 9350 | Grand Central Terminal      | New York | United States |          | \\N  | 40.752726 | -73.977229 | 70       | -5         | A   | America/New_York
 9351 | Tremont                     | New York | United States |          | \\N  | 40.847301 | -73.89955  | 200      | -5         | A   | America/New_York
 9451 | Port Authority              | New York | United States |          | \\N  | 40.756667 | -73.991111 | 33       | -5         | A   | America/New_York
(12 rows)

flights=# SELECT * FROM airports WHERE city = 'Paris' AND name != 'All Airports';
  id  |        name         | city  | country | iata_faa | icao | latitude  | longitude | altitude | utc_offset | dst |      tz      
------+---------------------+-------+---------+----------+------+-----------+-----------+----------+------------+-----+--------------
 1380 | Le Bourget          | Paris | France  | LBG      | LFPB | 48.969444 | 2.441389  | 218      | 1          | E   | Europe/Paris
 1382 | Charles De Gaulle   | Paris | France  | CDG      | LFPG | 49.012779 | 2.55      | 392      | 1          | E   | Europe/Paris
 1386 | Orly                | Paris | France  | ORY      | LFPO | 48.725278 | 2.359444  | 291      | 1          | E   | Europe/Paris
 6486 | La Defense Heliport | Paris | France  | JPU      | \\N  | 48.86667  | 2.333333  | 0        | 1          | E   | Europe/Paris
 7676 | Gare du Nord        | Paris | France  | XPG      | \\N  | 48.880931 | 2.355323  | 423      | 1          | E   | Europe/Paris
 7677 | Gare Montparnasse   | Paris | France  | XGB      | \\N  | 48.84     | 2.318611  | 423      | 1          | E   | Europe/Paris
 8586 | Gare de Lyon        | Paris | France  | PLY      | \\N  | 48.844722 | 2.373611  | 129      | 1          | E   | Europe/Paris
 8587 | Gare de LEst        | Paris | France  | XHP      | \\N  | 48.876944 | 2.359167  | 149      | 1          | E   | Europe/Paris
 8896 | Paris Nord          | Paris | France  |          | \\N  | 48.880931 | 2.355323  | 0        | 1          | E   | Europe/Paris
(9 rows)

flights=# SELECT * FROM routes ORDER BY ASC;
ERROR:  syntax error at or near "ASC"
LINE 1: SELECT * FROM routes ORDER BY ASC;
                                      ^
flights=# SELECT * FROM routes ORDER BY origin_id ASC;
flights=# SELECT * FROM routes ORDER BY origin_id ASC;
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id WHERE airports.city = 'New York' And name != 'All Airports'
flights-#  SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id WHERE airports.city = 'New York' And name != 'All Airports';
ERROR:  syntax error at or near "SELECT"
LINE 2:  SELECT * FROM airports JOIN routes ON airports.id = routes....
         ^
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id WHERE airports.city = 'New York' And name != 'All Airports';
flights=# SELECT COUNT(*) FROM airports JOIN routes ON airports.id = routes.origin_id WHERE airports.city = 'New York' And name != 'All Airports';
 count 
-------
   614
(1 row)

flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.dest_id WHERE airports.city = 'Paris' AND name != 'All Airports';
flights=# SELECT COUNT(*) FROM airports JOIN routes ON airports.id = routes.dest_id WHERE airports.city = 'Paris' AND name != 'All Airports';
 count 
-------
   720
(1 row)

flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id WHERE airports.city = 'New York' AND airports.id = routes.dest_id WHERE airports.city = 'Paris';
ERROR:  syntax error at or near "WHERE"
LINE 1: ...ity = 'New York' AND airports.id = routes.dest_id WHERE airp...
                                                             ^
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id AND airports.id = routes.dest_id WHERE airports.city = 'Paris' OR airports.city = 'New York';
 id | name | city | country | iata_faa | icao | latitude | longitude | altitude | utc_offset | dst | tz | airline_code | airline_id | origin_code | origin_id | dest_code | dest_id | codeshare | stops | equipment 
----+------+------+---------+----------+------+----------+-----------+----------+------------+-----+----+--------------+------------+-------------+-----------+-----------+---------+-----------+-------+-----------
(0 rows)

flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id AND airports.id = routes.dest_id WHERE airports.city = 'Paris' AND airports.city = 'New York';
 id | name | city | country | iata_faa | icao | latitude | longitude | altitude | utc_offset | dst | tz | airline_code | airline_id | origin_code | origin_id | dest_code | dest_id | codeshare | stops | equipment 
----+------+------+---------+----------+------+----------+-----------+----------+------------+-----+----+--------------+------------+-------------+-----------+-----------+---------+-----------+-------+-----------
(0 rows)

flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id OR airports.id = routes.dest_id WHERE airports.city = 'Paris' OR airports.city = 'New York';
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id AND airports.id = routes.dest_id WHERE airports.city = 'Paris';
 id | name | city | country | iata_faa | icao | latitude | longitude | altitude | utc_offset | dst | tz | airline_code | airline_id | origin_code | origin_id | dest_code | dest_id | codeshare | stops | equipment 
----+------+------+---------+----------+------+----------+-----------+----------+------------+-----+----+--------------+------------+-------------+-----------+-----------+---------+-----------+-------+-----------
(0 rows)

flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id AND airports.id = routes.dest_id WHERE airports.city = 'Paris';
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id AND airports.id = routes.dest_id WHERE airports.city = 'New York';
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id OR airports.id = routes.dest_id WHERE airports.city = 'New York';
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id OR airports.id = routes.dest_id WHERE airports.city = 'Paris';
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id OR airports.id = routes.dest_id WHERE airports.city = 'Paris';
flights=# SELECT * FROM airports JOIN routes ON airports.id = routes.origin_id OR airports.id = routes.dest_id WHERE airports.city = 'New York';
flights=
