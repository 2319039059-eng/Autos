-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Mar 02, 2026 at 07:14 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `autoselect1`
--

DELIMITER $$
--
-- Procedures
--
CREATE DEFINER=`root`@`localhost` PROCEDURE `Cotizacion` (IN `p_Id_venta` INT)   BEGIN
    SELECT 
        A.Modelo AS Modelo,
        V.Total AS Precio,
        CONCAT(C.Nombre_C, ' ', C.A_paterno_C, ' ', C.A_materno_C) AS Cliente,
        CONCAT(Ven.Nombre_V, ' ', Ven.A_paterno_V, ' ', Ven.A_materno_V) AS Vendedor,
        V.Fecha AS Fecha
    FROM Ventas V
    INNER JOIN Autos A ON V.Id_auto = A.Id_auto
    INNER JOIN Clientes C ON V.Id_cliente = C.Id_cliente
    INNER JOIN Vendedor Ven ON V.Id_vendedor = Ven.Id_vendedor
    WHERE V.Id_venta = p_Id_venta;
END$$

CREATE DEFINER=`root`@`localhost` PROCEDURE `MostrarUsuarios` ()   BEGIN
    SELECT 
        'Cliente' AS Tipo_usuario,
        Nombre_C AS Nombre,
        A_paterno_C AS Apellido_Paterno,
        A_materno_C AS Apellido_Materno,
        Correo_C AS Correo,
        Contrasena_C AS Contrasena
    FROM Clientes 

    UNION ALL

    SELECT 
        'Vendedor' AS Tipo_usuario,
        Nombre_V AS Nombre,
        A_paterno_V AS Apellido_Paterno,
        A_materno_V AS Apellido_Materno,
        Correo_V AS Correo,
        Contrasena_V AS Contrasena
    FROM Vendedor;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `autos`
--

