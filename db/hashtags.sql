CREATE TABLE `hashtags`
(
	`pol_id` int,
	`rank` int,
	`keyword` VARCHAR(50),
	`count` int,
	PRIMARY KEY (pol_id, rank)
);

ALTER TABLE `hashtags` ADD FOREIGN KEY (`pol_id`) REFERENCES `pol_all` (`id`);