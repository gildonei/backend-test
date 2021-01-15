-- MySQL Workbench Synchronization
-- Generated: 2021-01-14 21:53
-- Model: New Model
-- Version: 1.0
-- Project: Name of the project
-- Author: Junior

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

CREATE TABLE IF NOT EXISTS `socialrocker`.`regions` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  ` name` VARCHAR(100) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_idx` (` name` ASC),
  INDEX `active_idx` (`active` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`events` (
  `id` INT(11) UNSIGNED NOT NULL,
  `region_id` INT(11) UNSIGNED NOT NULL,
  `start` DATETIME NOT NULL,
  `end` DATETIME NOT NULL,
  `startdisplay` DATETIME NULL DEFAULT NULL,
  `enddisplay` DATETIME NULL DEFAULT NULL,
  `description` TEXT NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `region_id_events_idx` (`region_id` ASC),
  INDEX `start` (`start` ASC),
  INDEX `startdisplay` (`startdisplay` ASC),
  CONSTRAINT `region_id_events`
    FOREIGN KEY (`region_id`)
    REFERENCES `socialrocker`.`regions` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `content_id_events`
    FOREIGN KEY (`id`)
    REFERENCES `socialrocker`.`contents` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`people` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` INT(11) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `name_idx` (`name` ASC),
  INDEX `active_idx` (`active` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`registrations` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` INT(11) UNSIGNED NOT NULL,
  `person_id` INT(11) UNSIGNED NOT NULL,
  `registered` DATETIME NOT NULL,
  `token` VARCHAR(45) NOT NULL,
  `confirmed` DATETIME NULL DEFAULT NULL,
  `description` VARCHAR(400) NOT NULL,
  `place` VARCHAR(100) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `event_id_registrations_idx` (`event_id` ASC),
  INDEX `person_id_registrations_idx` (`person_id` ASC),
  INDEX `active_idx` (`active` ASC),
  UNIQUE INDEX `token_idx` (`token` ASC),
  INDEX `confirmed` (`confirmed` ASC),
  INDEX `registered` (`registered` ASC),
  CONSTRAINT `event_id_registrations`
    FOREIGN KEY (`event_id`)
    REFERENCES `socialrocker`.`events` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `person_id_registrations`
    FOREIGN KEY (`person_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`users` (
  `id` INT(11) UNSIGNED NOT NULL,
  `login` VARCHAR(255) NOT NULL,
  `pswd` VARCHAR(45) NOT NULL,
  `token` VARCHAR(45) NULL DEFAULT NULL,
  `expires` DATETIME NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `login_idx` (`login` ASC),
  UNIQUE INDEX `token_idx` (`token` ASC),
  CONSTRAINT `person_id_users`
    FOREIGN KEY (`id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`emails` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_id` INT(11) UNSIGNED NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `newsletter` TINYINT(1) UNSIGNED NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `person_id_emails_idx` (`person_id` ASC),
  UNIQUE INDEX `email_idx` (`person_id` ASC, `email` ASC),
  INDEX `active_idx` (`active` ASC),
  INDEX `newsletter_idx` (`newsletter` ASC),
  CONSTRAINT `person_id_emails`
    FOREIGN KEY (`person_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`contents` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(100) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `name_idx` (`name` ASC),
  INDEX `active_idx` (`active` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`midias` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `midiatype_id` INT(11) UNSIGNED NOT NULL,
  `name` VARCHAR(100) NOT NULL,
  `address` VARCHAR(255) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `midiatype_id_midias_idx` (`midiatype_id` ASC),
  INDEX `name_idx` (`name` ASC),
  INDEX `active_idx` (`active` ASC),
  CONSTRAINT `midiatype_id_midias`
    FOREIGN KEY (`midiatype_id`)
    REFERENCES `socialrocker`.`midiatypes` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`contents_midias` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `content_id` INT(11) UNSIGNED NOT NULL,
  `midia_id` INT(11) UNSIGNED NOT NULL,
  `cover` TINYINT(1) UNSIGNED NOT NULL,
  `public` TINYINT(1) UNSIGNED NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `content_id_contents_midias_idx` (`content_id` ASC),
  INDEX `midia_id_contents_midias_idx` (`midia_id` ASC),
  INDEX `public_idx` (`public` ASC),
  INDEX `cover_idx` (`cover` ASC),
  INDEX `active_idx` (`active` ASC),
  CONSTRAINT `content_id_contents_midias`
    FOREIGN KEY (`content_id`)
    REFERENCES `socialrocker`.`contents` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `midia_id_contents_midias`
    FOREIGN KEY (`midia_id`)
    REFERENCES `socialrocker`.`midias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`midiatypes` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_idx` (`name` ASC),
  INDEX `active_idx` (`active` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`phones` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_id` INT(11) UNSIGNED NOT NULL,
  `countrycode` CHAR(2) NOT NULL,
  `areacode` VARCHAR(3) NOT NULL,
  `number` VARCHAR(15) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `person_id_phones_idx` (`person_id` ASC),
  INDEX `active_idx` (`active` ASC),
  INDEX `countrycode_idx` (`countrycode` ASC),
  INDEX `areacode_idx` (`areacode` ASC),
  UNIQUE INDEX `phone_idx` (`person_id` ASC, `number` ASC),
  CONSTRAINT `person_id_phones`
    FOREIGN KEY (`person_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`people_midias` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_id` INT(11) UNSIGNED NOT NULL,
  `midia_id` INT(11) UNSIGNED NOT NULL,
  `cover` TINYINT(1) UNSIGNED NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `person_id_people_midias_idx` (`person_id` ASC),
  INDEX `midia_id_people_midias_idx` (`midia_id` ASC),
  INDEX `active_idx` (`active` ASC),
  INDEX `cover_idx` (`cover` ASC),
  CONSTRAINT `person_id_people_midias`
    FOREIGN KEY (`person_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `midia_id_people_midias`
    FOREIGN KEY (`midia_id`)
    REFERENCES `socialrocker`.`midias` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`friends` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `person_id` INT(11) UNSIGNED NOT NULL,
  `friend_id` INT(11) UNSIGNED NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `person_id_friends_idx` (`person_id` ASC),
  INDEX `friend_id_friends_idx` (`friend_id` ASC),
  CONSTRAINT `person_id_friends`
    FOREIGN KEY (`person_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `friend_id_friends`
    FOREIGN KEY (`friend_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`naturalperson` (
  `id` INT(11) UNSIGNED NOT NULL,
  `document` VARCHAR(45) NOT NULL,
  `birth` DATE NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `document_idx` (`document` ASC),
  CONSTRAINT `person_id_naturalperson`
    FOREIGN KEY (`id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`legalperson` (
  `id` INT(11) UNSIGNED NOT NULL,
  `document` VARCHAR(45) NOT NULL,
  `foundation` DATE NULL DEFAULT NULL,
  UNIQUE INDEX `document_idx` (`document` ASC),
  PRIMARY KEY (`id`),
  CONSTRAINT `person_id_legalperson`
    FOREIGN KEY (`id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`invitestatus` (
  `id` INT(11) UNSIGNED NOT NULL,
  `name` VARCHAR(45) NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE INDEX `name_idx` (`name` ASC),
  INDEX `active_idx` (`active` ASC))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`invites` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `status_id` INT(11) UNSIGNED NOT NULL,
  `token` VARCHAR(45) NOT NULL,
  `expires` TINYINT(1) UNSIGNED NOT NULL,
  `expiration` DATETIME NULL DEFAULT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `status_id_invites_idx` (`status_id` ASC),
  UNIQUE INDEX `token_idx` (`token` ASC),
  INDEX `active` (`active` ASC),
  INDEX `expires_idx` (`expires` ASC),
  CONSTRAINT `status_id_invites`
    FOREIGN KEY (`status_id`)
    REFERENCES `socialrocker`.`invitestatus` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`events_invites` (
  `id` INT(11) UNSIGNED NOT NULL AUTO_INCREMENT,
  `event_id` INT(11) UNSIGNED NOT NULL,
  `invite_id` INT(11) UNSIGNED NOT NULL,
  `person_id` INT(11) UNSIGNED NOT NULL,
  `friend_id` INT(11) UNSIGNED NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `event_id_events_invites_idx` (`event_id` ASC),
  INDEX `invite_id_events_invites_idx` (`invite_id` ASC),
  INDEX `person_id_events_invites_idx` (`person_id` ASC),
  INDEX `friend_id_events_invites_idx` (`friend_id` ASC),
  INDEX `active_idx` (`active` ASC),
  CONSTRAINT `event_id_events_invites`
    FOREIGN KEY (`event_id`)
    REFERENCES `socialrocker`.`events` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `invite_id_events_invites`
    FOREIGN KEY (`invite_id`)
    REFERENCES `socialrocker`.`invites` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `person_id_events_invites`
    FOREIGN KEY (`person_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `friend_id_events_invites`
    FOREIGN KEY (`friend_id`)
    REFERENCES `socialrocker`.`friends` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;

CREATE TABLE IF NOT EXISTS `socialrocker`.`friendshipinvites` (
  `id` INT(11) UNSIGNED NOT NULL,
  `person_id` INT(11) UNSIGNED NOT NULL,
  `invite_id` INT(11) UNSIGNED NOT NULL,
  `active` TINYINT(1) UNSIGNED NOT NULL,
  `created` DATETIME NOT NULL,
  `modified` DATETIME NOT NULL,
  `creator_id` INT(11) UNSIGNED NOT NULL,
  `modifier_id` INT(11) UNSIGNED NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `person_id_friendshipinvites_idx` (`person_id` ASC),
  INDEX `invite_id_friendshipinvites_idx` (`invite_id` ASC),
  INDEX `active_idx` (`active` ASC),
  CONSTRAINT `person_id_friendshipinvites`
    FOREIGN KEY (`person_id`)
    REFERENCES `socialrocker`.`people` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE,
  CONSTRAINT `invite_id_friendshipinvites`
    FOREIGN KEY (`invite_id`)
    REFERENCES `socialrocker`.`invites` (`id`)
    ON DELETE RESTRICT
    ON UPDATE CASCADE)
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
