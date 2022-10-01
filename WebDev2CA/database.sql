CREATE TABLE Users(
    username VARCHAR(40),
    password VARCHAR(40),
    fname VARCHAR(40),
    lname VARCHAR(40),
    address1 VARCHAR (40),
    address2 VARCHAR (40),
    city VARCHAR (40),
    telephone INT (40),
    mobile INT (40),
    CONSTRAINT user_pk PRIMARY KEY (username)
   );

CREATE TABLE Books(
    isbn VARCHAR (40),
    bookTitle VARCHAR (40),
    author VARCHAR (40),
    edition INT (1),
    year Year,
    bookCategory INT (40),
    reserved VARCHAR (1),
    CONSTRAINT book_pk PRIMARY KEY (isbn)
    );

CREATE TABLE Category(
    categoryID INT (40) AUTO_INCREMENT,
    categoryDescription VARCHAR(40),
    CONSTRAINT cat_pk PRIMARY KEY (categoryID)
    );

CREATE TABLE BooksReserved(
    reservedisbn VARCHAR (40),
    reservedUsername VARCHAR (40),
    reservedDate DATE,
    CONSTRAINT isbn_fk FOREIGN KEY (reservedisbn) REFERENCES Books(isbn),
    );

INSERT INTO Users
(username, password, fname, lname, address1, address2, city, telephone, mobile)
VALUES
('alanjmckenna', 't1234s', 'Alan', 'McKenna', '38 Cranley Road', 'Fairview', 'Dublin',
 9998377, 856625567);

INSERT INTO Users
(username, password, fname, lname, address1, address2, city, telephone, mobile)
VALUES
('joecrotty', 'kj7899', 'Joseph', 'Crotty', 'Apt 5 Clyde Road', 'Donnybrook', 'Dublin', 8887889, 876654456);

INSERT INTO Users
(username, password, fname, lname, address1, address2, city, telephone, mobile)
VALUES
('tommy100', '123456', 'tom', 'behan', '14 hyde road', 'dalkey', 'dublin', 9983747, 876738782);

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('093-403992', 'Computers in Business', 'Alicia Oneill', 3, 1997, 003, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('23472-8729', 'Exploring Peru', 'Stephanie Birchi', 4, 2005, 005, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('237-34823', 'Business Strategy', 'Joe Peppard', 2, 2002, 002, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('23u8-923849', 'A guide to nutrition', 'John Thorphe', 2, 1997, 001, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('2983-3494', 'Cooking for children', 'Anabelle Sharpe', 1, 2003, 007, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('82n8-398', 'computers for idiots', 'Susan O\'Neill', 5, 1998, 004, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('9823-23984', 'My life in picture', 'Kevin Graham', 8, 2004, 001, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('9823-2403-0', 'DaVinci Code', 'Dan Brown', 1, 2003, 008, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('98234-029384', 'My ranch in Texas', 'George Bush', 1, 2005, 001, 'Y');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('9823-98345', 'How to cook Italian food', 'Jamie Oliver', 2, 2005, 007, 'Y');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('9823-98487', 'Optimising your business', 'Cleo Blair', 1, 2001, 002, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('988745-234', 'Tara Road', 'Maeve Binchy', 4, 2002, 008, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('993-004-00', 'My life in bits', 'John Smith', 1, 2001, 001, 'N');

INSERT INTO Books
(isbn, bookTitle, author, edition, year, bookCategory, reserved)
VALUES
('9987-0039882', 'Shooting History', 'Jon Snow', 1, 2003, 001, 'N');

INSERT INTO Category
(categoryDescription)
VALUES
('Health');

INSERT INTO Category
(categoryDescription)
VALUES
('Business');

INSERT INTO Category
(categoryDescription)
VALUES
('Biography');

INSERT INTO Category
(categoryDescription)
VALUES
('Technology');

INSERT INTO Category
(categoryDescription)
VALUES
('Travel');

INSERT INTO Category
(categoryDescription)
VALUES
('Self-Help');

INSERT INTO Category
(categoryDescription)
VALUES
('Cookery');

INSERT INTO Category
(categoryDescription)
VALUES
('Fiction');


INSERT INTO BooksReserved
(reservedisbn, reservedUsername, reservedDate)
VALUES
('98234-029384', 'joecrotty', '11-Oct-2008');

INSERT INTO BooksReserved
(reservedisbn, reservedUsername, reservedDate)
VALUES
('9823-98345', 'tommy100', '11-Oct-2008');



