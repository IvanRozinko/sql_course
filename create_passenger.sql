CREATE TABLE `user`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE `driver`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
	-- TODO this will be aggregate field most likely calculated on `driver_rating` table update probalby using a trigger
    rating DECIMAL(1, 1) DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `passenger`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
	-- TODO this will be aggregate field most likely calculated on `passenger_rating` table update probalby using a trigger
    rating DECIMAL(1, 1) DEFAULT NULL,
    FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `operator`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `ride`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    driver_id INT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME,
	review_comment VARCHAR(200),
    status ENUM('pending', 'active', 'done', 'failed') NOT NULL DEFAULT 'pending',
	FOREIGN KEY (passenger_id) REFERENCES `passenger`(id),
    FOREIGN KEY (driver_id) REFERENCES `driver`(id)
);

CREATE TABLE `driver_rating`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	ride_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
   	FOREIGN KEY (ride_id) REFERENCES `ride`(id)
);

CREATE TABLE `passenger_rating`(
	id INT PRIMARY KEY AUTO_INCREMENT,
	ride_id INT NOT NULL,
    rating TINYINT NOT NULL CHECK (rating BETWEEN 1 AND 5),
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (ride_id) REFERENCES `ride`(id)
);
