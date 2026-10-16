
--   D ─── C ─── E
--   │     │     │
--   A ─── B ─── F        river between the middle and right column
--
-- Bridges: B-F "Central", C-E "Koval".

-- 1. Crossings: A=1, B=2, C=3, D=4, E=5, F=6
INSERT INTO `cross` (name, latitude, longitude) VALUES
('A', 50.4500000, 30.5200000),
('B', 50.4500000, 30.5300000),
('C', 50.4560000, 30.5300000),
('D', 50.4560000, 30.5000000),
('E', 50.4560000, 30.5400000),
('F', 50.4500000, 30.5400000);

-- 2. Chords: every road in both directions, distance filled in the next step
INSERT INTO `chord` (from_id, to_id, distance) VALUES
(1, 2, 0), (2, 1, 0),     -- ids 1, 2:    A <-> B
(2, 3, 0), (3, 2, 0),     -- ids 3, 4:    B <-> C
(3, 4, 0), (4, 3, 0),     -- ids 5, 6:    C <-> D
(1, 4, 0), (4, 1, 0),     -- ids 7, 8:    A <-> D
(3, 5, 0), (5, 3, 0),     -- ids 9, 10:   C <-> E  (bridge Koval)
(5, 6, 0), (6, 5, 0),     -- ids 11, 12:  E <-> F
(2, 6, 0), (6, 2, 0);     -- ids 13, 14:  B <-> F  (bridge Central)

-- 3. Distances from coordinates (POINT takes longitude first)
UPDATE `chord` ch
JOIN `cross` c  ON c.id  = ch.from_id
JOIN `cross` c1 ON c1.id = ch.to_id
SET ch.distance = ST_Distance_Sphere(
    POINT(c.longitude,  c.latitude),
    POINT(c1.longitude, c1.latitude)
);

-- 4. Bridges (chord ids from step 2)
INSERT INTO `bridge` (chord_id, name) VALUES
(13, 'Central'),
(14, 'Central'),
(9,  'Koval'),
(10, 'Koval');