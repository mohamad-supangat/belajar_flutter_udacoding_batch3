-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `task7_failed_jobs`;
CREATE TABLE `task7_failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `task7_failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `task7_kamus`;
CREATE TABLE `task7_kamus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `task7_migrations`;
CREATE TABLE `task7_migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `task7_migrations` (`id`, `migration`, `batch`) VALUES
(1,	'2014_10_12_000000_create_users_table',	1),
(2,	'2014_10_12_100000_create_password_resets_table',	1),
(3,	'2019_08_19_000000_create_failed_jobs_table',	1),
(4,	'2020_11_09_042126_create_news_table',	1),
(5,	'2020_11_11_043938_create_kamus_table',	1);

DROP TABLE IF EXISTS `task7_news`;
CREATE TABLE `task7_news` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Judul berita',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Url Gambar / foto',
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Isi Berita',
  `user` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Nama user yang membuat berita',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `task7_news` (`id`, `title`, `image`, `body`, `user`, `created_at`, `updated_at`) VALUES
(1,	'Amankah Vaksin Pfizer Virus Corona untuk Ibu Hamil? Ini Kata Ahli!',	'https://media.suara.com/pictures/653x366/2020/10/29/10210-ibu-hamil-unsplash.jpg',	'Suara.com - Baru-baru ini, vaksin Pfizer telah dibuktikan mampu mencegah orang tertular virus corona Covid-19 sebesar 90 persen. Kabar yang menggembirakan ini pun seolah memberi angin segar di tengah pandemi virus corona.\r\n\r\nTapi, vaksin virus corona ini masih harus melalui beberapa proses pengembangan, sebelum akhirnya tersedia dalam jumlah banyak dan distribusikan ke masyarakat umum.\r\n\r\nRintangan yang harus dilalui termasuk berbagai uji coba keamanan dan pengaruh vaksin Pfizer pada orang yang menerimanya.\r\n\r\nPara ahli dari Universitas Johns Hopkins di Baltimore, salah satu lembaga peneliti medis terkemuka dunia, mengatakan data khusus penggunaan vaksin Pfizer pada wanita hamil akan segera rilis.\r\n\r\nBaca Juga:\r\nWaspada, Gagal jantung Bisa Disebabkan Oleh Hipertensi Jangka Panjang\r\n\r\nRuth Karron, Ruth Faden dan Carleigh Krubiner, pemimpin Penelitian Etika Kehamilan untuk vaksin, epidemi dan teknologi baru ini pun telah menjelaskan arti vaksin virus bagi wanita hamil.\r\n\r\nIlustrasi Vaksin. (Pixabay/PhotoLizM)\r\nIlustrasi Vaksin. (Pixabay/PhotoLizM)\r\n\"Ketika vaksin virus pertama tersedia, kecil kemungkinannya akan ada bukti keberhasilan percobaan pada wanita hamil,\" jelas mereka dikutip dari Express.\r\n\r\nMereka memiliki beberapa wawasan mengenai keterkaitan wanita hamil dalam uji coba kemanjuran vaksin virus corona. Tapi, mereka mengatakan masih kecil kemungkinannya wanita hamil menjadi orang pertama yang mendapatkan vaksin.\r\n\r\nPara peneliti menambahkan, mereka yang memutuskan pemberian vaksin harus mempertimbangkan risiko vaksinasi dan tidak. Namun, ini akhirnya juga tergantung pada gambaran para ahli kesehatan.\r\n\r\n\"Faktor lain yang perlu dipertimbangkan adalah kami akan memiliki lebih banyak data tentang efek virus corona bagi pada kehamilan di awal 2021,\" jelasnya.\r\n\r\nBaca Juga:\r\nHipertensi Jangka Panjang Bisa Sebabkan Gagal Jantung\r\n\r\nBukti tersebut dianggap penting karena bisa memberi tahu peneliti dan para ahli mengenai risikonya. Jika virus menimbulkan risiko besar bagi wanita hamil, maka kemungkinan wanita hamil akan menjadi kelompok pertama yang akan menerima vaksin.\r\n\r\n\"Pengambil keputusan harus selalu mempertimbangkan risiko vaksinasi dibandingkan dengan risiko tidak divaksinasi terhadap penyakit yang bisa menyebabkan bahaya serius,\" jelasnya.\r\n\r\nPara peneliti pun berharap segera mendapatkan gambaran jelas mengenai vaksin ini di awal tahun depan. Mengingat vaksin belum selesai uji coba dan berbagai sertifikasi, jadi belum tahu seberapa aman vaksin virus corona ini pada ibu hamil.\r\n\r\nPeneliti ingin memastikan vaksin virus corona ini aman untuk ibu hamil, seperti vaksin lainnya. Vaksin batuk rejan dan flu termasuk vaksin yang aman dan memberi perlindungan pada ibu hamil.',	'Admin',	'2020-11-13 03:59:18',	NULL);

DROP TABLE IF EXISTS `task7_password_resets`;
CREATE TABLE `task7_password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `task7_password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `task7_users`;
CREATE TABLE `task7_users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `photo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `task7_users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


-- 2020-11-25 08:30:27
