create table multiboardtbl (
								board_no int primary key auto_increment,
                                board_name varchar(200) not null,
                                board_type int not null,
                                board_reboardyn varchar(1) not null,
                                board_replyyn varchar(1) not null,
                                board_secretyn varchar(1) not null
							);
ALTER TABLE multiboardtbl ADD board_order int;     

create table readnoticetbl (
							 read_no int auto_increment primary key,
							 user_id varchar(100),
                             article_no int
                             );
                             
drop table readnoticetbl;

set foreign_key_checks = 1;
truncate multiboardtbl; 
select * from multiboardtbl ORDER BY board_order ASC;          
select * from articletbl;      


insert into multiboardtbl values (1, '더미게시판1', 0, 'Y', 'Y', 'Y'); 
insert into multiboardtbl values (2, '더미게시판2', 0, 'Y', 'Y', 'Y'); 


create table articletbl (
							article_no int primary key auto_increment,
                            board_no int not null,
                            article_writer varchar(200) not null,
                            article_userid varchar(100) not null,
                            article_title varchar(200) not null,
                            article_content varchar(2000),
                            article_secretyn varchar(1) not null,
                            article_password varchar(1000),
                            article_parentsno int,
                            article_grouporder int,
                            article_groupdepth int,
                            article_hit int,
                            article_date datetime,
                            article_deleteyn varchar(1) not null,
                            foreign key (board_no) references multiboardtbl (board_no)
						);
alter table articletbl add article_noticeyn varchar(1);                        
truncate articletbl;

insert into articletbl values (0, 1, '관리자', 'admin', '즈에목', '브온문', 'N', null, 1, 0, 0, 0, now(), 'N'); 
insert into articletbl values (0, 1, '관리자', 'admin', '제목의 왕', '본문의 왕', 'N', null, 1, 0, 0, 0, now(), 'N'); 
insert into articletbl values (0, 2, '관리자', 'admin', '삥', '뺑', 'N', null, 1, 0, 0, 0, now(), 'N'); 
insert into articletbl values (0, 2, '관리자', 'admin', '뽕', '쁭', 'N', null, 1, 0, 0, 0, now(), 'N'); 
                        
create table replytbl(reply_no int auto_increment primary key,
					  article_no int,
                      reply_writer varchar(100),
                      reply_userid varchar(100),
                      reply_date datetime,
                      reply_content varchar(300)
                      );
drop table replytbl;

SELECT * FROM articletbl ORDER BY article_no DESC LIMIT 1;
                      
alter table articletbl drop foreign key articletbl_ibfk_1;            
select * from information_schema.table_constraints where table_name = 'articletbl';

insert readnoticetbl values (0, 'admin', 13);
insert readnoticetbl values (0,'admin', 14);
select * from readnoticetbl;
select * from articletbl;

-- 찾았나?
select distinct A.* from articletbl A, readnoticetbl C WHERE A.board_no = 7 AND A.article_no NOT IN (SELECT article_no from readnoticetbl);

-- 게시판 구분없이 알림형 게시판에 쓰여진 글
select B.* from (SELECT board_no FROM multiboardtbl WHERE board_type = 1) A, articletbl B WHERE A.board_no = B.board_no;

select * from articletbl;
select * from multiboardtbl;
select * from readnoticetbl;
-- 게시판 번호에 따라 알림형 게시판에 쓰여진 글
select B.*, C.board_name from (SELECT board_no FROm multiboardtbl WHERE board_type = 1) A, articletbl B, multiboardtbl C WHERE A.board_no = B.board_no AND A.board_no = C.board_no AND A.board_no = 7;

select COUNT(*) AS CNT from (SELECT board_no FROm multiboardtbl WHERE board_type = 1) A, articletbl B, multiboardtbl C WHERE A.board_no = B.board_no AND A.board_no = C.board_no AND A.board_no = 7;
-- 게시판 구분없이 알림형 게시판에 쓰여진 글 갯수
select COUNT(*) AS CNT from (SELECT board_no FROM multiboardtbl WHERE board_type = 1) A, articletbl B WHERE A.board_no = B.board_no;

