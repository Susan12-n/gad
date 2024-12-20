CREATE TABLE IF NOT EXISTS `members` (
	`member_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`surname` varchar(255) NOT NULL,
	`others` varchar(255) NOT NULL,
	`gender` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	`dob` date NOT NULL,
	`status` int NOT NULL DEFAULT '1',
	`password` varchar(255) NOT NULL,
	`location_id` int NOT NULL,
	`reg_date` timestamp NOT NULL,
	PRIMARY KEY (`member_id`)
);

CREATE TABLE IF NOT EXISTS `locations` (
	`location_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`location` varchar(255) NOT NULL,
	PRIMARY KEY (`location_id`)
);

CREATE TABLE IF NOT EXISTS `dependants` (
	`dependant_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`member_id` int NOT NULL,
	`surname` varchar(255) NOT NULL,
	`others` varchar(255) NOT NULL,
	`dob` date NOT NULL,
	`reg_date` timestamp NOT NULL,
	PRIMARY KEY (`dependant_id`)
);

CREATE TABLE IF NOT EXISTS `labtests` (
	`test_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`test_name` varchar(255) NOT NULL,
	`test_description` varchar(255) NOT NULL,
	`test_cost` int NOT NULL,
	`test_discount` int NOT NULL,
	`availability` boolean NOT NULL,
	`more_info` varchar(255) NOT NULL,
	`reg_date` timestamp NOT NULL,
	PRIMARY KEY (`test_id`)
);

CREATE TABLE IF NOT EXISTS `nurses` (
	`nurse_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`surname` varchar(255) NOT NULL,
	`gender` varchar(255) NOT NULL,
	`email` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	`password` varchar(255) NOT NULL,
	`reg_date` timestamp NOT NULL,
	PRIMARY KEY (`nurse_id`)
);

CREATE TABLE IF NOT EXISTS `nurse_labtest_allocation` (
	`allocation_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`nurse_id` int NOT NULL,
	`invoice_no` varchar(255) NOT NULL,
	`flag` varchar(255) NOT NULL DEFAULT 'active',
	`reg_date` timestamp NOT NULL,
	PRIMARY KEY (`allocation_id`)
);

CREATE TABLE IF NOT EXISTS `admin` (
	`admin_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`email` varchar(255) NOT NULL,
	`surname` varchar(255) NOT NULL,
	`phone` varchar(255) NOT NULL,
	`password` varchar(255) NOT NULL,
	PRIMARY KEY (`admin_id`)
);

CREATE TABLE IF NOT EXISTS `payment` (
	`payment_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`invoice_no` int NOT NULL,
	`total_amount` int NOT NULL,
	`new_field` int NOT NULL,
	`reg_date` timestamp NOT NULL,
	PRIMARY KEY (`payment_id`)
);

CREATE TABLE IF NOT EXISTS `bookings` (
	`booking_id` int AUTO_INCREMENT NOT NULL UNIQUE,
	`member_id` int NOT NULL,
	`booked_for` varchar(255) NOT NULL,
	`dependant_id` int NOT NULL,
	`test_id` int NOT NULL,
	`appointment_date` date NOT NULL,
	`appointment_time` time NOT NULL,
	`where_taken` varchar(255) NOT NULL,
	`latitude` decimal(10,0) NOT NULL,
	`longitude` decimal(10,0) NOT NULL,
	`status` varchar(255) NOT NULL DEFAULT 'Pending',
	`invoice_no` varchar(255) NOT NULL,
	`reg_date` timestamp NOT NULL,
	PRIMARY KEY (`booking_id`)
);

ALTER TABLE `members` ADD CONSTRAINT `members_fk8` FOREIGN KEY (`location_id`) REFERENCES `locations`(`location_id`);

ALTER TABLE `dependants` ADD CONSTRAINT `dependants_fk1` FOREIGN KEY (`member_id`) REFERENCES `members`(`member_id`);


ALTER TABLE `nurse_labtest_allocation` ADD CONSTRAINT `nurse_labtest_allocation_fk1` FOREIGN KEY (`nurse_id`) REFERENCES `nurses`(`nurse_id`);

ALTER TABLE `payment` ADD CONSTRAINT `payment_fk1` FOREIGN KEY (`invoice_no`) REFERENCES `bookings`(`booking_id`);
ALTER TABLE `bookings` ADD CONSTRAINT `bookings_fk1` FOREIGN KEY (`member_id`) REFERENCES `members`(`member_id`);

ALTER TABLE `bookings` ADD CONSTRAINT `bookings_fk3` FOREIGN KEY (`dependant_id`) REFERENCES `dependants`(`dependant_id`);

ALTER TABLE `bookings` ADD CONSTRAINT `bookings_fk4` FOREIGN KEY (`test_id`) REFERENCES `labtests`(`test_id`);