DROP TABLE QUESTIONTBL;
DROP TABLE SELECTTBL;
DROP TABLE ANSWERTBL;
DROP TABLE INFOTBL;
DROP TABLE ANALYSISTBL;

-- 테이블을 생성하는 부분

-- 설문조사 정보가 저장될 테이블을 선택한다.
CREATE TABLE INFOTBL(a_no int auto_increment primary key,
					 a_name varchar(400) not null,
                     a_collector varchar(100) not null,
                     a_submitter varchar(100) not null,
                     a_fromdate date not null,
                     a_todate date not null,
                     a_deploydate date not null,
                     a_aval int
                     );

-- 문제가 저장될 테이블을 만든다.
CREATE TABLE QUESTIONTBL (q_no INT auto_increment primary key,
						  a_no INT not null,
						  q_subject varchar(100) not null,
						  q_value varchar(2000) not null,
                          q_type varchar(10) not null,
                          q_selection int not null,
                          q_page int not null,
                          q_parentno int not null,
                          q_depth int
                          );
                          
-- 문항이 저장될 테이블을 만든다.                          
CREATE TABLE SELECTTBL (select_no int auto_increment primary key,
						q_type varchar(10) not null,
						q_selection int not null,
						q_svalue varchar(300) not null,
                        q_order int not null);
                        
-- 답안이 저장될 테이블을 만든다.                        
CREATE TABLE ANSWERTBL (a_number int auto_increment primary key,
						a_no int,
						q_no int,
                        q_id varchar(300),
                        q_selection int,
						q_value varchar(2000),
                        a_order int,
                        a_value varchar(100),
                        a_isetc int
                        );
                        
-- 사용자가 설문을 완료하면 사용할 테이블을 만든다.            
CREATE TABLE ANALYSISTBL(user_no int auto_increment primary key,
						 a_no int,
						 q_id varchar(100) not null,
                         user_complete int
                         );



SELECT * FROM ANALYSISTBL;
SELECT * FROM INFOTBL;            
SELECT * FROM ANSWERTBL ORDER BY q_no;

insert into infotbl values (0, '퓨전소프트 만족도 조사', '퓨전소프트', '회원', '2019-11-20', '2019-12-31', '2020-1-1', 1);
insert into infotbl values (0, '구윤모의 잘생김 조사', '퓨전소프트', '회원', '2019-11-25', '2019-12-04', '2020-1-1', 0);

SELECT * FROM ANSWERTBL WHERE q_no = 17 ORDER BY a_number DESC limit 2;
DELETE from answertbl where a_value = '기타';

set sql_safe_updates = 0;

select distinct q_selection from selecttbl;

SELECT * FROM ANALYSISTBL;
SELECT * FROM QUESTIONTBL;
SELECT * FROM SELECTTBL;
SELECT * FROM ANSWERTBL;
SELECT count(*) FROM ANSWERTBL;
SELECT * FROM INFOTBL;
select * from infotbl where a_no = 1;

SELECT MAX(q_selection) as CNT FROM SELECTTBL WHERE q_type = '001' AND q_selection <= 3000;

SELECT MAX(q_selection) as CNT FROM SELECTTBL WHERE q_type = '001' AND q_selection > 3000;

SELECT * FROM ANSWERTBL WHERE q_no =19 AND a_isetc = 1;  

update questiontbl set q_type = '000' where q_no = 16;

SELECT * FROM ANSWERTBL where q_id = 'admin';

update infotbl set a_submitter = '퓨전소프트 회원' Where a_no = 1;

SELECT * FROM QUESTIONTBL LEFT JOIN ANSWERTBL ON QUESTIONTBL.q_no = ANSWERTBL.q_no;
SELECT * FROM QUESTIONTBL LEFT JOIN ANSWERTBL ON QUESTIONTBL.q_no = ANSWERTBL.q_no WHERE ANSWERTBL.q_id = 'admin';

SELECT * FROM QUESTIONTBL LEFT JOIN SELECTTBL ON QUESTIONTBL.q_selection = SELECTTBL.q_selection ORDER BY QUESTIONTBL.q_no, SELECTTBL.q_order;

SELECT * FROM QUESTIONTBL LEFT JOIN SELECTTBL ON questiontbl.q_selection = selecttbl.q_selection;

SELECT * FROM QUESTIONTBL LEFT JOIN ANSWERTBL ON QUESTIONTBL.q_no = ANSWERTBL.q_no;

SELECT MAX(a_no) FROM infotbl;
select * from infotbl;


INSERT QUESTIONTBL VALUES (0, 2, '[전반적 만족도]', '나는 잘생겼나?', '001', '1111', 1, 1, null);
INSERT QUESTIONTBL VALUES (0, 2, '[검색성]', '나는 잘생겼지?', '001', '1111', 1, 2, null);
INSERT QUESTIONTBL VALUES (0, 2, '[검색성]', '빨리 그렇다고 말해', '001', '1111', 1, 3, null);
INSERT QUESTIONTBL VALUES (0, 2, '[사용성]', '10초 준다', '001', '1111', 1, 4, null);
INSERT QUESTIONTBL VALUES (0, 2, '[전반적 만족도]', '빨리', '001', '1111', 1, 5, null);
INSERT QUESTIONTBL VALUES (0, 2, '[사용성]', '싫어?','001', '1111', 2, 6, null);

