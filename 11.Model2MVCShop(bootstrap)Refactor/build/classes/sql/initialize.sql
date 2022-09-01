

set pagesize 4000;
set linesize 4000;


DROP TABLE Cart;
DROP TABLE transaction;
DROP TABLE product;
DROP TABLE upload_file;
DROP TABLE users;


ALTER TABLE product ADD amount NUMBER(20);
UPDATE product SET amount = 4;
ALTER TABLE transaction ADD amount NUMBER(20);
UPDATE product SET amount = 7;


DROP SEQUENCE seq_product_prod_no;
DROP SEQUENCE seq_transaction_tran_no;


CREATE SEQUENCE seq_product_prod_no		INCREMENT BY 1 START WITH 10000;
CREATE SEQUENCE seq_transaction_tran_no	INCREMENT BY 1 START WITH 10000;


CREATE TABLE users ( 
	user_id 				VARCHAR2(20)	NOT NULL,
	user_name 			VARCHAR2(50)	NOT NULL,
	password 			VARCHAR2(10)	NOT NULL,
	role 					VARCHAR2(5) 		DEFAULT 'user',
	ssn 					VARCHAR2(13),
	cell_phone 			VARCHAR2(14),
	addr 				VARCHAR2(100),
	email 				VARCHAR2(50),
	reg_date 				DATE,
	PRIMARY KEY(user_id)
);


CREATE TABLE product ( 
	prod_no 			NUMBER 			NOT NULL,
	prod_name 			VARCHAR2(100) 	NOT NULL,
	prod_detail 		VARCHAR2(200),
	manufacture_day		VARCHAR2(8),
	price 				NUMBER(10),
	image_file 			VARCHAR2(100),
	reg_date 			DATE,
	amount				NUMBER(10),
	PRIMARY KEY(prod_no)
);

CREATE TABLE transaction ( 
	tran_no 				NUMBER 			NOT NULL,
	tran_id					VARCHAR2(50)	NOT NULL,
	prod_no 				NUMBER(16)		NOT NULL REFERENCES product(prod_no),
	buyer_id 				VARCHAR2(20)	NOT NULL REFERENCES users(user_id),
	payment_option		CHAR(3),
	receiver_name 		VARCHAR2(20),
	receiver_phone		VARCHAR2(14),
	demailaddr 			VARCHAR2(100),
	dlvy_request 			VARCHAR2(100),
	tran_status_code		CHAR(3),
	order_data 			DATE,
	dlvy_date 			DATE,
	amount				NUMBER(10),
	total_price			NUMBER(20),
	PRIMARY KEY(tran_no)
);

CREATE TABLE Cart (
	prod_no				NUMBER(20)			NOT NULL REFERENCES product(prod_no),
	user_id				VARCHAR2(20)		NOT NULL REFERENCES users(user_id),
	image				VARCHAR(50),
	product_name		VARCHAR2(100),
	product_detail		VARCHAR2(200),
	amount				NUMBER(10),
	price				NUMBER(10)
);

CREATE TABLE Upload_File (
	fileNo				VARCHAR2(100)		NOT NULL,
	fileCount			NUMBER(20)			NOT NULL,
	fileName			VARCHAR2(100)		NOT NULL,
	file_path			varchar2(200)
);



INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) VALUES ( 'admin', 'admin이름', '1234', 'admin', NULL, '010-9999-9999', '서울시 서초구', 'admin@mvc.com',to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS')); 
INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) VALUES ( 'manager', 'manager이름', '1234', 'admin', NULL, '010-8888-8888', NULL, 'manager@mvc.com', to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));     
INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) VALUES ( 'non-member', 'non-member', 'non-member', 'non', NULL, NULL, NULL, 'manager@mvc.com', to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));        
INSERT INTO users VALUES ( 'user01', 'user01', '1111', 'user', NULL, '010-0000-0101', '서울 강서', 'user01@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user02', 'user02', '2222', 'user', NULL, '010-0000-0202', '서울 양천구', 'user02@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user03', 'user03', '3333', 'user', NULL, '010-0000-0303', '서울 구로구 오류동', 'user03@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user04', 'user04', '4444', 'user', NULL, '010-0000-0404', '서울 영등포구 대림동', 'user04@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user05', 'user05', '5555', 'user', NULL, '010-0000-0505', '서울 금천구', 'user05@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user06', 'user06', '6666', 'user', NULL, '010-0000-0606', '서울 동작구', 'user06@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user07', 'user07', '7777', 'user', NULL, '010-0000-0707', '서울 관악구 대학동', 'user07@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user08', 'user08', '8888', 'user', NULL, '010-0000-0808', '서울 서초구', 'user08@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user09', 'user09', '9999', 'user', NULL, '010-0000-0909', '서울 강남구', 'user09@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user10', 'user10', '1010', 'user', NULL, '010-1111-1010', '서울 송파구', 'user10@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user11', 'user11', '1111', 'user', NULL, '010-1111-1111', '서울 강동구', 'user11@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user12', 'user12', '1212', 'user', NULL, '010-1111-1212', '서울 마포구 상암동', 'user12@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user13', 'user13', '1313', 'user', NULL, '010-1111-1313', '서울 용산구 한남동', 'user13@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user14', 'user14', '1414', 'user', NULL, '010-1111-1414', '서울 서대문구', 'user14@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user15', 'user15', '1515', 'user', NULL, '010-1111-1515', '서울 은평구', 'user15@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user16', 'user16', '1616', 'user', NULL, '010-1111-1616', '서울 종로구', 'user16@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user17', 'user17', '1717', 'user', NULL, '010-1111-1717', '서울 중구 황학동', 'user17@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user18', 'user18', '1818', 'user', NULL, '010-1111-1818', '서울 성동구', 'user18@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user19', 'user19', '1919', 'user', NULL, '010-1111-1919', '서울 성북구', 'user19@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user20', 'user20', '2020', 'user', NULL, '010-2222-2020', '서울 동대문구 회기동', 'user20@mvc.com', sysdate);

