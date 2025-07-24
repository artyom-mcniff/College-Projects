-- Second file to execute
-- The following file is used to stage the data to later load into
-- the fact table

-- The database used
USE MusicCompDB;
-- Viewer Category Start 
DROP TABLE IF EXISTS stage_cat;
CREATE TABLE stage_cat(
    cat_sk INTEGER,
    catname varchar(100)
);

-- Inserting data from the viewercategory table into the
-- staging table. catid is used as the surrogate key
INSERT INTO stage_cat (SELECT catid, catname FROM viewercategory);

-- Inserting data from the staging table to the category
-- dimensional table
INSERT INTO CatDim (SELECT cat_sk, catname FROM stage_cat);
-- Viewer Category End 

-- Participants Start
DROP TABLE IF EXISTS stage_part;
CREATE TABLE stage_part(
    partname varchar(100),
    countyname varchar(100)
);

-- Inserting partname and countyname into the staging table
-- using the countyid value present in both the participants
-- and county table
INSERT INTO stage_part SELECT partname, countyname FROM participants
JOIN county USING(countyid);

-- Sequence used to populate the surrogate key column
DROP SEQUENCE IF EXISTS part_seq;
CREATE SEQUENCE part_seq
start with 1
increment by 1;

-- Surrogate key created
ALTER TABLE stage_part ADD part_sk INTEGER;

-- Setting the surrogate key value by using the sequence
UPDATE stage_part
SET part_sk = (NEXT VALUE for part_seq);

-- Inserting from the staging table to the dimensional table
INSERT INTO PartDim SELECT part_sk, partname, countyname
FROM stage_part;
-- Participants End

-- Viewer Start
DROP TABLE IF EXISTS stage_view;
CREATE TABLE stage_view(
    view_sk INTEGER,
    agegroupdesc varchar(100),
    countyname varchar(100)
);

-- Inserting viewerid, agegroupdesc, countyname into the
-- staging table by joining the county, agegroup and
-- viewers table. viewerid's values will be used as
-- the stage's surrogate key.
INSERT INTO stage_view SELECT viewerid, age_group_desc, countyname FROM viewers
JOIN county ON county.countyid = viewers.countyid
JOIN agegroup
ON agegroup.age_groupid = viewers.age_group;

-- Inserting from staging to dimensional
INSERT INTO ViewDim SELECT view_sk, agegroupdesc, countyname
FROM stage_view;
-- Viewers End

-- Edition Start
DROP TABLE IF EXISTS stage_ed;
CREATE TABLE stage_ed (
    edyear YEAR(4)
);

-- Inserting the edyear values from the edition table
-- into the staging table
INSERT INTO stage_ed(SELECT edyear FROM edition);

-- Creating the surrogate key
ALTER TABLE stage_ed ADD ed_sk INTEGER;

-- Creating the sequence used to populate the surrogate key
-- column
DROP SEQUENCE IF EXISTS ed_seq;
CREATE SEQUENCE ed_seq
START WITH 1
INCREMENT BY 1;

-- Populating the surrogate key column with the sequence
UPDATE stage_ed
SET ed_sk = (NEXT VALUE FOR ed_seq);

INSERT INTO EdDim SELECT ed_sk, edyear FROM stage_ed;
-- Edition End