-- phpMyAdmin SQL Dump
-- version 4.9.7
-- https://www.phpmyadmin.net/
--
-- Host: localhost:8889
-- Generation Time: May 15, 2021 at 03:24 PM
-- Server version: 5.7.32
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

--
-- Database: `gamezen`
--

-- --------------------------------------------------------

--
-- Table structure for table `addresses`
--

CREATE TABLE `addresses` (
  `id` int(11) NOT NULL,
  `address` varchar(30) NOT NULL,
  `civic` int(11) NOT NULL,
  `city` varchar(30) NOT NULL,
  `CAP` varchar(5) NOT NULL,
  `province` varchar(2) NOT NULL,
  `phone` varchar(30) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `addresses`
--

INSERT INTO `addresses` (`id`, `address`, `civic`, `city`, `CAP`, `province`, `phone`) VALUES
(1, 'Via Mauro Macchi', 52, 'Porto San Giorgio', '63822', 'FM', '3896970199');

-- --------------------------------------------------------

--
-- Table structure for table `categories`
--

CREATE TABLE `categories` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `categories`
--

INSERT INTO `categories` (`ID`, `name`) VALUES
(1, 'Astratti'),
(2, 'Per famiglie'),
(3, 'Per bambini'),
(4, 'Party games'),
(5, 'Strategici'),
(6, 'WarGames'),
(7, 'Collezionabili');

-- --------------------------------------------------------

--
-- Table structure for table `delivery`
--

CREATE TABLE `delivery` (
  `user` int(11) NOT NULL,
  `address` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `delivery`
--

INSERT INTO `delivery` (`user`, `address`) VALUES
(1, 1);

-- --------------------------------------------------------

--
-- Table structure for table `detail`
--

CREATE TABLE `detail` (
  `orderID` int(11) NOT NULL,
  `product` int(11) NOT NULL,
  `quantity` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `detail`
--

INSERT INTO `detail` (`orderID`, `product`, `quantity`) VALUES
(8, 1, 0),
(9, 3, 0);

-- --------------------------------------------------------

--
-- Table structure for table `orders`
--

CREATE TABLE `orders` (
  `id` int(11) NOT NULL,
  `date` date NOT NULL,
  `delivery` date DEFAULT NULL,
  `user` int(11) NOT NULL,
  `address` int(11) NOT NULL,
  `state` int(11) NOT NULL,
  `total` float DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `orders`
--

INSERT INTO `orders` (`id`, `date`, `delivery`, `user`, `address`, `state`, `total`) VALUES
(8, '2021-05-08', '2021-05-14', 1, 1, 1, 21.99),
(9, '2021-05-09', '2021-05-15', 1, 1, 2, 10.99);

-- --------------------------------------------------------

--
-- Table structure for table `producers`
--

CREATE TABLE `producers` (
  `ID` int(11) NOT NULL,
  `name` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `producers`
--

INSERT INTO `producers` (`ID`, `name`) VALUES
(1, 'Hasbro'),
(2, 'Editrice Giochi'),
(3, 'DV Giochi'),
(4, 'Parker Brothers'),
(5, 'Konami');

-- --------------------------------------------------------

--
-- Table structure for table `products`
--

CREATE TABLE `products` (
  `code` int(11) NOT NULL,
  `category` int(11) NOT NULL,
  `producer` int(11) NOT NULL,
  `name` varchar(40) NOT NULL,
  `description` varchar(250) DEFAULT NULL,
  `year` year(4) NOT NULL,
  `language` varchar(15) DEFAULT NULL,
  `price` float NOT NULL,
  `available` tinyint(1) NOT NULL,
  `image` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `products`
--

INSERT INTO `products` (`code`, `category`, `producer`, `name`, `description`, `year`, `language`, `price`, `available`, `image`) VALUES
(1, 5, 1, 'Monopoly', 'Il gioco di contrattazione più famoso del mondo. Compra, vendi, sogna e programma la tua strada verso la ricchezza. I giocatori comprano, vendono e contrattano per vincere; compra e vendi proprietà.', 2018, 'Italiano', 21.99, 1, 'monopoly.jpg'),
(2, 6, 2, 'Risiko', 'RisiKo! è la variante italiana di Risk. Lo scopo è il raggiungimento di un obiettivo segreto e diverso per ognuno, che può consistere nella conquista di un numero di territori, nella conquista di continenti o annientamento di un avversario.', 1977, 'Italiano', 28, 1, 'risiko.jpg'),
(3, 2, 3, 'The Mind', 'The Mind è più di un semplice gioco di carte: è un esperimento di telepatia. Si vince e si perde tutti insieme: se la squadra riesce a completare con successo tutti i livelli, conquista la vittoria. Se invece perde l’ultima vita, è stata sconfitta.', 2018, 'Italiano', 10.99, 1, 'themind.jpg'),
(4, 5, 1, 'Taboo', 'Fai in modo che i compagni di gioco pronuncino la parola misteriosa da indovinare senza nominare le parole proibite, altrimenti gli avversari schiacciano il pulsante. Comprende 260 carte e oltre 1000 parole misteriose da indovinare.', 1989, 'Inglese', 24.99, 1, 'taboo.jpg'),
(5, 7, 5, 'Yu-Gi-Oh Cyber Strike', 'Padroneggia le proibite arti della fusione che combinano feroci mostri Drago e Macchina con Structure Deck: Cyber Strike!', 2021, 'Inglese', 9.99, 0, 'yugioh-cyberstrike.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `save`
--

CREATE TABLE `save` (
  `user` int(11) NOT NULL,
  `product` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `save`
--

INSERT INTO `save` (`user`, `product`) VALUES
(1, 4);

-- --------------------------------------------------------

--
-- Table structure for table `states`
--

CREATE TABLE `states` (
  `ID` int(11) NOT NULL,
  `state` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `states`
--

INSERT INTO `states` (`ID`, `state`) VALUES
(1, 'In attesa di pagamento'),
(2, 'Pagamento ricevuto'),
(3, 'In eleborazione'),
(4, 'Spedito'),
(5, 'In consegna'),
(6, 'Consegnato');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(30) NOT NULL,
  `surname` varchar(30) NOT NULL,
  `password` varchar(50) NOT NULL,
  `email` varchar(60) DEFAULT NULL,
  `birth` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `name`, `surname`, `password`, `email`, `birth`) VALUES
(1, 'Alessio', 'Rubicini', '098f6bcd4621d373cade4e832627b4f6', 'alessiorubicini16@icloud.com', '2002-07-16'),
(7, 'Andrea', 'Malloni', '098f6bcd4621d373cade4e832627b4f6', 'malloni.andrea02@gmail.com', '2002-02-09');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `addresses`
--
ALTER TABLE `addresses`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `categories`
--
ALTER TABLE `categories`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `delivery`
--
ALTER TABLE `delivery`
  ADD PRIMARY KEY (`user`,`address`),
  ADD KEY `address` (`address`);

--
-- Indexes for table `detail`
--
ALTER TABLE `detail`
  ADD PRIMARY KEY (`orderID`,`product`),
  ADD KEY `product` (`product`);

--
-- Indexes for table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user` (`user`),
  ADD KEY `address` (`address`),
  ADD KEY `state` (`state`);

--
-- Indexes for table `producers`
--
ALTER TABLE `producers`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `products`
--
ALTER TABLE `products`
  ADD PRIMARY KEY (`code`),
  ADD KEY `category` (`category`),
  ADD KEY `producer` (`producer`);

--
-- Indexes for table `save`
--
ALTER TABLE `save`
  ADD PRIMARY KEY (`user`,`product`),
  ADD KEY `product` (`product`);

--
-- Indexes for table `states`
--
ALTER TABLE `states`
  ADD PRIMARY KEY (`ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `addresses`
--
ALTER TABLE `addresses`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `categories`
--
ALTER TABLE `categories`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `producers`
--
ALTER TABLE `producers`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `products`
--
ALTER TABLE `products`
  MODIFY `code` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `states`
--
ALTER TABLE `states`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `delivery`
--
ALTER TABLE `delivery`
  ADD CONSTRAINT `delivery_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `delivery_ibfk_2` FOREIGN KEY (`address`) REFERENCES `addresses` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `detail`
--
ALTER TABLE `detail`
  ADD CONSTRAINT `detail_ibfk_1` FOREIGN KEY (`orderID`) REFERENCES `orders` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `detail_ibfk_2` FOREIGN KEY (`product`) REFERENCES `products` (`code`) ON DELETE CASCADE;

--
-- Constraints for table `orders`
--
ALTER TABLE `orders`
  ADD CONSTRAINT `orders_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_2` FOREIGN KEY (`address`) REFERENCES `addresses` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `orders_ibfk_3` FOREIGN KEY (`state`) REFERENCES `states` (`ID`) ON DELETE CASCADE;

--
-- Constraints for table `products`
--
ALTER TABLE `products`
  ADD CONSTRAINT `products_ibfk_1` FOREIGN KEY (`category`) REFERENCES `categories` (`ID`),
  ADD CONSTRAINT `products_ibfk_2` FOREIGN KEY (`producer`) REFERENCES `producers` (`ID`);

--
-- Constraints for table `save`
--
ALTER TABLE `save`
  ADD CONSTRAINT `save_ibfk_1` FOREIGN KEY (`user`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `save_ibfk_2` FOREIGN KEY (`product`) REFERENCES `products` (`code`) ON DELETE CASCADE;
