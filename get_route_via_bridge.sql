SET @start = 1, @finish = 5;
-- this works only when it is exactly 5 (or less) chords between start and finish
-- finish is always at opposite side of the bridge, and crossing only 1 bridge at the time
SELECT CONCAT_WS(' -> ', c.name, c1.name, c2.name, c3.name, c4.name, c5.name) AS route,
	   b.name as bridge_name,
       ch.distance
         + COALESCE(ch1.distance, 0)
         + COALESCE(ch2.distance, 0)
         + COALESCE(ch3.distance, 0)
         + COALESCE(ch4.distance, 0) AS total_distance
-- joining 5 chords each new chord should start from prev to_id and not lead to one of the previous from_id. Also if prev to_id = finish - means we reach the destination
FROM `chord` ch
LEFT JOIN `chord` ch1 ON ch.to_id  = ch1.from_id AND ch.to_id  != @finish AND ch1.to_id != ch.from_id
LEFT JOIN `chord` ch2 ON ch1.to_id = ch2.from_id AND ch1.to_id != @finish AND ch2.to_id NOT IN (ch.from_id, ch1.from_id)
LEFT JOIN `chord` ch3 ON ch2.to_id = ch3.from_id AND ch2.to_id != @finish AND ch3.to_id NOT IN (ch.from_id, ch1.from_id, ch2.from_id)
LEFT JOIN `chord` ch4 ON ch3.to_id = ch4.from_id AND ch3.to_id != @finish AND ch4.to_id NOT IN (ch.from_id, ch1.from_id, ch2.from_id, ch3.from_id)
-- joining cross for each point of chord to get the name of each cross for route
JOIN `cross` c ON c.id  = ch.from_id
JOIN `cross` c1 ON c1.id = ch.to_id
LEFT JOIN `cross` c2 ON c2.id = ch1.to_id
LEFT JOIN `cross` c3 ON c3.id = ch2.to_id
LEFT JOIN `cross` c4 ON c4.id = ch3.to_id
LEFT JOIN `cross` c5 ON c5.id = ch4.to_id
-- joining on bridge will show only routes which includes the bridges
JOIN `bridge` b ON b.chord_id IN (ch.id, ch1.id, ch2.id, ch3.id, ch4.id)
WHERE ch.from_id = @start
  AND @finish IN (ch.to_id, ch1.to_id, ch2.to_id, ch3.to_id, ch4.to_id)
ORDER BY total_distance
LIMIT 1;