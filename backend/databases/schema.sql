CREATE DATABASE IF NOT EXISTS taskflow
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

USE taskflow;

CREATE TABLE IF NOT EXISTS `user` (
  `id`    INT AUTO_INCREMENT PRIMARY KEY,
  `name`  VARCHAR(50) NOT NULL,
  `gmail` VARCHAR(50) NOT NULL UNIQUE,
  `pass`  VARCHAR(72) NOT NULL,
  `tel`   VARCHAR(15)
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `project` (
  `id`   INT AUTO_INCREMENT PRIMARY KEY,
  `name` VARCHAR(50) NOT NULL
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `member` (
  `id_member`  INT AUTO_INCREMENT PRIMARY KEY,
  `id_user`    INT NOT NULL,
  `id_project` INT NOT NULL,
  `rol`        ENUM('Admin', 'Member') NOT NULL,
  UNIQUE KEY `member_user_project` (`id_user`, `id_project`),
  FOREIGN KEY (`id_user`)    REFERENCES `user` (`id`)    ON DELETE CASCADE,
  FOREIGN KEY (`id_project`) REFERENCES `project` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB;

CREATE TABLE IF NOT EXISTS `task` (
  `id_task`       INT AUTO_INCREMENT PRIMARY KEY,
  `title`         VARCHAR(50) NOT NULL,
  `priority`      ENUM('urgent', 'high', 'medium', 'low') NOT NULL,
  `date_limit`    DATETIME NOT NULL,
  `id_creator`    INT NOT NULL,
  `date_creation` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `state`         ENUM('todo', 'inprogress', 'completed') NOT NULL,
  `id_assigned`   INT NULL,
  `description`   VARCHAR(300),
  `id_project`    INT NOT NULL,
  FOREIGN KEY (`id_creator`)  REFERENCES `member` (`id_member`) ON DELETE CASCADE,
  FOREIGN KEY (`id_assigned`) REFERENCES `member` (`id_member`) ON DELETE SET NULL,
  FOREIGN KEY (`id_project`)  REFERENCES `project` (`id`)       ON DELETE CASCADE
) ENGINE=InnoDB;