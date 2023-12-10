
mysql -u root -p --local-infile




create database if not exists recommendation;

create table if not exists recommendation.users (uid int, age int, gender varchar(255), occupation varchar(255), zip int);

create table if not exists recommendation.genre (genre varchar(255), gid int);

create table if not exists recommendation.data (uid int, itemid int, rating int, timestamp int);

create table if not exists recommendation.items (itemid int, itemtitle varchar(255), release_date varchar(255), video_release_date varchar(255), url varchar(255), g0 int,g1 int,g2 int,g3 int,g4 int,g5 int,g6 int,g7 int,g8 int,g9 int,g10 int, g11 int,g12 int,g13 int,g14 int,g15 int,g16 int,g17 int,g18 int);






LOAD DATA LOCAL INFILE '/home/bigdata/Recommendation_Project/recommendation/users/u.user'
INTO TABLE recommendation.users 
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE '/home/bigdata/Recommendation_Project/recommendation/genre/u.genre'
INTO TABLE recommendation.genre 
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE '/home/bigdata/Recommendation_Project/recommendation/data/u.data'
INTO TABLE recommendation.data 
FIELDS TERMINATED BY '\t'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';


LOAD DATA LOCAL INFILE '/home/bigdata/Recommendation_Project/recommendation/items/u.item'
INTO TABLE recommendation.items 
FIELDS TERMINATED BY '|'
ENCLOSED BY '"'
LINES TERMINATED BY '\n';








