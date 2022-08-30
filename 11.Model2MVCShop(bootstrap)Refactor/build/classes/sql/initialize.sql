

set pagesize 4000;
set linesize 4000;


DROP TABLE users;
DROP TABLE Cart;
DROP TABLE transaction;
DROP TABLE product;
DROP TABLE upload_file;


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



INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) VALUES ( 'admin', 'admin', '1234', 'admin', NULL, NULL, '����� ���ʱ�', 'admin@mvc.com',to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS')); 
INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) VALUES ( 'manager', 'manager', '1234', 'admin', NULL, NULL, NULL, 'manager@mvc.com', to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));     
INSERT INTO users ( user_id, user_name, password, role, ssn, cell_phone, addr, email, reg_date ) VALUES ( 'non-member', 'non-member', 'non-member', 'non', NULL, NULL, NULL, 'manager@mvc.com', to_date('2012/01/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'));        
INSERT INTO users VALUES ( 'user01', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user02', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user03', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user04', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user05', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user06', 'SCOTT', '6666', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user07', 'SCOTT', '7777', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user08', 'SCOTT', '8888', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user09', 'SCOTT', '9999', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user10', 'SCOTT', '1010', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user11', 'SCOTT', '1111', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user12', 'SCOTT', '1212', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user13', 'SCOTT', '1313', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user14', 'SCOTT', '1414', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user15', 'SCOTT', '1515', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user16', 'SCOTT', '1616', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user17', 'SCOTT', '1717', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user18', 'SCOTT', '1818', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user19', 'SCOTT', '1919', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user20', 'SCOTT', '2020', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users VALUES ( 'user21', 'SCOTT', '2121', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user22', 'SCOTT', '2222', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user23', 'SCOTT', '2323', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user24', 'SCOTT', '2424', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user25', 'SCOTT', '2525', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user26', 'SCOTT', '2626', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user27', 'SCOTT', '2727', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user28', 'SCOTT', '2828', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user29', 'SCOTT', '2929', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user30', 'SCOTT', '3030', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user31', 'SCOTT', '3131', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user32', 'SCOTT', '3232', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user33', 'SCOTT', '3333', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user34', 'SCOTT', '3434', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user35', 'SCOTT', '3535', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user36', 'SCOTT', '3636', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user37', 'SCOTT', '3737', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user38', 'SCOTT', '3838', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user39', 'SCOTT', '3939', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user40', 'SCOTT', '4040', 'user', NULL, NULL, NULL, NULL, sysdate);

