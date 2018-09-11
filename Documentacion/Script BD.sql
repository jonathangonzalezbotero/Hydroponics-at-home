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
-- Table `hidroponia`.`Usuario`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Usuario` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Usuario` (
  `TipoId` VARCHAR(3) NOT NULL,
  `IdUsuario` INT NOT NULL,
  `Nombre` VARCHAR(70) NULL,
  `Apellidos` VARCHAR(45) NULL,
  `Telefono` INT NULL,
  `Direccion` VARCHAR(50) NULL,
  `CorreoElectronico` VARCHAR(50) NULL,
  `NombreUsuario` VARCHAR(50) NULL,
  `Contraseña` VARCHAR(50) NULL,
  `Imagen` LONGBLOB NULL,
  `Rol` VARCHAR(10) NULL COMMENT 'Consumidor o Cultivador',
  PRIMARY KEY (`TipoId`, `IdUsuario`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Categoria`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Categoria` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Categoria` (
  `CategoriaId` INT NOT NULL,
  `NombreCategoria` VARCHAR(50) NULL,
  `Descripcion` VARCHAR(500) NULL,
  PRIMARY KEY (`CategoriaId`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Producto` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Producto` (
  `ProductoId` INT NOT NULL,
  `Nombre` VARCHAR(50) NULL,
  `Descripcion` VARCHAR(500) NULL,
  `Precio` DECIMAL(10) NULL,
  `Imagen` LONGBLOB NULL,
  `Categoria_CategoriaId` INT NOT NULL,
  PRIMARY KEY (`ProductoId`, `Categoria_CategoriaId`),
  INDEX `fk_Producto_Categoria1_idx` (`Categoria_CategoriaId` ASC),
  CONSTRAINT `fk_Producto_Categoria1`
    FOREIGN KEY (`Categoria_CategoriaId`)
    REFERENCES `hidroponia`.`Categoria` (`CategoriaId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Cliente`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Cliente` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Cliente` (
  `TipoId` VARCHAR(3) NOT NULL,
  `IdUsuario` INT NOT NULL,
  `TipoPersona` VARCHAR(15) NULL COMMENT 'Juridica o Natrual',
  `Nit` VARCHAR(20) NULL,
  `Descripcion` VARCHAR(45) NULL,
  `Url` VARCHAR(45) NULL,
  PRIMARY KEY (`TipoId`, `IdUsuario`),
  INDEX `fk_Consumidor_Usuario1_idx` (`TipoId` ASC, `IdUsuario` ASC),
  CONSTRAINT `fk_Consumidor_Usuario1`
    FOREIGN KEY (`TipoId` , `IdUsuario`)
    REFERENCES `hidroponia`.`Usuario` (`TipoId` , `IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Pedido`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Pedido` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Pedido` (
  `idPedido` INT NOT NULL,
  `Total` DECIMAL(20) NULL,
  `FechaSolicitud` DATE NULL,
  `Cliente_TipoId` VARCHAR(3) NOT NULL,
  `Cliente_IdUsuario` INT NOT NULL,
  PRIMARY KEY (`idPedido`, `Cliente_TipoId`, `Cliente_IdUsuario`),
  INDEX `fk_Pedido_Cliente1_idx` (`Cliente_TipoId` ASC, `Cliente_IdUsuario` ASC),
  CONSTRAINT `fk_Pedido_Cliente1`
    FOREIGN KEY (`Cliente_TipoId` , `Cliente_IdUsuario`)
    REFERENCES `hidroponia`.`Cliente` (`TipoId` , `IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`LineaCompra`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`LineaCompra` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`LineaCompra` (
  `Cantidad` INT NULL,
  `Preciounitario` DECIMAL(20) NULL,
  `Producto_ProductoId` INT NOT NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`Producto_ProductoId`, `Pedido_idPedido`),
  INDEX `fk_LineaCompra_Producto1_idx` (`Producto_ProductoId` ASC),
  INDEX `fk_LineaCompra_Pedido1_idx` (`Pedido_idPedido` ASC),
  CONSTRAINT `fk_LineaCompra_Producto1`
    FOREIGN KEY (`Producto_ProductoId`)
    REFERENCES `hidroponia`.`Producto` (`ProductoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_LineaCompra_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `hidroponia`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Cuenta`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Cuenta` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Cuenta` (
  `idCuenta` VARCHAR(45) NOT NULL,
  `TipoCuenta` VARCHAR(45) NULL COMMENT 'Ahorro, Corriente, Credito',
  `NumeroCuenta` INT NULL,
  `NombreBanco` VARCHAR(45) NULL,
  `TipoId` VARCHAR(3) NOT NULL,
  `IdUsuario` INT NOT NULL,
  PRIMARY KEY (`idCuenta`, `TipoId`, `IdUsuario`),
  INDEX `fk_Cuenta_Usuario1_idx` (`TipoId` ASC, `IdUsuario` ASC),
  CONSTRAINT `fk_Cuenta_Usuario1`
    FOREIGN KEY (`TipoId` , `IdUsuario`)
    REFERENCES `hidroponia`.`Usuario` (`TipoId` , `IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
COMMENT = 'Información bancaria para realizar/recibir el pago de los pedidos';


-- -----------------------------------------------------
-- Table `hidroponia`.`Cultivador`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Cultivador` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Cultivador` (
  `TipoId` VARCHAR(3) NOT NULL,
  `IdUsuario` INT NOT NULL,
  `FechaNacimiento` DATE NULL,
  `Genero` VARCHAR(1) NULL,
  PRIMARY KEY (`TipoId`, `IdUsuario`),
  INDEX `fk_Cultivador_Usuario1_idx` (`TipoId` ASC, `IdUsuario` ASC),
  CONSTRAINT `fk_Cultivador_Usuario1`
    FOREIGN KEY (`TipoId` , `IdUsuario`)
    REFERENCES `hidroponia`.`Usuario` (`TipoId` , `IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Calificacion`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Calificacion` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Calificacion` (
  `idCalificacion` INT NOT NULL,
  `Puntaje` INT NULL,
  `Comentario` VARCHAR(200) NULL,
  `Pedido_idPedido` INT NOT NULL,
  PRIMARY KEY (`idCalificacion`, `Pedido_idPedido`),
  INDEX `fk_Calificacion_Pedido1_idx` (`Pedido_idPedido` ASC),
  CONSTRAINT `fk_Calificacion_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `hidroponia`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Cultivador_has_Producto`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Cultivador_has_Producto` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Cultivador_has_Producto` (
  `Cultivador_TipoId` VARCHAR(3) NOT NULL,
  `Cultivador_IdUsuario` INT NOT NULL,
  `Producto_ProductoId` INT NOT NULL,
  `Disponibilidad` INT NULL,
  `FechaActualizacion` DATE NULL,
  PRIMARY KEY (`Cultivador_TipoId`, `Cultivador_IdUsuario`, `Producto_ProductoId`),
  INDEX `fk_Cultivador_has_Producto_Producto1_idx` (`Producto_ProductoId` ASC),
  INDEX `fk_Cultivador_has_Producto_Cultivador1_idx` (`Cultivador_TipoId` ASC, `Cultivador_IdUsuario` ASC),
  CONSTRAINT `fk_Cultivador_has_Producto_Cultivador1`
    FOREIGN KEY (`Cultivador_TipoId` , `Cultivador_IdUsuario`)
    REFERENCES `hidroponia`.`Cultivador` (`TipoId` , `IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Cultivador_has_Producto_Producto1`
    FOREIGN KEY (`Producto_ProductoId`)
    REFERENCES `hidroponia`.`Producto` (`ProductoId`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `hidroponia`.`Despacho`
-- -----------------------------------------------------
DROP TABLE IF EXISTS `hidroponia`.`Despacho` ;

CREATE TABLE IF NOT EXISTS `hidroponia`.`Despacho` (
  `Pedido_idPedido` INT NOT NULL,
  `Cultivador_TipoId` VARCHAR(3) NOT NULL,
  `Cultivador_IdUsuario` INT NOT NULL,
  `FechaEntrega` DATE NULL,
  PRIMARY KEY (`Pedido_idPedido`, `Cultivador_TipoId`, `Cultivador_IdUsuario`),
  INDEX `fk_Despacho_Pedido1_idx` (`Pedido_idPedido` ASC),
  INDEX `fk_Despacho_Cultivador1_idx` (`Cultivador_TipoId` ASC, `Cultivador_IdUsuario` ASC),
  CONSTRAINT `fk_Despacho_Pedido1`
    FOREIGN KEY (`Pedido_idPedido`)
    REFERENCES `hidroponia`.`Pedido` (`idPedido`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_Despacho_Cultivador1`
    FOREIGN KEY (`Cultivador_TipoId` , `Cultivador_IdUsuario`)
    REFERENCES `hidroponia`.`Cultivador` (`TipoId` , `IdUsuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;