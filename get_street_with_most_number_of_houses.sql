SELECT s.name, COUNT(h.id) as house_count
FROM `street` s
LEFT JOIN `house` h ON s.id = h.street_id
GROUP BY s.id 
ORDER BY house_count DESC
LIMIT 1;