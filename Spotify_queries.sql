-- create table
DROP TABLE IF EXISTS spotify;
CREATE TABLE spotify (
    artist VARCHAR(255),
    track VARCHAR(255),
    album VARCHAR(255),
    album_type VARCHAR(50),
    danceability FLOAT,
    energy FLOAT,
    loudness FLOAT,
    speechiness FLOAT,
    acousticness FLOAT,
    instrumentalness FLOAT,
    liveness FLOAT,
    valence FLOAT,
    tempo FLOAT,
    duration_min FLOAT,
    title VARCHAR(255),
    channel VARCHAR(255),
    views FLOAT,
    likes BIGINT,
    comments BIGINT,
    licensed BOOLEAN,
    official_video BOOLEAN,
    stream BIGINT,
    energy_liveness FLOAT,
    most_played_on VARCHAR(50)
);

SELECT COUNT(*) FROM spotify;

SELECT COUNT(DISTINCT album) FROM spotify;		


SELECT DISTINCT album_type FROM spotify;	


-- Select all tracks that have over 1 billion streams
SELECT track 
FROM spotify 
WHERE stream > 1000000000;

-- List the artist name and corresponding album for each record
SELECT artist, album 
FROM spotify;

-- Sum up the total number of comments for licensed tracks
SELECT SUM(comments) AS total_comments 
FROM spotify 
WHERE licensed = TRUE;

-- Retrieve all tracks that belong to albums of type 'single'
SELECT track 
FROM spotify 
WHERE album_type = 'single';

-- Count the number of tracks each artist has in the dataset
SELECT artist, COUNT(track) AS total_tracks 
FROM spotify 
GROUP BY artist;

-- Calculate the average danceability of tracks grouped by album
SELECT album, AVG(danceability) AS avg_danceability 
FROM spotify 
GROUP BY album;


-- Select the top 5 tracks based on the highest energy levels
SELECT track, energy 
FROM spotify 
ORDER BY energy DESC 
LIMIT 5;

-- List tracks, views, and likes for tracks that have an official video
SELECT track, views, likes 
FROM spotify 
WHERE official_video = TRUE;


-- Select tracks where the number of streams is greater than the number of YouTube views
SELECT track 
FROM spotify 
WHERE stream > views;

-- Select all tracks by Arijit Singh
SELECT track, album, album_type, views, likes, stream
FROM spotify
WHERE artist = 'Yo Yo Honey Singh';

SELECT track, album, album_type, views, likes, stream, tempo
FROM spotify
WHERE artist = 'Arijit Singh';


-- Select all albums by Sidhu Moose Wala
SELECT DISTINCT album, album_type
FROM spotify
WHERE artist = 'Sidhu Moose Wala';

-- Find the top 3 most-viewed tracks for each artist
WITH RankedTracks AS (
    SELECT 
        artist, 
        track, 
        album, 
        views,
        ROW_NUMBER() OVER (PARTITION BY artist ORDER BY views DESC) AS rank
    FROM spotify
)
SELECT artist, track, album, views
FROM RankedTracks
WHERE rank <= 3;



-- Find tracks where the liveness score is above the average
WITH AverageLiveness AS (
    SELECT AVG(liveness) AS avg_liveness
    FROM spotify
)
SELECT track, artist, album, liveness
FROM spotify, AverageLiveness
WHERE liveness > avg_liveness;

-- Calculate the difference between the highest and lowest energy values for tracks in each album
WITH EnergyRange AS (
    SELECT 
        album,
        MAX(energy) AS max_energy,
        MIN(energy) AS min_energy
    FROM spotify
    GROUP BY album
)
SELECT 
    album, 
    (max_energy - min_energy) AS energy_difference
FROM EnergyRange;



SELECT track, album, views
FROM spotify
WHERE artist = 'Justin Bieber'
ORDER BY views DESC
LIMIT 1;
