-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema recipemeetupdb
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `recipemeetupdb` ;

-- -----------------------------------------------------
-- Schema recipemeetupdb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `recipemeetupdb` DEFAULT CHARACTER SET utf8 ;
USE `recipemeetupdb` ;

-- -----------------------------------------------------
-- Table `address`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `address` ;

CREATE TABLE IF NOT EXISTS `address` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `street` VARCHAR(190) NOT NULL,
  `city` VARCHAR(100) NOT NULL,
  `state` CHAR(2) NOT NULL,
  `postal_code` VARCHAR(11) NOT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 5
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `user`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user` ;

CREATE TABLE IF NOT EXISTS `user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `username` VARCHAR(45) NOT NULL,
  `password` VARCHAR(45) NOT NULL,
  `date_of_birth` DATE NOT NULL,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address_id` INT(11) NOT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `create_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  `admin` TINYINT(1) NOT NULL DEFAULT '0',
  `img-url` VARCHAR(45) NULL DEFAULT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `username_UNIQUE` (`username` ASC),
  INDEX `address_id_idx` (`address_id` ASC),
  CONSTRAINT `fk_user_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe` ;

CREATE TABLE IF NOT EXISTS `recipe` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `description` VARCHAR(300) NULL DEFAULT NULL,
  `ingredients` VARCHAR(45) NOT NULL,
  `serving_size` VARCHAR(45) NULL DEFAULT NULL,
  `cook_time` VARCHAR(45) NULL DEFAULT NULL,
  `instructions` TEXT NOT NULL,
  `category` VARCHAR(45) NOT NULL,
  `post_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `img_url` VARCHAR(45) NULL DEFAULT NULL,
  `author_id` INT(11) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT 1,
  PRIMARY KEY (`id`),
  INDEX `author_id_idx` (`author_id` ASC),
  CONSTRAINT `fk_recipe_user`
    FOREIGN KEY (`author_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `favorite_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `favorite_recipe` ;

CREATE TABLE IF NOT EXISTS `favorite_recipe` (
  `user_id` INT(11) NOT NULL,
  `recipe_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `recipe_id`),
  INDEX `fk_favorite_recipe_recipe_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_favorite_recipe_recipe`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_favorite_recipe_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `meetup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup` ;

CREATE TABLE IF NOT EXISTS `meetup` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `address_id` INT(11) NOT NULL,
  `description` TEXT NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `img_url` VARCHAR(45) NULL DEFAULT NULL,
  `author_id` INT(11) NOT NULL,
  `active` TINYINT(4) NOT NULL DEFAULT '1',
  `start_time` DATETIME NOT NULL,
  `end_time` DATETIME NULL DEFAULT NULL,
  `maximum_attendance` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `author_id_idx` (`author_id` ASC),
  INDEX `fk_meetup_address_idx` (`address_id` ASC),
  CONSTRAINT `fk_meetup_address`
    FOREIGN KEY (`address_id`)
    REFERENCES `address` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meetup_user`
    FOREIGN KEY (`author_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `meetup_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup_comment` ;

CREATE TABLE IF NOT EXISTS `meetup_comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `meetup_id` INT(11) NOT NULL,
  `text_content` VARCHAR(250) NOT NULL,
  `post_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `fk_meetup_comment_user_idx` (`user_id` ASC),
  INDEX `fk_meetup_comment_meetup_idx` (`meetup_id` ASC),
  CONSTRAINT `fk_meetup_comment_meetup`
    FOREIGN KEY (`meetup_id`)
    REFERENCES `meetup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meetup_comment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `meetup_comment_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup_comment_like` ;

CREATE TABLE IF NOT EXISTS `meetup_comment_like` (
  `meetup_comment_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`meetup_comment_id`, `user_id`),
  INDEX `fk_meetup_comment_like_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_meetup_comment_like_meetup_comment`
    FOREIGN KEY (`meetup_comment_id`)
    REFERENCES `meetup_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meetup_comment_like_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `meetup_recipe`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `meetup_recipe` ;

CREATE TABLE IF NOT EXISTS `meetup_recipe` (
  `meetup_id` INT(11) NOT NULL,
  `recipe_id` INT(11) NOT NULL,
  PRIMARY KEY (`meetup_id`, `recipe_id`),
  INDEX `fk_meetup_recipe_recipe_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_meetup_recipe_meetup`
    FOREIGN KEY (`meetup_id`)
    REFERENCES `meetup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_meetup_recipe_recipe`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `recipe_comment`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_comment` ;

