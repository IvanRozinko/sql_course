CREATE TABLE `user`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(30) NOT NULL,
    last_name VARCHAR(30) NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

CREATE TABLE `driver`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    rating INT,
    FOREIGN KEY (user_id) REFERENCES `user`(id)
);

CREATE TABLE `ride`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    passenger_id INT NOT NULL,
    driver_id INT NOT NULL,
    start_date DATETIME NOT NULL,
    end_date DATETIME,
    rating INT,
    status ENUM('pending', 'active', 'done', 'failed'),
    FOREIGN KEY (driver_id) REFERENCES `driver`(id)
);

CREATE TABLE `passenger`(
	id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    rating INT,
    last_ride_id INT,
    FOREIGN KEY (user_id) REFERENCES `user`(id),
    FOREIGN KEY (last_ride_id) REFERENCES `ride`(id)
);

ALTER TABLE `ride` ADD CONSTRAINT FOREIGN KEY (passenger_id) REFERENCES `passenger`(id);

