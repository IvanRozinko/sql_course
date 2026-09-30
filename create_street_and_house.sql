CREATE TABLE `street_type`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    type VARCHAR(20) NOT NULL UNIQUE
);

CREATE TABLE `street`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    type_id INT NOT NULL,
    FOREIGN KEY (type_id) REFERENCES street_type(id)
);

CREATE TABLE `historic_street`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	name VARCHAR(100) NOT NULL,
    street_id INT NOT NULL,
    date_applied DATE NOT NULL,
    is_latest BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (street_id) REFERENCES street(id)
);

CREATE TABLE `house`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    number VARCHAR(10),
    street_id INT NOT NULL,
    longitude DECIMAL(10,7) NOT NULL,
    latitude DECIMAL(10,7) NOT NULL,
    FOREIGN KEY (street_id) REFERENCES street(id),
	UNIQUE (street_id, number)
);
