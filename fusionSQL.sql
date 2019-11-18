create table usertbl(userno int AUTO_INCREMENT primary key,
					 userid varchar(20),
					 userpw varchar(300),
                     username varchar(50),
                     user_admin int);
                     
create table boardtbl(board_no int auto_increment primary key,
					  board_writer varchar(100),
                      board_userid varchar(100),
                      board_title varchar(100),
                      board_content longtext,
                      board_deletecon int,
                      board_date datetime,
                      board_hit int,
                      board_parentsno int,
                      board_grouporder int,
                      board_groupdepth int,
                      board_isnotice int);
                      
create table replytbl(reply_no int auto_increment primary key,
					  reply_board int,
                      reply_writer varchar(100),
                      reply_userid varchar(100),
                      reply_date datetime,
                      reply_content varchar(300)
                      );
                      
create table logtbl(log_no int auto_increment primary key,
					log_userid varchar(100),
                    log_date DATETIME,
                    log_userip varchar(50),
                    log_userbrowser varchar(50),
                    log_bversion varchar(100),
                    log_osversion varchar(100),
                    log_userreferrer varchar(500)
                    );

drop table logtbl;
select * from logtbl;

SELECT log_userreferrer, COUNT(*) AS CNT FROM LOGTBL GROUP BY log_userreferrer ORDER BY cnt DESC;
SELECT date_format(log_date, '%Y-%m-%d') AS log_date, COUNT(*) AS CNT FROM LOGTBL GROUP BY date_format(log_date, '%Y-%m-%d');

-- 날짜 넣었을 때
SELECT date_format(log_date, '%H') AS TIME, COUNT(*) AS CNT FROM (select * from logtbl where log_date >= '2019-11-15 00:00:00' AND log_date <= '2019-11-16 23:59:59') A GROUP BY date_format(log_date, '%H');

SELECT * FROM (select * from logtbl where log_date >= '2019-11-15 00:00:00' AND log_date <= '2019-11-18 23:59:59') A ORDER BY log_date DESC;

SELECT *
		FROM (SELECT * FROM LOGTBL WHERE log_date >= '2019-11-18 00:00:00' AND log_date <= '2019-11-18 23:59:59') A
		ORDER BY log_date DESC;


select date_format(log_date, '%Y-%m-%d') AS log_date, COUNT(*) as CNT FROM LOGTBL GROUP BY date_format(log_date, '%Y-%m-%d');

INSERT INTO LOGTBL VALUES (0, 'admin', '127.0.0.1', 'CHROME', '78.0.3904.97', 'WINDOWS_10', 'http://localhost:8080/user/userLogin.do');
INSERT INTO LOGTBL VALUES (0, 'admin', '127.0.0.1', 'EDGE', '18.18363', 'WINDOWS_10', 'http://localhost:8080/user/userLogin.do');
INSERT INTO LOGTBL VALUES (0, 'admin', '127.0.0.1', 'IE11', '11.0', 'WINDOWS_10', 'http://localhost:8080/user/userLogin.do');
                      
select * from replytbl;


select log_userid, COUNT(*) as cnt from logtbl group by log_userid order by cnt DESC;
select log_userbrowser, COUNT(*) as cnt from logtbl group by log_userbrowser order by cnt DESC;
truncate logtbl;
call looplog();

DELIMITER $$
DROP PROCEDURE IF EXISTS looplog$$

CREATE PROCEDURE looplog()
BEGIN
	DECLARE i INT DEFAULT 1;
    DECLARE j INT DEFAULT 1;
    DECLARE k INT DEFAULT 1;
    DECLARE l INT DEFAULT 1;
    
    WHILE i <= 19 DO
		INSERT INTO LOGTBL VALUES (0, 'admin', '2019-11-14 13:30:00', '127.0.0.1', 'CHROME', '78.0.3904.97', 'WINDOWS_10', 'http://localhost:8080/user/userLogin.do');
        SET i = i + 1;
	END WHILE;
    
    WHILE j <= 21 DO
		INSERT INTO LOGTBL VALUES (0, 'admin', '2019-11-15 12:37:25', '127.0.0.1', 'IE11', '11.0', 'WINDOWS_7', 'http://localhost:8080/user/userLogin.do');
        SET j = j + 1;
	END WHILE;
    
    WHILE k <= 17 DO
		INSERT INTO LOGTBL VALUES (0, 'admin', now(), '127.0.0.1', 'EDGE', '18.18363', 'WINDOWS_10', 'http://localhost:8080/user/userLogin.do');
		SET k = k + 1;
	END WHILE;
    
    WHILE l <= 24 DO
		INSERT INTO LOGTBL VALUES (0, 'admin', now(), '127.0.0.1', 'CHROME', '78.0.3904.97', 'WINDOWS_8.1', 'http://localhost:8080/user/userLogin.do');
		SET l = l + 1;
	END WHILE;
    
END $$
                     
DELIMITER $$
DROP PROCEDURE IF EXISTS loopInsert$$
 
CREATE PROCEDURE loopInsert()
BEGIN
    DECLARE i INT DEFAULT 1;
        
    WHILE i <= 50 DO
        INSERT INTO BOARDTBL(board_writer, board_userid, board_title, board_content, board_deletecon, board_date,
							 board_hit, board_parentsno, board_grouporder, board_groupdepth, board_isnotice)
          VALUES('관리자', 'admin', concat('제목', i), concat('내용', i), 0, now(), 0, i, 0, 0, 0);
        SET i = i + 1;
    END WHILE;
END$$
DELIMITER $$

select * from usertbl;
select count(*) from boardtbl;
select count(*) from boardtbl where board_deletecon = 0;
update boardtbl set board_deletecon = 1 Where board_no = 10;
select * from boardtbl;

SELECT * FROM BOARDTBL ORDER BY board_parentsno DESC, board_grouporder ASC;
call loopInsert;
truncate boardtbl;
INSERT into boardtbl values(0 ,'관리자', 'admin', '가장 최근 공지사항.', '공지사항의 내용입니다.', 0, now(), 0, 0, 0, 0, 1);

select max(board_grouporder) FROM BOARDTBL WHERE board_parentsno = 48;

select count(*) from boardtbl WHERE board_title like '%3%';
select * from boardtbl WHERE board_title like '%3%';


SELECT * FROM BOARDTBL ORDER BY board_date LIMIT 1*10, 10;

select @ROWNUM:=@ROWNUM+1, A.* from boardtbl A, (SELECT @ROWNUM:=0) R;