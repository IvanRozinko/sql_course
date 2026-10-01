CREATE TABLE `user`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE `driver`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    rating TINYINT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `passenger`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    rating TINYINT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `ride`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    driver_id INT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME,
    rating TINYINT DEFAULT 0,
    status ENUM('pending', 'active', 'done', 'failed') NOT NULL DEFAULT 'pending',
	FOREIGN KEY (passenger_id) REFERENCES `passenger`(id),
    FOREIGN KEY (driver_id) REFERENCES `driver`(id)
);


