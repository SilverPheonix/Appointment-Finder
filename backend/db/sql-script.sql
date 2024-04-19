-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema Appointment-Finder
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema Appointment-Finder
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `Appointment-Finder` DEFAULT CHARACTER SET utf8 ;
USE `Appointment-Finder` ;

-- -----------------------------------------------------
-- Table `Appointment-Finder`.`Appointment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Appointment-Finder`.`Appointment` (
  `a_id` INT NOT NULL AUTO_INCREMENT,
  `a_title` VARCHAR(45) NULL,
  `a_place` VARCHAR(45) NULL,
  `a_exdate` DATE NULL,
  PRIMARY KEY (`a_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Appointment-Finder`.`Option`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Appointment-Finder`.`Option` (
  `o_id` INT NOT NULL AUTO_INCREMENT,
  `o_date` DATE NULL,
  `o_from` TIME NULL,
  `o_to` TIME NULL,
  `o_appointment` INT NOT NULL,
  PRIMARY KEY (`o_id`, `o_appointment`),
  INDEX `fk_Options_Appointment_idx` (`o_appointment` ASC),
  CONSTRAINT `fk_Options_Appointment`
    FOREIGN KEY (`o_appointment`)
    REFERENCES `Appointment-Finder`.`Appointment` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

-- -----------------------------------------------------
-- Table `appointment-finder`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appointment-finder`.`user` (
  `u_id` INT NOT NULL AUTO_INCREMENT,
  `u_name` VARCHAR(45) NULL,
  PRIMARY KEY (`u_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `appointment-finder`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appointment-finder`.`comment` (
  `c_id` INT(11) NOT NULL AUTO_INCREMENT,
  `c_content` VARCHAR(125) NULL DEFAULT NULL,
  `c_appointment` INT(11) NOT NULL,
  `c_user` INT NOT NULL,
  PRIMARY KEY (`c_id`, `c_appointment`),
  INDEX `fk_Comment_Appointment1_idx` (`c_appointment` ASC),
  INDEX `fk_comment_user1_idx` (`c_user` ASC),
  CONSTRAINT `fk_Comment_Appointment1`
    FOREIGN KEY (`c_appointment`)
    REFERENCES `appointment-finder`.`appointment` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_comment_user1`
    FOREIGN KEY (`c_user`)
    REFERENCES `appointment-finder`.`user` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 11
DEFAULT CHARACTER SET = utf8;

-- -----------------------------------------------------
-- Table `appointment-finder`.`selected`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `appointment-finder`.`selected` (
  `s_id` INT(11) NOT NULL AUTO_INCREMENT,
  `s_option` INT(11) NOT NULL,
  `s_appointment` INT(11) NOT NULL,
  `s_value` TINYINT(4) NULL DEFAULT NULL,
  `s_user` INT NOT NULL,
  PRIMARY KEY (`s_id`, `s_option`, `s_appointment`),
  INDEX `fk_Selected_Option1_idx` (`s_option` ASC, `s_appointment` ASC),
  INDEX `fk_selected_user1_idx` (`s_user` ASC),
  CONSTRAINT `fk_Selected_Option1`
    FOREIGN KEY (`s_option` , `s_appointment`)
    REFERENCES `appointment-finder`.`option` (`o_id` , `o_appointment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_selected_user1`
    FOREIGN KEY (`s_user`)
    REFERENCES `appointment-finder`.`user` (`u_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 57
DEFAULT CHARACTER SET = utf8;

INSERT INTO `Appointment-Finder`.`Appointment`(`a_title`,`a_place`, `a_exdate`) VALUES ('Mathe Tutorium','FH Technikum','2024-05-30');
INSERT INTO `Appointment-Finder`.`Appointment`(`a_title`,`a_place`, `a_exdate`) VALUES ('Klassentreffen','Prater','2024-06-03');
INSERT INTO `Appointment-Finder`.`Appointment`(`a_title`,`a_place`, `a_exdate`) VALUES ('Bubble Tea','Mariahilferstraße','2024-04-27');

INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-06-01','16:00','18:00', 1);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-06-01','15:00','17:00', 1);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-06-01','9:00','11:00', 1);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-06-02','13:00','15:00', 1);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-06-07','13:30','19:00', 2);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-06-08','13:30','19:00', 2);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-06-09','13:30','19:00', 2);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-04-29','13:30','14:30', 3);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-04-29','17:30','18:30', 3);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-05-01','13:30','14:30', 3);
INSERT INTO `Appointment-Finder`.`Option`(`o_date`,`o_from`, `o_to`,`o_appointment`) VALUES ('2024-05-02','13:30','14:30', 3);


INSERT INTO `Appointment-Finder`.`User`(`u_name`) VALUES ('Emma');
INSERT INTO `Appointment-Finder`.`User`(`u_name`) VALUES ('Marie');
INSERT INTO `Appointment-Finder`.`User`(`u_name`) VALUES ('Stefan');
INSERT INTO `Appointment-Finder`.`User`(`u_name`) VALUES ('Ava');
INSERT INTO `Appointment-Finder`.`User`(`u_name`) VALUES ('Fiona');
INSERT INTO `Appointment-Finder`.`User`(`u_name`) VALUES ('Karola');
INSERT INTO `Appointment-Finder`.`User`(`u_name`) VALUES ('Toni');

INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,1,1, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,2,1, 0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,3,1, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,4,1, 0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,1,2, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,2,2, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,3,2, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (1,4,2, 0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (2,5,3, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (2,6,3, 0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (2,7,3, 0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (2,5,4, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (2,6,4, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (2,7,4, 1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,8,5,0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,9,5,0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,10,5,1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,11,5,1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,8,6,0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,9,6,1);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,10,6,0);
INSERT INTO `Appointment-Finder`.`Selected`(`s_appointment`,`s_option`,`s_user`, `s_value`) VALUES (3,11,6,1);

INSERT INTO `Appointment-Finder`.`Comment`(`c_content`,`c_appointment`,`c_user`) VALUES ('Wo würden wir dann essen?',1,2);
INSERT INTO `Appointment-Finder`.`Comment`(`c_content`,`c_appointment`,`c_user`) VALUES ('Kommt auch unser Klassenvorstand?',2,7);
INSERT INTO `Appointment-Finder`.`Comment`(`c_content`,`c_appointment`,`c_user`) VALUES ('Treffen wir uns bei der U-Bahn?',2,7);
INSERT INTO `Appointment-Finder`.`Comment`(`c_content`,`c_appointment`,`c_user`) VALUES ('Nice!',3,6);

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
