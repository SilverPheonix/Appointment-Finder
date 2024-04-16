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
  `a_date` DATE NULL,
  `a_exdate` DATE NULL,
  PRIMARY KEY (`a_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Appointment-Finder`.`Option`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Appointment-Finder`.`Option` (
  `o_id` INT NOT NULL AUTO_INCREMENT,
  `o_date` DATE NULL,
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
-- Table `Appointment-Finder`.`Comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Appointment-Finder`.`Comment` (
  `c_id` INT NOT NULL AUTO_INCREMENT,
  `c_content` VARCHAR(125) NULL,
  `c_user` VARCHAR(45) NULL,
  `c_appointment` INT NOT NULL,
  PRIMARY KEY (`c_id`, `c_appointment`),
  INDEX `fk_Comment_Appointment1_idx` (`c_appointment` ASC),
  CONSTRAINT `fk_Comment_Appointment1`
    FOREIGN KEY (`c_appointment`)
    REFERENCES `Appointment-Finder`.`Appointment` (`a_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `Appointment-Finder`.`Selected`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `Appointment-Finder`.`Selected` (
  `s_id` INT NOT NULL AUTO_INCREMENT,
  `s_option` INT NOT NULL,
  `s_appointment` INT NOT NULL,
  `s_user` VARCHAR(45) NULL,
  PRIMARY KEY (`s_id`, `s_option`, `s_appointment`),
  INDEX `fk_Selected_Option1_idx` (`s_option` ASC, `s_appointment` ASC) ,
  CONSTRAINT `fk_Selected_Option1`
    FOREIGN KEY (`s_option` , `s_appointment`)
    REFERENCES `Appointment-Finder`.`Option` (`o_id` , `o_appointment`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
