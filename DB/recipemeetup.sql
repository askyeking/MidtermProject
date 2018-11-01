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
  `img_url` VARCHAR(500) NULL DEFAULT 'https://image.freepik.com/free-icon/fork-and-knife-in-cross_318-61306.jpg',
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
  `title` VARCHAR(100) NOT NULL,
  `country` VARCHAR(45) NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  `ingredients` TEXT NOT NULL,
  `serving_size` VARCHAR(45) NULL DEFAULT NULL,
  `cook_time` VARCHAR(45) NULL DEFAULT NULL,
  `instructions` TEXT NOT NULL,
  `category` VARCHAR(45) NULL,
  `post_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `img_url` VARCHAR(500) NULL DEFAULT 'https://image.freepik.com/free-icon/fork-and-knife-in-cross_318-61306.jpg',
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
  `title` VARCHAR(150) NOT NULL,
  `address_id` INT(11) NOT NULL,
  `description` TEXT NOT NULL,
  `date_created` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `img_url` VARCHAR(500) NULL DEFAULT 'https://image.freepik.com/free-icon/fork-and-knife-in-cross_318-61306.jpg',
  `author_id` INT(11) NOT NULL,
  `active` TINYINT(1) NOT NULL DEFAULT '1',
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
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img_url`, `email`) VALUES (1, 'b', '92eb5ffee6ae2fec3ad71c777531578f', '1980-03-05', 'Blake', 'Shelton', 1, 'I\'m a country-lovin\' guy who enjoys cooking out with his buds on a Saturday night.', DEFAULT, DEFAULT, DEFAULT ,'https://images-na.ssl-images-amazon.com/images/I/B1fILelfKMS._CR0,0,3840,2880_._SL1000_.jpg', 'blake@gmail.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img_url`, `email`) VALUES (2, 'MarthaCooks', '3fb3dda4d438e40a314f47b912ed7ab3', '1955-02-01', 'Martha', 'Stewart', 2, 'I love hanging out with loved ones especially when we are cooking something tasty.', DEFAULT, DEFAULT, DEFAULT, 'https://assets.marthastewart.com/styles/wmax-520-highdpi/d16/1001_martha_long/1001_martha_long_xl.jpg?itok=edlDQA6j', 'Martharocks@yahoo.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img_url`, `email`) VALUES (3, 'RachaelPie', '3a41e7ad8037d6b1ea685a996fc1c372', '1956-10-08', 'Rachael', 'Ray', 3, 'I can\'t even begin to tell you how much I love to cook.  So don\'t be a stranger, come on over for some tremendous food, great wine and good laughs.', DEFAULT, DEFAULT, DEFAULT, 'https://m.media-amazon.com/images/M/MV5BMTQ2NTEzOTQ1NV5BMl5BanBnXkFtZTYwNzUzNDIz._V1_UX214_CR0,0,214,317_AL_.jpg', 'RachelRay@hotmail.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img_url`, `email`) VALUES (4, 'admin', '21232f297a57a5a743894a0e4a801fc3', '1994-10-16', 'Novak', 'Longsurnameovich', 4, 'Any food is good food. Any place is a good place to make it with fun people.', DEFAULT, DEFAULT, '1', DEFAULT, 'novinov@aol.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img_url`, `email`) VALUES (5, 'CodysKitchen', '7078c65df4baa37977eee6174d22e54b', '1989-06-12', 'Cody', 'Jones', 5, 'I love southern food with a healthy twist.', DEFAULT, DEFAULT, DEFAULT, 'https://images.pexels.com/photos/736716/pexels-photo-736716.jpeg?auto=compress&cs=tinysrgb&h=350', 'cody@aol.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img_url`, `email`) VALUES (6, 'Jackiesfineknives', '0cffeba4a6cfd5f4035d297dc2abb43a', '1970-12-21', 'Jackie', 'Smith', 6, 'I love inviting friends over for dinner. I\'ll cook anything from Pad Thai to fried ice cream.', DEFAULT, DEFAULT, DEFAULT, 'https://images.pexels.com/photos/712513/pexels-photo-712513.jpeg?auto=compress&cs=tinysrgb&h=350', 'JackieS@gmail.com');
INSERT INTO `user` (`id`, `username`, `password`, `date_of_birth`, `first_name`, `last_name`, `address_id`, `description`, `create_date`, `active`, `admin`, `img_url`, `email`) VALUES (7, 'Friedfoodlover', '132d7eebebd07d08624e339fd4b932ed', '1988-10-13', 'Cletus', 'McAlister', 8, 'Fried, fried, fried and more fried.  Sign me up for anything fried.', DEFAULT, DEFAULT, DEFAULT, 'http://www.jardine-electronics.com/athletics/images/Cletus.jpg', 'cletus.mcalister@gmail.com');
COMMIT;
-- -----------------------------------------------------
-- Data for table `recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (1, 'Chicken Quesadilla', 'Mexico', 'One of the best tasting and easiest meals to make.  This is a great meal if you are in a hurry or just want to make something easy.', '2 9-12 inch Corn or flour tortillas, ½ lb Choice of shredded meat(preferably chicken or steak), ½ lb Cheddar cheese, 1 ounce of diced onions, vegetable oil (spray)', '1', '15', 'Start by spraying a non-stick pan with some vegetable oil and setting in on a burner at medium-high heat and begin to brown your meat.  Once browned, turn off the burner.  Spray a second pan and place it on a burner at medium heat.  Place one tortilla in the pan and begin to layer the cheese and meat on top of it. Place the other tortilla on top of the cheese and meat.  In approximately 5 minutes, or until tortilla browns and cheese begins to melt, flip the quesadilla.  Let sit on the burner for approximately 3 more minutes or until this tortilla begins to brown.', 'Quick Meal', DEFAULT, 'https://images-gmi-pmc.edge-generalmills.com/07f07d48-ea31-4435-b387-d0c84ac632f3.jpg', 1, DEFAULT);
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (2, 'Turkey Goulash', 'Hungary', 'A lighter version of the classic goulash.  Serve with a salad for a quick and healthy meal.', '1 lb lean ground turkey, 1 can diced tomatoes, 3 cloves garlic, 1 cup tomato sauce, 2 teaspoons white sugar, ½ teaspoon dried basil 1 box bow tie pasta', '4', '60', 'In a large skillet over medium heat, cook the turkey until browned.  Stir in the stewed tomatoes, garlic, tomato sauce, sugar and basil, and then simmer for about 20 minutes.  Bring a large pot of lightly salted water to a boil. Add pasta and cook for 8 to 10 minutes or until the noodles are soft, and then drain.  Combine the pasta and turkey mixture; toss and serve.', 'NULL', DEFAULT, 'https://images.media-allrecipes.com/userphotos/560x315/5168274.jpg', 2, DEFAULT);
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (3, 'Chicken Fried Steak', 'US', 'This is by far the best chicken fried steak I\'ve ever had.  I\'ve made this numerous times and get nothing but good reviews each time.', '2lb beef cube steaks, 2 cups all-purpose flour, 2 teaspoons baking powder, 1 teaspoon baking soda, 1 teaspoon black pepper, ¾ teaspoon salt, 1 ½ cups buttermilk, 1 egg, 1 tablespoon hot pepper sauce(Tabasco), 2 cloves minced garlic, 3 cups vegetable shortening, 4 cups milk', '2', '60', 'Pound the steaks to about ¼ inch thickness.  Place 2 cups of flour in a shallow bowl.  Stir together the baking powder, baking soda, pepper, and salt in a separate shallow bowl; stir in the buttermilk, egg, tabasco sauce, and garlic.  Dredge each steak first in the flour, then in the batter, and again in the flour.  Pat the flour onto the surface of each steak so they are completely coated with dry flour. Heat the shortening in a deep cast-iron skillet to 325 degrees F (165 degrees C).  Fry the steaks until evenly golden brown, 3 to 5 minutes per side.  Place fried steaks on a plate with paper towels to drain. Drain the fat from the skiller, reserving ¼ cup of the liquid and as much of the solid remnants as possible.  Return the skillet to medium low heat with the reserved oil.  Whisk the remaining flour into the oil.  Scrape the bottom of the pan with a spatula to release solids into the gracy.  Stir in the milk, raise the heat to medium, and bring the gravy to a simmer, cook until thick, 6 to 7 minutes.  Season with kosher salt and pepper.  Spoon the gravy over the steaks to serve.', 'Fried', DEFAULT, 'https://food.fnr.sndimg.com/content/dam/images/food/fullset/2012/1/25/0/WU0101H_Chicken-Fried-Steak_s4x3.jpg.rend.hgtvcom.616.462.suffix/1387468612321.jpeg', 3, DEFAULT);
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (4, 'Easy Meatloaf', 'US', 'This is a very easy and no fail recipe for meatloaf.  It won\'t take long to make at all, and it\'s quite good!', '1 ½ lb ground beef, 1 egg, 1 chopped onion, 1 cup milk, 1 cup dried bread crumbs, salt and pepper to taste, 2 tablespoons brown sugar, 2 tablespoons prepared mustard, ⅓ cup ketchup', '3', '75', 'Preheat the oven to 325 degrees F (175 degrees C).  In a large bowl, combine the beef, egg, onion, milk, and bread OR cracker crumbs.  Season with salt and pepper to taste and place in a lightly greased 5x9 inch loaf pan, OR form into a loaf and place in a lightly greased 9x13 inch baking dish.  In a separate small bowl, combine the brown sugar, mustard and ketchup.  Mix well and pour over the meatloaf.  Bake at 350 degrees F (175 degrees C) for 1 hour.', 'Baked', DEFAULT, 'https://images-gmi-pmc.edge-generalmills.com/3e0ded09-f8a2-45b6-aff7-e08ab138ed84.jpg', 4, DEFAULT);
INSERT INTO `recipe` (`id`, `title`, `country`, `description`, `ingredients`, `serving_size`, `cook_time`, `instructions`, `category`, `post_date`, `img_url`, `author_id`, `active`) VALUES (5, 'Spicy Thai Basil Chicken (Pad Krapow Gai)', 'Thailand', 'My version of this classic Thai dish has a spectacular taste even with regular basil instead of Thai or holy basil.  The sauce actually acts like a glaze as the chicken mixture cooks over high heat.  The recipe works best if you chop or grind your own chicken and have all ingredients prepped before you start cooking.', '⅓ cup chicken broth, 1 tablespoon oyster sauce, 1 tablespoon soy sauce, 2 teaspoons fish sauce, 1 teaspoon white sugar, 1 teaspoon brown sugar, 2 tablespoons vegetable oil, 1 lb skinless chicken thighs coarsely chopped, ¼ cup sliced shallots, 4 cloves minced garlic, 2 tablespoons minced Thai chilies, 1 cup very thinly sliced fresh basil leaves 2 cups hot cooked rice', '4', '45', 'Whisk chicken broth, oyster sauce, soy sauce, fish sauce, white sugar, and brown sugar together in a bowl until well blended.  Heat large skillet over high heat.  Drizzle in oil .  Add chicken and stir fry until it loses its raw color, 2 to 3 minutes.  Stir in shallots, garlic, and sliced chilies, Continue cooking on high heat until some of the juices start to caramelize in the bottom of the pan, about 2 or 3 more minutes. Add about a tablespoon of the sauce mixture to the skiller; cook and stir until sauce begins to caramelize, about 1 minute.  Pour in the rest of the sauce.  Cook and stir until sauce has deglazed the bottom of the pan.  Continue to cook until sauce glazes onto the meat, 1 or 2 more minutes.  Remove from heat.  Stir in basil.  Cook and stir until basil is wilted, about 20 seconds.  Serve with rice.', 'Quick Meal', DEFAULT, 'https://images.media-allrecipes.com/userphotos/560x315/4507925.jpg', 5, DEFAULT);
COMMIT;
-- -----------------------------------------------------
-- Data for table `favorite_recipe`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (1, 2);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (2, 1);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (3, 4);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (4, 5);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (5, 3);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (6, 5);
INSERT INTO `favorite_recipe` (`user_id`, `recipe_id`) VALUES (7, 1);
COMMIT;
-- -----------------------------------------------------
-- Data for table `meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (1, 'French Food in Denver', 2, 'A sumptuous dinner with a French flair! Sensual and comforting as only the French know how to do it.  Unique flavor and texture combinations with herbs and spices that deepen the deliciousness.', DEFAULT, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg/240px-Tour_Eiffel_Wikimedia_Commons_%28cropped%29.jpg', 2, DEFAULT, '2018-11-09 17:00:00', '2018-11-09 19:00:00', 6);
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (2, 'Bountiful Brunch', 3, 'A hearty and slightly indulgent way to enjoy spring in Denver! A variety of pastries, a lovely egg and vegetable frittata, and numerous other tasty offerings from our host.  Fascinating people, food and a view of a lifetime.', DEFAULT, 'https://i2-prod.liverpoolecho.co.uk/whats-on/food-drink-news/article12752041.ece/ALTERNATES/s1200/Brunch-1.jpg', 7, DEFAULT, '2018-11-21 18:00:00','2018-11-21 20:00:00', 10);
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (3, 'Join us for a Korean Inspired Feast', 1, 'Explore fermented foods, chat with new friends, and delight your palate. RSVP today!', DEFAULT, 'http://i.imgur.com/75UgGVO.jpg', 4, DEFAULT, '2018-11-08 15:00:00', '2018-11-08 17:00:00', 8);
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (4, 'Fall Cocktails and Thanksgiving Inspired', 4, 'Let\'s get together for appetizers and drinks, bring your interpretation of a Fall/Thanksgiving appetizer to share.', DEFAULT, 'https://www.almanac.com/sites/default/files/styles/primary_image_in_article/public/image_nodes/thanksgiving.jpg?itok=xSe9VSL8', 5, DEFAULT, '2018-11-15 15:00:00', '2018-11-15 19:00:00', 10);
INSERT INTO `meetup` (`id`, `title`, `address_id`, `description`, `date_created`, `img_url`, `author_id`, `active`, `start_time`, `end_time`, `maximum_attendance`) VALUES (5, 'Let\'s enjoy Spanish Tapas + Wine!', 3, 'Want to learn about some of the best red and white wines that the beautiful country of Spain has to offer? We will pair with an array of spanish cheese and tapas.  Join us for a great time!', DEFAULT, 'https://hhp-blog.s3.amazonaws.com/2018/02/iStock-615737086.jpg', 6, DEFAULT, '2018-11-20 16:00:00', '2018-11-20 19:00:00', 5);
COMMIT;
-- -----------------------------------------------------
-- Data for table `meetup_comment`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (1, 3, 2, 'Can\'t wait!', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (2, 4, 2, 'I\'ve been waiting for this event for weeks!', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (3, 6, 2, 'Food sounds delicious.', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (4, 5, 1, 'Wow, great idea!', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (5, 1, 1, 'Food sounds delicious.', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (6, 6, 1, 'My friends and I might be interested!', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (7, 2, 3, 'Looks great!', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (8, 7, 4, 'Awesome.', DEFAULT, DEFAULT);
INSERT INTO `meetup_comment` (`id`, `user_id`, `meetup_id`, `text_content`, `post_date`, `active`) VALUES (9, 2, 5, 'Sweet', DEFAULT, DEFAULT);
COMMIT;
-- -----------------------------------------------------
-- Data for table `meetup_comment_like`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `meetup_comment_like` (`meetup_comment_id`, `user_id`) VALUES (1, 1);
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
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (1, 2, 3, 'Amazing!', DEFAULT, DEFAULT);
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (2, 3, 2, 'Great recipe.', DEFAULT, DEFAULT);
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (3, 4, 4, 'Superb', DEFAULT, DEFAULT);
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (4, 2, 5, 'Wow, amazing!', DEFAULT, DEFAULT);
INSERT INTO `recipe_comment` (`id`, `user_id`, `recipe_id`, `comment`, `timestamp`, `active`) VALUES (5, 1, 1, 'This is unreal!', DEFAULT, DEFAULT);
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
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (1, 4);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (2, 4);
INSERT INTO `recipe_like` (`recipe_id`, `user_id`) VALUES (3, 4);
COMMIT;
-- -----------------------------------------------------
-- Data for table `user_meetup`
-- -----------------------------------------------------
START TRANSACTION;
USE `recipemeetupdb`;
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (1, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (2, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (3, 5);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (7, 2);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (3, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (4, 1);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (5, 2);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (6, 2);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (4, 3);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (3, 3);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (5, 4);
INSERT INTO `user_meetup` (`user_id`, `meetup_id`) VALUES (6, 5);
COMMIT;