-- 고치기
SELECT COUNT(*) AS CNT 
				FROM multiboardtbl A, articletbl B 
				WHERE A.board_no = B.board_no 
					AND A.board_type = 1 
					AND B.article_no NOT IN (SELECT article_no from readnoticetbl WHERE user_id = 'awdawd');
                    

-- admin 유저가 게시판에서 읽지 않은 글
SELECT B.* FROM (SELECT article_no FROM readnoticetbl WHERE user_id = 'admin') A RIGHT JOIN articletbl B ON A.article_no != B.article_no WHERE B.article_no is null;

-- 해당 유저가 알림형 게시판에서 읽은 글
SELECT B.* FROM articletbl B WHERE B.board_no IN (SELECT board_no FROM multiboardtbl WHERE board_type = 1) AND B.article_no IN (SELECT article_no from readnoticetbl where user_id = 'admin');

-- 해당 유저가 전체 알림형 게시판에서 읽지 않은 글
SELECT A.board_name, B.* FROM multiboardtbl A, articletbl B WHERE B.board_no IN (SELECT board_no FROM multiboardtbl WHERE board_type = 1) AND B.article_no NOT IN (SELECT article_no from readnoticetbl where user_id = 'admin') AND B.board_no = A.board_no;

-- 해당 유저가 특정 알림형 게시판에서 읽지 않은 글
SELECT B.* FROM articletbl B WHERE B.board_no IN (SELECT board_no FROM multiboardtbl WHERE board_type = 1) AND B.article_no NOT IN (SELECT article_no from readnoticetbl where user_id = 'admin') AND B.board_no = 7;

-- 모든 알람형 게시판에서 내가 읽지 않은(readnoticetbl에 정보가 없는) 게시글 수
select COUNT(*) AS CNT from multiboardtbl A, articletbl B WHERE A.board_no = B.board_no AND A.board_type = 1 AND B.article_no NOT IN (SELECT article_no from readnoticetbl);



select COUNT(*) AS CNT from multiboardtbl A, articletbl B WHERE A.board_no = B.board_no AND A.board_type = 1 AND A.board_no = 7;

-- 게시판 초기화 하려면 실행
truncate readnoticetbl;
truncate articletbl;
truncate replytbl;
truncate multiboardtbl;

select * from usertbl;
SELECT * FROM BOARDTBL WHERE board_isnotice = 0 ORDER BY board_parentsno DESC, board_grouporder ASC, board_date DESC LIMIT 0, 10;

select * from boardtbl;

select * from replytbl;
select * from multiboardtbl;
select * from articletbl;
select * from usertbl;

delete from replytbl WHERE article_no = 1;

SELECT reply_no, article_no, reply_writer, reply_userid, DATE_FORMAT(reply_date, '%Y-%m-%d %h:%i:%s') AS reply_date, reply_content
		FROM replytbl
		WHERE article_no = 1 ORDER BY reply_date DESC 


-- 게시판 번호에 따른 게시글 리스트
select B.* from multiboardtbl A, articletbl B WHERE A.board_no = B.board_no AND A.board_no = 1; 

-- 게시판 번호에 따른 게시글 갯수
select COUNT(*) as cnt from multiboardtbl A, articletbl B WHERE A.board_no = B.board_no AND A.board_no = 1;

SELECT COUNT(*) FROM multiboardtbl A, articletbl B WHERE A.board_no = B.board_no AND article_title LIKE CONCAT('%', '제', '%') AND article_deleteyn = 'N' AND A.board_no = 1;

SELECT B.* FROM multiboardtbl A, articletbl B WHERE A.board_no = B.board_no AND article_title LIKE CONCAT('%', '제', '%') AND article_deleteyn = 'N' AND A.board_no = 1;

SELECT B.*
		FROM multiboardtbl A, articletbl B
		WHERE A.board_no = B.board_no AND A.board_no = 1
		ORDER BY article_parentsno DESC, article_grouporder ASC, article_date asc;

