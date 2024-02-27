-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 27, 2024 at 07:52 AM
-- Server version: 10.4.25-MariaDB
-- PHP Version: 8.1.10

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `db_ukk`
--

-- --------------------------------------------------------

--
-- Table structure for table `detail_penjualan`
--

CREATE TABLE `detail_penjualan` (
  `id_detail` int(11) NOT NULL,
  `id_penjualan` bigint(20) NOT NULL,
  `idProduk` int(11) NOT NULL,
  `qty` int(11) NOT NULL,
  `total_harga` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `detail_penjualan`
--

INSERT INTO `detail_penjualan` (`id_detail`, `id_penjualan`, `idProduk`, `qty`, `total_harga`) VALUES
(1, 4, 21, 3, 36000),
(2, 4, 18, 5, 60000),
(3, 4, 26, 5, 60000),
(4, 4, 17, 2, 24000),
(5, 5, 19, 2, 24000),
(6, 6, 33, 5, 10000),
(7, 6, 20, 2, 24000),
(8, 6, 34, 5, 10000),
(9, 6, 35, 5, 10000),
(10, 6, 36, 2, 4000),
(11, 7, 42, 10, 15000),
(12, 7, 40, 10, 20000);

--
-- Triggers `detail_penjualan`
--
DELIMITER $$
CREATE TRIGGER `kurangiStok` AFTER INSERT ON `detail_penjualan` FOR EACH ROW UPDATE produk SET produk.stok = produk.stok - NEW.qty
WHERE produk.idProduk = NEW.idProduk
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `nambahTotalHarga` AFTER INSERT ON `detail_penjualan` FOR EACH ROW UPDATE penjualan SET penjualan.total = penjualan.total + NEW.total_harga
WHERE penjualan.id_penjualan= NEW.id_penjualan
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Table structure for table `kategori`
--

CREATE TABLE `kategori` (
  `katid` int(11) NOT NULL,
  `katnama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `kategori`
--

INSERT INTO `kategori` (`katid`, `katnama`) VALUES
(1, 'makanan'),
(16, 'minuman');

-- --------------------------------------------------------

--
-- Table structure for table `penjualan`
--

CREATE TABLE `penjualan` (
  `id_penjualan` bigint(20) NOT NULL,
  `no_faktur` varchar(50) NOT NULL,
  `tgl_penjualan` datetime NOT NULL,
  `idUser` int(11) NOT NULL,
  `total` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `penjualan`
--

INSERT INTO `penjualan` (`id_penjualan`, `no_faktur`, `tgl_penjualan`, `idUser`, `total`) VALUES
(1, 'INVC2402260001', '2024-02-26 14:28:23', 12, 0),
(2, 'INVC2402260001', '2024-02-26 14:28:53', 12, 0),
(3, 'INVC2402260002', '2024-02-26 14:29:32', 12, 0),
(4, 'INVC2402260003', '2024-02-26 14:33:59', 12, 180000),
(5, 'INVC2402270004', '2024-02-27 07:29:58', 14, 24000),
(6, 'INVC2402270005', '2024-02-27 07:34:33', 12, 58000),
(7, 'INVC2402270006', '2024-02-27 13:24:25', 12, 35000);

-- --------------------------------------------------------

--
-- Table structure for table `produk`
--

CREATE TABLE `produk` (
  `idProduk` int(11) NOT NULL,
  `kode_produk` varchar(25) NOT NULL,
  `nama_produk` varchar(11) NOT NULL,
  `harga_beli` int(11) NOT NULL,
  `harga_jual` int(11) NOT NULL,
  `diskon` decimal(10,0) NOT NULL,
  `katid` int(11) NOT NULL,
  `satid` int(11) NOT NULL,
  `stok` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `produk`
--

INSERT INTO `produk` (`idProduk`, `kode_produk`, `nama_produk`, `harga_beli`, `harga_jual`, `diskon`, `katid`, `satid`, `stok`) VALUES
(35, 'PRD001', 'saus', 1000, 2000, '0', 1, 7, 95),
(40, 'PRD002', 'kecap', 1000, 2000, '0', 1, 7, 90),
(42, 'PRD003', 'teh gelas', 1000, 1500, '0', 16, 7, 90);

-- --------------------------------------------------------

--
-- Table structure for table `satuan`
--

CREATE TABLE `satuan` (
  `satid` int(11) NOT NULL,
  `satnama` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `satuan`
--

INSERT INTO `satuan` (`satid`, `satnama`) VALUES
(3, 'sachet'),
(7, 'pcs'),
(8, 'kg');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `idUser` int(11) NOT NULL,
  `Nama_User` varchar(225) NOT NULL,
  `Password` varchar(225) NOT NULL,
  `Level` enum('admin','kasir') NOT NULL,
  `username` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`idUser`, `Nama_User`, `Password`, `Level`, `username`) VALUES
(12, 'hafid murofi', '202cb962ac59075b964b07152d234b70', 'admin', 'hafid'),
(14, 'herli ', '202cb962ac59075b964b07152d234b70', 'kasir', 'her');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  ADD PRIMARY KEY (`id_detail`),
  ADD KEY `id_penjualan` (`id_penjualan`),
  ADD KEY `idProduk` (`idProduk`);

--
-- Indexes for table `kategori`
--
ALTER TABLE `kategori`
  ADD PRIMARY KEY (`katid`);

--
-- Indexes for table `penjualan`
--
ALTER TABLE `penjualan`
  ADD PRIMARY KEY (`id_penjualan`),
  ADD KEY `idUser` (`idUser`);

--
-- Indexes for table `produk`
--
ALTER TABLE `produk`
  ADD PRIMARY KEY (`idProduk`),
  ADD KEY `katid` (`katid`),
  ADD KEY `satid` (`satid`);

--
-- Indexes for table `satuan`
--
ALTER TABLE `satuan`
  ADD PRIMARY KEY (`satid`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`idUser`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `detail_penjualan`
--
ALTER TABLE `detail_penjualan`
  MODIFY `id_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `kategori`
--
ALTER TABLE `kategori`
  MODIFY `katid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `penjualan`
--
ALTER TABLE `penjualan`
  MODIFY `id_penjualan` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `produk`
--
ALTER TABLE `produk`
  MODIFY `idProduk` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=43;

--
-- AUTO_INCREMENT for table `satuan`
--
ALTER TABLE `satuan`
  MODIFY `satid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `idUser` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `produk`
--
ALTER TABLE `produk`
  ADD CONSTRAINT `produk_ibfk_1` FOREIGN KEY (`satid`) REFERENCES `satuan` (`satid`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `produk_ibfk_2` FOREIGN KEY (`katid`) REFERENCES `kategori` (`katid`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
