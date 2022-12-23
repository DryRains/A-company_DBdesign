CREATE TABLE department(
dept_id VARCHAR2(5) NOT NULL,
dept_name VARCHAR2(10) NOT NULL,
phone_number VARCHAR2(25),
fax_number VARCHAR2(20),
location VARCHAR2(5),
CONSTRAINT department_pk PRIMARY KEY (dept_id));

CREATE TABLE employee(
emp_id VARCHAR2(5) NOT NULL,
emp_name VARCHAR2(10) NOT NULL,
si VARCHAR2(10),
dong VARCHAR2(10),
ho VARCHAR2(10),
phone_number VARCHAR2(25),
salary number(8,0),
dept_id VARCHAR2(5),
tutor_id VARCHAR2(5),
CONSTRAINT employee_pk PRIMARY KEY (emp_id),
CONSTRAINT employee_fk1 FOREIGN KEY (dept_id) REFERENCES department(dept_id),
CONSTRAINT employee_fk2 FOREIGN KEY (tutor_id) REFERENCES employee(emp_id));

CREATE TABLE lecture(
lecture_id VARCHAR2(5) NOT NULL,
lecture_name VARCHAR2(30),
tutor_name VARCHAR2(10),
lecture_time VARCHAR2(15),
place VARCHAR2(10),
CONSTRAINT lecture_pk PRIMARY KEY (lecture_id));

CREATE TABLE lecture_taken(
emp_id VARCHAR2(5) NOT NULL,
lecture_id VARCHAR2(5) NOT NULL,
lecture_taken_date DATE,
grade varchar(2),
CONSTRAINT lecture_taken_pk PRIMARY KEY (emp_id, lecture_id),
CONSTRAINT lecture_taken_fk1 FOREIGN KEY (emp_id) REFERENCES employee (emp_id),
CONSTRAINT lecture_taken_fk2 FOREIGN KEY (lecture_id) REFERENCES lecture (lecture_id));

CREATE TABLE blender(
blender_id VARCHAR2(5) NOT NULL,
blender_name VARCHAR2(10) NOT NULL,
age NUMBER(5),
si VARCHAR2(20),
dong VARCHAR2(20),
ho VARCHAR2(20),
Phonenumber VARCHAR2(25),
gender VARCHAR2(10),
emp_id VARCHAR2(5),
CONSTRAINT blender_pk PRIMARY KEY (blender_id),
CONSTRAINT blender_fk FOREIGN KEY (emp_id) REFERENCES employee(emp_id));
CREATE TABLE blendingtea(
tea_id VARCHAR2(5) NOT NULL,
tea_name VARCHAR2 (30) NOT NULL,
stock NUMBER(6,0),
price NUMBER (6,0),
blender_id VARCHAR2 (5) NOT NULL,
royalty NUMBER (6,0),
CONSTRAINT blendingtea_pk PRIMARY KEY (tea_id),
CONSTRAINT blendingtear_fk FOREIGN KEY (blender_id) REFERENCES blender (blender_id));

CREATE TABLE material(
material_id VARCHAR2(5) NOT NULL,
material_name VARCHAR2(10) NOT NULL,
stock NUMBER(6,0),
price NUMBER(6,0),
CONSTRAINT material_pk PRIMARY KEY (material_id));

CREATE TABLE blendingtea_manufactured(
tea_id VARCHAR2(5) NOT NULL,
material_id VARCHAR2(5) NOT NULL,
amount NUMBER(6,0),
CONSTRAINT blendingtea_manufactured_pk PRIMARY KEY (tea_id, material_id),
CONSTRAINT blendgintea_manufactured_fk1 FOREIGN KEY (tea_id) REFERENCES blendingtea (tea_id),
CONSTRAINT blendgintea_manufactured_fk2 FOREIGN KEY (material_id) REFERENCES material (material_id));

CREATE TABLE supplier(
supplier_id VARCHAR2(5) NOT NULL,
supplier_name VARCHAR2(10) NOT NULL,
si VARCHAR2(10),
dong VARCHAR2(10),
ho VARCHAR2(10),
phonenumber VARCHAR2(25) NOT NULL,
CONSTRAINT supplier_pk PRIMARY KEY (supplier_id));