INSERT INTO users VALUES ( 'user21', 'user21', '2121', 'user', NULL, '010-2222-2121', '서울 도봉구', 'user21@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user22', 'user22', '2222', 'user', NULL, '010-2222-2222', '서울 노원구', 'user22@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user23', 'user23', '2323', 'user', NULL, '010-2222-2323', '서울 중광구', 'user23@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user24', 'user24', '2424', 'user', NULL, '010-2222-2424', '서울 광진구', 'user24@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user25', 'user25', '2525', 'user', NULL, '010-2222-2525', '서울 강북구', 'user25@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user26', 'user26', '2626', 'user', NULL, '010-2222-2626', '서울 영등포구 여의동', 'user26@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user27', 'user27', '2727', 'user', NULL, '010-2222-2727', '서울 영등포구 당산동', 'user27@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user28', 'user28', '2828', 'user', NULL, '010-2222-2828', '서울 영등포구 양평동', 'user28@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user29', 'user29', '2929', 'user', NULL, '010-2222-2929', '서울 영등포구 문래동', 'user29@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user30', 'user30', '3030', 'user', NULL, '010-3333-3030', '서울 영등포구 신길동', 'user30@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user31', 'user31', '3131', 'user', NULL, '010-3333-3131', '서울 구로구 개봉동', 'user31@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user32', 'user32', '3232', 'user', NULL, '010-3333-3232', '서울 구로구 고척동', 'user32@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user33', 'user33', '3333', 'user', NULL, '010-3333-3333', '서울 구로구 항동', 'user33@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user34', 'user34', '3434', 'user', NULL, '010-3333-3434', '서울 구로구 수궁동', 'user34@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user35', 'user35', '3535', 'user', NULL, '010-3333-3535', '서울 마포구 성산동', 'user35@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user36', 'user36', '3636', 'user', NULL, '010-3333-3636', '서울 마포구 망원동', 'user36@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user37', 'user37', '3737', 'user', NULL, '010-3333-3737', '서울 마포구 합정동', 'user37@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user38', 'user38', '3838', 'user', NULL, '010-3333-3838', '서울 마포구 연남동', 'user38@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user39', 'user39', '3939', 'user', NULL, '010-3333-3939', '서울 마포구 서교동', 'user39@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user40', 'user40', '4040', 'user', NULL, '010-4444-4040', '서울 마포구 동교동', 'user40@mvc.com', sysdate);

