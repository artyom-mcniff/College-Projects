-- First file to execute
-- The following file is used to set up the Dimensional Model Schema

-- MusicCompDB is the database that will be used
USE MusicCompDB;

-- Dropping tables to avoid errors if they have already been created
DROP TABLE IF EXISTS FactVotes;
DROP TABLE IF EXISTS CatDim;
DROP TABLE IF EXISTS ViewDim;
DROP TABLE IF EXISTS PartDim;
DROP TABLE IF EXISTS EdDim;

-- Dimensional table used to store the competition years
CREATE TABLE EdDim(
    ed_sk INTEGER PRIMARY KEY,
    edyear YEAR(4)
);

-- Dimensional table used to store the participants and their details
CREATE TABLE PartDim(
    part_sk INTEGER PRIMARY KEY,
    partname VARCHAR(100),
    countyname VARCHAR(100)
);

-- Dimensional table used to store information about the viewers
CREATE TABLE ViewDim(
    view_sk INTEGER PRIMARY KEY,
    agegroupdesc VARCHAR(100),
    countyname VARCHAR(100)
);

-- Dimensional table used to store information about viewer categories
CREATE TABLE CatDim(
    cat_sk INTEGER PRIMARY KEY,
    catname varchar(100)
);

-- Fact table used to execute queries against
CREATE TABLE FactVotes(
    ed_sk INTEGER,
    part_sk INTEGER,
    view_sk INTEGER,
    cat_sk INTEGER,
    votes int(99),
    votecost FLOAT,
    CONSTRAINT PK_fact PRIMARY KEY (ed_sk, part_sk, view_sk, cat_sk),
    CONSTRAINT SK_ed FOREIGN KEY (ed_sk) REFERENCES EdDim,
    CONSTRAINT SK_part FOREIGN KEY (part_sk) REFERENCES PartDim,
    CONSTRAINT SK_view FOREIGN KEY (view_sk) REFERENCES ViewDim,
    CONSTRAINT SK_cat FOREIGN KEY (cat_sk) REFERENCES CatDim
);


