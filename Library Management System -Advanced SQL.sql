
DROP TABLE IF EXISTS Borrowedby, Holding, Authoredby, Author, Book, Publisher, Member, Branch;

/*Table structure for table `branch` */
CREATE TABLE Branch (
  BranchID INT NOT NULL, 
  BranchSuburb varchar(255) NOT NULL,
  BranchState char(3) NOT NULL,
  PRIMARY KEY (BranchID)
);

CREATE TABLE Member (
  MemberID INT NOT NULL, 
  MemberStatus char(9) DEFAULT 'REGULAR',
  MemberName varchar(255) NOT NULL,
  MemberAddress varchar(255) NOT NULL,
  MemberSuburb varchar(25) NOT NULL,
  MemberState char(3) NOT NULL,
  MemberExpDate DATE,
  MemberPhone varchar(10),
  PRIMARY KEY (`MemberID`)
);

CREATE TABLE Publisher (
  PublisherID INT NOT NULL, 
  PublisherName varchar(255) NOT NULL,
  PublisherAddress varchar(255) DEFAULT NULL,
  PRIMARY KEY (PublisherID)
);

CREATE TABLE Book (
  BookID INT NOT NULL,
  BookTitle varchar(255) NOT NULL,
  PublisherID INT NOT NULL,
  PublishedYear INT4,
  Price Numeric(5,2) NOT NULL,
  PRIMARY KEY (BookID),
  KEY PublisherID (PublisherID),
  CONSTRAINT publisher_fk_1 FOREIGN KEY (PublisherID) REFERENCES Publisher (PublisherID) ON DELETE RESTRICT
);

CREATE TABLE Author (
  AuthorID INT NOT NULL, 
  AuthorName varchar(255) NOT NULL,
  AuthorAddress varchar(255) NOT NULL,
  PRIMARY KEY (AuthorID)
);

CREATE TABLE Authoredby (
  BookID INT NOT NULL,
  AuthorID INT NOT NULL, 
  PRIMARY KEY (BookID,AuthorID),
  KEY BookID (BookID),
  KEY AuthorID (AuthorID),
  CONSTRAINT book_fk_1 FOREIGN KEY (BookID) REFERENCES Book (BookID) ON DELETE RESTRICT,
  CONSTRAINT author_fk_1 FOREIGN KEY (AuthorID) REFERENCES Author (AuthorID) ON DELETE RESTRICT
);

CREATE TABLE Holding (
  BranchID INT NOT NULL, 
  BookID INT NOT NULL,
  InStock INT DEFAULT 1,
  OnLoan INT DEFAULT 0,
  PRIMARY KEY (BranchID, BookID),
  KEY BookID (BookID),
  KEY BranchID (BranchID),
  CONSTRAINT holding_cc_1 CHECK(InStock>=OnLoan),
  CONSTRAINT book_fk_2 FOREIGN KEY (BookID) REFERENCES Book (BookID) ON DELETE RESTRICT,
  CONSTRAINT branch_fk_1 FOREIGN KEY (BranchID) REFERENCES Branch (BranchID) ON DELETE RESTRICT
);

CREATE TABLE Borrowedby (
  BookIssueID INT UNSIGNED NOT NULL AUTO_INCREMENT,
  BranchID INT NOT NULL,
  BookID INT NOT NULL,
  MemberID INT NOT NULL,
  DateBorrowed DATE,
  DateReturned DATE DEFAULT NULL,
  ReturnDueDate DATE,
  PRIMARY KEY (BookIssueID),
  KEY BookID (BookID),
  KEY BranchID (BranchID),
  KEY MemberID (MemberID),
  CONSTRAINT borrowedby_cc_1 CHECK(DateBorrowed<ReturnDueDate),
  CONSTRAINT holding_fk_1 FOREIGN KEY (BookID,BranchID) REFERENCES Holding (BookID,BranchID) ON DELETE RESTRICT,
  CONSTRAINT member_fk_1 FOREIGN KEY (MemberID) REFERENCES Member (MemberID) ON DELETE RESTRICT
) ;



DELETE FROM Author;
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('1', 'Tolstoy','Russian Empire');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('2', 'Tolkien','England');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('3', 'Asimov','America');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('4', 'Silverberg','America');
INSERT INTO Author (AuthorID,AuthorName,AuthorAddress ) 
VALUES ('5', 'Paterson','Australia');

