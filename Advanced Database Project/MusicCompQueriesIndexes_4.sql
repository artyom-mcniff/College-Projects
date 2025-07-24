-- Fourth file to execute
USE MusicCompDB;

-- Question 1
-- For each edition of the programme, what is the
-- total votes cast by each age group in each county?
-- Include the age group description and county name
-- in the output.
-- Query
SELECT sum(factvotes.votes) as "Total Votes",
agegroupdesc, countyname, edyear FROM FactVotes
JOIN EdDim USING (ed_sk)
JOIN ViewDim USING (view_sk)
GROUP BY agegroupdesc, countyname, edyear
ORDER BY edyear;

-- Pre Index

-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","Extra"
-- "1","SIMPLE","EdDim","ALL","PRIMARY","","","","10","Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_view","PRIMARY","4","musiccompdb.EdDim.ed_sk","1",""
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1",""
EXPLAIN SELECT sum(factvotes.votes) as "Total Votes",
agegroupdesc, countyname, edyear FROM FactVotes
JOIN EdDim USING (ed_sk)
JOIN ViewDim USING (view_sk)
GROUP BY agegroupdesc, countyname, edyear
ORDER BY edyear;

-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","r_rows","filtered","r_filtered","Extra"
-- "1","SIMPLE","EdDim","ALL","PRIMARY","","","","10","10.00",100,100,"Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_view","PRIMARY","4","musiccompdb.EdDim.ed_sk","1","4735.20",100,100,""
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1","1.00",100,100,""
ANALYZE SELECT sum(factvotes.votes) as "Total Votes",
agegroupdesc, countyname, edyear FROM FactVotes
JOIN EdDim USING (ed_sk)
JOIN ViewDim USING (view_sk)
GROUP BY agegroupdesc, countyname, edyear
ORDER BY edyear;

-- Index
CREATE INDEX findex ON FactVotes(ed_sk);
-- 

-- Post Index
-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","Extra"
-- "1","SIMPLE","EdDim","ALL","PRIMARY","","","","10","Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_view,edindex,findex","PRIMARY","4","musiccompdb.EdDim.ed_sk","6144",""
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1",""

EXPLAIN SELECT sum(factvotes.votes) as "Total Votes",
agegroupdesc, countyname, edyear FROM FactVotes
JOIN EdDim USING (ed_sk)
JOIN ViewDim USING (view_sk)
GROUP BY agegroupdesc, countyname, edyear
ORDER BY edyear;

-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","r_rows","filtered","r_filtered","Extra"
-- "1","SIMPLE","EdDim","ALL","PRIMARY","","","","10","10.00",100,100,"Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_view,edindex,findex","PRIMARY","4","musiccompdb.EdDim.ed_sk","6144","4735.20",80,100,""
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1","1.00",100,100,""
ANALYZE SELECT sum(factvotes.votes) as "Total Votes",
agegroupdesc, countyname, edyear FROM FactVotes
JOIN EdDim USING (ed_sk)
JOIN ViewDim USING (view_sk)
GROUP BY agegroupdesc, countyname, edyear
ORDER BY edyear;

DROP INDEX findex ON FactVotes;
-- Question 2
--  For each county, what is the total number of votes
-- received by each participant in the 2022 edition of 
-- the programme from audience viewers in that county
-- voting for participants from the same county?
-- Include the county name in the output.

-- Query
SELECT sum(factvotes.votes) as "Total Votes", partname, partdim.countyname FROM FactVotes
JOIN PartDim USING (part_sk)
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE edyear='2022' AND  catname='Audience' AND ViewDim.countyname = PartDim.countyname
GROUP BY partname
ORDER BY partname;

-- Pre Index

-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","Extra"
-- "1","SIMPLE","CatDim","ALL","PRIMARY","","","","2","Using where; Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_part,SK_view,SK_cat","SK_cat","4","musiccompdb.CatDim.cat_sk","1",""
-- "1","SIMPLE","PartDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.part_sk","1",""
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1","Using where"
-- "1","SIMPLE","EdDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.ed_sk","1","Using where"
EXPLAIN SELECT sum(factvotes.votes) as "Total Votes", partname, partdim.countyname FROM FactVotes
JOIN PartDim USING (part_sk)
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE edyear='2022' AND  catname='Audience' AND ViewDim.countyname = PartDim.countyname
GROUP BY partname
ORDER BY partname;


-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","r_rows","filtered","r_filtered","Extra"
-- "1","SIMPLE","CatDim","ALL","PRIMARY","","","","2","2.00",100,50,"Using where; Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_part,SK_view,SK_cat","SK_cat","4","musiccompdb.CatDim.cat_sk","1","23654.00",100,100,""
-- "1","SIMPLE","PartDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.part_sk","1","1.00",100,100,""
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1","1.00",100,3.96,"Using where"
-- "1","SIMPLE","EdDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.ed_sk","1","1.00",100,9.19,"Using where"
ANALYZE SELECT sum(factvotes.votes) as "Total Votes", partname, partdim.countyname FROM FactVotes
JOIN PartDim USING (part_sk)
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE edyear='2022' AND  catname='Audience' AND ViewDim.countyname = PartDim.countyname
GROUP BY partname
ORDER BY partname;

-- Index
CREATE INDEX findex ON FactVotes(ed_sk);
CREATE INDEX catindx ON CatDim(catname);
CREATE INDEX viewindx ON ViewDim(countyname);

