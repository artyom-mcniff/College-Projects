-- Third file to execute
-- The following file creates the staging table for the fact table,
-- inserts data into the staging table, adds the surrogate keys,
-- adds the data for the vote numbers and cost of the votes

-- Databased used
USE MusicCompDB;
drop table if exists stage_fact;

create table stage_fact(
    votecost FLOAT,
    edyear varchar(50),
    partname varchar(50),
    viewerid integer,
    vote_cat integer,
    votemode varchar(50),
    vote int(99)
    
);

-- Inserting data from votes table into the staging table.
-- Inserting into the table using CASE
-- Explanation of how it works:
-- If vote_category=2 (where 2 corresponds to 'Audience')
-- And the edition year is equal to 2013, 2014, or 2015
-- Then if the vote mode is Facebook or Instagram, it costs 20c
-- to vote.
-- Or, if the vote mode is by TV or Phone, the cost is 50c
-- Else, there is no cost

-- However, if the edition year is not equal to 2013, 2014, or 2015
-- The same conditionals go again, only this time if the vote
-- mode is Facebook or Instagram, it costs 50c, and if the
-- vote mode is TV or Phone, it costs 1.0 or 1 euro.

-- If the vote_category is not 2, meaning it is Jury,
-- meaning the vote costs nothing.
INSERT INTO stage_fact SELECT
        CASE WHEN vote_category=2 THEN
        CASE WHEN edition_year='2013' OR edition_year='2014' OR edition_year='2015' THEN
                CASE WHEN votemode='Facebook' OR votemode='Instagram' THEN 0.2
                WHEN votemode='TV' OR votemode='Phone' THEN 0.5
                ELSE 0.0 END
            ELSE
                CASE WHEN votemode='Facebook' OR votemode='Instagram' THEN 0.5
                WHEN votemode='TV' OR votemode='Phone' THEN 1.0
                ELSE 0.0 END
            END
    ELSE 0.0 END AS votecost,edition_year, partname, viewerid, vote_category,
    votemode, vote FROM votes
    JOIN Edition ON votes.edition_year= edition.edyear;




-- sequence used to populate the cost_sk column,

-- Adding the surrogate keys
ALTER TABLE stage_fact add ed_sk INTEGER;
ALTER TABLE stage_fact add part_sk INTEGER;
ALTER TABLE stage_fact add view_sk INTEGER;
ALTER TABLE stage_fact add cat_sk INTEGER;

-- Setting the edition surrogate key values by joining the
-- stage_ed and stage_fact tables together using
-- the edition year name
UPDATE stage_fact
SET ed_sk=
(
    SELECT stage_ed.ed_sk FROM stage_ed
    WHERE
    stage_ed.edyear = stage_fact.edyear
);

-- Setting participant surrogate key values by using
-- a where statement
UPDATE stage_fact
SET part_sk=
(
    SELECT stage_part.part_sk FROM stage_part
    WHERE
    stage_part.partname = stage_fact.partname
);

-- Setting the viewer surrogate key via a where statement
UPDATE stage_fact
SET view_sk=
(
    SELECT stage_view.view_sk FROM stage_view
    WHERE
    stage_view.view_sk = stage_fact.viewerid
);

-- Setting the category surrogate via a where statement
UPDATE stage_fact
SET cat_sk=
(
    SELECT stage_cat.cat_sk FROM stage_cat
    WHERE
    stage_cat.cat_sk = stage_fact.vote_cat
);

INSERT INTO FactVotes
SELECT
    ed_sk, 
    part_sk, view_sk,
    cat_sk, vote,
    stage_fact.votecost FROM stage_fact;