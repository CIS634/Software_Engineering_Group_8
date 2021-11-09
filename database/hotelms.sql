SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";

-- Table structure for table `booking`

CREATE TABLE `booking` (
  `booking_id` int(10) NOT NULL,
  `customer_id` int(10) NOT NULL,
  `room_id` int(10) NOT NULL,
  `booking_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `check_in` varchar(100) DEFAULT NULL,
  `check_out` varchar(100) NOT NULL,
  `total_price` int(10) NOT NULL,
  `remaining_price` int(10) NOT NULL,
  `payment_status` tinyint(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `booking`
  ADD CONSTRAINT `booking_ibfk_1` FOREIGN KEY (`customer_id`) REFERENCES `customer` (`customer_id`),
  ADD CONSTRAINT `booking_ibfk_2` FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`);
ALTER TABLE `booking`
  MODIFY `booking_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;


-- Table structure for table `complaint`

CREATE TABLE `complaint` (
  `id` int(11) NOT NULL,
  `complainant_name` varchar(100) NOT NULL,
  `complaint_type` varchar(100) NOT NULL,
  `complaint` varchar(200) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `resolve_status` tinyint(1) NOT NULL,
  `resolve_date` timestamp NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `budget` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `complaint`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;


-- Table structure for table `customer`

CREATE TABLE `customer` (
  `customer_id` int(10) NOT NULL,
  `customer_name` varchar(100) NOT NULL,
  `contact_no` bigint(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `id_card_type_id` int(10) NOT NULL,
  `id_card_no` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `customer`
  ADD CONSTRAINT `customer_ibfk_1` FOREIGN KEY (`id_card_type_id`) REFERENCES `id_card_type` (`id_card_type_id`);
  ALTER TABLE `customer`
  MODIFY `customer_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

-- Table structure for table `emp_history`