-- Post Index
-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","Extra"
-- "1","SIMPLE","CatDim","ref","PRIMARY,catindx","catindx","403","const","1","Using where; Using index; Using temporary; Using filesort"
-- "1","SIMPLE","EdDim","ALL","PRIMARY","","","","10","Using where; Using join buffer (flat, BNL join)"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_part,SK_view,SK_cat,edindex,findex","PRIMARY","4","musiccompdb.EdDim.ed_sk","6144","Using where"
-- "1","SIMPLE","PartDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.part_sk","1","Using where"
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY,viewindx","viewindx","407","musiccompdb.PartDim.countyname,musiccompdb.FactVotes.view_sk","1","Using index"
EXPLAIN SELECT sum(factvotes.votes) as "Total Votes", partname, partdim.countyname FROM FactVotes
JOIN PartDim USING (part_sk)
JOIN EdDim  USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE edyear='2022' AND  catname='Audience' AND ViewDim.countyname = PartDim.countyname
GROUP BY partname
ORDER BY partname;

-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","r_rows","filtered","r_filtered","Extra"
-- "1","SIMPLE","CatDim","ref","PRIMARY,catindx","catindx","403","const","1","1.00",100,100,"Using where; Using index; Using temporary; Using filesort"
-- "1","SIMPLE","EdDim","ALL","PRIMARY","","","","10","10.00",100,10,"Using where; Using join buffer (flat, BNL join)"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_part,SK_view,SK_cat,edindex,findex","PRIMARY","4","musiccompdb.EdDim.ed_sk","6144","4449.00",42.09,49.81,"Using where"
-- "1","SIMPLE","PartDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.part_sk","1","1.00",100,100,"Using where"
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY,viewindx","viewindx","407","musiccompdb.PartDim.countyname,musiccompdb.FactVotes.view_sk","1","0.04",100,100,"Using index"
ANALYZE SELECT sum(factvotes.votes) as "Total Votes", partname, partdim.countyname FROM FactVotes
JOIN PartDim USING (part_sk)
JOIN EdDim USING (ed_sk)
JOIN CatDim  USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE edyear='2022' AND  catname='Audience' AND ViewDim.countyname = PartDim.countyname
GROUP BY partname
ORDER BY partname;

DROP INDEX findex ON FactVotes;
DROP INDEX catindx on CatDim;
DROP INDEX viewindx on ViewDim;
-- Question 3
-- The TV Company charges audience voters to cast their votes.
-- From 2013 to 2015 the charges were:
-- 20c for votes cast by Facebook and Instagram 
-- 50c for votes cast using the TV app and by Phone.
-- From 2016 to 2022 the charges were:
-- 50c for votes cast by Facebook and Instagram 
-- 1€ for votes cast using the TV app and by Phone.
-- Jury voters are not charged for casting their votes.
-- For the 2013 and 2019 edition of the programme respectively,
-- for each county, what was the total income earned
-- from audience viewers in that county for each voting category?
-- Include the county names and the year in the output.

-- Query
SELECT countyname, edyear, ROUND(SUM(factvotes.votecost*votes),2)
FROM FactVotes   
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE (edyear='2013' OR edyear='2019') 
GROUP BY countyname, edyear;

-- Pre Index

-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","Extra"
-- "1","SIMPLE","CatDim","ALL","PRIMARY","","","","2","Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_view,SK_cat","SK_cat","4","musiccompdb.CatDim.cat_sk","1",""
-- "1","SIMPLE","EdDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.ed_sk","1","Using where"
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1",""
EXPLAIN SELECT countyname, edyear, ROUND(SUM(factvotes.votecost*votes),2)
FROM FactVotes   
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE (edyear='2013' OR edyear='2019') 
GROUP BY countyname, edyear;


-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","r_rows","filtered","r_filtered","Extra"
-- "1","SIMPLE","CatDim","ALL","PRIMARY","","","","2","2.00",100,100,"Using temporary; Using filesort"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_view,SK_cat","SK_cat","4","musiccompdb.CatDim.cat_sk","1","23676.00",100,100,""
-- "1","SIMPLE","EdDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.ed_sk","1","1.00",100,19.58,"Using where"
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1","1.00",100,100,""
ANALYZE SELECT countyname, edyear, ROUND(SUM(factvotes.votecost*votes),2)
FROM FactVotes   
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE (edyear='2013' OR edyear='2019') 
GROUP BY countyname, edyear;

-- Index
CREATE INDEX findex ON FactVotes(ed_sk);
CREATE INDEX catindx ON CatDim(catname);
-- Post Index
-- "id","select_type","table","type","possible_keys","key","key_len","ref","rows","Extra"
-- "1","SIMPLE","CatDim","index","PRIMARY","catindx","403","","2","Using index; Using temporary; Using filesort"
-- "1","SIMPLE","EdDim","ALL","PRIMARY","","","","10","Using where; Using join buffer (flat, BNL join)"
-- "1","SIMPLE","FactVotes","ref","PRIMARY,SK_view,SK_cat,findex","PRIMARY","4","musiccompdb.EdDim.ed_sk","6144","Using where"
-- "1","SIMPLE","ViewDim","eq_ref","PRIMARY","PRIMARY","4","musiccompdb.FactVotes.view_sk","1",""
EXPLAIN SELECT countyname, edyear, ROUND(SUM(factvotes.votecost*votes),2)
FROM FactVotes   
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE (edyear='2013' OR edyear='2019') 
GROUP BY countyname, edyear;

ANALYZE SELECT countyname, edyear, ROUND(SUM(factvotes.votecost*votes),2)
FROM FactVotes   
JOIN EdDim USING (ed_sk)
JOIN CatDim USING (cat_sk)
JOIN ViewDim USING (view_sk)
WHERE (edyear='2013' OR edyear='2019') 
GROUP BY countyname, edyear;

DROP INDEX findex ON FactVotes;
DROP INDEX catindx on CatDim;