INSERT INTO users VALUES ( 'user41', 'user41', '4141', 'user', NULL, '010-4444-4141', '서울 마포구 신수동', 'user41@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user42', 'user42', '4242', 'user', NULL, '010-4444-4242', '서울 마포구 상수동', 'user42@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user43', 'user43', '4343', 'user', NULL, '010-4444-4343', '서울 마포구 신공덕동', 'user43@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user44', 'user44', '4444', 'user', NULL, '010-4444-4444', '서울 마포구 노고산동', 'user44@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user45', 'user45', '4545', 'user', NULL, '010-4444-4545', '서울 용산구 서빙고동', 'user45@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user46', 'user46', '4646', 'user', NULL, '010-4444-4646', '서울 용산구 보광동', 'user46@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user47', 'user47', '4747', 'user', NULL, '010-4444-4747', '서울 용산구 이태원동', 'user47@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user48', 'user48', '4848', 'user', NULL, '010-4444-4848', '서울 용산구 한강로동', 'user48@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user49', 'user49', '4949', 'user', NULL, '010-4444-4949', '서울 용산구 이촌동', 'user49@mvc.com', sysdate); 
INSERT INTO users VALUES ( 'user50', 'user50', '5050', 'user', NULL, '010-5555-5050', '서울 동대문구 전농동', 'user50@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user51', 'user51', '5151', 'user', NULL, '010-5555-5151', '서울 동대문구 용신동', 'user51@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user52', 'user52', '5252', 'user', NULL, '010-5555-5252', '서울 동대문구 장안동', 'user52@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user53', 'user53', '5353', 'user', NULL, '010-5555-5353', '서울 동대문구 휘경동', 'user53@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user54', 'user54', '5454', 'user', NULL, '010-5555-5454', '서울 동대문구 이문동', 'user54@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user55', 'user55', '5555', 'user', NULL, '010-5555-5555', '서울 관악구 삼성동', 'user55@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user56', 'user56', '5656', 'user', NULL, '010-5555-5656', '서울 관악구 남현동', 'user56@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user57', 'user57', '5757', 'user', NULL, '010-5555-5757', '서울 관악구 인현동', 'user57@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user58', 'user58', '5858', 'user', NULL, '010-5555-5858', '서울 관악구 낙성대동', 'user58@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user59', 'user59', '5959', 'user', NULL, '010-5555-5959', '서울 관악구 보라매동', 'user59@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user60', 'user60', '6060', 'user', NULL, '010-6666-6060', '서울 관악구 신사동', 'user60@mvc.com', sysdate);