truncate answertbl;

select count(*) from questiontbl WHERE a_no = 1;

SET SQL_SAFE_UPDATES = 0;

SET @CNT = 0;
UPDATE QUESTIONTBL SET QUESTIONTBL.q_no = @CNT:=@CNT+1;

INSERT QUESTIONTBL VALUES (0, 2, '[잘생김 조사]', '구윤모는 얼마나 잘생겼습니까?', '001', 1111, 1, 1, null);

truncate questiontbl;
-- QUESTIONTBL VALUES -- 
SELECT * FROM QUESTIONTBL;
INSERT QUESTIONTBL VALUES (0, 1, '[전반적 만족도]', '퓨전소프트 서비스에 대해 전반적으로 얼마나 만족하십니까?', '001', 1111, 1, 1, null);
INSERT QUESTIONTBL VALUES (0, 1, '[검색성]', '퓨전소프트에서 원하는 정보(자료)를 손쉽게 찾을 수 있습니까?', '001', 1111, 1, 2, null);
INSERT QUESTIONTBL VALUES (0, 1, '[검색성]', '검색창이 눈에 잘 띄는 위치에 적절한 크기로 배치되어 있습니까?', '001', 1111, 1, 3, null);
INSERT QUESTIONTBL VALUES (0, 1, '[사용성]', '게시물의 제목만으로도 게시물 내용을 알 수 있습니까?', '001', 1111, 1, 4, null);
INSERT QUESTIONTBL VALUES (0, 1, '[전반적 만족도]', '장문의 정보나 첨부문서가 포함된 경우 미리보기 또는 요약문을 충분히 제공한다고 생각하십니까?', '001', 1111, 1, 5, null);
INSERT QUESTIONTBL VALUES (0, 1, '[사용성]', '퓨전소프트에서 제공하는 자료의 글자 크기, 문단이 잘 정렬되어 보거나 읽기 쉽습니까?','001', 1111, 2, 6, null);
INSERT QUESTIONTBL VALUES (0, 1, '[사용성]', '퓨전소프트의 서비스 디자인이 일관성 있게 정돈되어 홈페이지 통일성이 느껴지십니까?', '001', 1111, 2, 7, null);
INSERT QUESTIONTBL VALUES (0, 1, '[사용성]', '퓨전소프트에서 사용되는 용어가 쉽고 명확하게 이해되십니까?', '001', 1111, 2, 8, null);
INSERT QUESTIONTBL VALUES (0, 1, '[사용성]', '서비스 페이지마다 동일한 아이콘과 버튼을 사용하고 있어 편리하십니까?', '001', 1111, 2, 9, null);
INSERT QUESTIONTBL VALUES (0, 1, '[정보보호]', '서비스를 이용하는데 필요한 최소한의 개인정보만을 요구하고 있다고 생각하십니까?', '001', 1111, 2, 10, null);
INSERT QUESTIONTBL VALUES (0, 1, '[유용성]', '포털을 방문하신 목적을 달성하시는데 포털에서 제고하는 서비스(통합검색, 마이메뉴 등)는 도움이 되셨습니까?', '001', 1111, 3, 11, null);
INSERT QUESTIONTBL VALUES (0, 1, '[유용성]', '서비스 이용을 통해 수업, 학습, 연구 준비에 도움이 되셨습니까?', '001', 1111, 3, 12, null);
INSERT QUESTIONTBL VALUES (0, 1, '[유용성]', '인쇄, 공유, 스크랩 등 유용한 부가기능을 충분히 제공하고 있다고 생각하십니까?', '001', 1111, 3, 13, null);
INSERT QUESTIONTBL VALUES (0, 1, '[소통]', '서비스 문의사항에 대해 신속하고 충분한 답변을 받으셨습니까?', '001', 1111, 3, 14, null);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '퓨전소프트에서 서비스하는 교육과정 관련 자료가 유익하십니까?','001', 1111, 3, 15, null);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '퓨전소프트에서 제공하는 서비스 중 가장 도움이 되는 서비스를 영역별로 선택해 주십시오.','000', 1110, 4, 16, null);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '수업*연구(2개 선택)','001', 3004, 4, 16, 1);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '교육정책(2개 선택)','001', 3002, 4, 16, 2);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '기타(2개 선택)','001', 3003, 4, 16, 3);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '위의 서비스를 선택한 이유는 무엇입니까?','002', 5000, 4, 17, null);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '퓨전소프트가 가장 시급하게 개선해야할 부분은 무엇이라고 생각하십니까?','001', 1115, 4, 18, null);
INSERT QUESTIONTBL VALUES (0, 1, '[일반]', '기타 퓨전소프트에 대한 의견을 자유롭게 작성하여 주십시오.','002', 5000, 5, 19, null);

update questiontbl set q_value = '위의 서비스를 선택한 이유는 무엇입니까? (필수)' where q_no = 20;
update questiontbl set q_type = '000' where q_no = 16;

