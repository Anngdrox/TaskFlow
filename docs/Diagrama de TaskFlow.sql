CREATE TABLE `user` (
  `id` int PRIMARY KEY,
  `name` varchar(50) NOT NULL,
  `gmail` varchar(50) UNIQUE NOT NULL,
  `pass` varchar(72) NOT NULL,
  `tel` varchar(15)
);

CREATE TABLE `member` (
  `id_member` int PRIMARY KEY,
  `id_user` int NOT NULL,
  `rol` ENUM ('Admin', 'Member') NOT NULL,
  `id_project` int NOT NULL
);

CREATE TABLE `project` (
  `id` int PRIMARY KEY,
  `name` varchar(50) NOT NULL
);

CREATE TABLE `task` (
  `id_task` int PRIMARY KEY,
  `title` varchar(50) NOT NULL,
  `priority` ENUM ('urgent', 'high', 'medium', 'low') NOT NULL,
  `date_limit` timestamp NOT NULL,
  `id_creator` int NOT NULL,
  `date_creation` timestamp NOT NULL DEFAULT (now()),
  `state` ENUM ('todo', 'completed', 'inprogress') NOT NULL,
  `id_assigned` int,
  `description` varchar(300),
  `id_project` int NOT NULL
);

CREATE UNIQUE INDEX `member_index_0` ON `member` (`id_user`, `id_project`);

ALTER TABLE `member` ADD FOREIGN KEY (`id_user`) REFERENCES `user` (`id`);

ALTER TABLE `member` ADD FOREIGN KEY (`id_project`) REFERENCES `project` (`id`);

ALTER TABLE `task` ADD FOREIGN KEY (`id_creator`) REFERENCES `member` (`id_member`);

ALTER TABLE `task` ADD FOREIGN KEY (`id_assigned`) REFERENCES `member` (`id_member`);

ALTER TABLE `task` ADD FOREIGN KEY (`id_project`) REFERENCES `project` (`id`);
