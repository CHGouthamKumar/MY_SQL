-- droping database if the database is exists.
drop database library;
-- creating a new database.
create database library;
-- using the new database.
use library;
-- creating table - 1 inside the database by providing data types and constraints using primary key & foregin key & not null.
create table publisher(
publisher_name varchar(50) not null primary key,
publisher_address varchar(100) not null,
publisher_phone varchar(15) not null
);

-- creating table - 2 inside the database by providing data types and constraints using primary key & foregin key & not null.
create table book(
book_id int not null primary key,
book_title varchar(80) not null,
book_PublisherName varchar(80) not null,
foreign key (book_publishername) references publisher(publisher_name) on delete cascade on update cascade
);

-- creating table - 3 inside the database by providing data types and constraints using primary key & foregin key & not null.
create table authors(
book_author_bookid int not null primary key,
book_author_book_name varchar(50) not null,
foreign key (book_author_bookid) references book(book_id) on delete cascade on update cascade
);

-- creating table - 4 inside the database by providing data types and constraints using primary key & foregin key & not null.
create table library_branch(
library_branch_id int auto_increment primary key,
library_branch_name varchar(50) not null,
library_branch_address varchar(100) not null
);

-- creating table - 5 inside the database by providing data types and constraints using primary key & foregin key & not null.
create table book_copies(
book_copies_id int auto_increment primary key,
book_copies_book_id int not null,
branch_id int not null, 
no_copies int not null,
foreign key (book_copies_book_id) references book(book_id) on delete cascade on update cascade,
foreign key (branch_id) references library_branch(library_branch_id) on delete cascade on update cascade
);

-- creating table - 6 inside the database by providing data types and constraints using primary key & foregin key & not null.
create table borrower(
borrower_card_no int not null primary key,
borrower_book_name varchar(50) not null,
borrower_address varchar(200) not null,
borrower_phone varchar(15) not null
);

-- creating table - 7 inside the database by providing data types and constraints using primary key & foregin key & not null.
create table book_loans(
book_loans_loan_id int auto_increment primary key,
book_loans_book_id int not null,
book_loans_branch_id int not null,
book_loans_card_no int not null,
book_loans_date_out date not null,
book_loans_due_date date not null,
foreign key (book_loans_book_id) references book(book_id) on delete cascade on update cascade,
foreign key (book_loans_branch_id) references library_branch(library_branch_id) on delete cascade on update cascade,
foreign key (book_loans_card_no) references borrower(borrower_card_no) on delete cascade on update cascade
);

-- importing csv files inside the tables inorder to check whether all the values in each table are added or not.
select * from authors;
select * from book_copies;
select * from book_loans;
select * from book;
select * from borrower;
select * from library_branch;
select * from publisher;


-- ------------------xx Questions xx--------------------------------

-- 1. how many copies of the book titled "The Lost Tribe" are owned by the library branch whose name is "sharpstown".
/*
create temporary table book_counts select * from book inner join book_copies;
select * from book_counts;
create temporary table copies select * from book_counts inner join library_branch;
select * from copies;
select no_copies,book_title,library_branch_name from copies where library_branch_name = 'Sharpstown';
*/

select book_title,library_branch_name from book join book_copies on book.book_id = book_copies.book_copies_book_id join library_branch on library_branch.library_branch_id
where book_title = "The Lost Tribe";


-- 2. how many copies of the book titled "The Lost Tribe" are owned by each library branch.

select book_title,no_copies,library_branch_name from copies where book_title = 'The Lost Tribe';

-- 3. Retrieve the names of all borrowers who do not have any books checked out.

select borrower_book_name from borrower left join book_loans on book_loans.book_loans_card_no = borrower.borrower_card_no 
where book_loans_card_no is null;


/* 4. From each book that is loaned out from the "Sharpstown" branch and whose Duedate is 2/3/18, retrieve the book title, the borrower's name
	and the borrower's address. */

select book_title,borrower_book_name,borrower_address from book left join book_loans on book.book_id = book_loans_book_id 
join borrower on borrower.borrower_card_no where book_loans_due_date = '2018-03-02';

-- 5. For each library branch, retrieve the branch name and the total number of books loaned out from that branch.

select library_branch_id,library_branch_name,book_loans_date_out from library_branch join book_loans on 
library_branch.library_branch_id = book_loans_branch_id;

-- 6. Retrive the names, addresses and the number of books checked out for all borrowers who have more than five books checked out.

select borrower_book_name,borrower_address,book_loans_date_out from book_loans join borrower 
on book_loans.book_loans_card_no = borrower.borrower_card_no join book_copies on book_copies.branch_id where no_copies >= 5;


-- 7. For each book authored by "Stephen King",retrieve the title and the number of copies owned by the library branch whose name is "Central".

select book_title,no_copies from authors join book on authors.book_author_bookid = book_id join book_copies on book_copies.book_copies_book_id 
join library_branch on library_branch.library_branch_id where book_author_book_name = 'Stephen King' and library_branch_name = 'Central';


