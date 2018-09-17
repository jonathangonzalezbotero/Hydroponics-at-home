-- -----------------------------------------------------
-- Schema hidroponia
-- -----------------------------------------------------
DROP SCHEMA IF EXISTS `hidroponia` ;

-- -----------------------------------------------------
-- Schema hidroponia
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `hidroponia` DEFAULT CHARACTER SET utf8 ;
USE `hidroponia` ;

-- -----------------------------------------------------
-- Table `hidroponia`.`Users`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Users` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Users` (
  `id_person` INT NOT NULL,
  `type_ID` VARCHAR(3) NOT NULL,
  `first_name` VARCHAR(70) NULL,
  `last_name` VARCHAR(45) NULL,
  `telephone` INT NULL,
  `address` VARCHAR(50) NULL,
  `email` VARCHAR(50) NULL,
  `username` VARCHAR(50) NULL,
  `password` VARCHAR(50) NULL,
  `image` LONGBLOB NULL,
  `role` VARCHAR(15) NULL COMMENT 'Consumidor o Cultivador',
  PRIMARY KEY (`id_person`, `type_ID`))
ENGINE = InnoDB
COMMENT = 'Tabla maestra de personas';


-- -----------------------------------------------------
-- Table `hidroponia`.`Categories`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Categories` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Categories` (
  `id_category` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `description` VARCHAR(500) NULL,
  PRIMARY KEY (`id_category`))
ENGINE = InnoDB
COMMENT = 'Se indican las categorias de los productos hidroponicos';


-- -----------------------------------------------------
-- Table `hidroponia`.`Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Products` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Products` (
  `id_product` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(50) NULL,
  `description` VARCHAR(500) NULL,
  `price` DECIMAL(10) NULL,
  `image` LONGBLOB NULL,
  `id_category` INT NOT NULL,
  PRIMARY KEY (`id_product`),
  INDEX `fk_Producto_Categoria1_idx` (`id_category` ASC),
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`id_category`)
    REFERENCES `hidroponia`.`Categories` (`id_category`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabla maestra para los productos existentes en el sistema';


-- -----------------------------------------------------
-- Table `hidroponia`.`Clients`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Clients` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Clients` (
  `id_person` INT NOT NULL,
  `type_ID` VARCHAR(3) NOT NULL,
  `kind_person` VARCHAR(15) NULL COMMENT 'Juridica o Natrual',
  `nit` VARCHAR(20) NULL,
  `description` VARCHAR(45) NULL,
  `url` VARCHAR(45) NULL,
  INDEX `fk_Client_Person1_idx` (`id_person` ASC, `type_ID` ASC),
  PRIMARY KEY (`id_person`, `type_ID`),
  CONSTRAINT `fk_Client_Person1`
    FOREIGN KEY (`id_person` , `type_ID`)
    REFERENCES `hidroponia`.`Users` (`id_person` , `type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'En esta tabla se registran las personas como clientes';


