-- MySQL dump 10.13  Distrib 5.7.36, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: etms
-- ------------------------------------------------------
-- Server version	5.7.36-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `etms_bulletin_board_messages`
--

DROP TABLE IF EXISTS `etms_bulletin_board_messages`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_bulletin_board_messages` (
  `message_id` bigint(20) DEFAULT NULL,
  `message_title` varchar(128) DEFAULT NULL,
  `message_body` text,
  `message_create_time` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_bulletin_board_messages`
--

LOCK TABLES `etms_bulletin_board_messages` WRITE;
/*!40000 ALTER TABLE `etms_bulletin_board_messages` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_bulletin_board_messages` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_exam_participants`
--

DROP TABLE IF EXISTS `etms_exam_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_exam_participants` (
  `exam_id` bigint(20) DEFAULT NULL,
  `contestant_uid` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_exam_participants`
--

LOCK TABLES `etms_exam_participants` WRITE;
/*!40000 ALTER TABLE `etms_exam_participants` DISABLE KEYS */;
INSERT INTO `etms_exam_participants` VALUES (1,1004),(2,1004);
/*!40000 ALTER TABLE `etms_exam_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_exam_submissions`
--

DROP TABLE IF EXISTS `etms_exam_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_exam_submissions` (
  `exam_id` bigint(20) DEFAULT NULL,
  `submission_id` bigint(20) DEFAULT NULL,
  KEY `etms_exam_submissions_etms_exams_null_fk` (`exam_id`),
  KEY `etms_exam_submissions_etms_submissions_null_fk` (`submission_id`),
  CONSTRAINT `etms_exam_submissions_etms_exams_null_fk` FOREIGN KEY (`exam_id`) REFERENCES `etms_exams` (`exam_id`),
  CONSTRAINT `etms_exam_submissions_etms_submissions_null_fk` FOREIGN KEY (`submission_id`) REFERENCES `etms_submissions` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_exam_submissions`
--

LOCK TABLES `etms_exam_submissions` WRITE;
/*!40000 ALTER TABLE `etms_exam_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_exam_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_exams`
--

DROP TABLE IF EXISTS `etms_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_exams` (
  `exam_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `exam_name` varchar(128) NOT NULL,
  `exam_notes` text,
  `exam_start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `exam_end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `exam_type` varchar(4) NOT NULL,
  `exam_problems` text NOT NULL,
  PRIMARY KEY (`exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_exams`
--

LOCK TABLES `etms_exams` WRITE;
/*!40000 ALTER TABLE `etms_exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_lesson_exams`
--

DROP TABLE IF EXISTS `etms_lesson_exams`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_lesson_exams` (
  `lesson_id` bigint(20) DEFAULT NULL,
  `exam_id` bigint(20) DEFAULT NULL,
  KEY `etms_lesson_exams_etms_exams_null_fk` (`exam_id`),
  KEY `etms_lesson_exams_etms_lessons_null_fk` (`lesson_id`),
  CONSTRAINT `etms_lesson_exams_etms_exams_null_fk` FOREIGN KEY (`exam_id`) REFERENCES `etms_exams` (`exam_id`),
  CONSTRAINT `etms_lesson_exams_etms_lessons_null_fk` FOREIGN KEY (`lesson_id`) REFERENCES `etms_lessons` (`lesson_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_lesson_exams`
--

LOCK TABLES `etms_lesson_exams` WRITE;
/*!40000 ALTER TABLE `etms_lesson_exams` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_lesson_exams` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_lesson_participants`
--

DROP TABLE IF EXISTS `etms_lesson_participants`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_lesson_participants` (
  `lesson_id` int(11) NOT NULL,
  `participant_id` int(11) NOT NULL,
  KEY `etms_lesson_participant_etms_lessons_null_fk` (`lesson_id`),
  KEY `etms_lesson_participant_etms_users_null_fk` (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_lesson_participants`
--

LOCK TABLES `etms_lesson_participants` WRITE;
/*!40000 ALTER TABLE `etms_lesson_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_lesson_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_lesson_resources`
--

DROP TABLE IF EXISTS `etms_lesson_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_lesson_resources` (
  `lesson_resource_id` int(11) NOT NULL AUTO_INCREMENT,
  `resource_id` int(11) NOT NULL,
  `lesson_id` int(11) NOT NULL,
  PRIMARY KEY (`lesson_resource_id`),
  KEY `resource_to_lesson_etms_lessons_null_fk` (`lesson_id`),
  KEY `resource_to_lesson_etms_resources_null_fk` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_lesson_resources`
--

LOCK TABLES `etms_lesson_resources` WRITE;
/*!40000 ALTER TABLE `etms_lesson_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_lesson_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_lessons`
--

DROP TABLE IF EXISTS `etms_lessons`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_lessons` (
  `lesson_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `lesson_name` varchar(64) NOT NULL,
  `description` varchar(256) DEFAULT NULL,
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `lecturer_id` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`lesson_id`),
  KEY `etms_lessons_etms_users_null_fk` (`lecturer_id`),
  CONSTRAINT `etms_lessons_etms_users_null_fk` FOREIGN KEY (`lecturer_id`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_lessons`
--

LOCK TABLES `etms_lessons` WRITE;
/*!40000 ALTER TABLE `etms_lessons` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_lessons` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_options`
--

DROP TABLE IF EXISTS `etms_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_options` (
  `option_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `option_name` varchar(256) NOT NULL,
  `option_value` varchar(256) NOT NULL,
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `etms_options_pk` (`option_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_options`
--

LOCK TABLES `etms_options` WRITE;
/*!40000 ALTER TABLE `etms_options` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_problem_tag_relationships`
--

DROP TABLE IF EXISTS `etms_problem_tag_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_problem_tag_relationships` (
  `problem_id` bigint(20) DEFAULT NULL,
  `problem_tag_id` bigint(20) DEFAULT NULL,
  KEY `etms_problem_tag_relationships_etms_problem_tags_null_fk` (`problem_tag_id`),
  KEY `etms_problem_tag_relationships_etms_problems_null_fk` (`problem_id`),
  CONSTRAINT `etms_problem_tag_relationships_etms_problem_tags_null_fk` FOREIGN KEY (`problem_tag_id`) REFERENCES `etms_problem_tags` (`problem_tag_id`),
  CONSTRAINT `etms_problem_tag_relationships_etms_problems_null_fk` FOREIGN KEY (`problem_id`) REFERENCES `etms_problems` (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_problem_tag_relationships`
--

LOCK TABLES `etms_problem_tag_relationships` WRITE;
/*!40000 ALTER TABLE `etms_problem_tag_relationships` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_problem_tag_relationships` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_problem_tags`
--

DROP TABLE IF EXISTS `etms_problem_tags`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_problem_tags` (
  `problem_tag_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `problem_tag_slug` varchar(32) NOT NULL,
  `problem_tag_name` varchar(32) NOT NULL,
  PRIMARY KEY (`problem_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_problem_tags`
--

LOCK TABLES `etms_problem_tags` WRITE;
/*!40000 ALTER TABLE `etms_problem_tags` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_problem_tags` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_problems`
--

DROP TABLE IF EXISTS `etms_problems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_problems` (
  `problem_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `problem_is_public` tinyint(4) NOT NULL,
  `problem_name` varchar(128) NOT NULL,
  `problem_description` text NOT NULL,
  `problem_hint` text,
  PRIMARY KEY (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_problems`
--

LOCK TABLES `etms_problems` WRITE;
/*!40000 ALTER TABLE `etms_problems` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_problems` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_resources`
--

DROP TABLE IF EXISTS `etms_resources`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_resources` (
  `resource_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `resource_type` varchar(32) NOT NULL,
  `resource_name` varchar(64) NOT NULL,
  `resource_path` varchar(256) DEFAULT NULL,
  `resource_info` text,
  PRIMARY KEY (`resource_id`),
  UNIQUE KEY `etms_resources_pk` (`resource_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_resources`
--

LOCK TABLES `etms_resources` WRITE;
/*!40000 ALTER TABLE `etms_resources` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_resources` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_submissions`
--

DROP TABLE IF EXISTS `etms_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_submissions` (
  `submission_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `problem_id` bigint(20) DEFAULT NULL,
  `uid` bigint(20) DEFAULT NULL,
  `submission_submit_time` timestamp NULL DEFAULT NULL,
  `submission_judge_score` int(11) DEFAULT NULL,
  `submission_context` text,
  PRIMARY KEY (`submission_id`),
  KEY `etms_submissions_etms_users_null_fk` (`uid`),
  KEY `etms_submissions_etms_problems_null_fk` (`problem_id`),
  CONSTRAINT `etms_submissions_etms_problems_null_fk` FOREIGN KEY (`problem_id`) REFERENCES `etms_problems` (`problem_id`),
  CONSTRAINT `etms_submissions_etms_users_null_fk` FOREIGN KEY (`uid`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_submissions`
--

LOCK TABLES `etms_submissions` WRITE;
/*!40000 ALTER TABLE `etms_submissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_submissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_user_groups`
--

DROP TABLE IF EXISTS `etms_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_user_groups` (
  `user_group_id` bigint(20) NOT NULL,
  `user_group_name` varchar(32) NOT NULL,
  `user_group_slug` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`user_group_id`),
  UNIQUE KEY `etms_user_groups_pk` (`user_group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_user_groups`
--

LOCK TABLES `etms_user_groups` WRITE;
/*!40000 ALTER TABLE `etms_user_groups` DISABLE KEYS */;
INSERT INTO `etms_user_groups` VALUES (1,'student',NULL),(2,'faculty',NULL),(3,'administrator',NULL);
/*!40000 ALTER TABLE `etms_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_user_meta`
--

DROP TABLE IF EXISTS `etms_user_meta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_user_meta` (
  `meta_id` bigint(20) NOT NULL AUTO_INCREMENT,
  `uid` bigint(20) NOT NULL,
  `meta_key` varchar(256) NOT NULL,
  `meta_value` text,
  PRIMARY KEY (`meta_id`),
  KEY `etms_user_meta_etms_users_null_fk` (`uid`),
  CONSTRAINT `etms_user_meta_etms_users_null_fk` FOREIGN KEY (`uid`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_user_meta`
--

LOCK TABLES `etms_user_meta` WRITE;
/*!40000 ALTER TABLE `etms_user_meta` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_user_meta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_users`
--

DROP TABLE IF EXISTS `etms_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_users` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(32) NOT NULL,
  `email` varchar(64) DEFAULT NULL,
  `user_group_id` bigint(20) NOT NULL,
  PRIMARY KEY (`uid`),
  UNIQUE KEY `etms_users_user_name_pk` (`username`),
  UNIQUE KEY `etms_users_email_pk` (`email`),
  KEY `etms_users_etms_user_groups_null_fk` (`user_group_id`),
  CONSTRAINT `etms_users_etms_user_groups_null_fk` FOREIGN KEY (`user_group_id`) REFERENCES `etms_user_groups` (`user_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10001 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_users`
--

LOCK TABLES `etms_users` WRITE;
/*!40000 ALTER TABLE `etms_users` DISABLE KEYS */;
INSERT INTO `etms_users` VALUES (10000,'admin','0000',NULL,3);
/*!40000 ALTER TABLE `etms_users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2022-11-05 13:05:09