INSERT INTO users VALUES ( 'user61', 'user61', '6161', 'user', NULL, '010-6666-6161', '서울 노원구 상계동', 'user61@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user62', 'user62', '6262', 'user', NULL, '010-6666-6262', '서울 노원구 중계동', 'user62@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user63', 'user63', '6363', 'user', NULL, '010-6666-6363', '서울 노원구 하계동', 'user63@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user64', 'user64', '6464', 'user', NULL, '010-6666-6464', '서울 노원구 월계동', 'user64@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user65', 'user65', '6565', 'user', NULL, '010-6666-6565', '서울 노원구 공릉동', 'user65@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user66', 'user66', '6666', 'user', NULL, '010-6666-6666', '서울 강북구 우이동', 'user66@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user67', 'user67', '6767', 'user', NULL, '010-6666-6767', '서울 강북구 수유동', 'user67@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user68', 'user68', '6868', 'user', NULL, '010-6666-6868', '서울 강북구 번동', 'user68@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user69', 'user69', '6969', 'user', NULL, '010-6666-6969', '서울 강북구 미아동', 'user69@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user70', 'user70', '7070', 'user', NULL, '010-7777-7070', '서울 관악구 신사동', 'user70@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user71', 'user71', '7171', 'user', NULL, '010-7777-7171', '서울 동대문구 용신동', 'user71@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user72', 'user72', '7272', 'user', NULL, '010-7777-7272', '서울 동대문구 장안동', 'user72@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user73', 'user73', '7373', 'user', NULL, '010-7777-7373', '서울 동대문구 휘경동', 'user73@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user74', 'user74', '7474', 'user', NULL, '010-7777-7474', '서울 동대문구 이문동', 'user74@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user75', 'user75', '7575', 'user', NULL, '010-7777-7575', '서울 중구 중림동', 'user75@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user76', 'user76', '7676', 'user', NULL, '010-7777-7676', '서울 중구 회현동', 'user76@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user77', 'user77', '7777', 'user', NULL, '010-7777-7777', '서울 중구 소공동', 'user77@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user78', 'user78', '7878', 'user', NULL, '010-7777-7878', '서울 중구 명동', 'user78@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user79', 'user79', '7979', 'user', NULL, '010-7777-7979', '서울 중구 필동', 'user79@mvc.com', sysdate);
INSERT INTO users VALUES ( 'user80', 'user80', '8080', 'user', NULL, '010-8888-8080', '서울 중구 을지로동', 'user80@mvc.com', sysdate);


           
insert into product values (seq_product_prod_no.nextval,'vaio vgn FS70B','소니 바이오 노트북 신동품','20120514',2000000, '20220818000001',to_date('2012/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'자전거','자전거 좋아요~','20120514',10000, '20220818000002',to_date('2012/11/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'),12);
insert into product values (seq_product_prod_no.nextval,'보르도','최고 디자인 신품','20120201',1170000, '20220818000003',to_date('2012/10/14 10:49:39', 'YYYY/MM/DD HH24:MI:SS'),11);
insert into product values (seq_product_prod_no.nextval,'보드세트','한시즌 밖에 안썼습니다 ㅠ.ㅠ','20120217', 200000, '20220818000004',to_date('2012/11/14 10:50:58', 'YYYY/MM/DD HH24:MI:SS'),2);
insert into product values (seq_product_prod_no.nextval,'인라인','좋아욥','20120819', 20000, '20220818000005',to_date('2012/11/14 10:51:40', 'YYYY/MM/DD HH24:MI:SS'),8);
insert into product values (seq_product_prod_no.nextval,'삼성센스 2G','sens 메모리 2Giga','20121121',800000, '20220818000006',to_date('2012/11/14 18:46:58', 'YYYY/MM/DD HH24:MI:SS'),5);
insert into product values (seq_product_prod_no.nextval,'연꽃','정원을 가꿔보세요','20121022',232300, '20220818000007',to_date('2012/11/15 17:39:01', 'YYYY/MM/DD HH24:MI:SS'),9);
insert into product values (seq_product_prod_no.nextval,'삼성센스','노트북','20120212',600000, '20220818000008',to_date('2012/11/12 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),3);
insert into product values (seq_product_prod_no.nextval,'test1','test1','20120212',60000, '20220818000009',to_date('2012/11/11 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test2','test2','20120212',50000, '20220818000010',to_date('2012/11/10 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test3','test3','20120212',20000, '20220818000011',to_date('2012/11/09 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test4','test4','20120212',15000, '20220818000012',to_date('2012/11/08 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test5','test5','20120212',7200, '20220818000013',to_date('2012/11/07 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),13);
insert into product values (seq_product_prod_no.nextval,'test6','test6','20120212',1000, '20220818000014',to_date('2012/11/06 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),18);
insert into product values (seq_product_prod_no.nextval,'test7','test7','20120212',94000, '20220818000015',to_date('2012/11/05 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),20);
insert into product values (seq_product_prod_no.nextval,'test8','test8','20120212',7000, '20220818000016',to_date('2012/11/14 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test9','test9','20120212',8000, '20220818000017',to_date('2012/11/15 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test10','test10','20120212',14000, '20220818000018',to_date('2012/11/16 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test11','test11','20120213',15000, '20220818000019',to_date('2012/10/12 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test12','test12','20120214',11000, '20220818000020',to_date('2012/10/14 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test13','test13','20120215',7000, '20220818000021',to_date('2012/10/16 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test14','test14','20120220',4000, '20220818000022',to_date('2012/10/18 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test15','test15','20120215',2000, '20220818000023',to_date('2012/10/19 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test16','test16','20120226',84000, '20220818000024',to_date('2012/10/20 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'test17','test17','20120223',52000, '20220818000025',to_date('2012/10/06 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),10);



INSERT INTO upload_file VALUES ('20220818000001', 1, 'flower.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000002', 1, '981633.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000003', 1, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000004', 1, '08a7ed5263cde1.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000005', 1, 'a12270722.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000006', 1, '62129057.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000007', 1, '8456ac3b755ea9d.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000008', 1, 'flower.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000009', 1, '981633.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000010', 1, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000011', 1, '08a7ed5263cde1.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000012', 1, 'a12270722.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000013', 1, '62129057.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000014', 1, '8456ac3b755ea9d.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000015', 1, 'flower.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000016', 1, '981633.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000017', 1, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000018', 1, '08a7ed5263cde1.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000019', 1, 'a12270722.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000020', 1, '62129057.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000021', 1, '8456ac3b755ea9d.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000022', 1, 'flower.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000023', 1, '981633.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000024', 3, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000024', 3, 'a12270722.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000024', 3, '8456ac3b755ea9d.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000025', 2, '08a7ed5263cde1.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000025', 2, '981633.jpg', 'C:\Users\903-19\git\11.Model2MVCShop-bootstrap-Refactor\11.Model2MVCShop(bootstrap)Refactor\src\main\webapp\images\uploadFiles\\');



INSERT INTO cart VALUES(10001, 'user02', 'AHlbAAAAvetFNwAA.jpg', '자전거', '자전거 좋아요', 3, 10000);
INSERT INTO cart VALUES(10002, 'user02', 'AHlbAAAAvewfegAB.jpg', '보르도', '최고 디자인 신품', 2, 1170000);
INSERT INTO cart VALUES(10003, 'user02', 'AHlbAAAAve1WwgAC.jpg', '보드세트', '한시즌 밖에 안썼습니다. 눈물을 머금고 내놓음 ㅠ.ㅠ', 5, 200000);
INSERT INTO cart VALUES(10004, 'user02', 'AHlbAAAAve37LwAD.jpg', '인라인', '좋아욥', 2, 20000);



commit;


