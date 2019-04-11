# mtweb
**CCMT 2019 EVAL WEB**  
This is the evaluation website for CCMT 2019. 
Participants will login this website and submit the results of their MT system. 
Score of each submission will be recorded and displayed on the leader board.  
For information of CCMT2019, please refer to [CCMT2019](http://ccmt2019.jxnu.edu.cn/). 


## Environment
* System: Windows10/8/7/Server/NT
* Server: Tomcat7.0
* Java Version: 1.8
* Python Version: 2.7
* Database:MySQL 5.7

## Structure
* Front: JSP and Bootstrap
* Back: SpringMVC

## Usage
DataBase Environment Establishing:
* Create DataBase  
```$xslt
create database mtwebtest;
use mtwebtest;
```
* Create Users Table
```$xslt
CREATE TABLE `users` (
  `username` varchar(20) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `affiliation` varchar(100) DEFAULT NULL,
  `web` varchar(50) DEFAULT NULL,
  `password` varchar(20) NOT NULL,
  `phone` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
```
* Create Systems Table
```$xslt
CREATE TABLE `systems` (
  `systemid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `software` varchar(20) DEFAULT NULL,
  `sourcelang` varchar(4) DEFAULT NULL,
  `targetlang` varchar(4) DEFAULT NULL,
  `citation` varchar(200) DEFAULT NULL,
  `website` varchar(40) DEFAULT NULL,
  `notes` varchar(40) DEFAULT NULL,
  `isConstraint` tinyint(1) DEFAULT '0',
  `isPrimary` tinyint(1) DEFAULT '0',
  `owner` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`systemid`),
  UNIQUE KEY `name` (`name`,`owner`),
  KEY `owner` (`owner`),
  CONSTRAINT `systems_ibfk_1` FOREIGN KEY (`owner`) REFERENCES `users` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
