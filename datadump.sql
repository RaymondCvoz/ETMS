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
  `message_title` varchar(128) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '公告标题',
  `message_body` text COLLATE utf8mb4_unicode_ci COMMENT '公告内容',
  `message_create_time` timestamp NULL DEFAULT NULL COMMENT '公告创建时间'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='公告栏信息';
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
  `participant_uid` bigint(20) DEFAULT NULL COMMENT '参与学生唯一标识符',
  KEY `etms_exam_participants_etms_exams_null_fk` (`exam_id`),
  KEY `etms_exam_participants_etms_users_null_fk` (`participant_uid`),
  CONSTRAINT `etms_exam_participants_etms_exams_null_fk` FOREIGN KEY (`exam_id`) REFERENCES `etms_exams` (`exam_id`),
  CONSTRAINT `etms_exam_participants_etms_users_null_fk` FOREIGN KEY (`participant_uid`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试与参与测试学生对应信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_exam_participants`
--

LOCK TABLES `etms_exam_participants` WRITE;
/*!40000 ALTER TABLE `etms_exam_participants` DISABLE KEYS */;
INSERT INTO `etms_exam_participants` VALUES (1,10001),(2,10006);
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试与提交对应信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_exam_submissions`
--

LOCK TABLES `etms_exam_submissions` WRITE;
/*!40000 ALTER TABLE `etms_exam_submissions` DISABLE KEYS */;
INSERT INTO `etms_exam_submissions` VALUES (1,1),(1,2),(2,3);
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
  `exam_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '测试名称',
  `exam_notes` text COLLATE utf8mb4_unicode_ci COMMENT '测试备注',
  `exam_start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '测试开始时间',
  `exam_end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '测试结束时间',
  `exam_mode` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '测试类型',
  `exam_problems` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '测试题目',
  PRIMARY KEY (`exam_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='测试信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_exams`
--

LOCK TABLES `etms_exams` WRITE;
/*!40000 ALTER TABLE `etms_exams` DISABLE KEYS */;
INSERT INTO `etms_exams` VALUES (1,'期末考试2','说明','2022-12-23 23:47:19','2022-12-23 23:50:19','Exam','[2,3]'),(2,'期末考试3','','2022-12-23 23:55:02','2022-12-23 23:56:02','Exam','[4,5]');
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程与测试对应关系';
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
  `participant_uid` int(11) NOT NULL COMMENT '选课学生唯一标识符',
  KEY `etms_lesson_participant_etms_lessons_null_fk` (`lesson_id`),
  KEY `etms_lesson_participant_etms_users_null_fk` (`participant_uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='学生选课信息';
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程与资源对应信息';
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
  `lesson_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '课程名称',
  `description` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '课程描述',
  `start_time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP COMMENT '课程开始时间',
  `end_time` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00' COMMENT '课程结束时间',
  `lecturer_id` bigint(20) DEFAULT NULL COMMENT '讲师用户唯一标识符',
  PRIMARY KEY (`lesson_id`),
  KEY `etms_lessons_etms_users_null_fk` (`lecturer_id`),
  CONSTRAINT `etms_lessons_etms_users_null_fk` FOREIGN KEY (`lecturer_id`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='课程信息';
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
  `option_name` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '选项名称',
  `option_value` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '选项值',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `etms_options_pk` (`option_name`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统设置信息';
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
-- Table structure for table `etms_problem_checkpoints`
--

DROP TABLE IF EXISTS `etms_problem_checkpoints`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `etms_problem_checkpoints` (
  `problem_id` bigint(20) DEFAULT NULL COMMENT '题目唯一标识符',
  `checkpoint_id` int(11) NOT NULL COMMENT '测试点唯一标识符',
  `checkpoint_exactly_match` tinyint(4) NOT NULL COMMENT '测试点是否精确匹配（填空题）',
  `checkpoint_type` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '测试点类型（选择、填空、论述等）',
  `checkpoint_score` int(11) NOT NULL COMMENT '测试点得分',
  `checkpoint_answer` longtext COLLATE utf8mb4_unicode_ci COMMENT '测试点答案',
  KEY `etms_problem_checkpoints_etms_problems_null_fk` (`problem_id`),
  CONSTRAINT `etms_problem_checkpoints_etms_problems_null_fk` FOREIGN KEY (`problem_id`) REFERENCES `etms_problems` (`problem_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目测试点信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_problem_checkpoints`
--

LOCK TABLES `etms_problem_checkpoints` WRITE;
/*!40000 ALTER TABLE `etms_problem_checkpoints` DISABLE KEYS */;
/*!40000 ALTER TABLE `etms_problem_checkpoints` ENABLE KEYS */;
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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目与类别对应关系';
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
  `problem_tag_slug` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目类别简易标识',
  `problem_tag_name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目类别名称',
  PRIMARY KEY (`problem_tag_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目类别信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_problem_tags`
--

LOCK TABLES `etms_problem_tags` WRITE;
/*!40000 ALTER TABLE `etms_problem_tags` DISABLE KEYS */;
INSERT INTO `etms_problem_tags` VALUES (1,'none','无');
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
  `problem_name` varchar(128) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目名称',
  `problem_description` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '题目描述',
  `problem_hint` text COLLATE utf8mb4_unicode_ci COMMENT '题目提示',
  `problem_type` int(11) NOT NULL DEFAULT '0' COMMENT '题目类型',
  `problem_answer` text COLLATE utf8mb4_unicode_ci COMMENT '题目标准答案',
  `problem_score` int(11) NOT NULL DEFAULT '0',
  PRIMARY KEY (`problem_id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_problems`
--

LOCK TABLES `etms_problems` WRITE;
/*!40000 ALTER TABLE `etms_problems` DISABLE KEYS */;
INSERT INTO `etms_problems` VALUES (2,1,'计算机学科专业基础01','将一个 10X10 对称矩阵 M 的上三角部分的元素mij(1≤i≤j≤10)按列优先存 入 C 语言的一位数组 N 中，元素m7,2在 N 中的下标是：\n\nA、15 \n\nB、16 \n\nC、22 \n\nD、23','请提交选项（A、B、C、D）',0,'C',10),(3,1,'计算机学科专业基础02','对 空 栈 S 进 行 Push 和 pop 操作，入栈序列 a,b,c,d,e 经 过 Push,Push,Pop,Push,Pop,Push,Push,Pop 操作后得到的出栈序列是：\n\nA、b,a,c \n\nB、b,a,e \n\nC、b,c,a \n\nD、b,c,e\n','请提交选项（A、B、C、D）',0,'D',10),(4,1,'计算机学科专业基础03','修改递归方式实现的图的深度优先搜索（DFS）算法，将输出（访问）定点信 息的语句移到退出递归前（即执行输出语句后立刻退出递归）。采用修改后的算 法遍历有向无环图 G，若输出结果中包含 G 中的全部顶点，则输出的顶点序列是 G 的：\n\nA、拓扑有序序列 \n\nB、逆拓扑有序序列 \n\nC、广度优先搜索序列 \n\nD、深度优先搜索序列','请提交选项（A、B、C、D）',0,'B',10),(5,1,'计算机学科专业基础04','在按字节编址，采用小端方式的 32 位计算机中，按边界对齐方式为以下 C 语言结构型变量 a 分配存储空间。 Struct record{ short x1; int x2; } a;\n若 a 的首地址为 2020 FE00H，a 的成员变量 x2 的机器数为 1234 0000H，则其中 34H 所在存储单元的地址是：\n\nA、2020 FE03H； \n\nB、2020 FE04H； \n\nC、2020 FE05H； \n\nD、2020 FE06H；','请提交选项（A、B、C、D）',0,'D',10),(6,1,'计算机学科专业基础05','若主机甲与主机乙建立 TCP 连接时发送的 SYN 段中的序号为 1000，在断开 连接时，甲发送给乙的 FIN 段中的序号为 5001，则在无任何重传的情况下，甲 向乙已经发送的应用层数据的字节数为：\n\nA、4002； \n\nB、4001； \n\nC、4000； \n\nD、3999；','请提交选项（A、B、C、D）',0,'C',10),(7,1,'思想政治理论01','中国共产党坚持马克思上义基本原理，坚持实事求是，从中国实际出发，洞察时代大势，把握历中主动，进行艰辛探索，不推进马克思主义中国化时代化，指导人民不断推进伟大社会革命。习近平总书记指出，“中国共产党为什么能，由特色社会主义为什么好，归根到底是因为马克思主义行!”马克思主义之所以根本原因在于（    ） \n\nA.马克思主义具有鲜明的政治立场 \n\nB.马克思主义具有自觉的历史担当 \n\nC.马克思主义是科学的世界观和方法论 \n\nD.马克思主义是无产阶级政党自我革命的武器 ','请提交选项（A、B、C、D）',0,'C',10),(8,1,'思想政治理论02','马克思在《资本论》中指出∶”一个商品占有者出售他现有的商品，而另一个商品占有者却只是作为货币的代表或作为未来货币的代表来购买这种商品。卖者成为债权人，买者成为债务人。由于商品的形态变化或育晶的价值形式的发展在这里起了变化，货币也就取得了另一种职能。”这里所论述的货币”另一种职能”指的是（    ） \n\nA.价值尺度 \n\nB.流通手段 \n\nC.贮藏手段 \n\nD.支付手段 ','请提交选项（A、B、C、D）',0,'D',10),(9,1,'思想政治理论03','中华传统关德是中华优秀文化的重要组成部分，其内容博大精深、源远流长。从《诗经》中的“夙夜在公”到《尚书》中的“以公灭私”，从西汉贾谊《治安策》中的“国而忘家，公而忘私”到宋代范仲淹《岳阳楼记》中的“先天下之忧而忧，后天下之乐而乐”，再到清代林则徐的“苟利国家生死以，岂因祸福避趋之”，贯穿其中的传统关德是（    ） \n\nA.强调知行合一，注重躬行实践 \n\nB.推崇“仁爱”原则，注重以和为贵 \n\nC.重视整体利益，强调责任奉献 \n\nD.提倡人伦价值，重视道德义务 ','无',0,'C',10),(13,1,'思想政治理论04','人类历史上的每一次科技革命都与材料的发展息息相关，而新材料的研制却是颇为不易的。人工智能可以借助数据共享，对先进材科的物理化学性质进行预测筛选，从而加快新材料的合成和生产。作为人工智能的一个分支，机器学习算法在辅助新材料设计时尤为“得力”，其工作过程主要包括“描述符”生成、模型构建和验证、材料预测、实验验证等步骤。人工智能辅助新材料研发的过程表明\n\nA.科学研究能够任意改变物质的性质和结构\n\nB.人工智能能够取代人类对物质世界的认识\n\nC.人类对于物质的认识是一个不断深化的过程 \n\nD.具体的物质结构和性质的变化并不改变世界的物质性 ','无',0,'CD',10);
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
  `resource_type` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源类型',
  `resource_name` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '资源名称',
  `resource_path` varchar(256) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '资源文件路径',
  `resource_info` text COLLATE utf8mb4_unicode_ci COMMENT '资源其他信息',
  PRIMARY KEY (`resource_id`),
  UNIQUE KEY `etms_resources_pk` (`resource_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='系统资源信息';
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
  `submission_context` text COLLATE utf8mb4_unicode_ci COMMENT '提交内容',
  PRIMARY KEY (`submission_id`),
  KEY `etms_submissions_etms_users_null_fk` (`uid`),
  KEY `etms_submissions_etms_problems_null_fk` (`problem_id`),
  CONSTRAINT `etms_submissions_etms_problems_null_fk` FOREIGN KEY (`problem_id`) REFERENCES `etms_problems` (`problem_id`),
  CONSTRAINT `etms_submissions_etms_users_null_fk` FOREIGN KEY (`uid`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='题目提交信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_submissions`
--

LOCK TABLES `etms_submissions` WRITE;
/*!40000 ALTER TABLE `etms_submissions` DISABLE KEYS */;
INSERT INTO `etms_submissions` VALUES (1,2,10001,'2022-12-23 23:41:03',10,'C'),(2,2,10001,'2022-12-23 23:47:31',10,'C'),(3,4,10006,'2022-12-23 23:55:18',0,'C');
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
  `user_group_name` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户组名称',
  `user_group_slug` varchar(32) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户组简易标识',
  PRIMARY KEY (`user_group_id`),
  UNIQUE KEY `etms_user_groups_pk` (`user_group_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户组信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_user_groups`
--

LOCK TABLES `etms_user_groups` WRITE;
/*!40000 ALTER TABLE `etms_user_groups` DISABLE KEYS */;
INSERT INTO `etms_user_groups` VALUES (1,'student','users'),(2,'faculty','fac'),(3,'administrator','administrators');
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
  `meta_key` varchar(256) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '信息键',
  `meta_value` text COLLATE utf8mb4_unicode_ci COMMENT '信息值',
  PRIMARY KEY (`meta_id`),
  KEY `etms_user_meta_etms_users_null_fk` (`uid`),
  CONSTRAINT `etms_user_meta_etms_users_null_fk` FOREIGN KEY (`uid`) REFERENCES `etms_users` (`uid`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户其他信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_usermeta`
--

LOCK TABLES `etms_usermeta` WRITE;
/*!40000 ALTER TABLE `etms_usermeta` DISABLE KEYS */;
INSERT INTO `etms_usermeta` VALUES (1,10005,'registerTime','2022-11-20 10:37:09'),(2,10006,'registerTime','2022-12-24 15:52:48');
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
  `username` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户名',
  `password` varchar(32) COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '用户密码',
  `email` varchar(64) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT '用户电子邮箱',
  `user_group_id` bigint(20) NOT NULL COMMENT '用户所属用户组的唯一标识符',
  PRIMARY KEY (`uid`),
  UNIQUE KEY `etms_users_user_name_pk` (`username`),
  UNIQUE KEY `etms_users_email_pk` (`email`),
  KEY `etms_users_etms_user_groups_null_fk` (`user_group_id`),
  CONSTRAINT `etms_users_etms_user_groups_null_fk` FOREIGN KEY (`user_group_id`) REFERENCES `etms_user_groups` (`user_group_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10007 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci COMMENT='用户基本信息';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `etms_users`
--

LOCK TABLES `etms_users` WRITE;
/*!40000 ALTER TABLE `etms_users` DISABLE KEYS */;
INSERT INTO `etms_users` VALUES (10000,'admin','0000',NULL,3),(10001,'raymond','0000',NULL,3),(10003,'testtest','000000','1@axos.com',1),(10005,'testau1','000000','testau1@etms.com',1),(10006,'arixarix','00000000','s@1.com',1);
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

-- Dump completed on 2022-12-26 10:05:47
