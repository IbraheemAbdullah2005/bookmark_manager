-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 13, 2026 at 01:01 PM
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
-- Database: `bookmark_manager`
--

-- --------------------------------------------------------

--
-- Table structure for table `bookmarks`
--

CREATE TABLE `bookmarks` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `url` text NOT NULL,
  `image` text DEFAULT NULL,
  `description` text DEFAULT NULL,
  `tags` varchar(255) DEFAULT NULL,
  `created_at` varchar(50) DEFAULT NULL,
  `updated_at` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `bookmarks`
--

INSERT INTO `bookmarks` (`id`, `user_id`, `name`, `url`, `image`, `description`, `tags`, `created_at`, `updated_at`) VALUES
(1, 1, 'Claude AI', 'https://claude.ai/', 'https://external-content.duckduckgo.com/ip3/claude.ai.ico', 'AI assistant from Anthropic', 'AI, Tool', '11/1/2024', ''),
(2, 1, 'Replit', 'https://replit.com/', 'https://external-content.duckduckgo.com/ip3/replit.com.ico', 'Collaborative browser-based IDE', 'AI, Build', '2/13/2025', '2/16/2025'),
(3, 1, 'n8n', 'https://n8n.io/', 'https://external-content.duckduckgo.com/ip3/n8n.io.ico', 'free and source-available workflow automation tool', 'Automation, Tool', '2/12/2025', ''),
(5, 1, 'Lucide Icons', 'https://lucide.dev/icons/', 'https://lucide.dev/favicon.ico', 'Browse all Lucide icons.', 'Tool', '05/13/2026', NULL),
(6, 1, 'BookmarkManager.com - Standalone Bookmark Manager', 'https://bookmarkmanager.com/', 'https://bookmarkmanager.com/favicon.svg', 'A standalone, cross-platform bookmark manager that relies on tags to organize and rediscover links. Built for individuals.', 'Tool', '05/13/2026', NULL),
(8, 1, '‏Google Gemini', 'https://gemini.google.com/app?hl=ar', 'https://www.gstatic.com/lamda/images/gemini_sparkle_aurora_33f86dc0c0257da337c63.svg', 'نقدّم لك Gemini، المساعد المستند إلى ذكاء Google الاصطناعي، وهو على أتمّ الاستعداد لدعمك في الكتابة والتخطيط واستلهام الأفكار والمزيد. إمكانات الذكاء الاصطناعي التوليدي في متناول يديك.', 'Tool', '05/13/2026', NULL),
(9, 1, 'Google Translate', 'https://translate.google.com/?sl=en&tl=ar&op=translate', 'https://www.gstatic.com/translate/favicon.ico', 'Google\'s service, offered free of charge, instantly translates words, phrases, and web pages between English and over 100 other languages.', 'Tool', '05/13/2026', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`id`, `email`, `password`, `created_at`) VALUES
(1, 'ibraheem@gmail.com', '$2y$10$.67uVgyqDg7iGS9jCJpZ/uPDGTbEJLANRj1syTYyXPDlGEdsRGhXK', '2026-05-11 13:23:50');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

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
-- AUTO_INCREMENT for table `bookmarks`
--
ALTER TABLE `bookmarks`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `bookmarks`
--
ALTER TABLE `bookmarks`
  ADD CONSTRAINT `bookmarks_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