CREATE TABLE material_supplied(
material_id VARCHAR2(5) NOT NULL,
supplier_id VARCHAR2(5) NOT NULL,
quantity number(5) NOT NULL,
material_supplied_date DATE NOT NULL,
CONSTRAINT material_supplied_pk PRIMARY KEY (supplier_id,material_id),
CONSTRAINT material_supplied_fk1 FOREIGN KEY (material_id) REFERENCES material(material_id),
CONSTRAINT material_supplied_fk2 FOREIGN KEY (supplier_id) REFERENCES Supplier(supplier_id));

CREATE TABLE customer
(customer_id VARCHAR2(10) NOT NULL,
customer_name VARCHAR2(10) NOT NULL,
si VARCHAR2(20),
dong VARCHAR2(20),
ho VARCHAR2(20),
login_id VARCHAR2(20),
login_pw VARCHAR2(20) NOT NULL,
gender VARCHAR2(4),
birthdate DATE,
CONSTRAINT customer_pk PRIMARY KEY (customer_id));
CREATE TABLE customer_phonenumber(
customer_id VARCHAR2(10) NOT NULL,
phonenumber VARCHAR2(25) NOT NULL,
CONSTRAINT customer_phonenumber_pk PRIMARY KEY (customer_id,phonenumber),
CONSTRAINT customer_phoneenumber_fk FOREIGN KEY (customer_id) REFERENCES customer (customer_id));

CREATE TABLE regular(
customer_id VARCHAR2(10) NOT NULL,
point NUMBER(6,0),
CONSTRAINT regular_pk PRIMARY KEY(customer_id),
CONSTRAINT regular_fk FOREIGN KEY(customer_id) REFERENCES customer(customer_id));

CREATE TABLE rate_plan(
plan_id VARCHAR2(10) NOT NULL,
plan_name VARCHAR2(10) NOT NULL,
price NUMBER(6,0),
provided_amount NUMBER(4,0),
CONSTRAINT rate_plan_pk PRIMARY KEY (plan_id));

CREATE TABLE subscriber(
customer_id VARCHAR2(10) NOT NULL,
creditcard_number VARCHAR2(20),
creditcard_cvc VARCHAR2(3),
subscribe_date DATE,
plan_id VARCHAR2(10) NOT NULL,
CONSTRAINT subscriber_pk PRIMARY KEY (customer_id),
CONSTRAINT subscriber_fk1 FOREIGN KEY (customer_id) REFERENCES customer(customer_id),
CONSTRAINT subscriber_fk2 FOREIGN KEY (plan_id) REFERENCES rate_plan(plan_id));

CREATE TABLE ordertable(
order_id VARCHAR2(5) NOT NULL, 
order_date DATE NOT NULL, 
customer_id VARCHAR2(10) NOT NULL,
CONSTRAINT order_pk PRIMARY KEY (order_id),
CONSTRAINT order_fk FOREIGN KEY (customer_id) REFERENCES customer(customer_id));

CREATE TABLE blendingtea_ordered(
tea_id VARCHAR2(5) NOT NULL, 
order_id VARCHAR2(5) NOT NULL, 
quantity NUMBER(5) NOT NULL,
CONSTRAINT blendingtea_ordered_pk PRIMARY KEY (tea_id, order_id),
CONSTRAINT blendingtea_ordered_fk1 FOREIGN KEY (tea_id) REFERENCES blendingtea(tea_id),
CONSTRAINT blendingtea_ordered_fk2 FOREIGN KEY (order_id) REFERENCES ordertable(order_id));



CREATE INDEX blendingtea_price_index on blendingtea(price);
CREATE INDEX ordered_quantity_index on blendingtea_ordered(quantity);
/*Useful SQL을 사용할 때 두 애트리뷰트가 조인되어 활용이 자주 된다(총 주문금액 조회, 재고 갱신 작업 등에 활용). 따라서 7팀은 조인에 자주 사용되는 두 애트리뷰트에 인덱스를 걸어주기로 결정하였다.*/