CREATE TABLE `autos` (
  `Id_auto` int(11) NOT NULL,
  `Color` varchar(50) DEFAULT NULL,
  `Marca` varchar(50) DEFAULT NULL,
  `Modelo` varchar(50) DEFAULT NULL,
  `Id_proveedor` int(11) DEFAULT NULL,
  `Stock` int(11) DEFAULT NULL,
  `ruta_imagen` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `clientes`
--

CREATE TABLE `clientes` (
  `Id_cliente` int(11) NOT NULL,
  `Id_tipo_usuario` int(11) DEFAULT NULL,
  `Nombre_C` varchar(50) DEFAULT NULL,
  `A_paterno_C` varchar(50) DEFAULT NULL,
  `A_materno_C` varchar(50) DEFAULT NULL,
  `Contrasena_C` varchar(100) DEFAULT NULL,
  `Correo_C` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `clientes`
--

INSERT INTO `clientes` (`Id_cliente`, `Id_tipo_usuario`, `Nombre_C`, `A_paterno_C`, `A_materno_C`, `Contrasena_C`, `Correo_C`) VALUES
(3, 2, 'Flor Ilen', 'Marcial', 'Nava', '$2y$10$W7h0F26Y0Cft.6xO5bLM1uDbBYVWWuQiRuj/vqWItSp5yv.W8v.FK', 'flor@gmail.com'),
(4, 2, 'Israel', 'Macario', 'Flores', '$2y$10$QzGEqr9dzlLL.aEGqBT1AetHfIwf8vezj7IvutCTxAmnPcPCLblJy', 'gansito@gmail.com'),
(5, 2, 'carmen', 'moreno', 'gonzalez', '$2y$10$38Bci0f10doJSb8NFbBUSuzcjy93/t6s2bSep.1F0GTUprkAY5mRC', 'C29@gmail.com');

-- --------------------------------------------------------

--
-- Table structure for table `compras`
--

CREATE TABLE `compras` (
  `Id_compra` int(11) NOT NULL,
  `Fecha` date NOT NULL,
  `Cantidad` int(11) DEFAULT NULL,
  `Id_tipo_proveedor` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detalle_compra`
--

CREATE TABLE `detalle_compra` (
  `Id_detalle_compra` int(11) NOT NULL,
  `Id_compra` int(11) DEFAULT NULL,
  `Total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `detalle_ventas`
--

CREATE TABLE `detalle_ventas` (
  `Id_detalle_venta` int(11) NOT NULL,
  `Id_venta` int(11) DEFAULT NULL,
  `Total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `jefe`
--

CREATE TABLE `jefe` (
  `Id_jefe` int(11) NOT NULL,
  `Id_tipo_usuario` int(11) DEFAULT NULL,
  `Nombre_J` varchar(50) DEFAULT NULL,
  `A_paterno_J` varchar(50) DEFAULT NULL,
  `A_materno_J` varchar(50) DEFAULT NULL,
  `Contrasena_J` varchar(100) DEFAULT NULL,
  `Correo_J` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `proveedor`
--

CREATE TABLE `proveedor` (
  `Id_proveedor` int(11) NOT NULL,
  `Telefono` varchar(20) DEFAULT NULL,
  `Nombre_P` varchar(50) DEFAULT NULL,
  `A_paterno_P` varchar(50) DEFAULT NULL,
  `A_materno_P` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `tipos_usuario`
--

CREATE TABLE `tipos_usuario` (
  `Id_tipo_usuario` int(11) NOT NULL,
  `rol` varchar(50) DEFAULT NULL,
  `Id_cliente` int(11) DEFAULT NULL,
  `Id_vendedor` int(11) DEFAULT NULL,
  `Id_jefe` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tipos_usuario`
--

INSERT INTO `tipos_usuario` (`Id_tipo_usuario`, `rol`, `Id_cliente`, `Id_vendedor`, `Id_jefe`) VALUES
(1, 'Jefe', 2, 3, 1),
(2, 'Cliente', 2, 3, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tipo_proveedor`
--

CREATE TABLE `tipo_proveedor` (
  `Id_tipo_proveedor` int(11) NOT NULL,
  `Id_proveedor` int(11) DEFAULT NULL,
  `Id_auto` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vendedor`
--

CREATE TABLE `vendedor` (
  `Id_vendedor` int(11) NOT NULL,
  `Id_tipo_usuario` int(11) DEFAULT NULL,
  `Nombre_V` varchar(50) DEFAULT NULL,
  `A_paterno_V` varchar(50) DEFAULT NULL,
  `A_materno_V` varchar(50) DEFAULT NULL,
  `Contrasena_V` varchar(100) DEFAULT NULL,
  `Correo_V` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `ventas`
--

CREATE TABLE `ventas` (
  `Id_venta` int(11) NOT NULL,
  `Id_auto` int(11) DEFAULT NULL,
  `Id_cliente` int(11) DEFAULT NULL,
  `Id_vendedor` int(11) DEFAULT NULL,
  `Fecha` date DEFAULT NULL,
  `Total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `autos`
--
ALTER TABLE `autos`
  ADD PRIMARY KEY (`Id_auto`),
  ADD KEY `Id_proveedor` (`Id_proveedor`);

--
-- Indexes for table `clientes`
--
ALTER TABLE `clientes`
  ADD PRIMARY KEY (`Id_cliente`),
  ADD KEY `Id_tipo_usuario` (`Id_tipo_usuario`);

--
-- Indexes for table `compras`
--
ALTER TABLE `compras`
  ADD PRIMARY KEY (`Id_compra`),
  ADD KEY `Id_tipo_proveedor` (`Id_tipo_proveedor`);

--
-- Indexes for table `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD PRIMARY KEY (`Id_detalle_compra`),
  ADD KEY `Id_compra` (`Id_compra`);

--
-- Indexes for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD PRIMARY KEY (`Id_detalle_venta`),
  ADD KEY `Id_venta` (`Id_venta`);

--
-- Indexes for table `jefe`
--
ALTER TABLE `jefe`
  ADD PRIMARY KEY (`Id_jefe`),
  ADD KEY `Id_tipo_usuario` (`Id_tipo_usuario`);

--
-- Indexes for table `proveedor`
--
ALTER TABLE `proveedor`
  ADD PRIMARY KEY (`Id_proveedor`);

--
-- Indexes for table `tipos_usuario`
--
ALTER TABLE `tipos_usuario`
  ADD PRIMARY KEY (`Id_tipo_usuario`);

--
-- Indexes for table `tipo_proveedor`
--
ALTER TABLE `tipo_proveedor`
  ADD PRIMARY KEY (`Id_tipo_proveedor`),
  ADD KEY `Id_auto` (`Id_auto`);

--
-- Indexes for table `vendedor`
--
ALTER TABLE `vendedor`
  ADD PRIMARY KEY (`Id_vendedor`),
  ADD KEY `Id_tipo_usuario` (`Id_tipo_usuario`);

--
-- Indexes for table `ventas`
--
ALTER TABLE `ventas`
  ADD PRIMARY KEY (`Id_venta`),
  ADD KEY `Id_auto` (`Id_auto`),
  ADD KEY `Id_cliente` (`Id_cliente`),
  ADD KEY `Id_vendedor` (`Id_vendedor`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `autos`
--
ALTER TABLE `autos`
  MODIFY `Id_auto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `clientes`
--
ALTER TABLE `clientes`
  MODIFY `Id_cliente` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `compras`
--
ALTER TABLE `compras`
  MODIFY `Id_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detalle_compra`
--
ALTER TABLE `detalle_compra`
  MODIFY `Id_detalle_compra` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  MODIFY `Id_detalle_venta` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `jefe`
--
ALTER TABLE `jefe`
  MODIFY `Id_jefe` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `proveedor`
--
ALTER TABLE `proveedor`
  MODIFY `Id_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tipos_usuario`
--
ALTER TABLE `tipos_usuario`
  MODIFY `Id_tipo_usuario` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tipo_proveedor`
--
ALTER TABLE `tipo_proveedor`
  MODIFY `Id_tipo_proveedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vendedor`
--
ALTER TABLE `vendedor`
  MODIFY `Id_vendedor` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ventas`
--
ALTER TABLE `ventas`
  MODIFY `Id_venta` int(11) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `autos`
--
ALTER TABLE `autos`
  ADD CONSTRAINT `autos_ibfk_1` FOREIGN KEY (`Id_proveedor`) REFERENCES `proveedor` (`Id_proveedor`);

--
-- Constraints for table `clientes`
--
ALTER TABLE `clientes`
  ADD CONSTRAINT `clientes_ibfk_1` FOREIGN KEY (`Id_tipo_usuario`) REFERENCES `tipos_usuario` (`Id_tipo_usuario`);

--
-- Constraints for table `compras`
--
ALTER TABLE `compras`
  ADD CONSTRAINT `compras_ibfk_1` FOREIGN KEY (`Id_tipo_proveedor`) REFERENCES `tipo_proveedor` (`Id_tipo_proveedor`);

--
-- Constraints for table `detalle_compra`
--
ALTER TABLE `detalle_compra`
  ADD CONSTRAINT `detalle_compra_ibfk_1` FOREIGN KEY (`Id_compra`) REFERENCES `compras` (`Id_compra`);

--
-- Constraints for table `detalle_ventas`
--
ALTER TABLE `detalle_ventas`
  ADD CONSTRAINT `detalle_ventas_ibfk_1` FOREIGN KEY (`Id_venta`) REFERENCES `ventas` (`Id_venta`);

--
-- Constraints for table `jefe`
--
ALTER TABLE `jefe`
  ADD CONSTRAINT `jefe_ibfk_1` FOREIGN KEY (`Id_tipo_usuario`) REFERENCES `tipos_usuario` (`Id_tipo_usuario`);

--
-- Constraints for table `tipo_proveedor`
--
ALTER TABLE `tipo_proveedor`
  ADD CONSTRAINT `tipo_proveedor_ibfk_1` FOREIGN KEY (`Id_auto`) REFERENCES `autos` (`Id_auto`);

--
-- Constraints for table `vendedor`
--
ALTER TABLE `vendedor`
  ADD CONSTRAINT `vendedor_ibfk_1` FOREIGN KEY (`Id_tipo_usuario`) REFERENCES `tipos_usuario` (`Id_tipo_usuario`);

--
-- Constraints for table `ventas`
--
ALTER TABLE `ventas`
  ADD CONSTRAINT `ventas_ibfk_1` FOREIGN KEY (`Id_auto`) REFERENCES `autos` (`Id_auto`),
  ADD CONSTRAINT `ventas_ibfk_2` FOREIGN KEY (`Id_cliente`) REFERENCES `clientes` (`Id_cliente`),
  ADD CONSTRAINT `ventas_ibfk_3` FOREIGN KEY (`Id_vendedor`) REFERENCES `vendedor` (`Id_vendedor`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
