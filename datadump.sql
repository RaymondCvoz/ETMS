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
  `message_id` bigint(20) DEFAULT NULL COMMENT '公告唯一标识符',
  `message_title` varchar(128) DEFAULT NULL COMMENT '公告标题',
  `message_body` text COMMENT '公告内容',
  `message_create_time` timestamp NULL DEFAULT NULL COMMENT '公告创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='公告栏信息';
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
  `exam_id` bigint(20) DEFAULT NULL COMMENT '测试唯一标识符',
  `participant_id` bigint(20) DEFAULT NULL COMMENT '参与学生唯一标识符',
  KEY `etms_exam_participants_etms_exams_null_fk` (`exam_id`),
  KEY `etms_exam_participants_etms_users_null_fk` (`participant_id`),
  CONSTRAINT `etms_exam_participants_etms_exams_null_fk` FOREIGN KEY (`exam_id`) REFERENCES `etms_exams` (`exam_id`),
  CONSTRAINT `etms_exam_participants_etms_users_null_fk` FOREIGN KEY (`participant_id`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='测试与参与测试学生对应信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_exam_participants`
--

LOCK TABLES `etms_exam_participants` WRITE;
/*!40000 ALTER TABLE `etms_exam_participants` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_exam_participants` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_exam_submissions`
--

DROP TABLE IF EXISTS `etms_exam_submissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_exam_submissions` (
  `exam_id` bigint(20) DEFAULT NULL COMMENT '测试唯一标识符',
  `submission_id` bigint(20) DEFAULT NULL COMMENT '提交唯一标识符',
  KEY `etms_exam_submissions_etms_exams_null_fk` (`exam_id`),
  KEY `etms_exam_submissions_etms_submissions_null_fk` (`submission_id`),
  CONSTRAINT `etms_exam_submissions_etms_exams_null_fk` FOREIGN KEY (`exam_id`) REFERENCES `etms_exams` (`exam_id`),
  CONSTRAINT `etms_exam_submissions_etms_submissions_null_fk` FOREIGN KEY (`submission_id`) REFERENCES `etms_submissions` (`submission_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='测试与提交对应信息';
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
  `exam_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '测试唯一标识符',
  `exam_name` varchar(128) NOT NULL COMMENT '测试名称',
  `exam_notes` text COMMENT '测试备注',
  `exam_start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '测试开始时间',
  `exam_end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '测试结束时间',
  `exam_type` varchar(4) NOT NULL COMMENT '测试类型',
  `exam_problems` text NOT NULL COMMENT '测试题目',
  PRIMARY KEY (`exam_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='测试信息';
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
  `lesson_id` bigint(20) DEFAULT NULL COMMENT '课程唯一标识符',
  `exam_id` bigint(20) DEFAULT NULL COMMENT '测试唯一标识符',
  KEY `etms_lesson_exams_etms_exams_null_fk` (`exam_id`),
  KEY `etms_lesson_exams_etms_lessons_null_fk` (`lesson_id`),
  CONSTRAINT `etms_lesson_exams_etms_exams_null_fk` FOREIGN KEY (`exam_id`) REFERENCES `etms_exams` (`exam_id`),
  CONSTRAINT `etms_lesson_exams_etms_lessons_null_fk` FOREIGN KEY (`lesson_id`) REFERENCES `etms_lessons` (`lesson_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='课程与测试对应关系';
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
  `lesson_id` int(11) NOT NULL COMMENT '课程唯一标识符',
  `participant_id` int(11) NOT NULL COMMENT '选课学生唯一标识符',
  KEY `etms_lesson_participant_etms_lessons_null_fk` (`lesson_id`),
  KEY `etms_lesson_participant_etms_users_null_fk` (`participant_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='学生选课信息';
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
  `lesson_resource_id` int(11) NOT NULL AUTO_INCREMENT COMMENT '对应信息唯一标识符',
  `resource_id` int(11) NOT NULL COMMENT '资源唯一标识符',
  `lesson_id` int(11) NOT NULL COMMENT '课程唯一标识符',
  `lesson_order` int(11) NOT NULL COMMENT '课程小节序号',
  PRIMARY KEY (`lesson_resource_id`),
  KEY `resource_to_lesson_etms_lessons_null_fk` (`lesson_id`),
  KEY `resource_to_lesson_etms_resources_null_fk` (`resource_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='课程与资源对应信息';
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
  `lesson_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '课程唯一标识符',
  `lesson_name` varchar(64) NOT NULL COMMENT '课程名称',
  `description` varchar(256) DEFAULT NULL COMMENT '课程描述',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '课程开始时间',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '课程结束时间',
  `lecturer_id` bigint(20) DEFAULT NULL COMMENT '讲师用户唯一标识符',
  PRIMARY KEY (`lesson_id`),
  KEY `etms_lessons_etms_users_null_fk` (`lecturer_id`),
  CONSTRAINT `etms_lessons_etms_users_null_fk` FOREIGN KEY (`lecturer_id`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='课程信息';
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
  `option_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '设置选项唯一标识符',
  `option_name` varchar(256) NOT NULL COMMENT '选项名称',
  `option_value` varchar(256) NOT NULL COMMENT '选项值',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `etms_options_pk` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=latin1 COMMENT='系统设置信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_options`
--

LOCK TABLES `etms_options` WRITE;
/*!40000 ALTER TABLE `etms_options` DISABLE KEYS */;
INSERT INTO `etms_options` VALUES (1,'allowUserRegister','1');
/*!40000 ALTER TABLE `etms_options` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_problem_tag_relationships`
--

DROP TABLE IF EXISTS `etms_problem_tag_relationships`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_problem_tag_relationships` (
  `problem_id` bigint(20) DEFAULT NULL COMMENT '题目唯一标识符',
  `problem_tag_id` bigint(20) DEFAULT NULL COMMENT '类别唯一标识符',
  KEY `etms_problem_tag_relationships_etms_problem_tags_null_fk` (`problem_tag_id`),
  KEY `etms_problem_tag_relationships_etms_problems_null_fk` (`problem_id`),
  CONSTRAINT `etms_problem_tag_relationships_etms_problem_tags_null_fk` FOREIGN KEY (`problem_tag_id`) REFERENCES `etms_problem_tags` (`problem_tag_id`),
  CONSTRAINT `etms_problem_tag_relationships_etms_problems_null_fk` FOREIGN KEY (`problem_id`) REFERENCES `etms_problems` (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='题目与类别对应关系';
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
  `problem_tag_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '题目类别唯一标识符',
  `problem_tag_slug` varchar(32) NOT NULL COMMENT '题目类别简易标识',
  `problem_tag_name` varchar(32) NOT NULL COMMENT '题目类别名称',
  PRIMARY KEY (`problem_tag_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='题目类别信息';
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
  `problem_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '题目唯一标识符',
  `problem_is_public` tinyint(4) NOT NULL COMMENT '题目是否公开',
  `problem_name` varchar(128) NOT NULL COMMENT '题目名称',
  `problem_description` text NOT NULL COMMENT '题目描述',
  `problem_hint` text COMMENT '题目提示',
  `problem_type` int(11) NOT NULL DEFAULT '0' COMMENT '题目类型',
  `problem_answer` text COMMENT '题目标准答案',
  `problem_score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='题目信息';
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
  `resource_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '资源唯一标识符',
  `resource_type` varchar(32) NOT NULL COMMENT '资源类型',
  `resource_name` varchar(64) NOT NULL COMMENT '资源名称',
  `resource_path` varchar(256) DEFAULT NULL COMMENT '资源文件路径',
  `resource_info` text COMMENT '资源其他信息',
  PRIMARY KEY (`resource_id`),
  UNIQUE KEY `etms_resources_pk` (`resource_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='系统资源信息';
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
  `submission_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '提交唯一标识符',
  `problem_id` bigint(20) DEFAULT NULL COMMENT '题目唯一标识符',
  `uid` bigint(20) DEFAULT NULL COMMENT '用户唯一标识符',
  `submission_submit_time` timestamp NULL DEFAULT NULL COMMENT '提交时间',
  `submission_judge_score` int(11) DEFAULT NULL COMMENT '题目得分',
  `submission_context` text COMMENT '提交内容',
  PRIMARY KEY (`submission_id`),
  KEY `etms_submissions_etms_users_null_fk` (`uid`),
  KEY `etms_submissions_etms_problems_null_fk` (`problem_id`),
  CONSTRAINT `etms_submissions_etms_problems_null_fk` FOREIGN KEY (`problem_id`) REFERENCES `etms_problems` (`problem_id`),
  CONSTRAINT `etms_submissions_etms_users_null_fk` FOREIGN KEY (`uid`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='题目提交信息';
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
  `user_group_id` bigint(20) NOT NULL COMMENT '用户组唯一标识符',
  `user_group_name` varchar(32) NOT NULL COMMENT '用户组名称',
  `user_group_slug` varchar(32) DEFAULT NULL COMMENT '用户组简易标识',
  PRIMARY KEY (`user_group_id`),
  UNIQUE KEY `etms_user_groups_pk` (`user_group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='用户组信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_user_groups`
--

LOCK TABLES `etms_user_groups` WRITE;
/*!40000 ALTER TABLE `etms_user_groups` DISABLE KEYS */;
INSERT INTO `etms_user_groups` VALUES (1,'student','users'),(2,'faculty','fac'),(3,'administrator','admin');
/*!40000 ALTER TABLE `etms_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_usermeta`
--

DROP TABLE IF EXISTS `etms_usermeta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_usermeta` (
  `meta_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '每条信息的唯一标识符',
  `uid` bigint(20) NOT NULL COMMENT '用户唯一标识符',
  `meta_key` varchar(256) NOT NULL COMMENT '信息键',
  `meta_value` text COMMENT '信息值',
  PRIMARY KEY (`meta_id`),
  KEY `etms_user_meta_etms_users_null_fk` (`uid`),
  CONSTRAINT `etms_user_meta_etms_users_null_fk` FOREIGN KEY (`uid`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1 COMMENT='用户其他信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_usermeta`
--

LOCK TABLES `etms_usermeta` WRITE;
/*!40000 ALTER TABLE `etms_usermeta` DISABLE KEYS */;
INSERT INTO `etms_usermeta` VALUES (1,10000,'registerDate','2022-11-01'),(2,10003,'registerTime','2022-11-17 23:41:37');
/*!40000 ALTER TABLE `etms_usermeta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `etms_users`
--

DROP TABLE IF EXISTS `etms_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_users` (
  `uid` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户唯一标识符',
  `username` varchar(32) NOT NULL COMMENT '用户名',
  `password` varchar(32) NOT NULL COMMENT '用户密码',
  `email` varchar(64) DEFAULT NULL COMMENT '用户电子邮箱',
  `user_group_id` bigint(20) NOT NULL COMMENT '用户所属用户组的唯一标识符',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `etms_users_user_name_pk` (`username`),
  UNIQUE KEY `etms_users_email_pk` (`email`),
  KEY `etms_users_etms_user_groups_null_fk` (`user_group_id`),
  CONSTRAINT `etms_users_etms_user_groups_null_fk` FOREIGN KEY (`user_group_id`) REFERENCES `etms_user_groups` (`user_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10004 DEFAULT CHARSET=latin1 COMMENT='用户基本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_users`
--

LOCK TABLES `etms_users` WRITE;
/*!40000 ALTER TABLE `etms_users` DISABLE KEYS */;
INSERT INTO `etms_users` VALUES (10000,'admin','0000',NULL,3),(10001,'raymond','0000',NULL,3),(10003,'testtest','000000','1@axos.com',1);
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

-- Dump completed on 2022-11-20 10:33:04
