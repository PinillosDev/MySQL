USE DBcinema;

-- Show name of movies
SELECT movie_name FROM movies;

-- Show year old califications
SELECT year_old_clasification FROM movies;

-- Show movies who hasn't got year calification
SELECT * FROM movies
WHERE year_old_clasification IS NULL;

-- Show rooms who hasn't got any movie
SELECT * FROM rooms
WHERE movie IS NULL;

-- Show all rooms' info. Also, movies' info if its has a room.
SELECT * FROM rooms AS r
LEFT JOIN movies AS m
ON m.movie_id=r.movie;

-- Show all movies' info. Also, rooms' info if its has a movie.
SELECT * FROM movies AS m
LEFT JOIN rooms AS r
ON r.movie=m.movie_id;

-- Show movies' name who haven't got any room
SELECT movie_name FROM movies
WHERE movie_id IN(
	SELECT movie FROM rooms
    WHERE movie IS NULL
);

-- Add info
INSERT INTO movies (movie_name, year_old_clasification)
VALUES ('Uno, dos, tres', 7);

-- If a movie doesn't have a clasification, set it to 13
UPDATE movies SET year_old_clasification=13
WHERE year_old_clasification IS NULL;

-- Delete rooms that have movies for all people
DELETE FROM rooms
WHERE movie IN (
	SELECT movie_id FROM movies
    WHERE year_old_clasification = 0
);