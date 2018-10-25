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
  `active` TINYINT(1) NOT NULL DEFAULT '0',
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
  `ACTIVE` TINYINT(1) NOT NULL DEFAULT '1',
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
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (1, '10393 great st', 'Denver', 'CO', '80104');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (2, '324 fdsa lane', 'Denver', 'CO', '80004');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (3, '23 dfbrt st', 'Seattle', 'WA', '90104');
INSERT INTO `address` (`id`, `street`, `city`, `state`, `postal_code`) VALUES (4, '4663 South Monaco St', 'Denver', 'CO', '80237');

COMMIT;


-- -----------------------------------------------------
-- Data for table `user`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (1, 'idontknow', 'hashedpass', '1993-07-03', 'Bob', 'Dylan', 1, NULL, DEFAULT, DEFAULT, DEFAULT, NULL, 'sdfaf@dfsfd.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (2, 'blake123', 'hashedPass2', '1994-05-03', 'Blake', 'Longfield', 4, 'Fun, blonde, tall, German heritage', DEFAULT, DEFAULT, DEFAULT, 'FACEBOOK.COM', 'blake.longfield@gmail.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (3, 'newel001', 'hashedPass3', '1988-04-04', 'Newel', 'Miole', 2, 'Fun, European, cool guy. Love all food. I left the military but my eating habits didn\'t change. #YOLO', DEFAULT, DEFAULT, DEFAULT, NULL, 'newel.miole@yahoo.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (4, 'askyeking', 'hashedPass4', '1992-07-17', 'Anthony', 'King', 1, 'Boring, metal loving, will not eat natural foods, favorite delicacy: pizza with anchovies', DEFAULT, DEFAULT, DEFAULT, NULL, 'anthony.king@me.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img-url`, `email`) VALUES (5, 'novakisnotamerican', 'hashedPass5', '1993-11-26', 'Novak', 'D', 3, 'Bad handwriting, can\'t pronounce the word vegatable. Loves long walks on the beach', DEFAULT, DEFAULT, DEFAULT, NULL, 'Novak.d@hotmail.com');

COMMIT;
