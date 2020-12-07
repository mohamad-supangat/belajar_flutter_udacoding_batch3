-- Adminer 4.7.7 MySQL dump

SET NAMES utf8;
SET time_zone = '+00:00';
SET foreign_key_checks = 0;
SET sql_mode = 'NO_AUTO_VALUE_ON_ZERO';

SET NAMES utf8mb4;

DROP TABLE IF EXISTS `categories`;
CREATE TABLE `categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'nama kategori',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Nama Kategori',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `categories` (`id`, `name`, `description`, `created_at`, `updated_at`) VALUES
(1,	'Supangat',	NULL,	'2020-12-07 02:31:55',	'2020-12-07 02:31:55'),
(2,	'Testing',	NULL,	'2020-12-07 02:32:30',	'2020-12-07 02:32:30');

DROP TABLE IF EXISTS `category_transaction`;
CREATE TABLE `category_transaction` (
  `transaction_id` int(11) NOT NULL,
  `category_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `category_transaction` (`transaction_id`, `category_id`) VALUES
(1,	1),
(2,	2);

DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `connection` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `payload` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `exception` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `migrations` (`id`, `migration`, `batch`) VALUES
(34,	'2014_10_12_000000_create_users_table',	1),
(35,	'2014_10_12_100000_create_password_resets_table',	1),
(36,	'2019_08_19_000000_create_failed_jobs_table',	1),
(37,	'2020_11_26_130805_create_categorys_table',	1),
(38,	'2020_11_26_130813_create_transactions_table',	1),
(39,	'2020_11_26_230309_create_category_transaction_table',	1);

DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;


DROP TABLE IF EXISTS `transactions`;
CREATE TABLE `transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT 'Judul transaksi',
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Deskripsi transaksi / keterangan tambahan',
  `type` enum('in','out') COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'in' COMMENT 'jenis transaksi masuk / keluar',
  `amount` int(11) NOT NULL COMMENT 'Jumlah nilai transaksi / uang ',
  `user_id` bigint(20) unsigned NOT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transactions_user_id_foreign` (`user_id`),
  CONSTRAINT `transactions_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `transactions` (`id`, `title`, `description`, `type`, `amount`, `user_id`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1,	'asdasdasdasd',	'jasdhjgsadasd',	'in',	200000,	2,	NULL,	'2020-12-07 02:31:54',	'2020-12-07 02:31:54'),
(2,	'testing 2',	NULL,	'out',	900000,	2,	NULL,	'2020-12-07 02:32:30',	'2020-12-07 02:32:30'),
(3,	'Gajian gas',	'Gajian',	'in',	120000,	2,	NULL,	'2020-12-01 00:00:00',	'2020-12-07 02:31:54'),
(4,	'Beli Bensin',	NULL,	'out',	20000,	2,	NULL,	'2020-12-01 00:00:00',	'2020-12-07 02:32:30'),
(6,	'Gajian gas',	'Gajian',	'in',	120000,	2,	NULL,	'2020-12-02 00:00:00',	'2020-12-07 02:31:54'),
(7,	'Beli Bensin',	NULL,	'out',	20000,	2,	NULL,	'2020-12-02 00:00:00',	'2020-12-07 02:32:30'),
(9,	'Gajian gas',	'Gajian',	'in',	120000,	2,	NULL,	'2020-12-05 00:00:00',	'2020-12-07 02:31:54'),
(10,	'Beli Bensin',	NULL,	'out',	20000,	2,	NULL,	'2020-12-05 00:00:00',	'2020-12-07 02:32:30');

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
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
  UNIQUE KEY `users_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO `users` (`id`, `name`, `email`, `username`, `photo`, `email_verified_at`, `password`, `created_at`, `updated_at`) VALUES
(1,	'supangat',	'supangat@gmail.com',	'supangat',	NULL,	NULL,	'$2y$10$eny97tGvzux7hvUsHWqG3u2QGn/Dwu7cLFMYk2xB6cqUViNkyQGs6',	'2020-12-07 02:16:54',	'2020-12-07 02:16:54'),
(2,	'tamutamu',	'tamu@gmail.com',	'tamutamu',	NULL,	NULL,	'$2y$10$BQL5yBMqkLKW/iieUjLdheoVIYivR0RN501hOTyEF.A/dkRzaJIsG',	'2020-12-07 02:17:39',	'2020-12-07 02:17:39');

-- 2020-12-07 03:35:24