```
* Create TestSets Table
```$xslt
CREATE TABLE `testsets` (
  `testsetid` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(40) DEFAULT NULL,
  `origin` varchar(20) DEFAULT NULL,
  `domain` varchar(40) DEFAULT NULL,
  `related_corpora` varchar(40) DEFAULT NULL,
  `citation` varchar(100) DEFAULT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `setups` varchar(10) DEFAULT NULL,
  `srcurl` varchar(60) DEFAULT NULL,
  `isPrimarySet` tinyint(1) DEFAULT NULL,
  `direction` varchar(30) DEFAULT NULL,
  `refurl` varchar(60) DEFAULT NULL,
  `realsrcurl` varchar(60) DEFAULT NULL,
  `srclang` varchar(4) DEFAULT NULL,
  `tgtlang` varchar(4) DEFAULT NULL,
  `track` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`testsetid`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8
```
* Create submissions Table
```$xslt
CREATE TABLE `submissions` (
  `submissionid` int(11) NOT NULL AUTO_INCREMENT,
  `systemid` int(11) DEFAULT NULL,
  `systemname` varchar(40) DEFAULT NULL,
  `testset` varchar(40) DEFAULT NULL,
  `file` varchar(100) DEFAULT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `BLEU` varchar(10) DEFAULT NULL,
  `BLEU_cased` varchar(10) DEFAULT NULL,
  `IGNORE_BLEU` varchar(10) DEFAULT NULL,
  `IGNORE_BLEU_cased` varchar(10) DEFAULT NULL,
  `IGNORE_BLEU_cased_norm` varchar(10) DEFAULT NULL,
  `TER` varchar(10) DEFAULT NULL,
  `BEER` varchar(10) DEFAULT NULL,
  `charac_ter` varchar(10) DEFAULT NULL,
  `time` varchar(40) DEFAULT NULL,
  `srclang` varchar(20) DEFAULT NULL,
  `tgtlang` varchar(20) DEFAULT NULL,
  `testsetid` int(11) DEFAULT NULL,
  `track` varchar(10) DEFAULT NULL,
  `BLEU_SBP` varchar(10) DEFAULT NULL,
  `BLEU_NIST` varchar(10) DEFAULT NULL,
  `METEOR` varchar(10) DEFAULT NULL,
  `NIST` varchar(10) DEFAULT NULL,
  `GTM` varchar(10) DEFAULT NULL,
  `mWER` varchar(10) DEFAULT NULL,
  `mPER` varchar(10) DEFAULT NULL,
  `ICT` varchar(10) DEFAULT NULL,
  `submitter` varchar(20) DEFAULT NULL,
  `isConstraint` tinyint(1) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`submissionid`),
  KEY `systemid` (`systemid`),
  KEY `testset` (`testset`),
  KEY `FK_2` (`testsetid`),
  KEY `FK_username` (`submitter`),
  CONSTRAINT `FK_2` FOREIGN KEY (`testsetid`) REFERENCES `testsets` (`testsetid`),
  CONSTRAINT `FK_username` FOREIGN KEY (`submitter`) REFERENCES `users` (`username`),
  CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`systemid`) REFERENCES `systems` (`systemid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
```
* Create Submissions Table
```$xslt
CREATE TABLE `submissions` (
  `submissionid` int(11) NOT NULL AUTO_INCREMENT,
  `systemid` int(11) DEFAULT NULL,
  `systemname` varchar(40) DEFAULT NULL,
  `testset` varchar(40) DEFAULT NULL,
  `file` varchar(100) DEFAULT NULL,
  `notes` varchar(200) DEFAULT NULL,
  `BLEU` varchar(10) DEFAULT NULL,
  `BLEU_cased` varchar(10) DEFAULT NULL,
  `IGNORE_BLEU` varchar(10) DEFAULT NULL,
  `IGNORE_BLEU_cased` varchar(10) DEFAULT NULL,
  `IGNORE_BLEU_cased_norm` varchar(10) DEFAULT NULL,
  `TER` varchar(10) DEFAULT NULL,
  `BEER` varchar(10) DEFAULT NULL,
  `charac_ter` varchar(10) DEFAULT NULL,
  `time` varchar(40) DEFAULT NULL,
  `srclang` varchar(20) DEFAULT NULL,
  `tgtlang` varchar(20) DEFAULT NULL,
  `testsetid` int(11) DEFAULT NULL,
  `track` varchar(10) DEFAULT NULL,
  `BLEU_SBP` varchar(10) DEFAULT NULL,
  `BLEU_NIST` varchar(10) DEFAULT NULL,
  `METEOR` varchar(10) DEFAULT NULL,
  `NIST` varchar(10) DEFAULT NULL,
  `GTM` varchar(10) DEFAULT NULL,
  `mWER` varchar(10) DEFAULT NULL,
  `mPER` varchar(10) DEFAULT NULL,
  `ICT` varchar(10) DEFAULT NULL,
  `submitter` varchar(20) DEFAULT NULL,
  `isConstraint` tinyint(1) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`submissionid`),
  KEY `systemid` (`systemid`),
  KEY `testset` (`testset`),
  KEY `FK_2` (`testsetid`),
  KEY `FK_username` (`submitter`),
  CONSTRAINT `FK_2` FOREIGN KEY (`testsetid`) REFERENCES `testsets` (`testsetid`),
  CONSTRAINT `FK_username` FOREIGN KEY (`submitter`) REFERENCES `users` (`username`),
  CONSTRAINT `submissions_ibfk_1` FOREIGN KEY (`systemid`) REFERENCES `systems` (`systemid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
```
* Create Langmap Table
```$xslt
CREATE TABLE `langmap` (
  `langid` int(11) NOT NULL AUTO_INCREMENT,
  `abbr` varchar(4) DEFAULT NULL,
  `full` varchar(20) DEFAULT NULL,
  PRIMARY KEY (`langid`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
```
* Create Tracks Table
```$xslt
CREATE TABLE `tracks` (
  `track` varchar(10) NOT NULL,
  `srclang` varchar(20) DEFAULT NULL,
  `tgtlang` varchar(20) DEFAULT NULL,
  `trackid` int(11) NOT NULL AUTO_INCREMENT,
  `direction` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`trackid`),
  UNIQUE KEY `trackname` (`track`)
) ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=utf8
```
* Initial Data
```$xslt
insert into langmap values(null,'zh','Chinese');
insert into langmap values(null,'en','English');
insert into langmap values(null,'mn','Mongolian');
insert into langmap values(null,'jp','Japanese');
insert into langmap values(null,'ti','Tibetan');
insert into langmap values(null,'uy','Uyghur');

insert into tracks values('CE','Chinese','English',null,'zh-en-news');
insert into tracks values('EC','English','Chinese',null,'en-zh-news');
insert into tracks values('JE','Japanese','English',null,'jp-en-pat');
insert into tracks values('MC','Mongolian','Chinese',null,'mn-zh-dail');
insert into tracks values('TC','Tibetan','Chinese',null,'ti-zh-gove');
insert into tracks values('UC','Uyghur','Chinese',null,'uy-zh-news');
```




