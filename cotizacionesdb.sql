-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 20-11-2024 a las 17:59:46
-- Versión del servidor: 10.4.32-MariaDB
-- Versión de PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `cotizacionesdb`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `cotizaciones`
--

CREATE TABLE `cotizaciones` (
  `id` int(11) NOT NULL,
  `modelo` varchar(255) NOT NULL,
  `marca` varchar(255) NOT NULL,
  `año` int(11) NOT NULL,
  `precio` decimal(10,2) NOT NULL,
  `color` varchar(100) DEFAULT NULL,
  `detalles_cliente` text DEFAULT NULL,
  `fecha_creacion` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Volcado de datos para la tabla `cotizaciones`
--

INSERT INTO `cotizaciones` (`id`, `modelo`, `marca`, `año`, `precio`, `color`, `detalles_cliente`, `fecha_creacion`) VALUES
(27, 'Chevrolet Camaro', 'Chevrolet', 2021, 33000.00, 'Negro', 'El cliente desea más información sobre las opciones de personalización del Camaro 2021. Correo: ejemplo2@correo.com, Teléfono: 555-2345-6789.', '2024-11-19 19:30:00'),
(28, 'Toyota Corolla', 'Toyota', 2023, 22000.00, 'Blanco', 'Interesado en un Toyota Corolla 2023, con opción de colores adicionales y accesorios. Correo: ejemplo3@correo.com, Teléfono: 555-3456-7890.', '2024-11-18 21:45:00'),
(29, 'Honda Civic', 'Honda', 2022, 24000.00, 'Azul', 'Consulta sobre el Civic 2022 en color azul, con todas las características de seguridad. Correo: ejemplo4@correo.com, Teléfono: 555-4567-8901.', '2024-11-17 17:15:00'),
(30, 'BMW Serie 3', 'BMW', 2020, 45000.00, 'Gris', 'Cliente interesado en el BMW 320i 2020, busca un auto de lujo con buen rendimiento. Correo: ejemplo5@correo.com, Teléfono: 555-5678-9012.', '2024-11-16 14:05:00'),
(31, 'Audi A4', 'Audi', 2021, 42000.00, 'Negro', 'El cliente pregunta por el Audi A4 2021, con opciones de personalización en interiores. Correo: ejemplo6@correo.com, Teléfono: 555-6789-0123.', '2024-11-15 18:25:00'),
(32, 'Volkswagen Golf', 'Volkswagen', 2022, 27000.00, 'Verde', 'Desea recibir detalles sobre el Golf 2022 y las opciones de financiamiento. Correo: ejemplo7@correo.com, Teléfono: 555-7890-1234.', '2024-11-14 22:30:00'),
(33, 'Mercedes-Benz C-Class', 'Mercedes-Benz', 2023, 55000.00, 'Plata', 'Interesado en el modelo C-Class 2023, con todos los paquetes de lujo y seguridad. Correo: ejemplo8@correo.com, Teléfono: 555-8901-2345.', '2024-11-13 16:00:00'),
(34, 'Nissan Altima', 'Nissan', 2022, 25000.00, 'Negro', 'El cliente busca un Nissan Altima 2022, con enfoque en eficiencia de combustible y confort. Correo: ejemplo9@correo.com, Teléfono: 555-9012-3456.', '2024-11-12 20:45:00'),
(35, 'Hyundai Sonata', 'Hyundai', 2021, 23000.00, 'Rojo', 'Consulta sobre el Hyundai Sonata 2021, interesado en el modelo híbrido. Correo: ejemplo10@correo.com, Teléfono: 555-0123-4567.', '2024-11-11 15:20:00'),
(36, 'Jeep Grand Cherokee', 'Jeep', 2020, 47000.00, 'Blanco', 'Cliente interesado en el Grand Cherokee 2020 para viajes de aventura y excursiones. Correo: ejemplo11@correo.com, Teléfono: 555-1234-5678.', '2024-11-10 19:50:00'),
(37, 'Kia Optima', 'Kia', 2023, 28000.00, 'Azul', 'El cliente solicita más información sobre el modelo Optima 2023, buscando un coche familiar. Correo: ejemplo12@correo.com, Teléfono: 555-2345-6789.', '2024-11-09 18:10:00'),
(38, 'Mazda CX-5', 'Mazda', 2021, 31000.00, 'Plata', 'Interesado en el Mazda CX-5 2021 con tracción total y sistema de navegación integrado. Correo: ejemplo13@correo.com, Teléfono: 555-3456-7890.', '2024-11-08 21:00:00'),
(39, 'Subaru Outback', 'Subaru', 2023, 33000.00, 'Verde', 'Consulta sobre la opción Outback 2023, enfocado en un vehículo de aventura con buen consumo de combustible. Correo: ejemplo14@correo.com, Teléfono: 555-4567-8901.', '2024-11-07 16:30:00'),
(40, 'Porsche 911', 'Porsche', 2022, 80000.00, 'Amarillo', 'Cliente buscando un Porsche 911 2022, enfocado en el rendimiento y el lujo. Correo: ejemplo15@correo.com, Teléfono: 555-5678-9012.', '2024-11-06 17:20:00'),
(41, 'Tesla Model 3', 'Tesla', 2021, 45000.00, 'Blanco', 'Interesado en el modelo eléctrico Tesla Model 3 2021, con opciones de conducción autónoma. Correo: ejemplo16@correo.com, Teléfono: 555-6789-0123.', '2024-11-05 19:40:00'),
(42, 'Land Rover Defender', 'Land Rover', 2020, 67000.00, 'Negro', 'Cliente interesado en el Defender 2020 para viajes de campo, buscando un vehículo robusto. Correo: ejemplo17@correo.com, Teléfono: 555-7890-1234.', '2024-11-04 20:00:00'),
(43, 'Ford F-150', 'Ford', 2022, 38000.00, 'Rojo', 'El cliente desea más detalles sobre la F-150 2022 con motor V6 y cabina extendida. Correo: ejemplo18@correo.com, Teléfono: 555-8901-2345.', '2024-11-03 15:15:00'),
(44, 'Chevrolet Silverado', 'Chevrolet', 2021, 35000.00, 'Azul', 'Interesado en la Silverado 2021 con capacidad de carga elevada y características de confort. Correo: ejemplo19@correo.com, Teléfono: 555-9012-3456.', '2024-11-02 16:50:00');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `cotizaciones`
--
ALTER TABLE `cotizaciones`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=46;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
