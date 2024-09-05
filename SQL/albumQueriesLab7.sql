-- Computer Science II
-- Lab 7.0 - Structured Query Language I
-- Queries
--
-- Name: Matthew Schlatter
-- Date: 2023-03-08
-- 
-- For each question, write an SQL query to get the specified result. You
-- are highly encouraged to use a GUI SQL tool such as MySQL Workbench and
-- keep track of your queries in an SQL script so that lab instructors can
-- verify your work. If you do, write your queries in the script file
-- provided rather than hand-writing your queries here.

-- Simple Queries 
-- --------------
use mschlatt;
-- 1. List all albums in the database.
select * from Album;
-- 2. List all albums in the database from newest to oldest.
select * from Album order by -year;
-- 3. List all bands in the database that begin with "The".
select * from Band where name like 'The%';
-- 4. List all songs in the database in alphabetic order.
select * from Song order by title;
-- 5. Write a query that gives just the albumId of the album "Nevermind".
select albumId from Album where title like '%Nevermind%';

-- Simple Aggregate Queries 
-- ------------------------

-- 6. Write a query to determine how many musicians are in the database.
select count(musicianId) as numMusicians from Musician;
-- 7. Write a (nested) query to list the oldest album(s) in the database.
select * from Album where albumId = 
  (select albumId from Album where year = 
  (select min(year) from Album));
-- 8. Write a query to find the total running time (in seconds) of all 
--    tracks on the album *Rain Dogs* by Tom Waits
select sum(trackLength) from AlbumSong where albumId like '5';

-- Join Queries 
-- ------------

-- 9. Write a query list all albums in the database along with the album's
--    band, but only include the album title, year and band name.
select a.title, a.year, b.name from Band b 
join Album a on b.bandId = a.bandId;
-- 10. Write a query that lists all albums and all tracks on the albums 
--     for the band Nirvana.
select b.bandId, b.name, a.albumId, a.title, a.year, a.number, a.bandId, t.albumSongId, t.trackNumber, t.trackLength, t.albumId, t.songId, s.songId, s.title from Song s
  join AlbumSong t on s.songId = t.songId
  join Album a on t.albumId = a.AlbumId
  join Band b on a.bandId = b.bandId where
  b.name = "Nirvana" order by a.title;
-- 11. Write a query that list all bands along with all their albums in 
--     the database *even if they do not have any*.
select b.name, a.title, a.year from Band b left join Album a on b.bandId = a.bandId;

-- Grouped Join Queries 
-- --------------------

-- 12. Write a query list all bands along with a *count* of how many albums
--     they have in the database (as you saw in the previous query, some should
--     have zero).
select b.name, count(a.albumId) as numAlbums 
  from Band b left join Album a 
  on b.bandId = a.bandId group by b.bandId;
-- 13. Write a query that lists all albums in the database along with the
--     number of tracks on them.
select a.title, count(s.songId) as numTracks
  from Album a left join AlbumSong s
  on a.albumId = s.albumId group by a.albumId;
-- 14. Write the same query, but limit it to albums which have 12 or more
--     tracks on them.
select a.title, count(s.songId) as numTracks
  from Album a left join AlbumSong s
  on a.albumId = s.albumId group by a.albumId
  having numTracks >= 12;
-- 15. Write a query to find all musicians that are not in any bands.
select m.firstName, m.lastName, count(b.bandId) as numBands from Musician m 
  left join BandMember b on m.musicianId = b.musicianId 
  group by m.musicianId having numBands = 0;
-- 16. Write a query to find all musicians that are in more than one band.
select m.firstName, m.lastName, count(b.bandId) as numBands from Musician m 
  left join BandMember b on m.musicianId = b.musicianId 
  group by m.musicianId having numBands > 1;