CREATE TABLE IF NOT EXISTS `recipe_comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `recipe_id` INT(11) NOT NULL,
  `comment` VARCHAR(250) NOT NULL,
  `timestamp` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`id`),
  INDEX `fk_recipe_comment_user_idx` (`user_id` ASC),
  INDEX `fk_recipe_comment_recipe_idx` (`recipe_id` ASC),
  CONSTRAINT `fk_recipe_comment_recipe`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_comment_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `recipe_comment_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_comment_like` ;

CREATE TABLE IF NOT EXISTS `recipe_comment_like` (
  `recipe_comment_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`recipe_comment_id`, `user_id`),
  INDEX `fk_comment_like_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_recipe_comment_like_recipe_comment`
    FOREIGN KEY (`recipe_comment_id`)
    REFERENCES `recipe_comment` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_comment_like_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `recipe_like`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `recipe_like` ;

CREATE TABLE IF NOT EXISTS `recipe_like` (
  `recipe_id` INT(11) NOT NULL,
  `user_id` INT(11) NOT NULL,
  PRIMARY KEY (`recipe_id`, `user_id`),
  INDEX `fk_recipe_like_user_idx` (`user_id` ASC),
  CONSTRAINT `fk_recipe_like_recipe`
    FOREIGN KEY (`recipe_id`)
    REFERENCES `recipe` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_recipe_like_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `user_meetup`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `user_meetup` ;

CREATE TABLE IF NOT EXISTS `user_meetup` (
  `user_id` INT(11) NOT NULL,
  `meetup_id` INT(11) NOT NULL,
  PRIMARY KEY (`user_id`, `meetup_id`),
  INDEX `fk_user_meetup_meetup_idx` (`meetup_id` ASC),
  CONSTRAINT `fk_user_meetup_meetup`
    FOREIGN KEY (`meetup_id`)
    REFERENCES `meetup` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_meetup_user`
    FOREIGN KEY (`user_id`)
    REFERENCES `user` (`id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8;

SET SQL_MODE = '';
DROP USER IF EXISTS fduser@localhost;
SET SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';
CREATE USER 'fduser'@'localhost' IDENTIFIED BY 'feraldesolation';

GRANT SELECT, INSERT, TRIGGER, UPDATE, DELETE ON TABLE * TO 'fduser'@'localhost';

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

-- -----------------------------------------------------
-- Data for table `address`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (1, '889 South Dampton Rd', 'Denver', 'CO', '80202');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (2, '10393 Mississipi Rd', 'Denver', 'CO', '80101');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (3, '100 Boise St', 'Denver', 'CO', '80104');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (4, '4301 Seattle ln', 'Denver', 'CO', '80401');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (5, '4555 Dylan Rd', 'Raleigh', 'NC', '27629');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (6, '863 Art St', 'Raleigh', 'NC', '27662');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (7, '200 Columbia Rd', 'Raleigh', 'NC', '27696');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (8, '400 Beachwalk Bvd', 'Raleigh', 'NC', '27607');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (9, '1033 Federal St', 'Raleigh', 'NC', '27601');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (1, 'blake234', 'hashedPass1', '1997-03-05', 'Blake', 'Shelton', 1, 'Fun, Smart, love cooking casseroles.', DEFAULT, DEFAULT, DEFAULT, NULL, 'blake@gmail.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (2, 'anthony_prince', 'Prince', '1989-02-01', 'Anthony', 'Prince', 2, 'Love for fine American cuisine.', DEFAULT, DEFAULT, DEFAULT, NULL, 'aprince@yahoo.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (3, 'newel1', 'aAse3G2013', '1988-03-08', 'Newel', 'New', 3, 'Love European food. They even used to call me the European kid.', DEFAULT, DEFAULT, DEFAULT, NULL, 'newel@hotmail.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (4, 'novienov', 'AcTb432yESV460', '1994-10-16', 'Novak', 'Longsurnameovich', 4, 'Any food is good food. Any place is a good place to make it with fun people.', DEFAULT, DEFAULT, DEFAULT, NULL, 'novinov@aol.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (5, 'codjones', 'jones1', '1955-06-12', 'Code', 'Jones', 5, 'I love southern food with a healthy spin.', DEFAULT, DEFAULT, DEFAULT, NULL, 'cody@codyjones.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (6, 'jakiechan123', 'finePass101', '1970-12-21', 'Jack', 'Bryan', 6, 'I love inviting friends over for dinner. I\'ll cook anything from Pad Thai to fried ice cream.', DEFAULT, DEFAULT, DEFAULT, NULL, 'codejones@gmail.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (7, 'cletus23', 'osgdfs23', '1988-10-13', 'Cletus', 'McAlister', 8, NULL, DEFAULT, DEFAULT, DEFAULT, NULL, 'bryan.mcalister@gmail.com');

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (1, 'Chicken quesadilla', 'Mexico', NULL, 'corn tortilla, chicken, etc.', '4', NULL, 'put meat inside of tortilla.', '\"Quick meal\"', DEFAULT, NULL, 1, DEFAULT);
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (2, 'Cevapcici', 'Serbia', NULL, 'beef, beef, and beef. And garlic.', '10', NULL, 'put meat on the grill. Add garlic.', '\"Grilled\"', DEFAULT, NULL, 4, DEFAULT);
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (3, 'Chicken fried steak', 'US', NULL, 'bread, chese, gravy, chicken tenders.', '4', NULL, 'make it nice and tasty.', '\"Fried\"', DEFAULT, NULL, 3, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `favorite_recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (1, 1);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (2, 2);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (3, 2);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (4, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (1, 'French Food in Denver', 2, 'Let\'s get together and make some Creme Brule!', DEFAULT, NULL, 3, DEFAULT, '2018-11-09 12:00:00', '2018-11-09 18:00:00', 6);
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (2, 'Raleigh Mexican Delish!', 9, 'Let\'s get together and make chicken tostadas, tacos and of course Salsa.', DEFAULT, NULL, 7, DEFAULT, '2018-12-01 20:00:00', NULL, 15);
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (3, 'Grill and Chill Denver', 1, 'My daughter had a wedding last week and there is so much food left unprepared. Let\'s grill it and eat it together! There are many vegan options as well.', DEFAULT, NULL, 2, DEFAULT, '2018-10-12 15:00:00', '2018-10-11 12:00:00', 25);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (1, 2, 2, 'Great idea. I am looking forward to attending', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (2, 1, 3, 'I am so hyped', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (3, 3, 2, 'How do I get to your address. Google map gives no results.', DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup_comment_like`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `meetup_comment_like` (`meetup_comment_id`, `user_id`) VALUES (1, 1);
INSERT INTO `meetup_comment_like` (`meetup_comment_id`, `user_id`) VALUES (3, 2);

COMMIT;


-- -----------------------------------------------------
-- Data for table `meetup_recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `meetup_recipe` (`meetup_id`, `recipe_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (1, 1, 3, 'Too much meat for my taste', DEFAULT, DEFAULT);
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (2, 1, 3, 'I am ok with this.', DEFAULT, DEFAULT);
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (3, 1, 3, 'Don\'t like it at all.', DEFAULT, DEFAULT);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_comment_like`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `recipe_comment_like` (`recipe_comment_id`, `user_id`) VALUES (1, 3);
INSERT INTO `recipe_comment_like` (`recipe_comment_id`, `user_id`) VALUES (1, 5);
INSERT INTO `recipe_comment_like` (`recipe_comment_id`, `user_id`) VALUES (1, 6);
INSERT INTO `recipe_comment_like` (`recipe_comment_id`, `user_id`) VALUES (2, 4);
INSERT INTO `recipe_comment_like` (`recipe_comment_id`, `user_id`) VALUES (1, 1);

COMMIT;


-- -----------------------------------------------------
-- Data for table `recipe_like`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (1, 2);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (1, 3);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (1, 5);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (1, 7);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (1, 6);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (2, 6);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (3, 4);

COMMIT;


-- -----------------------------------------------------
-- Data for table `user_meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (1, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (2, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (3, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (4, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (5, 2);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (6, 2);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (7, 2);

COMMIT;

