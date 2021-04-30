-- phpMyAdmin SQL Dump
-- version 5.0.3
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Apr 28, 2021 alle 21:52
-- Versione del server: 10.4.14-MariaDB
-- Versione PHP: 7.4.11

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `gamezen`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `categorie`
--

CREATE TABLE `categorie` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `consegna`
--

CREATE TABLE `consegna` (
  `Utente` int(11) NOT NULL,
  `Indirizzo` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `indirizzi`
--

CREATE TABLE `indirizzi` (
  `ID` int(11) NOT NULL,
  `Via` varchar(75) DEFAULT NULL,
  `Civico` int(11) DEFAULT NULL,
  `Citta` varchar(75) DEFAULT NULL,
  `Provincia` varchar(75) DEFAULT NULL,
  `Telefono` varchar(15) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `ordini`
--

CREATE TABLE `ordini` (
  `ID` int(11) NOT NULL,
  `DataOrdine` date DEFAULT NULL,
  `StimaConsegna` date DEFAULT NULL,
  `Utente` int(11) DEFAULT NULL,
  `Indirizzo` int(11) DEFAULT NULL,
  `Stato` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotti`
--

CREATE TABLE `prodotti` (
  `Codice` int(11) NOT NULL,
  `Categoria` int(11) DEFAULT NULL,
  `Produttore` int(11) DEFAULT NULL,
  `Nome` varchar(100) DEFAULT NULL,
  `Descrizione` varchar(250) DEFAULT NULL,
  `Anno` year(4) DEFAULT NULL,
  `Lingua` varchar(50) DEFAULT NULL,
  `Prezzo` float DEFAULT NULL,
  `Disponibile` tinyint(1) DEFAULT NULL,
  `Immagine` varchar(200) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `produttori`
--

CREATE TABLE `produttori` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `salva`
--

CREATE TABLE `salva` (
  `Utente` int(11) NOT NULL,
  `CodiceProdotto` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `stati`
--

CREATE TABLE `stati` (
  `ID` int(11) NOT NULL,
  `Stato` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Struttura della tabella `utenti`
--

CREATE TABLE `utenti` (
  `ID` int(11) NOT NULL,
  `Nome` varchar(50) DEFAULT NULL,
  `Cognome` varchar(50) DEFAULT NULL,
  `Email` varchar(50) DEFAULT NULL,
  `Password` varchar(50) DEFAULT NULL,
  `DataNascita` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `categorie`
--
ALTER TABLE `categorie`
  ADD PRIMARY KEY (`ID`);

--
-- Indici per le tabelle `consegna`
--
ALTER TABLE `consegna`
  ADD PRIMARY KEY (`Utente`,`Indirizzo`),
  ADD KEY `Indirizzo` (`Indirizzo`);

--
-- Indici per le tabelle `indirizzi`
--
ALTER TABLE `indirizzi`
  ADD PRIMARY KEY (`ID`);

--
-- Indici per le tabelle `ordini`
--
ALTER TABLE `ordini`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `Utente` (`Utente`),
  ADD KEY `Indirizzo` (`Indirizzo`),
  ADD KEY `Stato` (`Stato`);

--
-- Indici per le tabelle `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`Codice`),
  ADD KEY `Categoria` (`Categoria`),
  ADD KEY `Produttore` (`Produttore`);

--
-- Indici per le tabelle `produttori`
--
ALTER TABLE `produttori`
  ADD PRIMARY KEY (`ID`);

--
-- Indici per le tabelle `salva`
--
ALTER TABLE `salva`
  ADD PRIMARY KEY (`Utente`,`CodiceProdotto`),
  ADD KEY `CodiceProdotto` (`CodiceProdotto`);

--
-- Indici per le tabelle `stati`
--
ALTER TABLE `stati`
  ADD PRIMARY KEY (`ID`);

--
-- Indici per le tabelle `utenti`
--
ALTER TABLE `utenti`
  ADD PRIMARY KEY (`ID`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `categorie`
--
ALTER TABLE `categorie`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `indirizzi`
--
ALTER TABLE `indirizzi`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `ordini`
--
ALTER TABLE `ordini`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `prodotti`
--
ALTER TABLE `prodotti`
  MODIFY `Codice` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `produttori`
--
ALTER TABLE `produttori`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `stati`
--
ALTER TABLE `stati`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT per la tabella `utenti`
--
ALTER TABLE `utenti`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `consegna`
--
ALTER TABLE `consegna`
  ADD CONSTRAINT `consegna_ibfk_1` FOREIGN KEY (`Utente`) REFERENCES `utenti` (`ID`),
  ADD CONSTRAINT `consegna_ibfk_2` FOREIGN KEY (`Indirizzo`) REFERENCES `indirizzi` (`ID`);

--
-- Limiti per la tabella `ordini`
--
ALTER TABLE `ordini`
  ADD CONSTRAINT `ordini_ibfk_1` FOREIGN KEY (`Utente`) REFERENCES `utenti` (`ID`),
  ADD CONSTRAINT `ordini_ibfk_2` FOREIGN KEY (`Indirizzo`) REFERENCES `indirizzi` (`ID`),
  ADD CONSTRAINT `ordini_ibfk_3` FOREIGN KEY (`Stato`) REFERENCES `stati` (`ID`);

--
-- Limiti per la tabella `prodotti`
--
ALTER TABLE `prodotti`
  ADD CONSTRAINT `prodotti_ibfk_1` FOREIGN KEY (`Categoria`) REFERENCES `categorie` (`ID`),
  ADD CONSTRAINT `prodotti_ibfk_2` FOREIGN KEY (`Produttore`) REFERENCES `produttori` (`ID`);

--
-- Limiti per la tabella `salva`
--
ALTER TABLE `salva`
  ADD CONSTRAINT `salva_ibfk_1` FOREIGN KEY (`Utente`) REFERENCES `utenti` (`ID`),
  ADD CONSTRAINT `salva_ibfk_2` FOREIGN KEY (`CodiceProdotto`) REFERENCES `prodotti` (`Codice`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
