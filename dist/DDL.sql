-- MySQL Script generated by MySQL Workbench
-- Tue Jun 10 08:34:07 2025
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema hopi_hari_db
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS hopi_hari_db ;

-- -----------------------------------------------------
-- Schema hopi_hari_db
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS hopi_hari_db DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci ;
USE hopi_hari_db ;

-- -----------------------------------------------------
-- Table hopi_hari_db.areas
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS hopi_hari_db.areas (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(45) NOT NULL,
  PRIMARY KEY (id))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table hopi_hari_db.rides
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS hopi_hari_db.rides (
  id INT NOT NULL AUTO_INCREMENT,
  name VARCHAR(100) NOT NULL,
  waiting_time INT NOT NULL,
  status VARCHAR(50) NOT NULL,
  id_areas INT NOT NULL,
  image VARCHAR(3000) NULL,
  PRIMARY KEY (id, id_areas),
  INDEX fk_rides_areas1_idx (id_areas ASC) VISIBLE,
  CONSTRAINT fk_rides_areas1
    FOREIGN KEY (id_areas)
    REFERENCES hopi_hari_db.areas (id))
ENGINE = InnoDB
AUTO_INCREMENT = 51
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table hopi_hari_db.users
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS hopi_hari_db.users (
  id INT NOT NULL AUTO_INCREMENT,
  first_name VARCHAR(50) NOT NULL,
  last_name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL,
  password VARCHAR(255) NOT NULL,
  birth_date DATE NOT NULL,
  phone VARCHAR(20) NULL DEFAULT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  updated_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (id),
  UNIQUE INDEX email (email ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table hopi_hari_db.lines
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS hopi_hari_db.lines (
  id_ride INT NOT NULL,
  id_user INT NOT NULL,
  created_at TIMESTAMP NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (id_ride, id_user),
  INDEX fk_rides_has_users_users1_idx (id_user ASC) VISIBLE,
  INDEX fk_rides_has_users_rides_idx (id_ride ASC) VISIBLE,
  CONSTRAINT fk_rides_has_users_rides
    FOREIGN KEY (id_ride)
    REFERENCES hopi_hari_db.rides (id),
  CONSTRAINT fk_rides_has_users_users1
    FOREIGN KEY (id_user)
    REFERENCES hopi_hari_db.users (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;


-- -----------------------------------------------------
-- Table hopi_hari_db.notifications
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS hopi_hari_db.notifications (
  id INT NOT NULL AUTO_INCREMENT,
  description VARCHAR(200) NOT NULL,
  id_rides INT NOT NULL,
  id_user INT NOT NULL,
  status TINYINT NOT NULL,
  PRIMARY KEY (id),
  INDEX fk_notifications_rides1_idx (id_rides ASC) VISIBLE,
  INDEX fk_notifications_users1_idx (id_user ASC) VISIBLE,
  CONSTRAINT fk_notifications_rides1
    FOREIGN KEY (id_rides)
    REFERENCES hopi_hari_db.rides (id),
  CONSTRAINT fk_notifications_users1
    FOREIGN KEY (id_user)
    REFERENCES hopi_hari_db.users (id))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_unicode_ci;

USE hopi_hari_db;

DELIMITER $$
USE hopi_hari_db$$
CREATE
DEFINER=root@localhost
TRIGGER hopi_hari_db.after_insert_lines
AFTER INSERT ON hopi_hari_db.lines
FOR EACH ROW
BEGIN
      DECLARE wait_time INT;
        DECLARE line_count INT;
        DECLARE total_wait INT;
                    
        SELECT waiting_time INTO wait_time
          FROM rides
     WHERE id = NEW.id_ride;
            
    SELECT COUNT(id_user) INTO line_count
          FROM hopi_hari_db.lines
     WHERE id_ride = NEW.id_ride;
                
         SET total_wait = wait_time * line_count;
         
         INSERT INTO notifications (description, id_rides, id_user, status)
     VALUES (CONCAT(total_wait, " minuto(s) de espera para o brinquedo" ), NEW.id_ride, NEW.id_user, TRUE);
  END$$


DELIMITER ;

SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
use hopi_hari_db;
INSERT INTO areas (name) VALUES 
("Kaminda"),
("Wild West"),
("Infantasia"),
("Aribabiba"),
("Mistieri");


-- Cine 180 - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Cine 180", 2, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Espetáculo de Rua - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Espetáculo de Rua", 0, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Infocentro - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Infocentro", 0, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Ghosti Hotel - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Ghosti Hotel", 4, "Aberto",  (SELECT id FROM areas WHERE name = "Wild West"));

-- Saloon Show - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Saloon Show", 0, "Aberto",  (SELECT id FROM areas WHERE name = "Wild West"));

-- Carrossel di Billie - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Carrossel di Billie", 2, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Hora do Horror Kids - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Hora do Horror Kids", 1, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Super Heroi Show - Aribabiba
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Super Herói Show", 0, "Aberto", (SELECT id FROM areas WHERE name = "Aribabiba"));

-- The Looney Tunes Show - Aribabiba (antigo show temático)
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("The Looney Tunes Show", 0, "Fechado", (SELECT id FROM areas WHERE name = "Aribabiba"));

-- Cine 180 - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Cine 180", 2, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Espetáculo de Rua - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Espetáculo de Rua", 0, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Infocentro - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Infocentro", 0, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Ghosti Hotel - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Ghosti Hotel", 4, "Aberto",  (SELECT id FROM areas WHERE name = "Wild West"));

-- Saloon Show - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Saloon Show", 0, "Aberto",  (SELECT id FROM areas WHERE name = "Wild West"));

-- Carrossel di Billie - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Carrossel di Billie", 2, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Hora do Horror Kids - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Hora do Horror Kids", 1, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Cine 180 - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Cine 180", 2, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Espetáculo de Rua - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Espetáculo de Rua", 0, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Infocentro - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Infocentro", 0, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Ghosti Hotel - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Ghosti Hotel", 4, "Aberto", (SELECT id FROM areas WHERE name = "Wild West"));

-- Saloon Show - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Saloon Show", 0, "Aberto", (SELECT id FROM areas WHERE name = "Wild West"));

-- Evolution - Mistieri
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Evolution", 6, "Aberto", (SELECT id FROM areas WHERE name = "Mistieri"));

-- Simulákron - Mistieri
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Simulákron", 4, "Aberto", (SELECT id FROM areas WHERE name = "Mistieri"));

-- Theatro di Kaminda - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Theatro di Kaminda", 2, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Eléktron - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Eléktron", 5, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Trukes di Kaminda - Kaminda
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Trukes di Kaminda", 3, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Kastel di Lendas - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Kastel di Lendas", 4, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Minimontanha - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Minimontanha", 2, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Trenzinho - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Trenzinho", 1, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Crazy Wagon - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Crazy Wagon", 6, "Aberto", (SELECT id FROM areas WHERE name = "Wild West"));

-- Old West - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Old West", 2, "Aberto", (SELECT id FROM areas WHERE name = "Wild West"));

-- Vambatê - Aribabiba
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Vambatê", 3, "Aberto", (SELECT id FROM areas WHERE name = "Aribabiba"));

-- Toka di Urso - Aribabiba
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Toka di Urso", 2, "Aberto", (SELECT id FROM areas WHERE name = "Aribabiba"));
 use hopi_hari_db;

-- Montezum - Mistieri
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Montezum", 5, "Aberto", (SELECT id FROM areas WHERE name = "Mistieri"));

-- Ekatomb - Mistieri
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Ekatomb", 10, "Aberto", (SELECT id FROM areas WHERE name = "Mistieri"));

-- Katakumb - Mistieri
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Katakumb", 7, "Aberto", (SELECT id FROM areas WHERE name = "Mistieri"));

-- Rio Bravo - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Rio Bravo", 15, "Aberto", (SELECT id FROM areas WHERE name = "Wild West"));

-- West River Hotel - Wild West
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("West River Hotel", 3, "Aberto", (SELECT id FROM areas WHERE name = "Wild West"));

-- La Tour Eiffel - Aribabiba
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("La Tour Eiffel", 12, "Aberto", (SELECT id FROM areas WHERE name = "Aribabiba"));

-- Vurang - Mistieri
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Vurang", 8, "Aberto", (SELECT id FROM areas WHERE name = "Mistieri"));

-- Giranda Mundi - Kaminda (corrigido)
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Giranda Mundi", 5, "Aberto", (SELECT id FROM areas WHERE name = "Kaminda"));

-- Speedi Kid - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Speedi Kid", 2, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

-- Doremí - Infantasia
INSERT INTO rides(name, waiting_time, status, id_areas)
VALUES ("Doremí", 3, "Aberto", (SELECT id FROM areas WHERE name = "Infantasia"));

USE hopi_hari_db;

-- Atrações com imagens próprias
UPDATE rides SET image = 'atronavi.jpg' WHERE name = 'Atronavi';
UPDATE rides SET image = 'bugabalum.jpg' WHERE name = 'Bugabalum';
UPDATE rides SET image = 'dispenkito.jpg' WHERE name = 'Dispenkito';
UPDATE rides SET image = 'ekatomb.jpg' WHERE name = 'Ekatomb';
UPDATE rides SET image = 'evolution.jpg' WHERE name = 'Evolution';
UPDATE rides SET image = 'giralata.jpg' WHERE name = 'Giralata';
UPDATE rides SET image = 'girandaMundi.jpg' WHERE name = 'Giranda Mundi';
UPDATE rides SET image = 'granPalaz.jpg' WHERE name = 'Gran Palaz';
UPDATE rides SET image = 'hadikali.jpg' WHERE name = 'Hadikali';
UPDATE rides SET image = 'jogaki.jpg' WHERE name = 'Jogakí';
UPDATE rides SET image = 'kastel.jpg' WHERE name = 'Kastel di Lendas';
UPDATE rides SET image = 'katakumb.jpg' WHERE name = 'Katakumb';
UPDATE rides SET image = 'katapul.jpg' WHERE name = 'Katapul';
UPDATE rides SET image = 'klapi.jpg' WHERE name = 'Klapi Klapi';
UPDATE rides SET image = 'Le Voyage.jpg' WHERE name = 'Le Voyage';
UPDATE rides SET image = 'Montezum.jpg' WHERE name = 'Montezum';
UPDATE rides SET image = 'Parangolé.jpg' WHERE name = 'Parangolé';
UPDATE rides SET image = 'pokoto.jpg' WHERE name = 'Pokoto';
UPDATE rides SET image = 'Rango-DJango.jpg' WHERE name = 'Rango-Django';
UPDATE rides SET image = 'Rio Bravo.jpg' WHERE name = 'Rio Bravo';
UPDATE rides SET image = 'saloon.jpg' WHERE name = 'Saloon';
UPDATE rides SET image = 'simlakron.jpg' WHERE name = 'Simulákron';
UPDATE rides SET image = 'spleshi.jpg' WHERE name = 'Spleshi';
UPDATE rides SET image = 'theatro.jpg' WHERE name = 'Theatro di Kaminda';
UPDATE rides SET image = 'toka.jpg' WHERE name = 'Toka di Urso';
UPDATE rides SET image = 'vambate.jpg' WHERE name = 'Vambatê';
UPDATE rides SET image = 'vulaviking.jpg' WHERE name = 'Vulaviking';
UPDATE rides SET image = 'vurang.jpg' WHERE name = 'Vurang';

-- Reutilização de imagens SEM repetir uma mesma imagem para mais de uma atração

UPDATE rides SET image = 'kastel.jpg' WHERE name = 'Cine 180';
UPDATE rides SET image = 'granPalaz.jpg' WHERE name = 'Espetáculo de Rua';
UPDATE rides SET image = 'klapi.jpg' WHERE name = 'Infocentro';
UPDATE rides SET image = 'theatro.jpg' WHERE name = 'Ghosti Hotel';
UPDATE rides SET image = 'vambate.jpg' WHERE name = 'Saloon Show';
UPDATE rides SET image = 'Le Voyage.jpg' WHERE name = 'Carrossel di Billie';
UPDATE rides SET image = 'bugabalum.jpg' WHERE name = 'Hora do Horror Kids';
UPDATE rides SET image = 'pokoto.jpg' WHERE name = 'Super Herói Show';
UPDATE rides SET image = 'jogaki.jpg' WHERE name = 'The Looney Tunes Show';
UPDATE rides SET image = 'katapul.jpg' WHERE name = 'Trukes di Kaminda';
UPDATE rides SET image = 'parangolé.jpg' WHERE name = 'Minimontanha';
UPDATE rides SET image = 'dispenkito.jpg' WHERE name = 'Trenzinho';
UPDATE rides SET image = 'ekatomb.jpg' WHERE name = 'Crazy Wagon';
UPDATE rides SET image = 'giralata.jpg' WHERE name = 'Old West';
UPDATE rides SET image = 'girandaMundi.jpg' WHERE name = 'West River Hotel';
UPDATE rides SET image = 'saloon.jpg' WHERE name = 'La Tour Eiffel';

-- Atrações extras já com imagens válidas
UPDATE rides SET image = 'Rango-DJango.jpg' WHERE name = 'Speedi Kid';
UPDATE rides SET image = 'jogaki.jpg' WHERE name = 'Doremí';