DELETE FROM Branch;
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('1','Parramatta','NSW');
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('2','North Ryde','NSW');
INSERT INTO Branch (BranchID,BranchSuburb,BranchState) 
VALUES ('3','Sydney City','NSW');

DELETE FROM Publisher;
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('1','Penguin','New York');
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('2','Platypus','Sydney');
INSERT INTO Publisher (PublisherID,PublisherName,PublisherAddress ) 
VALUES ('3','Another Choice','Patagonia');

DELETE FROM Member;
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('1','REGULAR','Joe','4 Nowhere St','Here','NSW','2021-09-30','0434567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('2','REGULAR','Pablo','10 Somewhere St','There','ACT','2022-09-30','0412345678');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('3','REGULAR','Chen','23/9 Faraway Cl','Far','QLD','2020-11-30','0412346578');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('4','REGULAR','Zhang','Dunno St','North','NSW','2020-12-31','');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('5','REGULAR','Saleem','44 Magnolia St','South','SA','2020-09-30','1234567811');
INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone) 
VALUES ('6','SUSPENDED','Homer','Middle of Nowhere','North Ryde','NSW','2020-09-30','1234555811');

DELETE FROM Book;
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('1','Anna Karenina','1','2003',12.75);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('2','War and Peace','2','1869',139.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('3','The Hobbit','2','1937',9.19);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('4','I, Robot','2','1950',29.99);
INSERT INTO Book (BookID,BookTitle,PublisherID,PublishedYear,Price )
VALUES ('5','The Positronic Man','3','2010',125.99);

DELETE FROM Authoredby;
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('1', '1');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('2', '1');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('3', '2');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('4', '3');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('5', '3');
INSERT INTO Authoredby (BookID,AuthorID) VALUES ('5', '4');

DELETE FROM Holding;
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '1','2','2');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '2','2','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('1', '3','3','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('2', '1','1','1');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('2', '4','3','2');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('3', '4','4','0');
INSERT INTO Holding (BranchID,BookID,InStock,OnLoan) 
VALUES ('3', '5','2','1');

DELETE FROM Borrowedby;
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '1','2',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '4','4',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '1','4',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('2', '4','1',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('3', '5','3',curdate(),NULL,date_add(curdate(),INTERVAL 3 WEEK));
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '1','1','2020-08-30',NULL,'2020-09-30');
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('1', '2','2','2020-08-30',NULL,'2020-09-30');
INSERT INTO Borrowedby (BranchID,BookID,MemberID,DateBorrowed,DateReturned,ReturnDueDate)
VALUES ('3', '4','2','2020-08-30',NULL,'2020-09-30');




-- TASK 1
-- here we assume that the increments are in whole numbers (2 dollars per day) but we still allow two decimal places in case there is an anomaly for a fine calculation. 
-- on an overview of the values used to populate the table. We can see that some book prices are provided with 2 decimal places. 
-- To maintain compliance and to avoid unforseen errors, we would assume that fines can be decimal.
-- -------------------------------------------------------------------------------------------------
ALTER TABLE Member
ADD FineFee DECIMAL(5, 2) DEFAULT 0.00;
-- -------------------------------------------------------------------------------------------------
-- -----------------testing done for task 1---------------------------------------------------------
DESCRIBE Member;


INSERT INTO Member (MemberID,MemberStatus,MemberName,MemberAddress,MemberSuburb,MemberState,MemberExpDate,MemberPhone,FineFee) 
VALUES ('8','SUSPENDED','TEST','TEST','TEST','NSW','2020-09-30','1234555811','24');

-- -------------------------------------------------------------------------------------------------

-- --------TASK 2-----------------------------------------------------------------------------------
DELIMITER //

DROP TRIGGER IF EXISTS MembershipReset//