-- -----------------------------------------------------
-- Table `hidroponia`.`Orders`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Orders` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Orders` (
  `id_order` INT NOT NULL,
  `total` DECIMAL(20) NULL,
  `application_date` DATE NULL,
  `id_person` INT NOT NULL,
  `type_ID` VARCHAR(3) NOT NULL,
  INDEX `fk_Order_Client1_idx` (`id_person` ASC, `type_ID` ASC),
  PRIMARY KEY (`id_order`),
  CONSTRAINT `fk_Order_Client1`
    FOREIGN KEY (`id_person` , `type_ID`)
    REFERENCES `hidroponia`.`Clients` (`id_person` , `type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Tabla donde se guarda la solicitud de compra por parte del cliente';


-- -----------------------------------------------------
-- Table `hidroponia`.`Order_has_Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Order_has_Products` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Order_has_Products` (
  `id_order` INT NOT NULL,
  `id_product` INT NOT NULL,
  `quantity` INT NULL,
  `unitPrice` DECIMAL(20) NULL,
  PRIMARY KEY (`id_order`, `id_product`),
  INDEX `fk_Order_has_Products_Orders1_idx` (`id_order` ASC),
  CONSTRAINT `fk_LineaCompra_Producto1`
    FOREIGN KEY (`id_product`)
    REFERENCES `hidroponia`.`Products` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Order_has_Products_Orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `hidroponia`.`Orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Permite relacionar que productos solicito el usuario al momento de realizar su cotizacion';


-- -----------------------------------------------------
-- Table `hidroponia`.`Cultivators`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Cultivators` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Cultivators` (
  `id_person` INT NOT NULL,
  `type_ID` VARCHAR(3) NOT NULL,
  `birth_day` DATE NULL,
  `gender` VARCHAR(1) NULL,
  PRIMARY KEY (`type_ID`, `id_person`),
  CONSTRAINT `fk_Cultivator_Person1`
    FOREIGN KEY (`id_person` , `type_ID`)
    REFERENCES `hidroponia`.`Users` (`id_person` , `type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'En esta tabla se registran las personas como cultivadores';


-- -----------------------------------------------------
-- Table `hidroponia`.`Califications`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Califications` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Califications` (
  `id_calification` INT NOT NULL AUTO_INCREMENT,
  `score` INT NULL,
  `comment` VARCHAR(200) NULL,
  `id_order` INT NOT NULL,
  PRIMARY KEY (`id_calification`),
  INDEX `fk_Califications_Orders1_idx` (`id_order` ASC),
  CONSTRAINT `fk_Califications_Orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `hidroponia`.`Orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Se registra el puntaje de cada compra hecha por el cliente';


-- -----------------------------------------------------
-- Table `hidroponia`.`Cultivator_has_Products`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Cultivator_has_Products` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Cultivator_has_Products` (
  `id_person` INT NOT NULL,
  `type_ID` VARCHAR(3) NOT NULL,
  `id_product` INT NOT NULL,
  `availability` INT NULL,
  `update_date` DATE NULL COMMENT 'Tabla para actualizar la disponibilidad de cada producto',
  INDEX `fk_Cultivator_has_Product_Cultivator1_idx` (`id_person` ASC, `type_ID` ASC),
  INDEX `fk_Cultivator_has_Product_Product1_idx` (`id_product` ASC),
  PRIMARY KEY (`id_person`, `type_ID`, `id_product`),
  CONSTRAINT `fk_Cultivator_has_Product_Cultivator1`
    FOREIGN KEY (`id_person` , `type_ID`)
    REFERENCES `hidroponia`.`Cultivators` (`id_person` , `type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cultivator_has_Product_Product1`
    FOREIGN KEY (`id_product`)
    REFERENCES `hidroponia`.`Products` (`id_product`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Esta tabla permite conocer cuales productos estan cultivando los cultivadores, ademas de saber su disponibilidad';


-- -----------------------------------------------------
-- Table `hidroponia`.`Dispatches`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Dispatches` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Dispatches` (
  `id_person` INT NOT NULL,
  `type_ID` VARCHAR(3) NOT NULL,
  `id_order` INT NOT NULL,
  `dispatch_date` DATE NULL,
  INDEX `fk_Dispatch_Cultivator1_idx` (`id_person` ASC, `type_ID` ASC),
  INDEX `fk_Dispatches_Orders1_idx` (`id_order` ASC),
  PRIMARY KEY (`id_order`, `type_ID`, `id_person`),
  CONSTRAINT `fk_Dispatch_Cultivator1`
    FOREIGN KEY (`id_person` , `type_ID`)
    REFERENCES `hidroponia`.`Cultivators` (`id_person` , `type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Dispatches_Orders1`
    FOREIGN KEY (`id_order`)
    REFERENCES `hidroponia`.`Orders` (`id_order`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'se guardan los datos de quien fue el encargado de atender la orden de compra';


-- -----------------------------------------------------
-- Table `hidroponia`.`Accounts`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Accounts` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Accounts` (
  `id_person` INT NOT NULL,
  `type_ID` VARCHAR(3) NOT NULL,
  `type_account` VARCHAR(45) NULL COMMENT 'Ahorro, Corriente, Credito',
  `number` INT NULL,
  `name_bank` VARCHAR(45) NULL,
  PRIMARY KEY (`type_ID`, `id_person`),
  INDEX `fk_Account_Person1_idx` (`id_person` ASC, `type_ID` ASC),
  CONSTRAINT `fk_Account_Person1`
    FOREIGN KEY (`id_person` , `type_ID`)
    REFERENCES `hidroponia`.`Users` (`id_person` , `type_ID`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Guarda informacion bancaria para recibir/pagar las ordenes de compra';