delete from questiontbl where q_no = 6;

INSERT QUESTIONTBL VALUES (0, 1, '[주관식]', '주관식 테스트 질문', '002', '1112', 2);


truncate selecttbl;
-- SELECTTBL VALUES --
INSERT SELECTTBL VALUES(0, '001', 1111, '매우 만족', 1);
INSERT SELECTTBL VALUES(0, '001', 1111, '대체로 만족', 2);
INSERT SELECTTBL VALUES(0, '001', 1111, '약간 만족', 3);
INSERT SELECTTBL VALUES(0, '001', 1111, '보통', 4);
INSERT SELECTTBL VALUES(0, '001', 1111, '약간 불만족', 5);
INSERT SELECTTBL VALUES(0, '001', 1111, '대체로 불만족', 6);
INSERT SELECTTBL VALUES(0, '001', 1111, '매우 불만족', 7);

INSERT SELECTTBL VALUES(0, '001', 3004, '수업설계자료', 1);
INSERT SELECTTBL VALUES(0, '001', 3004, '단원학습자료', 2);
INSERT SELECTTBL VALUES(0, '001', 3004, '인성, 진로, 다문화', 3);
INSERT SELECTTBL VALUES(0, '001', 3004, '연구자료', 4);
INSERT SELECTTBL VALUES(0, '001', 3004, '교육과정자료', 5);
INSERT SELECTTBL VALUES(0, '001', 3004, '주제별 사진영상 자료', 6);
INSERT SELECTTBL VALUES(0, '001', 3004, '교과주제별 학습자료', 7);
INSERT SELECTTBL VALUES(0, '001', 3004, '외부자료', 8);
INSERT SELECTTBL VALUES(0, '001', 3004, '위두랑', 9);
INSERT SELECTTBL VALUES(0, '001', 3004, '우수수업동영상', 10);
INSERT SELECTTBL VALUES(0, '001', 3004, '디지털교과서', 11);
INSERT SELECTTBL VALUES(0, '001', 3004, '소프트웨어교육', 12);
INSERT SELECTTBL VALUES(0, '001', 3004, '연구대회', 13);
INSERT SELECTTBL VALUES(0, '001', 3004, '연구학교', 14);
INSERT SELECTTBL VALUES(0, '001', 3004, '사서 추천도서', 15);
INSERT SELECTTBL VALUES(0, '001', 3004, '교원연수', 16);
INSERT SELECTTBL VALUES(0, '001', 3004, '영어 e-교과서', 17);
INSERT SELECTTBL VALUES(0, '001', 3004, '스마트교육 이해', 18);
INSERT SELECTTBL VALUES(0, '001', 3004, '문제은행', 19);
INSERT SELECTTBL VALUES(0, '001', 3004, '없음', 20);

INSERT SELECTTBL VALUES(0, '001', 3002, '2015 개정 교육과정', 1);
INSERT SELECTTBL VALUES(0, '001', 3002, '학생평가', 2);
INSERT SELECTTBL VALUES(0, '001', 3002, '자유학기제', 3);
INSERT SELECTTBL VALUES(0, '001', 3002, '고교교육력 제고', 4);
INSERT SELECTTBL VALUES(0, '001', 3002, 'NCS기반 교육과정', 5);
INSERT SELECTTBL VALUES(0, '001', 3002, '고교학점제', 6);
INSERT SELECTTBL VALUES(0, '001', 3002, '사이버폭력예방, 정보윤리교육', 7);
INSERT SELECTTBL VALUES(0, '001', 3002, '도란도란 학교폭력예방', 8);
INSERT SELECTTBL VALUES(0, '001', 3002, '없음', 9);

INSERT SELECTTBL VALUES(0, '001', 3003, '공지사항', 1);
INSERT SELECTTBL VALUES(0, '001', 3003, '마이페이지', 2);
INSERT SELECTTBL VALUES(0, '001', 3003, '독서교육, 인문소양교육', 3);
INSERT SELECTTBL VALUES(0, '001', 3003, '선생님들의 나눔공간', 4);
INSERT SELECTTBL VALUES(0, '001', 3003, '나에게 Dream', 5);
INSERT SELECTTBL VALUES(0, '001', 3003, '시*도교육정보서비스', 6);
INSERT SELECTTBL VALUES(0, '001', 3003, '최신동향', 7);
INSERT SELECTTBL VALUES(0, '001', 3003, '고객센터(이용문의)', 8);
INSERT SELECTTBL VALUES(0, '001', 3003, '기타', 9);
INSERT SELECTTBL VALUES(0, '001', 3003, '없음', 10);

INSERT SELECTTBL VALUES(0, '001', 1112, '콘텐츠 보강', 1);
INSERT SELECTTBL VALUES(0, '001', 1112, '콘텐츠 검색', 2);
INSERT SELECTTBL VALUES(0, '001', 1112, '회원가입', 3);
INSERT SELECTTBL VALUES(0, '001', 1112, '인지도 강화(홍보)', 4);
INSERT SELECTTBL VALUES(0, '001', 1112, '기타', 5);

INSERT SELECTTBL VALUES(0, '002', 5000, '주관식', 0);