CREATE TRIGGER MembershipReset
BEFORE UPDATE ON member
FOR EACH ROW
BEGIN
    DECLARE itemsBorrowedRecently INT;
    DECLARE itemsOverdue INT;
    DECLARE totalFine DECIMAL(5,2);
    DECLARE errMsg VARCHAR(100);
    
    -- Count the number of items borrowed by the member in the last 21 days (BR4)
    -- REFERENCE FOR CODE BLOCK (https://stackoverflow.com/questions/10763031/how-to-subtract-30-days-from-the-current-datetime-in-mysql)
    SELECT COUNT(*) INTO itemsBorrowedRecently 
    FROM Borrowedby 
    WHERE MemberID = NEW.MemberID AND DateReturned IS NULL AND DateBorrowed >= CURDATE() - INTERVAL 21 DAY;

    -- Check if any items are overdue
    SELECT COUNT(*) INTO itemsOverdue 
    FROM Borrowedby 
    WHERE MemberID = NEW.MemberID AND DateReturned IS NULL AND ReturnDueDate < CURRENT_DATE;

    -- Get the total fine from the Member table
    SELECT FineFee INTO totalFine FROM Member WHERE MemberID = NEW.MemberID;
    
    -- ----------------------------------------Error handlers-----------------------------------------------------------------
    -- Error handling for incorrect fine amounts
    IF NEW.FineFee < 0 THEN
        SET errMsg = 'Negative amount is incorrect for this column';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errMsg;
    END IF;
    
    -- Error handling for inconsistent member status
    IF totalFine = 0 AND OLD.MemberStatus = 'SUSPENDED' AND NEW.MemberStatus <> 'SUSPENDED' THEN
        SET errMsg = 'Double check membership if old and new status match please.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errMsg;
    END IF;

    -- Error handling for exceeding the borrowing limit within 21 days (BR4)
    IF itemsBorrowedRecently > 5 THEN
        SET errMsg = 'Exceeds maximum allowed borrowings within 21 days.';
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = errMsg;
    END IF;

    -- -------------Resetting member status if all conditions are met (BR8)--------------------------
    IF totalFine = 0 AND itemsOverdue = 0 AND OLD.MemberStatus = 'SUSPENDED' THEN
        SET NEW.MemberStatus = 'REGULAR';
    END IF;
END 
//

DELIMITER ;


-- -----------------Task 3 (stored procedure)--------------------------------------------------------


-- -----new table to track changes-------------------------
DROP TABLE IF EXISTS MemberStatusChange;
CREATE TABLE MemberStatusChange (
    MemberID INT NOT NULL,
    OldStatus VARCHAR(15),
    NewStatus VARCHAR(15),
    ChangeDate DATETIME NOT NULL,
    PRIMARY KEY (MemberID, ChangeDate)
);

-- we then proceed to create a trigger to Track status changes INSIDE member table
DELIMITER //
Drop trigger if exists TrackMembershipStatusChange//
CREATE TRIGGER TrackMembershipStatusChange
AFTER UPDATE ON Member
FOR EACH ROW
BEGIN
    IF OLD.MemberStatus <> NEW.MemberStatus THEN
        INSERT INTO MemberStatusChange (MemberID, OldStatus, NewStatus, ChangeDate) 
        VALUES (NEW.MemberID, OLD.MemberStatus, NEW.MemberStatus, NOW());
    END IF;
END;
//
DELIMITER;

-- --------------------------main procedure for task 3---------------------------------------
DELIMITER //
CREATE PROCEDURE TerminateOverdueMemberships()
BEGIN
    DECLARE errorOccurred INT DEFAULT 0;
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION SET errorOccurred = 1; -- reference lecture note week 10: best practices for error handling

    -- Terminate memberships for members who were suspended twice in the past three years and have an overdue item
    UPDATE Member m
    INNER JOIN (
        SELECT ms.MemberID
        FROM MemberStatusChange ms
        INNER JOIN Borrowedby b ON ms.MemberID = b.MemberID
        WHERE ms.NewStatus = 'SUSPENDED'
        AND b.DateReturned IS NULL
        AND b.ReturnDueDate < CURDATE()
        AND ms.ChangeDate > DATE_SUB(CURDATE(), INTERVAL 3 YEAR)
        GROUP BY ms.MemberID
        HAVING COUNT(ms.MemberID) >= 2
    ) as subquery ON m.MemberID = subquery.MemberID
    SET m.MemberStatus = 'TERMINATE';

    IF errorOccurred THEN
        SELECT 'Error occurred while terminating memberships.';
    END IF;
END;
//

DELIMITER ;



-- -------------Test cases ---------------------------------------------------------------------
-- Member Status Reset 
UPDATE Member SET MemberStatus = 'SUSPENDED', FineFee = 30 WHERE MemberID = 5;
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) VALUES (1, 1, 5, CURDATE() - INTERVAL 30 DAY, CURDATE() - INTERVAL 10 DAY);

