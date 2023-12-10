create database if not exists mongo;

add jar file:///home/bigdata/Recommendation_Project/hive_jars/mongo-hadoop-core-1.5.2.jar;
add jar file:///home/bigdata/Recommendation_Project/hive_jars/mongo-hadoop-hive-1.5.2.jar;
add jar file:///home/bigdata/Recommendation_Project/hive_jars/mongo-java-driver-3.2.1.jar;


CREATE EXTERNAL TABLE if not exists mongo.collaborative(uid INT,itemid INT)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"uid":"uid","itemid":"itemid"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/recommendation.collaborative');

insert into table mongo.collaborative
select * from recommendation.collaborative;


CREATE EXTERNAL TABLE if not exists mongo.content_based(uid INT,itemid INT)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"uid":"uid","itemid":"itemid"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/recommendation.content_based');

insert into table mongo.content_based
select * from recommendation.content_based;


CREATE EXTERNAL TABLE if not exists mongo.hybrid(uid INT,itemid INT)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"uid":"uid","itemid":"itemid"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/recommendation.hybrid');

insert into table mongo.hybrid
select * from recommendation.hybrid;


CREATE EXTERNAL TABLE if not exists mongo.items(itemid int,
itemtitle string,
release_date string,
video_release_date string,
url string,
g0 int,g1 int,g2 int,g3 int,g4 int,g5 int,g6 int,g7 int,g8 int,g9 int,g10 int,g11 int,g12 int,g13 int,g14 int,g15 int,g16 int,g17 int,g18 int)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"itemid":"itemid","itemtitle":"itemtitle","release_date":"release_date","video_release_date":"video_release_date","url":"url","g0":"g0","g1":"g1",
"g2":"g2","g3":"g3","g4":"g4","g5":"g5","g6":"g6","g7":"g7","g8":"g8","g9":"g9","g10":"g10","g11":"g11","g12":"g12","g13":"g13","g14":"g14","g15":"g15","g16":"g16","g17":"g17","g18":"g18"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/recommendation.items');

insert into table mongo.items
select * from recommendation.items;



CREATE EXTERNAL TABLE if not exists mongo.users(uid INT,age int,gender string,occupation string,zip int)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"uid":"uid","itemid":"itemid"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/recommendation.users');

insert into table mongo.users
select * from recommendation.users;



CREATE EXTERNAL TABLE if not exists mongo.user_item_rating(uid INT,itemid INT,rating int)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"uid":"uid","itemid":"itemid","rating":"rating"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/recommendation.user_item_rating');

insert into table mongo.user_item_rating
select * from recommendation.user_item_rating;



CREATE EXTERNAL TABLE if not exists mongo.genre(genre string,gid int)
STORED BY 'com.mongodb.hadoop.hive.MongoStorageHandler'
WITH SERDEPROPERTIES('mongo.columns.mapping'='{"genre":"genre","gid":"gid"}')
TBLPROPERTIES('mongo.uri'='mongodb://localhost:27017/recommendation.genre');


insert into table mongo.genre
select * from recommendation.genre;