INSERT INTO department VALUES ('D0001','경영기획','02 340 9072','924 5013 8072','5-1');
INSERT INTO department VALUES ('D0002','인사','02 589 2249','435 7892 3798','3-1');
INSERT INTO department VALUES ('D0003','재무','02 900 5238','243 8902 3324','2-3');
INSERT INTO department VALUES ('D0004','물류','02 584 3882','348 0932 4489','5-3');
INSERT INTO department VALUES ('D0005','차연구','02 435 3957','854 3934 5890','3-2');
INSERT INTO department VALUES ('D0006','마케팅','02 934 4958','423 0894 3089','4-1');
INSERT INTO department VALUES ('D0007','해외','02 398 8843','456 8904 5689','6-1');
INSERT INTO department VALUES ('D0008','포장개발','02 823 9398','909 0234 5494','6-3');
INSERT INTO department VALUES ('D0009','생산관리','02 920 3294','435 2348 1293','4-2');
INSERT INTO department VALUES ('D0010','생산','02 572 3383','985 439 2343','4-3');
INSERT INTO department VALUES ('D0011','설비','02 923 4849','912 9430 0329','2-2');
INSERT INTO department VALUES ('D0012','품질보증','02 570 9130','812 3482 3589','3-3');
INSERT INTO department VALUES ('D0013','환경과안전','02 859 3291','853 8895 3901','6-2');
INSERT INTO department VALUES ('D0014','영업','02 325 2398','325 3258 5489','5-2');
INSERT INTO department VALUES ('D0015','홍보','02 932 0923','943 0543 5599','2-1');

INSERT INTO employee VALUES ('E0001','김철수','Seoul','Chang','1804','+82 010 4032 0996',5000000,'D0001',null);
INSERT INTO employee VALUES ('E0014','김윤환','Seoul','Guro','1103','+82 010 8900 3214',5790000,'D0015',null);
INSERT INTO employee VALUES ('E0015','김준수','Seoul','Samsung','904','+82 010 2131 5885',6240000,'D0014',null);
INSERT INTO employee VALUES ('E0009','김진우','Seoul','Gangnam','1004','+82 010 9329 8142',5530000,'D0007',null);
INSERT INTO employee VALUES ('E0002','김영희','Seoul','Suyu','301','+82 010 3944 1012',4850000,'D0004','E0015');
INSERT INTO employee VALUES ('E0003','손흥민','Siheung','Daeya','803','+82 010 2347 4237',4970000,'D0009','E0009');
INSERT INTO employee VALUES ('E0004','이상혁','Seoul','SSangmun','1302','+82 010 9842 3248',3920000,'D0011','E0001');
INSERT INTO employee VALUES ('E0005','김혁규','Seoul','Mia','504','+82 010 8493 9299',4250000,'D0004','E0014');
INSERT INTO employee VALUES ('E0006','한성욱','Goyang','Haengsin','903','+82 010 0148 4832',4580000,'D0001','E0015');
INSERT INTO employee VALUES ('E0007','이병건','Seoul','Hyehwa','501','+82 010 9129 4332',5230000,'D0005','E0015');
INSERT INTO employee VALUES ('E0008','김재현','Seoul','Nowon','1102','+82 010 2100 4323',3510000,'D0008','E0014');
INSERT INTO employee VALUES ('E0010','박준석','Ansan','Sangrok1','602','+82 010 2391 3929',3290000,'D0012','E0009');
INSERT INTO employee VALUES ('E0011','한가인','Seoul','Banpo','1403','+82 010 4359 0124',3870000,'D0009','E0014');
INSERT INTO employee VALUES ('E0012','이효리','Seoul','Seocho','702','+82 010 8432 9014',3910000,'D0012','E0009');
INSERT INTO employee VALUES ('E0013','임경모','Suwon','Pajang','1202','+82 010 5323 5901',5120000,'D0013','E0009');

