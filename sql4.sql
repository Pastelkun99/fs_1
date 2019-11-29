create table POPUPTBL (pop_id int auto_increment primary key,
						pop_title varchar(100),
						pop_fromdate date,
						pop_todate date,
						pop_height int,
						pop_width int,
						pop_content varchar(1000),
                        pop_imageurl varchar(2000),
						pop_url varchar(2000),
                        pop_aval int
						);
drop table popuptbl;
truncate popuptbl;
                        
SELECT * FROM POPUPTBL;

SELECT * FROM popuptbl WHERE pop_aval = 1 ORDER BY pop_id DESC LIMIT 1;

insert into popuptbl values (0, '임시 팝업', '2019-11-27', '2019-11-30', 600, 400, '팝업의 내용입니다.', 'https://taegon.kim/wp-content/uploads/2018/05/image-5.png', 'www.naver.com', 1);