CREATE TABLE `emp_history` (
  `id` int(11) NOT NULL,
  `emp_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `from_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `to_date` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `emp_history`
  ADD CONSTRAINT `emp_history_ibfk_1` FOREIGN KEY (`emp_id`) REFERENCES `staff` (`emp_id`),
  ADD CONSTRAINT `emp_history_ibfk_2` FOREIGN KEY (`shift_id`) REFERENCES `shift` (`shift_id`);
  ALTER TABLE `emp_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;


-- Dumping data for table `emp_history`
INSERT INTO `emp_history` (`id`, `emp_id`, `shift_id`, `from_date`, `to_date`, `created_at`) VALUES
(22, 14, 2, '2021-11-02 13:13:38', NULL, '2021-11-02 13:13:38');

-- Table structure for table `id_card_type`

CREATE TABLE `id_card_type` (
  `id_card_type_id` int(10) NOT NULL,
  `id_card_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `id_card_type`
  MODIFY `id_card_type_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

-- Dumping data for table `id_card_type`
INSERT INTO `id_card_type` (`id_card_type_id`, `id_card_type`) VALUES
(1, 'National Identity Card'),
(2, 'Passport'),
(3, 'International Driving License'),
(4, 'Driving License');

-- Table structure for table `room`

CREATE TABLE `room` (
  `room_id` int(10) NOT NULL,
  `room_type_id` int(10) NOT NULL,
  `room_no` varchar(10) NOT NULL,
  `status` tinyint(1) DEFAULT NULL,
  `check_in_status` tinyint(1) NOT NULL,
  `check_out_status` tinyint(1) NOT NULL,
  `deleteStatus` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `room`
  ADD CONSTRAINT `room_ibfk_1` FOREIGN KEY (`room_type_id`) REFERENCES `room_type` (`room_type_id`);
  ALTER TABLE `room`
  MODIFY `room_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

-- Dumping data for table `room`
INSERT INTO `room` (`room_id`, `room_type_id`, `room_no`, `status`, `check_in_status`, `check_out_status`, `deleteStatus`) VALUES
(27, 1, 'A 101', NULL, 0, 0, 0),
(28, 1, 'A 102', NULL, 0, 0, 0),
(29, 2, 'B 201', NULL, 0, 0, 0),
(30, 3, 'C 301', NULL, 0, 0, 0);



-- Table structure for table `room_type`

CREATE TABLE `room_type` (
  `room_type_id` int(10) NOT NULL,
  `room_type` varchar(100) NOT NULL,
  `price` int(10) NOT NULL,
  `max_person` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `room_type`
  MODIFY `room_type_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

-- Dumping data for table `room_type`
INSERT INTO `room_type` (`room_type_id`, `room_type`, `price`, `max_person`) VALUES
(1, 'Single', 100, 1),
(2, 'Double', 150, 2),
(3, 'Triple', 200, 3),
(4, 'Family', 250, 2),
(5, 'King Sized', 280, 4),
(6, 'Master Suite', 300, 6),
(7, 'Mini-Suite', 290, 3),
(8, 'Connecting Rooms', 270, 6),
(9, 'Presidential Suite', 400, 4),
(10, 'Murphy Room', 310, 3);

-- Table structure for table `shift`

CREATE TABLE `shift` (
  `shift_id` int(10) NOT NULL,
  `shift` varchar(100) NOT NULL,
  `shift_timing` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `shift`
  MODIFY `shift_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;
  


-- Dumping data for table `shift`

INSERT INTO `shift` (`shift_id`, `shift`, `shift_timing`) VALUES
(1, 'Morning', '5:00 AM - 10:00 AM'),
(2, 'Day', '10:00 AM - 4:00PM'),
(3, 'Evening', '4:00 PM - 10:00 PM'),
(4, 'Night', '10:00PM - 5:00AM');


-- Table structure for table `staff`

CREATE TABLE `staff` (
  `emp_id` int(11) NOT NULL,
  `emp_name` varchar(100) NOT NULL,
  `staff_type_id` int(11) NOT NULL,
  `shift_id` int(11) NOT NULL,
  `id_card_type` int(11) NOT NULL,
  `id_card_no` varchar(20) NOT NULL,
  `address` varchar(100) NOT NULL,
  `contact_no` bigint(20) NOT NULL,
  `salary` bigint(20) NOT NULL,
  `joining_date` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `staff`
  ADD CONSTRAINT `staff_ibfk_1` FOREIGN KEY (`id_card_type`) REFERENCES `id_card_type` (`id_card_type_id`),
  ADD CONSTRAINT `staff_ibfk_2` FOREIGN KEY (`shift_id`) REFERENCES `shift` (`shift_id`),
  ADD CONSTRAINT `staff_ibfk_3` FOREIGN KEY (`staff_type_id`) REFERENCES `staff_type` (`staff_type_id`);
  ALTER TABLE `staff`
  MODIFY `emp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

-- Dumping data for table `staff`

INSERT INTO `staff` (`emp_id`, `emp_name`, `staff_type_id`, `shift_id`, `id_card_type`, `id_card_no`, `address`, `contact_no`, `salary`, `joining_date`, `updated_at`) VALUES
(14, 'Ross Maria', 1, 2, 4, 'abcdef1234567890', '1800 E 14th ST', 1234567889, 3000, '2021-11-02 13:13:38', '2021-11-02 13:13:38');

-- Table structure for table `staff_type`

CREATE TABLE `staff_type` (
  `staff_type_id` int(10) NOT NULL,
  `staff_type` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `staff_type`
  MODIFY `staff_type_id` int(10) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;
ALTER TABLE `staff_type`
  ADD PRIMARY KEY (`staff_type_id`);


-- Dumping data for table `staff_type`
INSERT INTO `staff_type` (`staff_type_id`, `staff_type`) VALUES
(1, 'Manager'),
(2, 'Housekeeping Manager'),
(3, 'Front Desk Receptionist'),
(4, 'Cheif'),
(5, 'Waiter'),
(6, 'Room Attendant'),
(7, 'Concierge'),
(8, 'Hotel Maintenance Engineer'),
(9, 'Hotel Sales Manager');

-- Table structure for table `user`
CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `name` varchar(100) NOT NULL,
  `username` varchar(15) NOT NULL,
  `email` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);
  


-- Dumping data for table `user`

INSERT INTO `user` (`id`, `name`, `username`, `email`, `password`, `created_at`) VALUES
(2, 'Rikul Joshi', 'rikul', 'rikuljoshi@gmail.com', '1234', '2020-10-27 11:49:22'),
(3, 'Pavan Sanghani', 'pavan', 'pavan@gmail.com', '1234', '2020-10-28 12:49:22');


ALTER TABLE `booking`
  ADD PRIMARY KEY (`booking_id`),
  ADD KEY `customer_id` (`customer_id`),
  ADD KEY `room_id` (`room_id`);

ALTER TABLE `complaint`
  ADD PRIMARY KEY (`id`);

ALTER TABLE `customer`
  ADD PRIMARY KEY (`customer_id`),
  ADD KEY `customer_id_type` (`id_card_type_id`);

ALTER TABLE `emp_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `emp_id` (`emp_id`),
  ADD KEY `shift_id` (`shift_id`);

ALTER TABLE `id_card_type`
  ADD PRIMARY KEY (`id_card_type_id`);

ALTER TABLE `room`
  ADD PRIMARY KEY (`room_id`),
  ADD KEY `room_type_id` (`room_type_id`);

ALTER TABLE `room_type`
  ADD PRIMARY KEY (`room_type_id`);

ALTER TABLE `shift`
  ADD PRIMARY KEY (`shift_id`);

ALTER TABLE `staff`
  ADD PRIMARY KEY (`emp_id`),
  ADD KEY `id_card_type` (`id_card_type`),
  ADD KEY `shift_id` (`shift_id`),
  ADD KEY `staff_type_id` (`staff_type_id`);