INSERT INTO lecture VALUES ('L0001','이슬람의 등장과 타 종교','최재천','THU09001030','7-1');
INSERT INTO lecture VALUES ('L0002','아랍어 기초 회화 I','김중기','WED09001030','7-3');
INSERT INTO lecture VALUES ('L0003','아랍어 기초 회화 II','김중기','WED10451200','7-3');
INSERT INTO lecture VALUES ('L0004','아랍 외교 연구 개관(1)','오영택','FRI13001430','7-2');
INSERT INTO lecture VALUES ('L0005','아랍 외교 연구 개관(2)','오영택','FRI14451600','7-2');
INSERT INTO lecture VALUES ('L0006','중동 평화 협상과정과 전망','이승기','TUE09001030','7-1');
INSERT INTO lecture VALUES ('L0007','아랍 문화권의 식생활','최재천','MON16001730','7-2');
INSERT INTO lecture VALUES ('L0008','중동의 차 역사','최재천','MON14301545','7-3');
INSERT INTO lecture VALUES ('L0009','세계 차 문화 기행 I','김기열','THU13001430','7-2');
INSERT INTO lecture VALUES ('L0010','원재료의 배합에 따른 차의 맛','강호동','MON09001015','7-3');
INSERT INTO lecture VALUES ('L0011','이슬람의 등장과 타 종교','최재천','MON10301045','7-3');
INSERT INTO lecture VALUES ('L0012','아랍 차와 음료','최재천','TUE10451200','7-1');
INSERT INTO lecture VALUES ('L0013','세계 차 문화 기행 II','김기열','THU14451600','7-2');
INSERT INTO lecture VALUES ('L0014','아랍 지역별 문화 특징 I','김영태','WED15001615','7-1');
INSERT INTO lecture VALUES ('L0015','아랍 지역별 문화 특징 II','김영태','THU16301745','7-1');

INSERT INTO lecture_taken VALUES ('E0001','L0002','2021-09-08','A');
INSERT INTO lecture_taken VALUES ('E0002','L0006','2021-09-18','B');
INSERT INTO lecture_taken VALUES ('E0002','L0004','2021-10-21','A');
INSERT INTO lecture_taken VALUES ('E0002','L0003','2021-10-15','A');
INSERT INTO lecture_taken VALUES ('E0003','L0007','2021-11-03','C');
INSERT INTO lecture_taken VALUES ('E0005','L0001','2021-11-12','A');
INSERT INTO lecture_taken VALUES ('E0006','L0011','2021-12-01','A');
INSERT INTO lecture_taken VALUES ('E0006','L0012','2021-12-05','B');
INSERT INTO lecture_taken VALUES ('E0008','L0015','2022-01-03','B');
INSERT INTO lecture_taken VALUES ('E0012','L0014','2022-01-24','A');
INSERT INTO lecture_taken VALUES ('E0013','L0007','2022-01-25','B');
INSERT INTO lecture_taken VALUES ('E0014','L0008','2022-02-06','B');
INSERT INTO lecture_taken VALUES ('E0015','L0009','2022-02-18','A');

INSERT INTO blender VALUES ('B0001', 'Donald ',23, 'yongin','jukjeon','101','010-1234-1235','male','E0001');
INSERT INTO blender VALUES ('B0002', 'Author',43,'goyang','jungsan', '102','010-1234-1236','male','E0002');
INSERT INTO blender VALUES ('B0003','Bobby',45,'seongnam', 'jeongja','103','010-1234-1237','male','E0003');
INSERT INTO blender VALUES ('B0004', 'Harry',42,'yongin','giheong','104','010-1234-1238','male','E0004');
INSERT INTO blender VALUES ('B0005', 'Lenorld',29,'goyang','jungsan','105','010-1234-1239','female','E0005');
INSERT INTO blender VALUES ('B0006', 'Peter',53, 'seongnam', 'seohyeon','106','010-1234-1240','male','E0006');
INSERT INTO blender VALUES ('B0007', 'Roy',35, 'yongin','jukjeon','107','010-1234-1241','male','E0007');
INSERT INTO blender VALUES ('B0008', 'Raymond',34, 'suwon', 'mangpo','108','010-1234-1242','male','E0008');
INSERT INTO blender VALUES ('B0009', 'Frank',23, 'ansan', 'singil','110','010-1234-1244','male','E0010');
INSERT INTO blender VALUES ('B0010', 'Fred',52, 'ansan', 'singil', '111', '010-1234-1245','male','E0011');
INSERT INTO blender VALUES ('B0011', 'Dennis',35, 'anyang','guanyang','112','010-1234-1246','female','E0012');
INSERT INTO blender VALUES ('B0012', 'Charlie',67, 'anyang','guanyang','113','010-1234-1247','female','E0013');
INSERT INTO blender VALUES ('B0013', 'Rose',49, 'seongnam','jeongja','114','010-1234-1248','female','E0014');
INSERT INTO blender VALUES ('B0014', 'Sally',29, 'pengtaek','dongsak','115','010-1234-1249','female','E0014');
INSERT INTO blender VALUES ('B0015', 'Nicole',46, 'anyang','guanyang','116','010-1234-1250','female','E0015');

