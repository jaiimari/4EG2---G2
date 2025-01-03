-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Jan 03, 2025 at 02:00 AM
-- Server version: 11.6.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `python`
--

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add content type', 4, 'add_contenttype'),
(14, 'Can change content type', 4, 'change_contenttype'),
(15, 'Can delete content type', 4, 'delete_contenttype'),
(16, 'Can view content type', 4, 'view_contenttype'),
(17, 'Can add session', 5, 'add_session'),
(18, 'Can change session', 5, 'change_session'),
(19, 'Can delete session', 5, 'delete_session'),
(20, 'Can view session', 5, 'view_session'),
(21, 'Can add user', 6, 'add_user'),
(22, 'Can change user', 6, 'change_user'),
(23, 'Can delete user', 6, 'delete_user'),
(24, 'Can view user', 6, 'view_user'),
(25, 'Can add task', 7, 'add_task'),
(26, 'Can change task', 7, 'change_task'),
(27, 'Can delete task', 7, 'delete_task'),
(28, 'Can view task', 7, 'view_task'),
(29, 'Can add project', 8, 'add_project'),
(30, 'Can change project', 8, 'change_project'),
(31, 'Can delete project', 8, 'delete_project'),
(32, 'Can view project', 8, 'view_project'),
(33, 'Can add file', 9, 'add_file'),
(34, 'Can change file', 9, 'change_file'),
(35, 'Can delete file', 9, 'delete_file'),
(36, 'Can view file', 9, 'view_file'),
(37, 'Can add notification', 10, 'add_notification'),
(38, 'Can change notification', 10, 'change_notification'),
(39, 'Can delete notification', 10, 'delete_notification'),
(40, 'Can view notification', 10, 'view_notification'),
(41, 'Can add file assignment', 11, 'add_fileassignment'),
(42, 'Can change file assignment', 11, 'change_fileassignment'),
(43, 'Can delete file assignment', 11, 'delete_fileassignment'),
(44, 'Can view file assignment', 11, 'view_fileassignment');

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'contenttypes', 'contenttype'),
(5, 'sessions', 'session'),
(9, 'user_app', 'file'),
(11, 'user_app', 'fileassignment'),
(10, 'user_app', 'notification'),
(8, 'user_app', 'project'),
(7, 'user_app', 'task'),
(6, 'user_app', 'user');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2024-12-08 11:48:20.972391'),
(2, 'contenttypes', '0002_remove_content_type_name', '2024-12-08 11:48:21.024389'),
(3, 'auth', '0001_initial', '2024-12-08 11:48:21.205417'),
(4, 'auth', '0002_alter_permission_name_max_length', '2024-12-08 11:48:21.230413'),
(5, 'auth', '0003_alter_user_email_max_length', '2024-12-08 11:48:21.239423'),
(6, 'auth', '0004_alter_user_username_opts', '2024-12-08 11:48:21.247438'),
(7, 'auth', '0005_alter_user_last_login_null', '2024-12-08 11:48:21.254417'),
(8, 'auth', '0006_require_contenttypes_0002', '2024-12-08 11:48:21.256413'),
(9, 'auth', '0007_alter_validators_add_error_messages', '2024-12-08 11:48:21.263441'),
(10, 'auth', '0008_alter_user_username_max_length', '2024-12-08 11:48:21.275436'),
(11, 'auth', '0009_alter_user_last_name_max_length', '2024-12-08 11:48:21.287438'),
(12, 'auth', '0010_alter_group_name_max_length', '2024-12-08 11:48:21.352450'),
(13, 'auth', '0011_update_proxy_permissions', '2024-12-08 11:48:21.357436'),
(14, 'auth', '0012_alter_user_first_name_max_length', '2024-12-08 11:48:21.364455'),
(15, 'user_app', '0001_initial', '2024-12-08 11:48:21.518437'),
(16, 'admin', '0001_initial', '2024-12-08 11:48:21.580933'),
(17, 'admin', '0002_logentry_remove_auto_add', '2024-12-08 11:48:21.588421'),
(18, 'admin', '0003_logentry_add_action_flag_choices', '2024-12-08 11:48:21.598429'),
(19, 'sessions', '0001_initial', '2024-12-08 11:48:21.624443'),
(20, 'user_app', '0002_project_task', '2024-12-10 04:10:27.455325'),
(21, 'user_app', '0003_alter_project_end_date_alter_project_start_date', '2024-12-10 04:38:22.768066'),
(22, 'user_app', '0004_task_assigned_members', '2024-12-11 10:16:12.226131'),
(23, 'user_app', '0005_alter_task_assigned_members_teammember', '2024-12-11 10:16:12.400664'),
(24, 'user_app', '0006_alter_task_options_task_priority_alter_task_end_date_and_more', '2024-12-11 10:16:12.572208'),
(25, 'user_app', '0007_alter_task_options', '2024-12-11 10:16:12.583177'),
(26, 'user_app', '0008_user_created_by', '2024-12-15 12:39:36.427480'),
(27, 'user_app', '0009_remove_user_created_by', '2024-12-15 12:41:20.274564'),
(28, 'user_app', '0010_user_created_by', '2024-12-16 02:19:49.635017'),
(29, 'user_app', '0011_remove_user_created_by', '2024-12-16 02:20:17.476925'),
(30, 'user_app', '0012_user_created_by', '2024-12-16 02:20:32.721770'),
(31, 'user_app', '0013_alter_user_email', '2024-12-27 12:52:10.302799'),
(32, 'user_app', '0014_alter_user_email', '2024-12-27 12:58:23.260196'),
(33, 'user_app', '0015_file', '2024-12-29 03:37:19.176727'),
(34, 'user_app', '0016_remove_task_progress_percentage_and_more', '2024-12-30 06:21:58.329803'),
(35, 'user_app', '0017_task_progress', '2024-12-31 01:19:09.972662'),
(36, 'user_app', '0018_remove_task_progress', '2024-12-31 01:21:05.286507'),
(37, 'user_app', '0019_task_progress', '2024-12-31 01:23:43.756771'),
(38, 'user_app', '0020_remove_task_progress', '2024-12-31 01:30:08.692813'),
(39, 'user_app', '0021_task_progress', '2024-12-31 01:44:05.529148'),
(40, 'user_app', '0022_remove_task_progress', '2024-12-31 01:45:00.616115'),
(41, 'user_app', '0023_task_progress', '2024-12-31 01:47:08.941544'),
(42, 'user_app', '0024_remove_task_progress', '2024-12-31 01:50:50.146782'),
(43, 'user_app', '0025_task_progress', '2024-12-31 01:51:43.491611'),
(44, 'user_app', '0026_alter_task_progress', '2024-12-31 01:58:17.823773'),
(45, 'user_app', '0027_remove_task_progress', '2024-12-31 02:01:25.613948'),
(46, 'user_app', '0028_task_progress', '2024-12-31 02:02:11.944780'),
(47, 'user_app', '0029_remove_task_progress', '2024-12-31 02:04:47.694969'),
(48, 'user_app', '0030_task_progress', '2024-12-31 02:06:14.353169'),
(49, 'user_app', '0031_notification', '2024-12-31 10:22:27.615876'),
(50, 'user_app', '0032_delete_notification', '2024-12-31 10:26:50.005143'),
(51, 'user_app', '0033_notification', '2024-12-31 10:27:06.056615'),
(52, 'user_app', '0034_delete_notification', '2024-12-31 10:30:46.488122'),
(53, 'user_app', '0035_notification', '2024-12-31 10:32:09.893999'),
(54, 'user_app', '0036_delete_notification', '2024-12-31 10:34:47.696675'),
(55, 'user_app', '0037_notification', '2024-12-31 10:39:39.146208'),
(56, 'user_app', '0038_delete_notification', '2024-12-31 10:41:43.064811'),
(57, 'user_app', '0039_notification', '2024-12-31 11:06:46.317894'),
(58, 'user_app', '0040_alter_notification_created_at_and_more', '2024-12-31 11:13:09.260439'),
(59, 'user_app', '0041_delete_notification', '2024-12-31 11:15:08.984165'),
(60, 'user_app', '0042_notification', '2024-12-31 11:18:56.504996'),
(61, 'user_app', '0043_delete_notification', '2024-12-31 11:23:36.622567'),
(62, 'user_app', '0044_notification', '2024-12-31 11:28:49.795642'),
(63, 'user_app', '0045_delete_notification', '2024-12-31 12:58:06.166610'),
(64, 'user_app', '0046_notification', '2025-01-01 06:23:25.727444'),
(65, 'user_app', '0047_notification_task_alter_notification_user', '2025-01-01 08:59:51.607950'),
(66, 'user_app', '0048_remove_notification_task_alter_notification_user', '2025-01-01 09:02:40.696076'),
(67, 'user_app', '0049_notification_task_alter_notification_user', '2025-01-01 09:05:13.602261'),
(68, 'user_app', '0050_remove_notification_task_alter_notification_user', '2025-01-01 09:06:25.676024'),
(69, 'user_app', '0051_notification_task_alter_notification_user', '2025-01-01 09:08:45.280791'),
(70, 'user_app', '0052_remove_notification_task_alter_notification_user', '2025-01-01 09:10:20.347070'),
(71, 'user_app', '0053_fileassignment', '2025-01-02 07:21:58.044881'),
(72, 'user_app', '0054_alter_file_task', '2025-01-02 07:53:53.072173');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('0wxy3zosylp49bak0u7obco8sdxli3yo', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tRM08:mX3FIGLALp6AeIun4REmT3o9wGpyC2XEbaJGfTagiyc', '2025-01-11 01:52:24.268262'),
('2ft9cv6jjs9hcljsxj8ls6fufy0cyeqj', '.eJxVjEEOwiAQRe_C2hDGAkNduvcMZGBAqoYmpV0Z7y5NutDtf-_9t_C0rcVvLS1-YnERGsXpdwwUn6nuhB9U77OMc12XKchdkQdt8jZzel0P9--gUCu9zjkoZTmfA1hCa1zgIYPSwA6NpRHcoMF0TqA1qhgZR8zRIUcwPRSfLwjON9s:1tSx09:Sx05PqtfnIJKzzgXG9a65dhDszP3Alio6hbav5msO8Y', '2025-01-15 11:35:01.446903'),
('3oan3opd1c18eup2lkhb4slmpc0xnr6y', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tRM06:maZr7Vv-gOBVb8V02nYVQddfp7PVVdkVHgZE4yTQJ1I', '2025-01-11 01:52:22.330372'),
('3qbfr4wuz5luvdsco70klbhfwy1iyr7g', '.eJxVjMsOwiAURP-FtSEglIdL934DuQ-QqqFJaVfGf7dNutDdZM6ZeYsE61LT2vOcRhYXEcTpt0OgZ2474Ae0-yRpass8otwVedAubxPn1_Vw_w4q9LqtobiC5HXUJcLZokOESGWLTDp4GjCA4aINsFZWxeyRlEFLka3JbhCfLxr0OOk:1tLJnT:PdQ_43K-JiR3vRZaEdtZbvS5bDqFq2ZqzZ_7xJJOXJ0', '2024-12-25 10:18:23.062734'),
('53ug5n66a4nxtwiwucyu8gu4b4ks1q5r', '.eJxVjMsOwiAURP-FtSEglIdL934DuQ-QqqFJaVfGf7dNutDdZM6ZeYsE61LT2vOcRhYXEcTpt0OgZ2474Ae0-yRpass8otwVedAubxPn1_Vw_w4q9LqtobiC5HXUJcLZokOESGWLTDp4GjCA4aINsFZWxeyRlEFLka3JbhCfLxr0OOk:1tN1Ss:q4Z5eUn1s7zyLkcJKWmRRt1q5SVkAnHsH00EdYK8UmY', '2024-12-30 03:08:10.893330'),
('6ckk7ss0o0fgdheh6gwwo4qhfk3ewynf', '.eJxVjDsOwjAQBe_iGllZf4KXkj5nsNbeFQ4gW4qTCnF3iJQC2jcz76UibWuJW5clzqwuCgZ1-h0T5YfUnfCd6q3p3Oq6zEnvij5o11NjeV4P9--gUC_f2o_oMPjg2BoTDBFCJgABDhxGRmtyZjRCaAbHCZKcxQF6zt6jJVLvD-pnN9o:1tKVHB:DdGfFgjz70TMYeTVAVh-pi1A_m2-MmRBoFCVld5CIr0', '2024-12-23 04:21:41.753758'),
('6f6c8f1vmwwh0v936xni2ewg9ac0hfwg', 'e30:1tKJ8X:hE40g82kpmf0dRooVrmnq9SgGUBVVirQLzJIViJY5D4', '2024-12-22 15:23:57.963452'),
('7qkddhnh42lhhc11tkd4czv0f69kpgl7', '.eJxVjDsOwyAQRO9CHSE-RuCU6XMGtLsswUmEJWNXVu4eLLlIypn3ZnYRYVtL3BovcUriKowTl98SgV5cD5KeUB-zpLmuy4TyUORJm7zPid-30_07KNBKXyNxsIMajcmagLWzSNmT8UmHAQOo0L-8yyN6YGM7cYTJBo25JwXi8wUiIji0:1tSRtu:HsEGR30lriafBgI3AZ7jfjqgk0UYOux0NKME84oV0J4', '2025-01-14 02:22:30.868017'),
('84hpu5kifmu0lea9vleibfmmqs33rtw9', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tRM08:mX3FIGLALp6AeIun4REmT3o9wGpyC2XEbaJGfTagiyc', '2025-01-11 01:52:24.565975'),
('9jislvhb1n660yfsa4vd4fei9nvyef1p', '.eJxVjDsOwyAQRO9CHSE-RuCU6XMGtLsswUmEJWNXVu4eLLlIypn3ZnYRYVtL3BovcUriKowTl98SgV5cD5KeUB-zpLmuy4TyUORJm7zPid-30_07KNBKXyNxsIMajcmagLWzSNmT8UmHAQOo0L-8yyN6YGM7cYTJBo25JwXi8wUiIji0:1tTFvD:eISko9Z1tm8pFUNySKW9Q3zcu-fuC4d3ZHiQELz45GA', '2025-01-16 07:47:11.251453'),
('bg23s70lyuhhqqdgvjhp63421i5paan1', '.eJxVjDsOwyAQRO9CHSE-RuCU6XMGtLsswUmEJWNXVu4eLLlIypn3ZnYRYVtL3BovcUriKowTl98SgV5cD5KeUB-zpLmuy4TyUORJm7zPid-30_07KNBKXyNxsIMajcmagLWzSNmT8UmHAQOo0L-8yyN6YGM7cYTJBo25JwXi8wUiIji0:1tSIHl:JlgB3VqYBO6gLacXVDxy48jzD_4WE4nnF5LBZ6y1vbg', '2025-01-13 16:06:29.930300'),
('d3cw5kkfwk73rrvmp9f5ybydpkf15wnw', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tRM07:4mLskS10NJrlYAvFQVmOikc6rBljbC1R02BkcDYuFFw', '2025-01-11 01:52:23.718201'),
('fgqfzv1ffwk92s7cd2x6oc06g5tu5eve', '.eJxVjEEOwiAQRe_C2hAoUKhL956BzDCDVA0kpV0Z765NutDtf-_9l4iwrSVunZc4kzgLZ8Tpd0RID647oTvUW5Op1XWZUe6KPGiX10b8vBzu30GBXr71OGQOPBj0AbIKmTxx8ui1sTY447KxylsKE2oHONkRAbPTZDKzUjqJ9wcUVThu:1tTVW9:q_FOBnwWrDXjTVNCaouVxsh8TBpKXMlXp5NRLxNPZa4', '2025-01-17 00:26:21.661027'),
('g7v0dj5lwophzg2cfwpst20sh646leaq', '.eJxVjEEOwiAQRe_C2hDGAkNduvcMZGBAqoYmpV0Z7y5NutDtf-_9t_C0rcVvLS1-YnERGsXpdwwUn6nuhB9U77OMc12XKchdkQdt8jZzel0P9--gUCu9zjkoZTmfA1hCa1zgIYPSwA6NpRHcoMF0TqA1qhgZR8zRIUcwPRSfLwjON9s:1tStc6:uieNtvozpw6JPxe--heuGZiKPLJs2VCEGzRHOdd2kTw', '2025-01-15 07:57:58.348978'),
('go5vs2wwknopqf1x5pz88u73y70rhcvc', '.eJxVjMsOwiAURP-FtSEglIdL934DuQ-QqqFJaVfGf7dNutDdZM6ZeYsE61LT2vOcRhYXEcTpt0OgZ2474Ae0-yRpass8otwVedAubxPn1_Vw_w4q9LqtobiC5HXUJcLZokOESGWLTDp4GjCA4aINsFZWxeyRlEFLka3JbhCfLxr0OOk:1tMS26:ohc1zu-VCLFY0oq2Jb3xbT6gostPwpiw-iq_vUcXfzk', '2024-12-28 13:18:10.039013'),
('harnjfz2ej76i1x4xtcnu369ld1b6gwx', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tKxeH:naAfTfxAvKqqYsKvA4RlPW5xlI7IJBo6cbBEIDex3RE', '2024-12-24 10:39:25.099210'),
('ib1ec61q82okdxv3uiy34by15vsjzrrf', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tRM08:mX3FIGLALp6AeIun4REmT3o9wGpyC2XEbaJGfTagiyc', '2025-01-11 01:52:24.087234'),
('jjztbieu93wo0c91lr84ffyi32j2v7vv', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tTV4y:_pOE08l5_yD1xtm2eJ9fIN01Aj1sqPMUUPOPJoWaEpg', '2025-01-16 23:58:16.888057'),
('l9nkr2y5afwrq14nenimz42nzlf24c95', 'e30:1tKJ81:_axOZStY7XCTNrRy_pBi3NKzxDunCL8SVDktFUuvEoU', '2024-12-22 15:23:25.985559'),
('nxctrkjfij8a5k07ix2vni3vojfla6cj', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tRM07:4mLskS10NJrlYAvFQVmOikc6rBljbC1R02BkcDYuFFw', '2025-01-11 01:52:23.601006'),
('qctq7qfu6z4epa20vamu6xyy7um91axz', 'e30:1tKJAl:Xg-yv7whEUUr-AG6jsHawBIpMOtvvzDXZVZGwlFpnZ8', '2024-12-22 15:26:15.932712'),
('sak9lc8uzf60xquoj6pq5s6o6mouhlxc', 'e30:1tTNqq:k6anDVi9qiN5R94SIWUksexwuuPm_w4AI_txc1ho8Yg', '2025-01-16 16:15:12.307386'),
('t09qtebcfpychbf0b0kxm2uaoz9wgmej', '.eJxVjMEOwiAQRP-FsyFA6dJ69N5vILssSNVAUtqT8d9tkx70Npn3Zt7C47Zmv7W4-JnFVWhx-e0IwzOWA_ADy73KUMu6zCQPRZ60yalyfN1O9-8gY8v7GlKnBgZ2cSQzcsBI5LRyeg_JDAnJWmsSGWCADokVQCKdehWsA9WLzxcIQDiH:1tRM08:mX3FIGLALp6AeIun4REmT3o9wGpyC2XEbaJGfTagiyc', '2025-01-11 01:52:24.253301'),
('texfmo0o9qb51w4rwlhqondvl9ruulkf', '.eJxVjDsOwjAQBe_iGlnrZP2jpOcM1q69xgGUSPlUiLtDpBTQvpl5L5VoW1vaFpnTUNRZ2U6dfkem_JBxJ-VO423SeRrXeWC9K_qgi75ORZ6Xw_07aLS0b01ona8OMMZieoTqSmSUyDZWthi494WdAGIAJNshmQxiJPgeDAev3h_yPDdP:1tTVTq:57agV_hlpDHPfR2Qjvf2PUcO8IRfRTEVleZLii0Vo_8', '2025-01-17 00:23:58.510330'),
('y5fav3yoguegdkzrwig5i6vog9wb6zkp', '.eJxVjDsOwjAQBe_iGlnxZ-01JX3OYK1_OIAcKU4qxN1JpBTQvpl5b-ZpW6vfel78lNiVgWCX3zFQfOZ2kPSgdp95nNu6TIEfCj9p5-Oc8ut2un8HlXrda4EwIIKzCiwVkMYSJRe0wCgH67R0JCEri9oUlTEGIhlD2S2ICk1iny_cdTe6:1tTVKP:F5nCpZ_GXtMzZQc3vn4Ab-TJS7jaWWWUEMn73KHiar4', '2025-01-17 00:14:13.125689');

-- --------------------------------------------------------

--
-- Table structure for table `user_app_file`
--

CREATE TABLE `user_app_file` (
  `id` bigint(20) NOT NULL,
  `file` varchar(100) NOT NULL,
  `uploaded_at` datetime(6) NOT NULL,
  `task_id` bigint(20) DEFAULT NULL,
  `uploaded_by_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_fileassignment`
--

CREATE TABLE `user_app_fileassignment` (
  `id` bigint(20) NOT NULL,
  `assigned_at` datetime(6) NOT NULL,
  `file_id` bigint(20) NOT NULL,
  `member_id` bigint(20) NOT NULL,
  `project_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_notification`
--

CREATE TABLE `user_app_notification` (
  `id` bigint(20) NOT NULL,
  `message` longtext NOT NULL,
  `is_read` tinyint(1) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_project`
--

CREATE TABLE `user_app_project` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `created_by_id` bigint(20) NOT NULL,
  `progress_percentage` double NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_task`
--

CREATE TABLE `user_app_task` (
  `id` bigint(20) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `project_id` bigint(20) NOT NULL,
  `priority` varchar(10) NOT NULL,
  `status` varchar(15) NOT NULL,
  `progress` int(10) UNSIGNED NOT NULL CHECK (`progress` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_task_assigned_members`
--

CREATE TABLE `user_app_task_assigned_members` (
  `id` bigint(20) NOT NULL,
  `task_id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_user`
--

CREATE TABLE `user_app_user` (
  `id` bigint(20) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  `role` varchar(20) NOT NULL,
  `created_by_id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `user_app_user`
--

INSERT INTO `user_app_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`, `role`, `created_by_id`) VALUES
(1, 'pbkdf2_sha256$870000$Ytz0QYt6CnHGq2TvZLl5iw$VUV3oNbup1Hxly53qT/W+SdQdtXaivOsxvFSU2igJ7Y=', '2025-01-02 23:58:16.885069', 0, 'admin', '', '', '', 0, 1, '2024-12-08 11:49:46.142125', 'super_admin', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `user_app_user_groups`
--

CREATE TABLE `user_app_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_app_user_user_permissions`
--

CREATE TABLE `user_app_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` bigint(20) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_user_app_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- Indexes for table `user_app_file`
--
ALTER TABLE `user_app_file`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_app_file_uploaded_by_id_e73dccb3_fk_user_app_user_id` (`uploaded_by_id`),
  ADD KEY `user_app_file_task_id_685a6ea4_fk_user_app_task_id` (`task_id`);

--
-- Indexes for table `user_app_fileassignment`
--
ALTER TABLE `user_app_fileassignment`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_app_fileassignment_file_id_bb395f7c_fk_user_app_file_id` (`file_id`),
  ADD KEY `user_app_fileassignment_member_id_7c6f4ffc_fk_user_app_user_id` (`member_id`),
  ADD KEY `user_app_fileassignm_project_id_35150afc_fk_user_app_` (`project_id`);

--
-- Indexes for table `user_app_notification`
--
ALTER TABLE `user_app_notification`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_app_notification_user_id_654257be_fk_user_app_user_id` (`user_id`);

--
-- Indexes for table `user_app_project`
--
ALTER TABLE `user_app_project`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_app_project_created_by_id_b9915ff4_fk_user_app_user_id` (`created_by_id`);

--
-- Indexes for table `user_app_task`
--
ALTER TABLE `user_app_task`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_app_task_project_id_d3d52962_fk_user_app_project_id` (`project_id`);

--
-- Indexes for table `user_app_task_assigned_members`
--
ALTER TABLE `user_app_task_assigned_members`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_app_task_assigned_members_task_id_user_id_8a0924df_uniq` (`task_id`,`user_id`),
  ADD KEY `user_app_task_assign_user_id_cad7cf0b_fk_user_app_` (`user_id`);

--
-- Indexes for table `user_app_user`
--
ALTER TABLE `user_app_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`),
  ADD KEY `user_app_user_created_by_id_59bcd563_fk_user_app_user_id` (`created_by_id`);

--
-- Indexes for table `user_app_user_groups`
--
ALTER TABLE `user_app_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_app_user_groups_user_id_group_id_13ac6bde_uniq` (`user_id`,`group_id`),
  ADD KEY `user_app_user_groups_group_id_77b237a8_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `user_app_user_user_permissions`
--
ALTER TABLE `user_app_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `user_app_user_user_permi_user_id_permission_id_46c11fb3_uniq` (`user_id`,`permission_id`),
  ADD KEY `user_app_user_user_p_permission_id_66c16b85_fk_auth_perm` (`permission_id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=45;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=73;

--
-- AUTO_INCREMENT for table `user_app_file`
--
ALTER TABLE `user_app_file`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=134;

--
-- AUTO_INCREMENT for table `user_app_fileassignment`
--
ALTER TABLE `user_app_fileassignment`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT for table `user_app_notification`
--
ALTER TABLE `user_app_notification`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=32;

--
-- AUTO_INCREMENT for table `user_app_project`
--
ALTER TABLE `user_app_project`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=18;

--
-- AUTO_INCREMENT for table `user_app_task`
--
ALTER TABLE `user_app_task`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT for table `user_app_task_assigned_members`
--
ALTER TABLE `user_app_task_assigned_members`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=77;

--
-- AUTO_INCREMENT for table `user_app_user`
--
ALTER TABLE `user_app_user`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `user_app_user_groups`
--
ALTER TABLE `user_app_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_app_user_user_permissions`
--
ALTER TABLE `user_app_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_user_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_file`
--
ALTER TABLE `user_app_file`
  ADD CONSTRAINT `user_app_file_task_id_685a6ea4_fk_user_app_task_id` FOREIGN KEY (`task_id`) REFERENCES `user_app_task` (`id`),
  ADD CONSTRAINT `user_app_file_uploaded_by_id_e73dccb3_fk_user_app_user_id` FOREIGN KEY (`uploaded_by_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_fileassignment`
--
ALTER TABLE `user_app_fileassignment`
  ADD CONSTRAINT `user_app_fileassignm_project_id_35150afc_fk_user_app_` FOREIGN KEY (`project_id`) REFERENCES `user_app_project` (`id`),
  ADD CONSTRAINT `user_app_fileassignment_file_id_bb395f7c_fk_user_app_file_id` FOREIGN KEY (`file_id`) REFERENCES `user_app_file` (`id`),
  ADD CONSTRAINT `user_app_fileassignment_member_id_7c6f4ffc_fk_user_app_user_id` FOREIGN KEY (`member_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_notification`
--
ALTER TABLE `user_app_notification`
  ADD CONSTRAINT `user_app_notification_user_id_654257be_fk_user_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_project`
--
ALTER TABLE `user_app_project`
  ADD CONSTRAINT `user_app_project_created_by_id_b9915ff4_fk_user_app_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_task`
--
ALTER TABLE `user_app_task`
  ADD CONSTRAINT `user_app_task_project_id_d3d52962_fk_user_app_project_id` FOREIGN KEY (`project_id`) REFERENCES `user_app_project` (`id`);

--
-- Constraints for table `user_app_task_assigned_members`
--
ALTER TABLE `user_app_task_assigned_members`
  ADD CONSTRAINT `user_app_task_assign_task_id_124b8132_fk_user_app_` FOREIGN KEY (`task_id`) REFERENCES `user_app_task` (`id`),
  ADD CONSTRAINT `user_app_task_assign_user_id_cad7cf0b_fk_user_app_` FOREIGN KEY (`user_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_user`
--
ALTER TABLE `user_app_user`
  ADD CONSTRAINT `user_app_user_created_by_id_59bcd563_fk_user_app_user_id` FOREIGN KEY (`created_by_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_user_groups`
--
ALTER TABLE `user_app_user_groups`
  ADD CONSTRAINT `user_app_user_groups_group_id_77b237a8_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `user_app_user_groups_user_id_9ac3bba9_fk_user_app_user_id` FOREIGN KEY (`user_id`) REFERENCES `user_app_user` (`id`);

--
-- Constraints for table `user_app_user_user_permissions`
--
ALTER TABLE `user_app_user_user_permissions`
  ADD CONSTRAINT `user_app_user_user_p_permission_id_66c16b85_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `user_app_user_user_p_user_id_6099c7a4_fk_user_app_` FOREIGN KEY (`user_id`) REFERENCES `user_app_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
