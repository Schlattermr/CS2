# Computer Science II
# Lab 8.0 - Structured Query Language II
# Queries
#
# Name: Matthew Schlatter
#
# Part 3.2
# 1. Choose your favorite album and insert it into the database by doing the
#   following.
#   1.  Write a query to insert the band of the album 
insert into Band (name) values ('Aries');
#   2.  Write a query to insert the album 
insert into Album (title,year,number,bandId) values 
	('BELIEVE IN ME, WHO BELIEVES IN YOU', 2021, 1, (select bandId from Band where name like 'Aries'));
#   3.  Write two queries to insert the first two songs of the album
insert into Song (title) values ('BOUNTY HUNTER');
insert into Song (title) values ('FOOLS GOLD');
#   4.  Write two queries to associate the two songs with the inserted album
insert into AlbumSong (trackNumber,trackLength,albumId,songId) values 
	(1, 153, (select albumId from Album where title like 'BELIEVE IN ME, WHO BELIEVES IN YOU'), 
    (select songId from Song where title like 'BOUNTY HUNTER'));
insert into AlbumSong (trackNumber,trackLength,albumId,songId) values 
	(2, 150, (select albumId from Album where title like 'BELIEVE IN ME, WHO BELIEVES IN YOU'), 
    (select songId from Song where title like 'FOOLS GOLD'));
# 2. Update the musician record for "P. Best", his first name should be "Pete".
update Musician set firstName = "Pete" where musicianId = (select musicianId from Musician where firstName = 'P.');
# 3. Pete Best was the Beatles original drummer, but was fired in 1962. 
#    Write a query that removes Pete Best from the Beatles.
delete from BandMember where musicianId = (select musicianId from Musician where firstName = 'Pete' and lastName = 'Best');
# 4. Attempt to delete the song "Big in Japan" (by Tom Waits on the album
#    *Mule Variations*).  Observe that the query will fail due to referencing
#    records. Write a series of queries that will allow you to delete the 
#    album *Mule Variations*.
delete from AlbumSong where albumId = (select albumId from Album where title = 'Mule Variations');
delete from Song where songId = (select songId from AlbumSong where albumId = (select albumId from Album where title = 'Mule Variations'));
delete from Album where title = 'Mule Variations';

# Part 3.2.2
# Write quries to create your new tables for concerts, venues, etc. here:

drop tables if exists Concert;
drop tables if exists ConcertSong;
drop tables if exists Venue;

create table Concert (
	concertId int not null primary key auto_increment,
    date varchar(50) not null,
    bandId int not null,
    foreign key (bandId) references Band(bandId)
);

create table ConcertSong (
	concertSong int not null primary key auto_increment,
    songId int not null,
    concertId int not null,
	foreign key (songId) references Song(songId),
    foreign key (concertId) references Concert(concertId)
);

create table Venue (
	venueId int not null  primary key auto_increment,
	name varchar(100) not null,
    numSeats int not null,
    ticketsSold int not null
);

# Part 3.3.3
# 
# Insert some test data to your new tables
#
# 1.  Write queries to insert at least two `Concert` records.
insert into Concert (date, bandId) values 
	('2022-02-16', (select bandId from Band where name like 'Aries'));
insert into Concert (date, bandId) values 
	('2020-03-11', (select bandId from Band where name like 'Taylor Swift'));
# 2.  Write queries to associate at least 2 songs with each of the two concerts
insert into ConcertSong (songId, concertId) values 
	((select songId from Song where title = 'BOUNTY HUNTER'),1);
insert into ConcertSong (songId, concertId) values 
	((select songId from Song where title = 'FOOLS GOLD'),1);
insert into ConcertSong (songId, concertId) values 
	((select songId from Song where title = 'Welcome to New York'),2);
insert into ConcertSong (songId, concertId) values 
	((select songId from Song where title = 'Blank Space'),2);
# 3.  Write a select-join query to retrieve these new results and produce
#     a playlist for each concert
select title from Song s left join 
	ConcertSong cs on s.songId = cs.songId left join 
    Concert c on c.concertId = cs.concertId where c.date = '2022-02-16'
union
select title from Song s left join 
	ConcertSong cs on s.songId = cs.songId left join 
    Concert c on c.concertId = cs.concertId where c.date = '2020-03-11';