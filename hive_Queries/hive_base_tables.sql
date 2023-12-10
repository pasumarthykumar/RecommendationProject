create database if not exists recommendation;

CREATE EXTERNAL TABLE if not exists recommendation.collaborative(
uid int, 
itemid int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n' 
stored as textfile LOCATION 'hdfs://localhost:8020/recommendation/output/collaborative';

CREATE EXTERNAL TABLE if not exists recommendation.content_based(
uid int, 
itemid int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n' 
STORED AS textfile LOCATION 'hdfs://localhost:8020/recommendation/output/content_based';

CREATE EXTERNAL TABLE if not exists recommendation.hybrid(
uid int, 
itemid int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n' 
STORED AS textfile LOCATION 'hdfs://localhost:8020/recommendation/output/hybrid';

CREATE EXTERNAL TABLE if not exists recommendation.items(
itemid int, 
itemtitle string, 
release_date string, 
video_release_date string, 
url string, 
g0 int,g1 int,g2 int,g3 int,g4 int,g5 int,g6 int,g7 int,g8 int,g9 int,g10 int,
g11 int,g12 int,g13 int,g14 int,g15 int,g16 int,g17 int,g18 int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\n' 
STORED AS textfile LOCATION 'hdfs://localhost:8020/recommendation/items';


CREATE EXTERNAL TABLE if not exists recommendation.users(
uid int, 
age int, 
gender string, 
occupation string, 
zip int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\n' 
STORED AS textfile LOCATION 'hdfs://localhost:8020/recommendation/users';

CREATE EXTERNAL TABLE if not exists recommendation.user_item_rating(
uid int, 
itemid int, 
rating int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '\t' 
LINES TERMINATED BY '\n' 
STORED AS textfile LOCATION 'hdfs://localhost:8020/recommendation/user_item_rating';

CREATE EXTERNAL TABLE if not exists recommendation.genre(
genre string, 
gid int)
ROW FORMAT DELIMITED 
FIELDS TERMINATED BY '|' 
LINES TERMINATED BY '\n' 
STORED AS textfile LOCATION 'hdfs://localhost:8020/recommendation/genre';