INSERT INTO blendingTea VALUES ('T0001', 'Citron Green Tea', 100, 8000, 'B0001', 10000);
INSERT INTO blendingTea VALUES ('T0002', 'Earl Grey Crema Tea', 200, 10000, 'B0002', 10000);
INSERT INTO blendingTea VALUES ('T0003', 'Strawberry Black Tea', 300, 12000, 'B0003', 9000);
INSERT INTO blendingTea VALUES ('T0004', 'Irish Breakfast Tea', 100, 9000, 'B0004', 12000);
INSERT INTO blendingTea VALUES ('T0005', 'Shanghai Breakfast Tea', 200, 10000, 'B0005', 9000);
INSERT INTO blendingTea VALUES ('T0006', 'Russian Caravan Tea', 100, 8000, 'B0006', 8000);
INSERT INTO blendingTea VALUES ('T0007', 'Afternoon Tea',400, 12000, 'B0007',10000);
INSERT INTO blendingTea VALUES ('T0008', 'Orange Pekoe Tea', 500, 15000, 'B0008', 12000);
INSERT INTO blendingTea VALUES ('T0009', 'Old Black Magic Tea', 300, 9000, 'B0009', 13000);
INSERT INTO blendingTea VALUES ('T0010', 'Rich Mango Tea', 100, 8000, 'B0010', 10000);
INSERT INTO blendingTea VALUES ('T0011', 'Samda Tangerine Tea', 400, 15000, 'B0011', 12000);
INSERT INTO blendingTea VALUES ('T0012', 'Sweet Caramel Tea', 500, 8000,'B0012', 10000);
INSERT INTO blendingTea VALUES ('T0013', 'Lady Straberry Tea', 200,9000, 'B0013', 13000);
INSERT INTO blendingTea VALUES ('T0014', 'Pure Black Tea', 200, 10000, 'B0014',14000);
INSERT INTO blendingTea VALUES ('T0015', 'Apple Cinnamon Tea ', 300, 13000, 'B0015', 9000);

INSERT INTO material VALUES ('M0001', 'Sugar', null,null);
INSERT INTO material VALUES ('M0002', 'Tea Bag', 957000,100);
INSERT INTO material VALUES ('M0003', 'Oolong Tea', 63436,300);
INSERT INTO material VALUES ('M0004', 'Green Tea', 23425,250);
INSERT INTO material VALUES ('M0005', 'White Tea', 74574,400);
INSERT INTO material VALUES ('M0006', 'Assam', 83564,200);
INSERT INTO material VALUES ('M0007', 'Earl Grey', 11536,250);
INSERT INTO material VALUES ('M0008', 'Lavender', 37556,300);
INSERT INTO material VALUES ('M0009', 'Jasmine', 215230,200);
INSERT INTO material VALUES ('M0010', 'Applemint', 94575,250);
INSERT INTO material VALUES ('M0011', 'Spearmint', 80456,300);
INSERT INTO material VALUES ('M0012', 'Peppermint', 74624,200);
INSERT INTO material VALUES ('M0013', 'Hibiscus', 163640,250);
INSERT INTO material VALUES ('M0014', 'Cinnamon', 48453,150);
INSERT INTO material VALUES ('M0015', 'Apple', 45256,1000);


INSERT INTO blendingtea_manufactured VALUES ('T0001', 'M0001', 2000); 
INSERT INTO blendingtea_manufactured VALUES ('T0002', 'M0004', 3000);
INSERT INTO blendingtea_manufactured VALUES ('T0003', 'M0006', 4000);
INSERT INTO blendingtea_manufactured VALUES ('T0004', 'M0004', 4000);
INSERT INTO blendingtea_manufactured VALUES ('T0005', 'M0013', 6000);
INSERT INTO blendingtea_manufactured VALUES ('T0006', 'M0009', 4000);
INSERT INTO blendingtea_manufactured VALUES ('T0007', 'M0010', 5000);
INSERT INTO blendingtea_manufactured VALUES ('T0008', 'M0003', 6000);
INSERT INTO blendingtea_manufactured VALUES ('T0009', 'M0015', 2000); 
INSERT INTO blendingtea_manufactured VALUES ('T0010', 'M0009', 1000);
INSERT INTO blendingtea_manufactured VALUES ('T0011', 'M0014', 1200);
INSERT INTO blendingtea_manufactured VALUES ('T0012', 'M0003', 3000);
INSERT INTO blendingtea_manufactured VALUES ('T0013', 'M0007', 5000);
INSERT INTO blendingtea_manufactured VALUES ('T0014', 'M0001', 6000);
INSERT INTO blendingtea_manufactured VALUES ('T0015', 'M0005', 4000);

