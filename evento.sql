SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='TRADITIONAL,ALLOW_INVALID_DATES';

DROP SCHEMA IF EXISTS `evento` ;
CREATE SCHEMA IF NOT EXISTS `evento` DEFAULT CHARACTER SET latin1 COLLATE latin1_spanish_ci ;
USE `evento` ;

-- -----------------------------------------------------
-- Table `evento`.`asistente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evento`.`asistente` (
  `id_asistente` INT NOT NULL,
  `nombre` VARCHAR(45) NOT NULL,
  `apellido` VARCHAR(45) NOT NULL,
  `correo` VARCHAR(45) NOT NULL,
  `fecha_nacimiento` DATETIME NOT NULL,
  `cedula` VARCHAR(45) NOT NULL,
  `direccion` VARCHAR(45) NOT NULL,
  `telefono` VARCHAR(45) NOT NULL,
  `forma_de_pago` VARCHAR(6) NOT NULL,
  PRIMARY KEY (`id_asistente`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_asistente_UNIQUE` ON `evento`.`asistente` (`id_asistente` ASC);


-- -----------------------------------------------------
-- Table `evento`.`notificacion`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evento`.`notificacion` (
  `id_notificacion` INT NOT NULL,
  `correo` VARCHAR(20) NOT NULL,
  `fecha` DATETIME NOT NULL,
  `observacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_notificacion`))
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_notificacion_UNIQUE` ON `evento`.`notificacion` (`id_notificacion` ASC);


-- -----------------------------------------------------
-- Table `evento`.`reserva`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evento`.`reserva` (
  `id_reserva` VARCHAR(6) NOT NULL,
  `num_notificacion` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `observacion` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`id_reserva`),
  CONSTRAINT `num_notificacion`
    FOREIGN KEY (`num_notificacion`)
    REFERENCES `evento`.`notificacion` (`id_notificacion`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_reserva_UNIQUE` ON `evento`.`reserva` (`id_reserva` ASC);

CREATE INDEX `num_notificacion_idx` ON `evento`.`reserva` (`num_notificacion` ASC);


-- -----------------------------------------------------
-- Table `evento`.`pago`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `evento`.`pago` (
  `id_pago` VARCHAR(6) NOT NULL,
  `id_reserva` VARCHAR(6) NOT NULL,
  `asistente` INT NOT NULL,
  `fecha` DATETIME NOT NULL,
  `monto` DECIMAL(20) NOT NULL,
  `pagocol` VARCHAR(45) NOT NULL,
  `num_notificacion` INT NOT NULL,
  `correo` VARCHAR(20) NOT NULL,
  PRIMARY KEY (`id_pago`),
  CONSTRAINT `id_reserva`
    FOREIGN KEY (`id_reserva`)
    REFERENCES `evento`.`reserva` (`id_reserva`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `asistente`
    FOREIGN KEY (`asistente`)
    REFERENCES `evento`.`asistente` (`id_asistente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;

CREATE UNIQUE INDEX `id_pago_UNIQUE` ON `evento`.`pago` (`id_pago` ASC);

CREATE INDEX `asistente_idx` ON `evento`.`pago` (`asistente` ASC);

CREATE INDEX `id_reserva_idx` ON `evento`.`pago` (`id_reserva` ASC);


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
