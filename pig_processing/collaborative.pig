set default_parallel 4;
UI = load 'hdfs://localhost:8020/recommendation/user_item_rating/*' using PigStorage('\t') as (uid:int,itemid:int,rating:double);
SPLIT UI into NonZero if rating!=0,Zero if rating==0;

G = group NonZero by itemid;
Avg = foreach G generate group as itemid,AVG(NonZero.rating) as avg;
J = join NonZero by itemid,Avg by itemid;
S = foreach J generate NonZero::uid as uid,NonZero::itemid as itemid,(DOUBLE)(NonZero::rating - Avg::avg) as rating;
CA = UNION S,Zero;

A = foreach CA generate uid,itemid,rating;
B = foreach CA generate uid,itemid,rating;
C = join A by uid,B by uid;
P = foreach C generate A::itemid,B::itemid,A::uid,(DOUBLE)(A::rating * B::rating) as rp;
Gr = group P by (A::itemid,B::itemid);
G_Sum = foreach Gr generate group as pid,SUM(P.rp) as sum;
G_Sum1 = foreach G_Sum generate pid,FLATTEN(pid),sum;
Numerator = foreach G_Sum1 generate pid::A::itemid as it1,pid::B::itemid as it2,sum;

P_1 = foreach CA generate uid,itemid,rating;
P_2 = foreach P_1 generate uid,itemid,(DOUBLE)(rating * rating) as sq; 
P_3 = group P_2 by itemid;
P_4 = foreach P_3 generate group as itemid,(DOUBLE)(SUM(P_2.sq)) as ss;
Sqrt = foreach P_4 generate  itemid,(DOUBLE)(SQRT(ss)) as rms;
P_5 = foreach Sqrt generate itemid,rms;
P_6 = foreach Sqrt generate itemid,rms;
P_7 = CROSS P_5,P_6;
Denominator = foreach P_7 generate P_5::itemid as it1,P_6::itemid as it2,(DOUBLE)(P_5::rms * P_6::rms) as prms;

P_8 = join Numerator by (it1,it2),Denominator by (it1,it2);
II = foreach P_8 generate Numerator::it1 as it1,Numerator::it2 as it2,(DOUBLE)(Numerator::sum / Denominator::prms) as sim;

JNZ = join NonZero by itemid,II by it1;
BJ = join JNZ by (NonZero::uid,II::it2),Zero by (uid,itemid);
Test = foreach BJ generate Zero::uid as uid, Zero::itemid as pitem ,JNZ::II::it1 as sitem,JNZ::NonZero::rating as rating,JNZ::II::sim as sim;
P_13 = group Test by (uid,pitem);
P_14 = foreach P_13 { sim_ord = order Test by sim desc; lim = limit sim_ord 10; generate group as uid_itemnotrated,lim; };
P_15 = foreach P_14 generate uid_itemnotrated,FLATTEN(lim);
P_16 = foreach P_15 generate FLATTEN(uid_itemnotrated),(DOUBLE)(lim::rating * lim::sim) as pro,lim::sim as sim;
P_17 = group P_16 by (uid_itemnotrated::uid,uid_itemnotrated::pitem);
P_18 = foreach P_17 generate group as uid_item,(DOUBLE)SUM(P_16.pro) as sum_pro,(DOUBLE)SUM(P_16.sim) as sum_sim;
P_19 = foreach P_18 generate uid_item,(DOUBLE)(sum_pro / sum_sim) as PredictedRating;
Prediction = foreach P_19 generate FLATTEN(uid_item),PredictedRating;

P_21 = group Prediction by uid_item::uid_itemnotrated::uid;
P_22 = foreach P_21 { ord = order Prediction by PredictedRating desc; lim = limit ord 5; generate group as uid,lim;};
P_23 = foreach P_22 generate uid,FLATTEN(lim);
RecommendedItems = foreach P_23 generate uid,lim::uid_item::uid_itemnotrated::pitem as pitem;

store RecommendedItems into 'hdfs://localhost:8020/recommendation/output/collaborative';



