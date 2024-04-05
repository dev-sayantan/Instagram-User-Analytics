-- Instagram User Analytics
-------------------------------------------------------------------
-- 5 oldest users of the Instagram from the database provided
SELECT DISTINCT 
	users.username, 
	users.created_at 
FROM users
ORDER BY users.created_at
LIMIT 5;
---------------------------------------------------------------------------
-- Users who have never posted a single photo on Instagram
SELECT users.username FROM users
LEFT JOIN photos
ON photos.user_id = users.id
WHERE photos.id IS NULL;
----------------------------------------------------------------------------------
SELECT * FROM photos;
SELECT * FROM users;
SELECT * FROM likes;
-- Details of the user who gets the most likes on a single photo
SELECT 
	users.username,
	photos.image_url,
    photos.id,
    count(*) AS total
FROM photos
INNER JOIN users
ON photos.user_id = users.id
INNER JOIN likes
ON photos.id = likes.photo_id
GROUP BY photos.id
ORDER BY total DESC
LIMIT 1;
------------------------------------------------------------------------
SELECT * FROM tags;
SELECT * FROM photo_tags;
-- Identify and suggest the top 5 most commonly used hashtags on the platform
SELECT
	tags.tag_name,
    count(tags.tag_name) AS all_tags_count
FROM tags
INNER JOIN photo_tags
ON tags.id = photo_tags.tag_id
GROUP BY tags.tag_name
ORDER BY all_tags_count DESC
LIMIT 5;
-------------------------------------------------------------------------
SELECT * FROM users;
-- Launch AD Campaign: What day of the week do most users register on?
SELECT 
	dayname(users.created_at) AS day_of_wk,
    count(*) AS total_reg
FROM users
GROUP BY day_of_wk
ORDER BY total_reg DESC
LIMIT 3;
------------------------------------------------------------------------
SELECT * FROM photos;
SELECT * FROM users;
-- How many times does average user posts on Instagram. Also, total number of photos on Instagram/total number of users
SELECT round(
	((SELECT count(photos.id) FROM photos)
    /
    (SELECT count(users.id) FROM users))
    ,1
);
----------------------------------------------------------------------------
SELECT * FROM likes;
SELECT * FROM photos;
SELECT * FROM users;
-- Data on users (bots) who have liked every single photo on the site
SELECT DISTINCT
	likes.user_id,
	count(photos.id) AS total_photos_liked_by_bot,
    likes.created_at
FROM likes
JOIN photos
ON likes.photo_id = photos.id
GROUP BY 
	likes.user_id,
    likes.created_at
HAVING total_photos_liked_by_bot = 257
ORDER BY total_photos_liked_by_bot DESC;