INSERT INTO users VALUES ( 'user41', 'SCOTT', '4141', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user42', 'SCOTT', '4242', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user43', 'SCOTT', '4343', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user44', 'SCOTT', '4444', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user45', 'SCOTT', '4545', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user46', 'SCOTT', '4646', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user47', 'SCOTT', '4747', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user48', 'SCOTT', '4848', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user49', 'SCOTT', '4949', 'user', NULL, NULL, NULL, NULL, sysdate); 
INSERT INTO users VALUES ( 'user50', 'SCOTT', '5050', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user51', 'SCOTT', '5151', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user52', 'SCOTT', '5252', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user53', 'SCOTT', '5353', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user54', 'SCOTT', '5454', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user55', 'SCOTT', '5555', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user56', 'SCOTT', '5656', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user57', 'SCOTT', '5757', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user58', 'SCOTT', '5858', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user59', 'SCOTT', '5959', 'user', NULL, NULL, NULL, NULL, sysdate);
INSERT INTO users VALUES ( 'user60', 'SCOTT', '6060', 'user', NULL, NULL, NULL, NULL, sysdate);


           
insert into product values (seq_product_prod_no.nextval,'vaio vgn FS70B','�Ҵ� ���̿� ��Ʈ�� �ŵ�ǰ','20120514',2000000, '20220818000001',to_date('2012/12/14 11:27:27', 'YYYY/MM/DD HH24:MI:SS'),10);
insert into product values (seq_product_prod_no.nextval,'������','������ ���ƿ�~','20120514',10000, '20220818000002',to_date('2012/11/14 10:48:43', 'YYYY/MM/DD HH24:MI:SS'),12);
insert into product values (seq_product_prod_no.nextval,'������','�ְ� ������ ��ǰ','20120201',1170000, '20220818000003',to_date('2012/10/14 10:49:39', 'YYYY/MM/DD HH24:MI:SS'),11);
insert into product values (seq_product_prod_no.nextval,'���弼Ʈ','�ѽ��� �ۿ� �Ƚ���ϴ�. ������ �ӱݰ� ������ ��.��','20120217', 200000, '20220818000004',to_date('2012/11/14 10:50:58', 'YYYY/MM/DD HH24:MI:SS'),2);
insert into product values (seq_product_prod_no.nextval,'�ζ���','���ƿ�','20120819', 20000, '20220818000005',to_date('2012/11/14 10:51:40', 'YYYY/MM/DD HH24:MI:SS'),8);
insert into product values (seq_product_prod_no.nextval,'�Ｚ���� 2G','sens �޸� 2Giga','20121121',800000, '20220818000006',to_date('2012/11/14 18:46:58', 'YYYY/MM/DD HH24:MI:SS'),5);
insert into product values (seq_product_prod_no.nextval,'����','������ ���㺸����','20121022',232300, '20220818000007',to_date('2012/11/15 17:39:01', 'YYYY/MM/DD HH24:MI:SS'),9);
insert into product values (seq_product_prod_no.nextval,'�Ｚ����','��Ʈ��','20120212',600000, '20220818000008',to_date('2012/11/12 13:04:31', 'YYYY/MM/DD HH24:MI:SS'),3);
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



INSERT INTO upload_file VALUES ('20220818000001', 1, 'flower.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000002', 1, '981633.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000003', 1, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000004', 1, '08a7ed5263cde1.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000005', 1, 'a12270722.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000006', 1, '62129057.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000007', 1, '8456ac3b755ea9d.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000008', 1, 'flower.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000009', 1, '981633.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000010', 1, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000011', 1, '08a7ed5263cde1.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000012', 1, 'a12270722.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000013', 1, '62129057.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000014', 1, '8456ac3b755ea9d.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000015', 1, 'flower.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000016', 1, '981633.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000017', 1, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000018', 1, '08a7ed5263cde1.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000019', 1, 'a12270722.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000020', 1, '62129057.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000021', 1, '8456ac3b755ea9d.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000022', 1, 'flower.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000023', 1, '981633.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000024', 3, 'pngtree-purple-flower-squid-illustration-image_1448683.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000024', 3, 'a12270722.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000024', 3, '8456ac3b755ea9d.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000025', 2, '08a7ed5263cde1.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');
INSERT INTO upload_file VALUES ('20220818000025', 2, '981633.jpg', 'C:\\Users\\bitcamp\\git\\09Model2-jQuery-Refactor\\09.Model2MVCShop(jQuery)Refactor\\src\\main\\webapp\\images\\uploadFiles\\');



INSERT INTO cart VALUES(10001, 'user02', 'AHlbAAAAvetFNwAA.jpg', '������', '������ ���ƿ�', 3, 10000);
INSERT INTO cart VALUES(10002, 'user02', 'AHlbAAAAvewfegAB.jpg', '������', '�ְ� ������ ��ǰ', 2, 1170000);
INSERT INTO cart VALUES(10003, 'user02', 'AHlbAAAAve1WwgAC.jpg', '���弼Ʈ', '�ѽ��� �ۿ� �Ƚ���ϴ�. ������ �ӱݰ� ������ ��.��', 5, 200000);
INSERT INTO cart VALUES(10004, 'user02', 'AHlbAAAAve37LwAD.jpg', '�ζ���', '���ƿ�', 2, 20000);



commit;


