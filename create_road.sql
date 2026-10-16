
CREATE TABLE `cross`(
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(30) NOT NULL UNIQUE,
    latitude  DECIMAL(10,7) NOT NULL,
    longitude DECIMAL(10,7) NOT NULL
);
 
-- Every two-way road is stored as two rows (A->B and B->A).
CREATE TABLE `chord`(
    id INT PRIMARY KEY AUTO_INCREMENT,
    from_id INT NOT NULL,
    to_id INT NOT NULL,
    distance DECIMAL(10,2) NOT NULL,  -- metres, straight line between the two crossings
    FOREIGN KEY (from_id) REFERENCES `cross`(id),
    FOREIGN KEY (to_id)   REFERENCES `cross`(id),
    CONSTRAINT uq_chord_from_to UNIQUE (from_id, to_id)
);
 
-- A bridge is a chord that crosses the river; both directions are listed.
CREATE TABLE `bridge`(
    id INT PRIMARY KEY AUTO_INCREMENT,
    chord_id INT NOT NULL,
    name VARCHAR(30),
    FOREIGN KEY (chord_id) REFERENCES `chord`(id),
    CONSTRAINT uq_bridge_chord UNIQUE (chord_id)
);