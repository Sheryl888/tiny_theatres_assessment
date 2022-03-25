-- MySQL Script generated by MySQL Workbench
-- Tue Mar 22 12:06:17 2022
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema tiny_theatre_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `tiny_theatre_db` ;

-- -----------------------------------------------------
-- Schema tiny_theatre_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `tiny_theatre_db` DEFAULT CHARACTER SET utf8 ;
USE `tiny_theatre_db` ;

-- -----------------------------------------------------
-- Table `tiny_theatre_db`.`customer`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tiny_theatre_db`.`customer` ;

CREATE TABLE IF NOT EXISTS `tiny_theatre_db`.`customer` (
  `customer_id` INT NOT NULL AUTO_INCREMENT,
  `first_name` VARCHAR(45) NOT NULL,
  `last_name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(150) NULL,
  `phone` VARCHAR(15) NULL,
  `email` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`customer_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiny_theatre_db`.`theatre`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tiny_theatre_db`.`theatre` ;

CREATE TABLE IF NOT EXISTS `tiny_theatre_db`.`theatre` (
  `theatre_id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `address` VARCHAR(145) NOT NULL,
  `phone` VARCHAR(15) NOT NULL,
  `email` VARCHAR(100) NOT NULL,
  PRIMARY KEY (`theatre_id`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiny_theatre_db`.`show`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tiny_theatre_db`.`show` ;

CREATE TABLE IF NOT EXISTS `tiny_theatre_db`.`show` (
  `show_id` INT NOT NULL AUTO_INCREMENT,
  `show_title` VARCHAR(100) NOT NULL,
  `show_date` DATETIME NOT NULL,
  `theatre_theatre_id` INT NOT NULL,
  PRIMARY KEY (`show_id`),
  INDEX `fk_show_theatre1_idx` (`theatre_theatre_id` ASC) VISIBLE,
  CONSTRAINT `fk_show_theatre1`
    FOREIGN KEY (`theatre_theatre_id`)
    REFERENCES `tiny_theatre_db`.`theatre` (`theatre_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `tiny_theatre_db`.`tickets`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `tiny_theatre_db`.`tickets` ;

CREATE TABLE IF NOT EXISTS `tiny_theatre_db`.`tickets` (
  `ticket_id` INT NOT NULL AUTO_INCREMENT,
  `seat` VARCHAR(5) NOT NULL,
  `ticket_price` DOUBLE NOT NULL,
  `customer_customer_id` INT NOT NULL,
  `show_show_id` INT NOT NULL,
  PRIMARY KEY (`ticket_id`),
  INDEX `fk_tickets_customer1_idx` (`customer_customer_id` ASC) VISIBLE,
  INDEX `fk_tickets_show1_idx` (`show_show_id` ASC) VISIBLE,
  CONSTRAINT `fk_tickets_customer1`
    FOREIGN KEY (`customer_customer_id`)
    REFERENCES `tiny_theatre_db`.`customer` (`customer_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_tickets_show1`
    FOREIGN KEY (`show_show_id`)
    REFERENCES `tiny_theatre_db`.`show` (`show_id`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
