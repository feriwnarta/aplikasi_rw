-- phpMyAdmin SQL Dump
-- version 4.9.0.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jul 08, 2022 at 12:40 PM
-- Server version: 10.3.16-MariaDB
-- PHP Version: 7.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `nextg_mobileapp`
--

-- --------------------------------------------------------

--
-- Table structure for table `tb_bill_event`
--

CREATE TABLE `tb_bill_event` (
  `id_event` int(11) NOT NULL,
  `tab_title` varchar(50) NOT NULL,
  `url_image_event` varchar(100) NOT NULL,
  `title_event` varchar(50) NOT NULL,
  `price` varchar(100) NOT NULL,
  `duedate` datetime NOT NULL,
  `background_color` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_bill_event`
--

INSERT INTO `tb_bill_event` (`id_event`, `tab_title`, `url_image_event`, `title_event`, `price`, `duedate`, `background_color`) VALUES
(1, 'Event Lomba', 'imageevent/1.png', 'citizen dues for event contest', '150.000', '2022-06-25 13:00:00', 'Colors.green');

-- --------------------------------------------------------

--
-- Table structure for table `tb_category`
--

CREATE TABLE `tb_category` (
  `id_category` int(11) NOT NULL,
  `id_master_category` int(11) NOT NULL,
  `category` varchar(100) NOT NULL,
  `icon` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_category`
--

INSERT INTO `tb_category` (`id_category`, `id_master_category`, `category`, `icon`) VALUES
(1, 1, 'Perawatan taman', 'pohon_01_blue.png'),
(2, 1, 'Kebersihan Lingkungan', 'sampah 02_blue.png'),
(3, 1, 'Kesehatan Lingkungan', 'pest_ctrl_01_blue.png'),
(4, 2, 'Perawatan Mekanikal dan Elektrikal', 'kabelistrik_01_blue.png'),
(5, 1, 'Perawatan Club house', 'clubhouse02_blue.png'),
(6, 3, 'Building Controll', 'pengawas_bgn_01_blue.png'),
(7, 2, 'Perawatan Kolam Renang', 'kolam_renang_01_blue.png'),
(8, 4, 'Pengurusan Administrasi', 'fasilitas_jalan_03_blue.png'),
(9, 3, 'Permasalahan Keamanan', 'keamanan_01_blue.png');

-- --------------------------------------------------------

--
-- Table structure for table `tb_category_detail`
--

CREATE TABLE `tb_category_detail` (
  `id_category_detail` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `icon_detail` varchar(50) NOT NULL,
  `name_category_detail` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_category_detail`
--

INSERT INTO `tb_category_detail` (`id_category_detail`, `id_category`, `icon_detail`, `name_category_detail`) VALUES
(1, 1, 'pohon_01_blue.png', 'Pemangkasan Pohon'),
(2, 1, 'pohon_01_blue.png', 'Pemangkasan Rumput'),
(3, 1, 'pohon_01_blue.png', 'Pemangkasan Semak'),
(4, 2, 'sampah 02_blue.png', 'Pembuangan Sampah Taman'),
(5, 2, 'sampah 02_blue.png', 'Penyapuan Jalan'),
(6, 2, 'sampah 02_blue.png', 'Pencabutan Rumput Liar'),
(7, 2, 'sampah 02_blue.png', 'Pembersihan Saluran'),
(8, 3, 'pest_ctrl_01_blue.png', 'Pest Controll'),
(9, 3, 'pest_ctrl_01_blue.png', 'Roden Controll'),
(10, 3, 'pest_ctrl_01_blue.png', 'Animal Controll'),
(11, 3, 'pest_ctrl_01_blue.png', 'Termite Controll'),
(12, 4, 'kabelistrik_01_blue.png', 'Perawatan Penerangan Jln Umum / Lampu'),
(13, 4, 'kabelistrik_01_blue.png', 'Perawatan Panel'),
(14, 4, 'kabelistrik_01_blue.png', 'Perawatan Barrier Gate'),
(15, 7, 'kolam_renang_01_blue.png', 'Perawatan Kolam Renang'),
(17, 6, 'pengawas_bgn_01_blue.png', 'Pengawan Proyek'),
(18, 1, 'pohon_01_blue.png', 'Pengendalian Hama'),
(19, 4, 'kabelistrik_01_blue.png', 'Perawatan CCTV'),
(20, 1, 'pohon_01_blue.png', 'Penyiraman Taman'),
(23, 1, 'pohon_01_blue.png', 'Pemupukan'),
(24, 1, 'pohon_01_blue.png', 'Weeding'),
(25, 2, 'sampah 02_blue.png', 'Kebersihan Brandgang\r\n'),
(26, 4, 'kabelistrik_01_blue.png', 'Perawatan Lampu Taman'),
(27, 1, 'clubhouse02_blue.png', 'Pembersihan Club House\r\n'),
(28, 1, 'clubhouse02_blue.png', 'Perawatan Rumah Pompa'),
(29, 6, 'pengawas_bgn_01_blue.png', 'Pengawasan Fungsi Bangunan'),
(30, 6, 'pengawas_bgn_01_blue.png', 'Perawatan Pos Jaga'),
(31, 6, 'pengawas_bgn_01_blue.png', 'Perawatan Jalan'),
(32, 6, 'pengawas_bgn_01_blue.png', 'Perawatan Pagar'),
(33, 8, 'keamanan_01_blue.png', 'Pengurusan izin perbaikan no deposit'),
(34, 8, '', 'Pengurusan izin renovasi Deposit'),
(35, 8, '', 'Pengurusan Id Card'),
(36, 8, '', 'Pengurusan izin kendaraan Proyek'),
(37, 8, '', 'Pengurusan refund deposit'),
(38, 8, '', 'Pengurusan refund deposit'),
(39, 8, '', 'Pengurusan kartu akses'),
(40, 8, '', 'Pengurusan izin Kegiatan'),
(41, 8, '', 'Pengurusan Izin Tinggal');

-- --------------------------------------------------------

--
-- Table structure for table `tb_comment`
--

CREATE TABLE `tb_comment` (
  `id_comment` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `comment` text NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_comment`
--

INSERT INTO `tb_comment` (`id_comment`, `id_status`, `id_user`, `comment`, `time`) VALUES
(1, 1, 1, 'tes', '2022-06-27 13:51:03'),
(2, 2, 1, 'tessss', '2022-06-28 11:51:02'),
(3, 2, 1, 'test', '2022-06-29 15:01:13'),
(4, 2, 1, 'y', '2022-06-29 15:01:33'),
(5, 1, 1, 'y', '2022-06-29 15:04:37'),
(6, 2, 1, 'tr', '2022-06-29 15:11:42'),
(7, 2, 1, 'tr', '2022-06-29 15:11:56'),
(8, 2, 1, 'y', '2022-06-29 15:13:26'),
(9, 2, 1, 'tes', '2022-06-29 15:39:43'),
(10, 3, 1, 'test', '2022-06-29 15:52:33'),
(11, 3, 1, 'y', '2022-06-29 15:52:42'),
(12, 3, 1, 'rr', '2022-06-29 15:52:56'),
(13, 3, 1, 'u', '2022-06-29 15:53:27'),
(14, 3, 1, 'r', '2022-06-29 15:53:41'),
(15, 4, 1, 'yy', '2022-06-29 15:54:12'),
(16, 4, 1, 'tws', '2022-06-29 15:54:26'),
(17, 4, 1, 'rt', '2022-06-29 15:54:33'),
(18, 4, 1, 'rt', '2022-06-29 15:55:13'),
(19, 4, 1, 'yy', '2022-06-29 15:55:22'),
(20, 5, 1, 'tr', '2022-06-29 15:56:28'),
(21, 5, 1, 'rt', '2022-06-29 15:56:47'),
(22, 5, 1, 'rr', '2022-06-29 15:56:55'),
(23, 5, 1, 'yy', '2022-06-29 15:57:02'),
(24, 1, 1, 'rt', '2022-06-29 16:06:56'),
(25, 5, 1, 'y', '2022-06-30 08:25:34'),
(26, 6, 1, 'yy', '2022-06-30 13:50:40'),
(27, 6, 1, 'tesss', '2022-06-30 14:36:50'),
(28, 6, 1, 't', '2022-06-30 14:37:20'),
(29, 5, 1, 'ok', '2022-06-30 14:37:33'),
(30, 6, 1, 'r', '2022-06-30 14:37:49'),
(31, 6, 1, 'ok', '2022-06-30 14:38:00'),
(32, 6, 1, 'y', '2022-06-30 14:39:12'),
(33, 6, 1, 'yy', '2022-06-30 14:39:51'),
(34, 6, 1, 'yyu', '2022-06-30 14:39:59'),
(35, 6, 1, 'uk', '2022-06-30 14:40:07'),
(36, 6, 1, 'yu', '2022-06-30 14:40:51'),
(37, 6, 1, 'lok', '2022-06-30 14:43:39'),
(38, 5, 1, 'y', '2022-06-30 15:34:50'),
(39, 6, 1, 'yy', '2022-06-30 15:59:58'),
(40, 6, 1, 'yy', '2022-06-30 16:00:27'),
(41, 6, 1, 'yy', '2022-06-30 16:00:43'),
(42, 6, 1, 'lok', '2022-06-30 16:00:52'),
(43, 4, 1, 'okk', '2022-06-30 16:04:42'),
(44, 3, 1, 'yyu', '2022-06-30 16:04:53'),
(45, 4, 1, 'okk', '2022-06-30 16:05:34'),
(46, 5, 1, 'lokk', '2022-06-30 16:05:50'),
(47, 3, 1, 'yye', '2022-06-30 16:05:58'),
(48, 2, 1, 'lok', '2022-06-30 16:07:24'),
(49, 3, 1, 'ok', '2022-06-30 16:07:40'),
(50, 4, 1, 'y', '2022-06-30 16:07:54'),
(51, 5, 1, 'y', '2022-06-30 16:07:59'),
(52, 3, 1, 'lu', '2022-06-30 16:08:13'),
(53, 2, 1, 'yy', '2022-06-30 16:08:34'),
(54, 2, 1, 'loj', '2022-06-30 16:08:58'),
(55, 2, 1, 'loj', '2022-06-30 16:09:29'),
(56, 2, 1, 'jj', '2022-06-30 16:09:34'),
(57, 3, 1, 'yy', '2022-06-30 16:10:35'),
(58, 3, 1, 'yuj', '2022-06-30 16:10:41'),
(59, 5, 1, 'lok', '2022-06-30 16:11:17'),
(60, 5, 1, 'yy', '2022-06-30 16:11:24'),
(61, 4, 1, 'yyk', '2022-06-30 16:11:30'),
(62, 4, 1, 'lok', '2022-06-30 16:11:36'),
(63, 4, 1, 'yu', '2022-06-30 16:11:41'),
(64, 5, 1, 'yy', '2022-06-30 16:11:47'),
(65, 5, 1, 'tt', '2022-06-30 16:11:53'),
(66, 5, 1, 'yu', '2022-06-30 16:11:58'),
(67, 5, 1, 'll', '2022-06-30 16:12:02'),
(68, 5, 1, 'yy', '2022-06-30 16:15:57'),
(69, 4, 1, 'luk', '2022-06-30 16:16:04'),
(70, 3, 1, 'lok', '2022-06-30 16:16:10'),
(71, 5, 1, 'yy', '2022-06-30 16:16:30'),
(72, 4, 1, 'lok', '2022-06-30 16:16:44'),
(73, 8, 1, 'naik mobili dong pak', '2022-06-30 16:31:31'),
(74, 8, 1, 'test', '2022-07-08 14:26:15'),
(75, 13, 1, 'yy', '2022-07-08 14:46:09');

-- --------------------------------------------------------

--
-- Table structure for table `tb_contractor`
--

CREATE TABLE `tb_contractor` (
  `id_contractor` int(11) NOT NULL,
  `id_estate_cordinator` int(11) NOT NULL,
  `name_contractor` varchar(150) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_contractor`
--

INSERT INTO `tb_contractor` (`id_contractor`, `id_estate_cordinator`, `name_contractor`, `username`, `password`) VALUES
(1, 1, 'PT HAM', 'kontraktor04', '7cbdc623517d34967b7b99852d223507'),
(2, 1, 'PT BIOSIS', 'kontraktor05', '5bfd4daf66d89965ad4679a7f1bdaa6e');

-- --------------------------------------------------------

--
-- Table structure for table `tb_contractor_job`
--

CREATE TABLE `tb_contractor_job` (
  `id_contractor_job` int(11) NOT NULL,
  `id_contractor` int(11) NOT NULL,
  `id_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_contractor_job`
--

INSERT INTO `tb_contractor_job` (`id_contractor_job`, `id_contractor`, `id_category`) VALUES
(1, 1, 1),
(2, 1, 2),
(3, 1, 3),
(4, 1, 5),
(5, 2, 1),
(6, 2, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tb_detail_klasifikasi_category`
--

CREATE TABLE `tb_detail_klasifikasi_category` (
  `id_klasifikasi_detail` int(11) NOT NULL,
  `id_klasifikasi` int(11) NOT NULL,
  `id_report` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_detail_klasifikasi_category`
--

INSERT INTO `tb_detail_klasifikasi_category` (`id_klasifikasi_detail`, `id_klasifikasi`, `id_report`) VALUES
(1, 11, 1),
(4, 11, 2),
(5, 13, 2),
(6, 15, 2),
(7, 9, 3),
(8, 13, 3),
(9, 11, 4),
(10, 13, 4),
(11, 9, 5),
(12, 11, 5),
(13, 13, 5),
(14, 11, 6),
(15, 13, 6),
(16, 11, 7),
(17, 13, 7),
(18, 7, 8),
(19, 15, 9),
(20, 46, 10),
(21, 19, 11),
(22, 13, 12),
(23, 11, 13),
(24, 13, 13),
(25, 51, 14),
(26, 26, 14),
(27, 3, 15),
(28, 2, 16),
(29, 45, 17),
(30, 2, 18),
(31, 3, 18),
(32, 5, 18),
(33, 11, 19),
(34, 3, 20),
(35, 9, 21),
(36, 11, 21),
(37, 11, 1),
(38, 13, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_estate_cordinator`
--

CREATE TABLE `tb_estate_cordinator` (
  `id_estate_cordinator` int(11) NOT NULL,
  `name_estate_cordinator` varchar(255) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_estate_cordinator`
--

INSERT INTO `tb_estate_cordinator` (`id_estate_cordinator`, `name_estate_cordinator`, `username`, `password`) VALUES
(1, 'Iskandar', 'cordinator1', 'd6bc62e260dd0eff33686800a8d97ac5'),
(2, 'Iskandar', 'kontraktor05', '5bfd4daf66d89965ad4679a7f1bdaa6e'),
(3, 'Cecep', 'kontraktor06', '5bfd4daf66d89965ad4679a7f1bdaa6e');

-- --------------------------------------------------------

--
-- Table structure for table `tb_estate_cordinator_job`
--

CREATE TABLE `tb_estate_cordinator_job` (
  `id_estate_cordinator_job` int(11) NOT NULL,
  `id_estate_cordinator` int(11) NOT NULL,
  `id_master_category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_estate_cordinator_job`
--

INSERT INTO `tb_estate_cordinator_job` (`id_estate_cordinator_job`, `id_estate_cordinator`, `id_master_category`) VALUES
(1, 2, 1),
(2, 3, 2);

-- --------------------------------------------------------

--
-- Table structure for table `tb_estate_manager`
--

CREATE TABLE `tb_estate_manager` (
  `id_estate_manager` int(11) NOT NULL,
  `name_estate_manager` varchar(150) NOT NULL,
  `job` varchar(150) NOT NULL,
  `username` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `tb_klasifikasi_category`
--

CREATE TABLE `tb_klasifikasi_category` (
  `id_klasifikasi` int(11) NOT NULL,
  `id_category_detail` int(11) NOT NULL,
  `id_category` int(11) NOT NULL,
  `klasifikasi` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_klasifikasi_category`
--

INSERT INTO `tb_klasifikasi_category` (`id_klasifikasi`, `id_category_detail`, `id_category`, `klasifikasi`) VALUES
(1, 1, 1, 'Pohon terlalu tinggi'),
(2, 1, 1, 'Cabang pohon menggangu'),
(3, 1, 1, 'Pelepah pohon banyak yang kering'),
(5, 2, 1, 'Rumput Tinggi'),
(7, 3, 1, 'Tanaman Sudah Tinggi'),
(9, 4, 2, 'Sampah Belum di angkat'),
(11, 5, 2, 'Lingkungan kotor/banyak sampah'),
(13, 6, 2, 'Banyak rumput liar dijalan'),
(15, 7, 2, 'Saluran mamper/air tidak mengalir'),
(16, 8, 3, 'Banyak nyamuk'),
(17, 8, 3, 'Kasus demam berdarah'),
(18, 9, 3, 'Banyak tikus dihalaman'),
(19, 10, 3, 'Keluhan monyet liar'),
(20, 10, 3, 'Keluhan kucing liar'),
(21, 11, 3, 'Keluhan Banyak Rayap'),
(22, 12, 4, 'Pju padam'),
(23, 12, 4, 'Pju/Lampu sorot keropos/rusak'),
(24, 13, 4, 'Pju keropos'),
(26, 14, 4, 'Barier gate error'),
(27, 15, 7, 'air kolam keruh'),
(29, 17, 6, 'Proyek berisik'),
(32, 18, 1, 'Banyak semut/belalang/kutu/serangga'),
(34, 19, 5, 'CCTV rusak'),
(36, 15, 7, 'Pompa rusak'),
(37, 17, 6, 'Pelanggaran izin kerja'),
(42, 20, 1, 'Tanaman Kering'),
(43, 23, 1, 'Tanaman tidak sehat'),
(44, 24, 1, 'Banyak tanaman liar di taman'),
(45, 25, 2, 'Brandgang kotor'),
(46, 25, 2, 'Banyak material/barang bekas'),
(47, 8, 3, 'Banyak jentik nyamuk di saluran\r\n'),
(48, 10, 3, 'Keluhan anjing liar'),
(49, 10, 3, 'Keluhan kotoran anjing'),
(50, 10, 3, 'Keluhan ular/biawak'),
(51, 13, 4, 'Panel listrik terbakar'),
(52, 14, 4, 'Barier gate rusak'),
(53, 26, 4, 'Lampu taman padam'),
(54, 27, 5, 'Kamar mandi bau'),
(55, 27, 5, 'Toilet kotor'),
(56, 27, 5, 'Toilet bau'),
(57, 27, 5, 'Toilet mampet'),
(58, 28, 1, 'Rumah pompa kotor'),
(60, 29, 6, 'Rumah jadi kantor/catering/warung/gudang'),
(61, 30, 6, 'Pos jaga bocor/kotor/rusak'),
(62, 31, 6, 'Jalan bolong / bergelombang'),
(63, 31, 6, 'Pemasangan polisi tidur'),
(64, 32, 6, 'Pagar rusak / karatan'),
(65, 33, 8, 'Keterlambatan terbit izin perbaikan non deposit'),
(66, 34, 8, 'Keterlambatan terbit izin renovasi deposit\r\n'),
(67, 35, 8, 'Keterlambatan terbit id card'),
(68, 36, 8, 'Keterlambatan terbit izin kendaraan proyek'),
(69, 37, 8, 'Keterlambatan terbit refund deposit'),
(70, 38, 8, 'Keterlambatan terbit kartu akses'),
(71, 39, 8, 'Keterlambatan terbit izin kegiatan'),
(72, 40, 8, 'Keterlambatan terbit izin tinggal');

-- --------------------------------------------------------

--
-- Table structure for table `tb_like_status`
--

CREATE TABLE `tb_like_status` (
  `id_like` int(11) NOT NULL,
  `id_status` int(11) NOT NULL,
  `id_user` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_like_status`
--

INSERT INTO `tb_like_status` (`id_like`, `id_status`, `id_user`) VALUES
(48, 1, 1),
(62, 3, 1),
(63, 2, 1),
(65, 4, 1),
(66, 5, 1);

-- --------------------------------------------------------

--
-- Table structure for table `tb_master_category`
--

CREATE TABLE `tb_master_category` (
  `id_master_category` int(11) NOT NULL,
  `id_cordinator` int(11) NOT NULL,
  `unit` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_master_category`
--

INSERT INTO `tb_master_category` (`id_master_category`, `id_cordinator`, `unit`) VALUES
(1, 0, 'Pertamanan, kebersihan, dan clubhouse'),
(2, 0, 'ME, INFRA dan kolam renang'),
(3, 0, 'Building Control dan security'),
(4, 0, 'Administrasi');

-- --------------------------------------------------------

--
-- Table structure for table `tb_news`
--

CREATE TABLE `tb_news` (
  `id_news` int(11) NOT NULL,
  `url_news_image` varchar(255) NOT NULL,
  `caption` varchar(150) NOT NULL,
  `content` text NOT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `writer` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_news`
--

INSERT INTO `tb_news` (`id_news`, `url_news_image`, `caption`, `content`, `time`, `writer`) VALUES
(3, 'imagenews/1.png', 'ini berita 1', 'Keputusan Presiden Joko Widodo untuk mengganti sejumlah menterinya di periode kedua kepemimpinan menuai respons miring dari sejumlah pihak, terutama dua partai oposisi Demokrat dan PKS.\r\nLangkah reshuffle kabinet disebut-sebut hanya untuk memenuhi ambisi politik Jokowi dua tahun sebelum habis masa jabatan pada 2024. Terutama untuk mengakomodir partai koalisi pemerintah.\r\n\r\nDeputi Badan Pemenangan Pemilu (Bappilu) Partai Demokrat, Kamhar Lakumani menilai reshuffle kali ini tak menjawab persoalan masyarakat atau memaksimalkan kinerja di dua tahun terakhir masa jabatan.\r\n\r\n\r\n\r\n\"Terbaca bahwa perombakan ini lebih memenuhi dan melayani kepentingan politik Pak Jokowi bukan untuk menyelesaikan persoalan rakyat atau mengoptimalkan kinerja di akhir masa jabatan,\" kata dia kepada CNNIndonesia.com, Rabu (15/6).\r\n', '2022-06-16 13:07:56', 'admin 1'),
(4, 'imagenews/2.jpg', 'ini contoh berita 2', 'Jauh sebelum kepergian Emmeril Kahn Mumtadz,  Gubernur Jawa Barat, Ridwan Kamil beserta Atalia Praratya ternyata sudah lebih dulu memutuskan mengasuh seorang malaikat kecil untuk dijadikan anak bungsu dalam keluarganya tersebut. Tidak dipungkiri, setelah meninggalnya sosok Eril putra sulung dari Ridwan Kamil ini, sosok anak kecil yang diduga anak asuh dari pasangan Gubernur Jawa Barat ini memang langsung menjadi sorotan publik. Pasalnya, banyak warganet dan masyarakat yang menganggap kehadiran malaikat kecil itu seolah sengaja dipersiapkan oleh Allah SWT untuk menjadi pelipur lara Ridwan Kamil dan sekeluarga, selepas kepergian Eril ke pangkuan Rahmatullah. \r\n\r\nArtikel ini sudah tayang di VIVA.co.id pada hari Kamis, 16 Juni 2022 - 05:59 WIB\r\nJudul Artikel : Terkuak, Awal Mula Ridwan Kamil Angkat Arkana Jadi Anaknya\r\nLink Artikel : https://www.viva.co.id/berita/nasional/1485778-terkuak-awal-mula-ridwan-kamil-angkat-arkana-jadi-anaknya\r\nOleh : Dian Lestari Ningsih', '2022-06-16 13:12:51', 'admin 2'),
(8, 'imagenews/b3245aaf9addde3d2281d9bfab66d8f9becca276.png', 'asskskskskskkskssssssssssssaaaaaaaaaaaaaaaaaaaaa', 'kakakskjdskjdksjkakkkkaaaaaaaaaaaaaaaaaaaaaaaaasdnsadnnn', '2022-06-17 13:43:44', 'adminku');

-- --------------------------------------------------------

--
-- Table structure for table `tb_process_report`
--

CREATE TABLE `tb_process_report` (
  `id_process_report` int(11) NOT NULL,
  `id_report` int(11) NOT NULL,
  `id_user` int(11) NOT NULL,
  `id_estate_cordinator` int(11) NOT NULL,
  `status_process` varchar(150) NOT NULL,
  `current_time_process` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_process_report`
--

INSERT INTO `tb_process_report` (`id_process_report`, `id_report`, `id_user`, `id_estate_cordinator`, `status_process`, `current_time_process`) VALUES
(1, 1, 1, 0, 'Laporan diteruskan ke bagian Perawatan taman dan kebersihan', '2022-07-08 13:58:47'),
(2, 1, 0, 2, 'Laporan diterima oleh estate cordinator (Iskandar)', '2022-07-08 13:59:00'),
(3, 1, 0, 2, 'Laporan sedang dikerjakan', '2022-07-08 13:59:07');

-- --------------------------------------------------------

--
-- Table structure for table `tb_process_work_cordinator`
--

CREATE TABLE `tb_process_work_cordinator` (
  `id_process_work` int(11) NOT NULL,
  `id_report` int(11) NOT NULL,
  `id_estate_cordinator` int(11) NOT NULL,
  `photo_work_1` varchar(255) NOT NULL,
  `photo_work_2` varchar(255) NOT NULL,
  `photo_complete_1` varchar(255) NOT NULL,
  `photo_complete_2` varchar(255) NOT NULL,
  `current_time_work` datetime NOT NULL DEFAULT current_timestamp(),
  `finish_time` datetime NOT NULL,
  `duration` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_process_work_cordinator`
--

INSERT INTO `tb_process_work_cordinator` (`id_process_work`, `id_report`, `id_estate_cordinator`, `photo_work_1`, `photo_work_2`, `photo_complete_1`, `photo_complete_2`, `current_time_work`, `finish_time`, `duration`) VALUES
(1, 1, 2, 'imagecordinatorwork/1d94fc735bbe4587a986c22bbe73cc74bbb8e8cf.jpg', '', '', '', '2022-07-08 13:59:07', '0000-00-00 00:00:00', '');

-- --------------------------------------------------------

--
-- Table structure for table `tb_report`
--

CREATE TABLE `tb_report` (
  `id_report` int(255) NOT NULL,
  `id_user` int(255) NOT NULL,
  `no_ticket` varchar(50) NOT NULL,
  `description` text NOT NULL,
  `date_post` date NOT NULL,
  `time_post` time NOT NULL,
  `category` varchar(255) NOT NULL,
  `id_category` int(100) NOT NULL,
  `url_image` varchar(255) NOT NULL,
  `status` varchar(50) NOT NULL,
  `star` int(11) NOT NULL,
  `comment` varchar(255) NOT NULL,
  `comment_time` datetime NOT NULL,
  `urut` int(100) NOT NULL,
  `latitude` varchar(150) NOT NULL,
  `longitude` varchar(150) NOT NULL,
  `address` varchar(255) NOT NULL,
  `id_category_detail` int(11) NOT NULL,
  `id_klasifikasi_category` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_report`
--

INSERT INTO `tb_report` (`id_report`, `id_user`, `no_ticket`, `description`, `date_post`, `time_post`, `category`, `id_category`, `url_image`, `status`, `star`, `comment`, `comment_time`, `urut`, `latitude`, `longitude`, `address`, `id_category_detail`, `id_klasifikasi_category`) VALUES
(1, 1, '202207/00001', 'chcycucuvubbhhjj', '2022-07-08', '13:58:47', 'Kebersihan Lingkungan', 2, 'imagereport/dce73d2d51dc3874876582500631a926fbbd8c0e.jpg', 'process', 0, '', '0000-00-00 00:00:00', 1, '-6.1876768', '106.6934804', 'RM6V+R9Q, Jl. Kihajar Dewantoro, RT.006/RW.001, Gondrong, Kec. Cipondoh, Kota Tangerang, Banten 15146, Indonesia', 0, '');

-- --------------------------------------------------------

--
-- Table structure for table `tb_status`
--

CREATE TABLE `tb_status` (
  `id_status` int(255) NOT NULL,
  `id_user` int(255) NOT NULL,
  `username` varchar(50) NOT NULL,
  `upload_time` datetime NOT NULL DEFAULT current_timestamp(),
  `foto_profile` varchar(255) NOT NULL,
  `status_image` varchar(255) NOT NULL,
  `caption` text NOT NULL,
  `comment` int(11) NOT NULL,
  `like` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_status`
--

INSERT INTO `tb_status` (`id_status`, `id_user`, `username`, `upload_time`, `foto_profile`, `status_image`, `caption`, `comment`, `like`) VALUES
(1, 1, 'testadmin', '2022-06-13 13:08:17', '/imageuser/default_profile/blank_profile_picture.jpg', 'imagestatus/9de4271080658a9b231c0ea2c6e8d70c14356c9c.jpg', '', 3, 0),
(2, 1, 'testadmin', '2022-06-28 11:50:44', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'tesssss', 12, 0),
(3, 1, 'testadmin', '2022-06-29 15:47:59', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'test\n', 12, 0),
(4, 1, 'testadmin', '2022-06-29 15:54:07', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'tr', 13, 0),
(5, 1, 'testadmin', '2022-06-29 15:56:20', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 't', 17, 0),
(6, 1, 'testadmin', '2022-06-30 10:19:37', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'imagestatus/6bb4d9bab8efdaaa713b42d658761f7c0b4fecd3.jpg', '', 15, 0),
(7, 1, 'testadmin', '2022-06-30 16:20:12', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'gimana ceritanya makan batu bata', 0, 0),
(8, 1, 'testadmin', '2022-06-30 16:21:48', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'gimana ya caranya ke pik 2', 2, 0),
(9, 1, 'testadmin', '2022-07-08 14:08:01', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'blok', 0, 0),
(10, 1, 'testadmin', '2022-07-08 14:09:56', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'yyy', 0, 0),
(11, 1, 'testadmin', '2022-07-08 14:45:04', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'tost', 0, 0),
(12, 1, 'testadmin', '2022-07-08 14:45:30', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'test', 0, 0),
(13, 1, 'testadmin', '2022-07-08 14:45:40', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'tidt', 1, 0),
(14, 1, 'testadmin', '2022-07-08 16:38:32', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'test', 0, 0),
(15, 1, 'testadmin', '2022-07-08 16:39:49', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'tess', 0, 0),
(16, 1, 'testadmin', '2022-07-08 16:41:09', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'tr', 0, 0),
(17, 1, 'testadmin', '2022-07-08 16:44:38', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 'no_image', 'ty', 0, 0);

-- --------------------------------------------------------

--
-- Table structure for table `tb_user`
--

CREATE TABLE `tb_user` (
  `id_user` int(11) NOT NULL,
  `no_ipl` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `no_telp` varchar(50) NOT NULL,
  `username` varchar(100) NOT NULL,
  `password` varchar(100) NOT NULL,
  `profile_image` varchar(255) NOT NULL,
  `otp` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `tb_user`
--

INSERT INTO `tb_user` (`id_user`, `no_ipl`, `email`, `no_telp`, `username`, `password`, `profile_image`, `otp`) VALUES
(1, '', 'testadmin@gmail.com', '0857123111', 'testadmin', 'afa36c2f1db8d683e055475d3902ce21', 'imageuser/9245ca6c2923c039ba64ccdc0cd2288f328d087a.jpg', 0),
(2, '', 'asdadsadasd', '085714342528', '', '', '', 322378),
(3, '', 'asdjsadjasdj', '085714342528', '', '', '', 417573),
(4, '', 'asdad', '085714342528', '', '', '', 305198),
(5, '', 'feriwnarta26@gmail.com', '085714342528', '', '', '', 650791),
(6, '', 'feriwnarta26@asdad.com', '085714342528', '', '', '', 377276);

--
-- Indexes for dumped tables
--

--
-- Indexes for table `tb_bill_event`
--
ALTER TABLE `tb_bill_event`
  ADD PRIMARY KEY (`id_event`);

--
-- Indexes for table `tb_category`
--
ALTER TABLE `tb_category`
  ADD PRIMARY KEY (`id_category`);

--
-- Indexes for table `tb_category_detail`
--
ALTER TABLE `tb_category_detail`
  ADD PRIMARY KEY (`id_category_detail`);

--
-- Indexes for table `tb_comment`
--
ALTER TABLE `tb_comment`
  ADD PRIMARY KEY (`id_comment`);

--
-- Indexes for table `tb_contractor`
--
ALTER TABLE `tb_contractor`
  ADD PRIMARY KEY (`id_contractor`);

--
-- Indexes for table `tb_contractor_job`
--
ALTER TABLE `tb_contractor_job`
  ADD PRIMARY KEY (`id_contractor_job`);

--
-- Indexes for table `tb_detail_klasifikasi_category`
--
ALTER TABLE `tb_detail_klasifikasi_category`
  ADD PRIMARY KEY (`id_klasifikasi_detail`);

--
-- Indexes for table `tb_estate_cordinator`
--
ALTER TABLE `tb_estate_cordinator`
  ADD PRIMARY KEY (`id_estate_cordinator`);

--
-- Indexes for table `tb_estate_cordinator_job`
--
ALTER TABLE `tb_estate_cordinator_job`
  ADD PRIMARY KEY (`id_estate_cordinator_job`);

--
-- Indexes for table `tb_estate_manager`
--
ALTER TABLE `tb_estate_manager`
  ADD PRIMARY KEY (`id_estate_manager`);

--
-- Indexes for table `tb_klasifikasi_category`
--
ALTER TABLE `tb_klasifikasi_category`
  ADD PRIMARY KEY (`id_klasifikasi`);

--
-- Indexes for table `tb_like_status`
--
ALTER TABLE `tb_like_status`
  ADD PRIMARY KEY (`id_like`);

--
-- Indexes for table `tb_master_category`
--
ALTER TABLE `tb_master_category`
  ADD PRIMARY KEY (`id_master_category`);

--
-- Indexes for table `tb_news`
--
ALTER TABLE `tb_news`
  ADD PRIMARY KEY (`id_news`);

--
-- Indexes for table `tb_process_report`
--
ALTER TABLE `tb_process_report`
  ADD PRIMARY KEY (`id_process_report`);

--
-- Indexes for table `tb_process_work_cordinator`
--
ALTER TABLE `tb_process_work_cordinator`
  ADD PRIMARY KEY (`id_process_work`);

--
-- Indexes for table `tb_report`
--
ALTER TABLE `tb_report`
  ADD PRIMARY KEY (`id_report`);

--
-- Indexes for table `tb_status`
--
ALTER TABLE `tb_status`
  ADD PRIMARY KEY (`id_status`);

--
-- Indexes for table `tb_user`
--
ALTER TABLE `tb_user`
  ADD PRIMARY KEY (`id_user`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `tb_bill_event`
--
ALTER TABLE `tb_bill_event`
  MODIFY `id_event` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_category`
--
ALTER TABLE `tb_category`
  MODIFY `id_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `tb_category_detail`
--
ALTER TABLE `tb_category_detail`
  MODIFY `id_category_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `tb_comment`
--
ALTER TABLE `tb_comment`
  MODIFY `id_comment` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=76;

--
-- AUTO_INCREMENT for table `tb_contractor`
--
ALTER TABLE `tb_contractor`
  MODIFY `id_contractor` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_contractor_job`
--
ALTER TABLE `tb_contractor_job`
  MODIFY `id_contractor_job` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `tb_detail_klasifikasi_category`
--
ALTER TABLE `tb_detail_klasifikasi_category`
  MODIFY `id_klasifikasi_detail` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=39;

--
-- AUTO_INCREMENT for table `tb_estate_cordinator`
--
ALTER TABLE `tb_estate_cordinator`
  MODIFY `id_estate_cordinator` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_estate_cordinator_job`
--
ALTER TABLE `tb_estate_cordinator_job`
  MODIFY `id_estate_cordinator_job` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `tb_estate_manager`
--
ALTER TABLE `tb_estate_manager`
  MODIFY `id_estate_manager` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tb_klasifikasi_category`
--
ALTER TABLE `tb_klasifikasi_category`
  MODIFY `id_klasifikasi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `tb_like_status`
--
ALTER TABLE `tb_like_status`
  MODIFY `id_like` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `tb_master_category`
--
ALTER TABLE `tb_master_category`
  MODIFY `id_master_category` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `tb_news`
--
ALTER TABLE `tb_news`
  MODIFY `id_news` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `tb_process_report`
--
ALTER TABLE `tb_process_report`
  MODIFY `id_process_report` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `tb_process_work_cordinator`
--
ALTER TABLE `tb_process_work_cordinator`
  MODIFY `id_process_work` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_report`
--
ALTER TABLE `tb_report`
  MODIFY `id_report` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tb_status`
--
ALTER TABLE `tb_status`
  MODIFY `id_status` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `tb_user`
--
ALTER TABLE `tb_user`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