-- Clear the fee and return overdue item
UPDATE Member SET FineFee = 0 WHERE MemberID = 5;
UPDATE Borrowedby SET DateReturned = CURDATE() WHERE MemberID = 7 AND BookID = 1;


-- Testing for negative fine amounts
UPDATE Member SET FineFee = -10 WHERE MemberID = 1;

-- we exceed the borrow limit of 5 in 21 days. we populate 5 times and then try one more time to see if it raises the error. 
-- we first insert values
INSERT INTO Holding (BranchID, BookID, InStock, OnLoan) VALUES (1, 4, 2, 0);
INSERT INTO Holding (BranchID, BookID, InStock, OnLoan) VALUES (1, 5, 2, 0);
-- Borrowing 1st item
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 1, 3, CURDATE(), CURDATE() + INTERVAL 21 DAY);

-- Borrowing 2nd item
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 2, 3, CURDATE(), CURDATE() + INTERVAL 21 DAY);

-- Borrowing 3rd item
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 3, 3, CURDATE(), CURDATE() + INTERVAL 21 DAY);

-- Borrowing 4th item 
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 1, 3, CURDATE(), CURDATE() + INTERVAL 21 DAY);

-- Borrowing 5th item 
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 2, 3, CURDATE(), CURDATE() + INTERVAL 21 DAY);

-- attempting to borrow the 6th item (should give error)
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 3, 3, CURDATE(), CURDATE() + INTERVAL 21 DAY);



DELIMITER //

CREATE TRIGGER enforce_borrow_limit
BEFORE INSERT ON Borrowedby
FOR EACH ROW
BEGIN
    DECLARE borrow_count INT;

    -- Calculate the number of items the member has borrowed in the last 21 days
    SELECT COUNT(*) INTO borrow_count
    FROM Borrowedby
    WHERE MemberID = NEW.MemberID
      AND DateBorrowed >= CURDATE() - INTERVAL 21 DAY
      AND DateReturned IS NULL;

    -- If the count is 5 or more, prevent the new insert
    IF borrow_count >= 5 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Borrow limit exceeded: Cannot borrow more than 5 items within 21 days.';
    END IF;
END;

//
DELIMITER ;

INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 4, 3, CURDATE(), CURDATE() + INTERVAL 21 DAY);

-- Overdue Items 
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) VALUES (1, 3, 5, CURDATE() - INTERVAL 40 DAY, CURDATE() - INTERVAL 20 DAY);
UPDATE Member SET MemberStatus = 'REGULAR' WHERE MemberID = 5;


-- -------BR4 IMPLEMENTATION----------------
DELIMITER //

CREATE TRIGGER check_membership_expiry_before_borrowing
BEFORE INSERT ON Borrowedby
FOR EACH ROW
BEGIN
    DECLARE member_expiry DATE;


    SELECT MemberExpDate INTO member_expiry
    FROM Member
    WHERE MemberID = NEW.MemberID;


    IF NEW.ReturnDueDate > member_expiry THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Return due date cannot be past membership expiry date.';
    END IF;
END;

//
DELIMITER ;

INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 2, 1, '2023-12-20', '2024-01-10');


-- -------------------BR6 AND BR7 IMPLEMENTATION-------------------
UPDATE Member SET FineFee = 30 WHERE MemberID = 2;
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 3, 2, CURDATE(), CURDATE() + INTERVAL 21 DAY);
-- -----------------------------------------------------------------

-- Insert past suspension records (PROCEDURE IN TASK 3)
INSERT INTO Member (MemberID, MemberStatus, MemberName, MemberAddress, MemberSuburb, MemberState, MemberExpDate, MemberPhone) 
VALUES (10, 'REGULAR', 'Test User', '123 Test St', 'Testville', 'TS', '2024-12-31', '1234567890');

INSERT INTO MemberStatusChange (MemberID, OldStatus, NewStatus, ChangeDate) 
VALUES (10, 'REGULAR', 'SUSPENDED', CURDATE() - INTERVAL 2 YEAR),
       (10, 'REGULAR', 'SUSPENDED', CURDATE() - INTERVAL 1 YEAR);
       
INSERT INTO Borrowedby (BranchID, BookID, MemberID, DateBorrowed, ReturnDueDate) 
VALUES (1, 5, 10, CURDATE() - INTERVAL 40 DAY, CURDATE() - INTERVAL 20 DAY);

CALL TerminateOverdueMemberships();