INSERT INTO supplier VALUES ('S0001', 'Acompany', null,null,null,'010-2134-3457');
INSERT INTO supplier VALUES ('S0002', 'Bcompany', '서울','도곡동','142','010-2234-4578');
INSERT INTO supplier VALUES ('S0003', 'Ccompany', '부천','송내동','304','010-2134-3457');
INSERT INTO supplier VALUES ('S0004', 'Dcompany', null,null,null,'010-3154-3487');
INSERT INTO supplier VALUES ('S0005', 'Ecompany', '고양','백석1동','호수로 606','010-2134-3457');
INSERT INTO supplier VALUES ('S0006', 'Fcompany', null,null,null,'010-4565-8967');
INSERT INTO supplier VALUES ('S0007', 'Gcompany', null,null,null,'010-4567-1234');
INSERT INTO supplier VALUES ('S0008', 'Hcompany', '서울','가락동','524','010-6784-7435');
INSERT INTO supplier VALUES ('S0009', 'Icompany', null,null,null,'010-3546-1423');
INSERT INTO supplier VALUES ('S0010', 'Jcompany', '울산','상안동','294','010-5876-0897');
INSERT INTO supplier VALUES ('S0011', 'Kcompany', null,null,null,'010-2243-7756');
INSERT INTO supplier VALUES ('S0012', 'Lcompany', '부산','우동','324','010-8856-7742');
INSERT INTO supplier VALUES ('S0013', 'Mcompany', null,null,null,'010-1163-8856');
INSERT INTO supplier VALUES ('S0014', 'Ncompany', '광주','내방동','2','010-3375-9674');
INSERT INTO supplier VALUES ('S0015', 'Ocompany', '세종','용호동','13','010-2645-5436');

INSERT INTO material_supplied VALUES ('M0015','S0013',2457,'2022-9-2');
INSERT INTO material_supplied VALUES ('M0005','S0012',34534,'2022-9-6');
INSERT INTO material_supplied VALUES ('M0013','S0001',252,'2022-9-9');
INSERT INTO material_supplied VALUES ('M0002','S0009',52343,'2022-9-15');
INSERT INTO material_supplied VALUES ('M0001','S0015',34545,'2022-9-23');
INSERT INTO material_supplied VALUES ('M0006','S0012',5745,'2022-9-27');
INSERT INTO material_supplied VALUES ('M0011','S0009',23423,'2022-10-3');
INSERT INTO material_supplied VALUES ('M0012','S0012',36867,'2022-10-5');
INSERT INTO material_supplied VALUES ('M0007','S0001',3124,'2022-10-13');
INSERT INTO material_supplied VALUES ('M0002','S0015',3457,'2022-10-27');
INSERT INTO material_supplied VALUES ('M0014','S0013',2343,'2022-11-12');
INSERT INTO material_supplied VALUES ('M0008','S0012',346,'2022-11-27');
INSERT INTO material_supplied VALUES ('M0013','S0010',7545,'2022-12-2');
INSERT INTO material_supplied VALUES ('M0011','S0012',346,'2022-12-13');
INSERT INTO material_supplied VALUES ('M0005','S0015',486,'2022-12-25');

