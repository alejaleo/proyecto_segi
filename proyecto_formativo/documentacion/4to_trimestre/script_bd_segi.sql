-- MySQL Script generated by MySQL Workbench
-- Thu May  6 20:28:08 2021
-- Model: New Model    Version: 1.0
-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `mydb` DEFAULT CHARACTER SET utf8 ;
USE `mydb` ;

-- -----------------------------------------------------
-- Table `mydb`.`usuarios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`usuarios` (
  `idusuarios` INT NOT NULL,
  `contraseña` VARCHAR(45) NULL,
  `usuario` VARCHAR(45) NULL,
  `usuarioscol` VARCHAR(45) NULL,
  `rol` VARCHAR(45) NULL,
  PRIMARY KEY (`idusuarios`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`personas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`personas` (
  `idpersonas` INT NOT NULL,
  `primer_nombre` VARCHAR(45) NULL,
  `segundo_nombre` VARCHAR(45) NULL,
  `primer_apellido` VARCHAR(45) NULL,
  `segundo_apellido` VARCHAR(45) NULL,
  `telefono` VARCHAR(45) NULL,
  `celular` VARCHAR(45) NULL,
  `email` VARCHAR(45) NULL,
  `direccion` VARCHAR(45) NULL,
  `profesion` VARCHAR(45) NULL,
  `usuarios_idusuarios` INT NOT NULL,
  PRIMARY KEY (`idpersonas`, `usuarios_idusuarios`),
  INDEX `fk_personas_usuarios1_idx` (`usuarios_idusuarios` ASC) ,
  CONSTRAINT `fk_personas_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios`)
    REFERENCES `mydb`.`usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`casos_contables`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`casos_contables` (
  `idcasos_contables` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha_inicio` DATE NULL,
  `fecha_fin` DATE NULL,
  `personas_idpersonas` INT NOT NULL,
  PRIMARY KEY (`idcasos_contables`, `personas_idpersonas`),
  INDEX `fk_casos_contables_personas_idx` (`personas_idpersonas` ASC) ,
  CONSTRAINT `fk_casos_contables_personas`
    FOREIGN KEY (`personas_idpersonas`)
    REFERENCES `mydb`.`personas` (`idpersonas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`categorias`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`categorias` (
  `idcategorias` INT NOT NULL,
  `nombre_categoria` VARCHAR(45) NULL,
  PRIMARY KEY (`idcategorias`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`insumos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`insumos` (
  `idinsumos` INT NOT NULL,
  `nombre_insumo` VARCHAR(45) NULL,
  `personas_idpersonas` INT NOT NULL,
  `categorias_idcategorias` INT NOT NULL,
  PRIMARY KEY (`idinsumos`, `personas_idpersonas`, `categorias_idcategorias`),
  INDEX `fk_insumos_personas1_idx` (`personas_idpersonas` ASC) ,
  INDEX `fk_insumos_categorias1_idx` (`categorias_idcategorias` ASC) ,
  CONSTRAINT `fk_insumos_personas1`
    FOREIGN KEY (`personas_idpersonas`)
    REFERENCES `mydb`.`personas` (`idpersonas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_insumos_categorias1`
    FOREIGN KEY (`categorias_idcategorias`)
    REFERENCES `mydb`.`categorias` (`idcategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`peticiones`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`peticiones` (
  `idpeticiones` INT NOT NULL,
  `descriocion` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `usuarios_idusuarios` INT NOT NULL,
  `personas_idpersonas` INT NOT NULL,
  `personas_usuarios_idusuarios` INT NOT NULL,
  `insumos_idinsumos` INT NOT NULL,
  `insumos_personas_idpersonas` INT NOT NULL,
  `insumos_categorias_idcategorias` INT NOT NULL,
  PRIMARY KEY (`idpeticiones`, `usuarios_idusuarios`, `personas_idpersonas`, `personas_usuarios_idusuarios`, `insumos_idinsumos`, `insumos_personas_idpersonas`, `insumos_categorias_idcategorias`),
  INDEX `fk_peticiones_usuarios1_idx` (`usuarios_idusuarios` ASC) ,
  INDEX `fk_peticiones_personas1_idx` (`personas_idpersonas` ASC, `personas_usuarios_idusuarios` ASC) ,
  INDEX `fk_peticiones_insumos1_idx` (`insumos_idinsumos` ASC, `insumos_personas_idpersonas` ASC, `insumos_categorias_idcategorias` ASC) ,
  CONSTRAINT `fk_peticiones_usuarios1`
    FOREIGN KEY (`usuarios_idusuarios`)
    REFERENCES `mydb`.`usuarios` (`idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_peticiones_personas1`
    FOREIGN KEY (`personas_idpersonas` , `personas_usuarios_idusuarios`)
    REFERENCES `mydb`.`personas` (`idpersonas` , `usuarios_idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_peticiones_insumos1`
    FOREIGN KEY (`insumos_idinsumos` , `insumos_personas_idpersonas` , `insumos_categorias_idcategorias`)
    REFERENCES `mydb`.`insumos` (`idinsumos` , `personas_idpersonas` , `categorias_idcategorias`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `mydb`.`mantenimientos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `mydb`.`mantenimientos` (
  `idmantenimientos` INT NOT NULL,
  `descripcion` VARCHAR(45) NULL,
  `fecha` DATE NULL,
  `personas_idpersonas` INT NOT NULL,
  `peticiones_idpeticiones` INT NOT NULL,
  `peticiones_usuarios_idusuarios` INT NOT NULL,
  PRIMARY KEY (`idmantenimientos`, `personas_idpersonas`, `peticiones_idpeticiones`, `peticiones_usuarios_idusuarios`),
  INDEX `fk_mantenimientos_personas1_idx` (`personas_idpersonas` ASC) ,
  INDEX `fk_mantenimientos_peticiones1_idx` (`peticiones_idpeticiones` ASC, `peticiones_usuarios_idusuarios` ASC) ,
  CONSTRAINT `fk_mantenimientos_personas1`
    FOREIGN KEY (`personas_idpersonas`)
    REFERENCES `mydb`.`personas` (`idpersonas`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_mantenimientos_peticiones1`
    FOREIGN KEY (`peticiones_idpeticiones` , `peticiones_usuarios_idusuarios`)
    REFERENCES `mydb`.`peticiones` (`idpeticiones` , `usuarios_idusuarios`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;