INSERT INTO customer VALUES ('C0001','김건우','서울','남가좌동','201호','rjsdn2009','to9412','남','1998-01-19');
INSERT INTO customer VALUES ('C0002','조다인','의정부','호원동','301호','jdi34','di9898','여','1998-11-12');
INSERT INTO customer VALUES ('C0003','박철수','부산','원래동','401호','dkd133','oksj1354','남','1977-02-15');
INSERT INTO customer VALUES ('C0004','박미자','서울','삼성동','2212호','mija2000','11345','여','1970-04-20');
INSERT INTO customer VALUES ('C0005','제주완','서울','홍은동','305호','jjw98','jwpower','남','1998-12-22');
INSERT INTO customer VALUES ('C0006','김형근','수원','천호동','401호','kimhg10','hg123','남','1998-05-25');
INSERT INTO customer VALUES ('C0007','이석희','인천','포제동','303호', 'seokhee86','1234','남','1986-04-19');
INSERT INTO customer VALUES ('C0008','마석도','울산','강인동','401호', 'stoneman','1355','남','1990-10-13');
INSERT INTO customer VALUES ('C0009','최내화','춘천','명동','1001호','naehwa2','cnh975','여','1985-02-12');
INSERT INTO customer VALUES ('C0010','김마리','대구','동구동','1204호','marikim971','9999','여','1995-01-11');
INSERT INTO customer VALUES ('C0011','한명희','서귀포','하외동','601호','myeonghi94','3434','남','1994-12-25');
INSERT INTO customer VALUES ('C0012','김소영','의정부','금오동','2101호','sy8787','sykimmm','여','1998-01-10');
INSERT INTO customer VALUES ('C0013','전태웅','세종','행군동','1301호','jtw2244','19345','남','1998-06-15');
INSERT INTO customer VALUES ('C0014','신진하','포천','은영동','1401호','jinha392','jh944','남','1967-02-15');
INSERT INTO customer VALUES ('C0015','이수민','대전','은행동','2202호','leewater1','lsm1999','여','1999-12-01');
INSERT INTO customer VALUES ('C0016','최하은','남양주','장현동','401호',null,'135532','여','1998-06-14');
INSERT INTO customer VALUES ('C0017','조민규','별내','이화동','1601호',null,'jmk933','남','1979-04-04');
INSERT INTO customer VALUES ('C0018','윤혜주','서울','녹양동','1401호',null,'3324','여','1989-07-20');
INSERT INTO customer VALUES ('C0019','손관성','전주','한양동','2203호',null,'gwanmandd','남','1979-09-08');
INSERT INTO customer VALUES ('C0020','김민지','수원','영세동','3201호',null,'thyvic05','여','2005-10-14');

INSERT INTO customer_phonenumber VALUES ('C0001','+82 010-3838-9394');
INSERT INTO customer_phonenumber VALUES ('C0001','+82 070-8814-9412');
INSERT INTO customer_phonenumber VALUES ('C0002','+82 010-4348-6455');
INSERT INTO customer_phonenumber VALUES ('C0003','+82 010-2248-5343');
INSERT INTO customer_phonenumber VALUES ('C0004','+82 010-0893-3922');
INSERT INTO customer_phonenumber VALUES ('C0005','+82 010-4243-9484');
INSERT INTO customer_phonenumber VALUES ('C0005','+82 010-3939-1327');
INSERT INTO customer_phonenumber VALUES ('C0006','+82 010-7464-7785');
INSERT INTO customer_phonenumber VALUES ('C0007','+82 010-8443-3432');
INSERT INTO customer_phonenumber VALUES ('C0008','+82 010-5443-3324');
INSERT INTO customer_phonenumber VALUES ('C0009','+82 010-3234-6654');
INSERT INTO customer_phonenumber VALUES ('C0010','+82 010-5593-2423');
INSERT INTO customer_phonenumber VALUES ('C0011','+82 010-6448-5858');
INSERT INTO customer_phonenumber VALUES ('C0012','+82 010-1144-4575');
INSERT INTO customer_phonenumber VALUES ('C0013','+82 010-2538-4944');
INSERT INTO customer_phonenumber VALUES ('C0014','+82 010-3211-2993');
INSERT INTO customer_phonenumber VALUES ('C0015','+82 010-1313-3945');
INSERT INTO customer_phonenumber VALUES ('C0015','+82 070-7044-9073');
INSERT INTO customer_phonenumber VALUES ('C0016','+82 010-2947-4040');
INSERT INTO customer_phonenumber VALUES ('C0017','+82 010-5578-2342');
INSERT INTO customer_phonenumber VALUES ('C0018','+82 010-9932-0087');
INSERT INTO customer_phonenumber VALUES ('C0019','+82 010-3543-1155');
INSERT INTO customer_phonenumber VALUES ('C0020','+82 010-6947-3554');
INSERT INTO customer_phonenumber VALUES ('C0020','+82 011-1245-9404');

INSERT INTO rate_plan VALUES ('P0001','Basic',13900,30);
INSERT INTO rate_plan VALUES ('P0002','Medium',19900,50);
INSERT INTO rate_plan VALUES ('P0003','Premium',24900,80);
INSERT INTO rate_plan VALUES ('P0004','Luxury',29900,100);

INSERT INTO regular VALUES ('C0001',320);
INSERT INTO regular VALUES ('C0002',1954);
INSERT INTO regular VALUES ('C0003',14562);
INSERT INTO regular VALUES ('C0004',1030);
INSERT INTO regular VALUES ('C0005',7460);
INSERT INTO regular VALUES ('C0006',4030);
INSERT INTO regular VALUES ('C0007',0);
INSERT INTO regular VALUES ('C0008',100);
INSERT INTO regular VALUES ('C0009',220);
INSERT INTO regular VALUES ('C0010',10);

INSERT INTO subscriber VALUES ('C0011','9394 9342 4432 1234','258','2022-11-30','P0001');
INSERT INTO subscriber VALUES ('C0012','5324 4242 7367 1434','211','2022-11-20','P0001');
INSERT INTO subscriber VALUES ('C0013','8772 1266 6345 9887','169','2022-11-21','P0002');
INSERT INTO subscriber VALUES ('C0014','7752 9375 3937 8234','141','2022-12-01','P0003');
INSERT INTO subscriber VALUES ('C0015','2576 3423 5422 9134','343','2022-12-15','P0004');

INSERT INTO ordertable VALUES ('O0001','2022-10-30','C0001');
INSERT INTO ordertable VALUES ('O0002','2022-10-24','C0002');
INSERT INTO ordertable VALUES ('O0003','2022-10-21','C0003');
INSERT INTO ordertable VALUES ('O0004','2022-12-20','C0004');
INSERT INTO ordertable VALUES ('O0005','2022-12-19','C0005');
INSERT INTO ordertable VALUES ('O0006','2022-10-13','C0006');
INSERT INTO ordertable VALUES ('O0007','2022-9-2','C0007');
INSERT INTO ordertable VALUES ('O0008','2022-9-15','C0008');
INSERT INTO ordertable VALUES ('O0009','2022-10-3','C0009');
INSERT INTO ordertable VALUES ('O0010','2022-11-12','C0010');
INSERT INTO ordertable VALUES ('O0011','2022-11-27','C0011');
INSERT INTO ordertable VALUES ('O0012','2022-12-2','C0012');
INSERT INTO ordertable VALUES ('O0013','2022-12-13','C0013');
INSERT INTO ordertable VALUES ('O0014','2022-12-25','C0014');
INSERT INTO ordertable VALUES ('O0015','2022-10-27','C0015');
INSERT INTO ordertable VALUES ('O0016','2022-11-02','C0001');
INSERT INTO ordertable VALUES ('O0017','2022-11-21','C0001');
INSERT INTO ordertable VALUES ('O0018','2022-12-02','C0001');

INSERT INTO blendingtea_ordered VALUES ('T0001','O0001',20);
INSERT INTO blendingtea_ordered VALUES ('T0002','O0003',50);
INSERT INTO blendingtea_ordered VALUES ('T0005','O0004',70);
INSERT INTO blendingtea_ordered VALUES ('T0006','O0006',80);
INSERT INTO blendingtea_ordered VALUES ('T0010','O0009',150);
INSERT INTO blendingtea_ordered VALUES ('T0015','O0002',110);
INSERT INTO blendingtea_ordered VALUES ('T0003','O0007',35);
INSERT INTO blendingtea_ordered VALUES ('T0004','O0010',60);
INSERT INTO blendingtea_ordered VALUES ('T0011','O0008',15);
INSERT INTO blendingtea_ordered VALUES ('T0007','O0011',20);
INSERT INTO blendingtea_ordered VALUES ('T0008','O0013',30);
INSERT INTO blendingtea_ordered VALUES ('T0009','O0014',66);
INSERT INTO blendingtea_ordered VALUES ('T0013','O0005',77);
INSERT INTO blendingtea_ordered VALUES ('T0014','O0012',88);
INSERT INTO blendingtea_ordered VALUES ('T0012','O0015',30);
INSERT INTO blendingtea_ordered VALUES ('T0015','O0016',130);
INSERT INTO blendingtea_ordered VALUES ('T0012','O0017',200);
INSERT INTO blendingtea_ordered VALUES ('T0013','O0018',100);
