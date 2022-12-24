### 1. 프로젝트 설명
전공 수업 'DB 설계 및 구현'에서 진행한 프로젝트로, 데이터베이스 시스템을 필요로 하는 실제 기업을 인터뷰하고 그들의 요구사항을 기반으로 데이터베이스를 
설계하고, 해당 데이터베이스를 활용한 몇가지의 SQL을 도출하는 것이 프로젝트 최종 목표이다.
<br></br>
### 2. 선정 기업
'A사(기업 관계자분의 요청으로 기업 이름은 익명 처리)'는 블렌딩 티를 판매하는 작은 규모의 스타트업 기업이다. 블렌딩 티란 기본적으로 존재하는 차 (e.g., 녹차,캐모마일)에 다른 차나 재료들을 섞어 탄생한 새로운 풍미의 차인데, 이 기업의 특이점은 블렌딩 티를 한국에 거주하고 있는 아랍인들이 만든다는 점이다. A사는 블렌딩 티의 원료가 되는 재료들을 공급업체로부터 구비하고, 이 재료를를 기반으로 아랍인 블렌더들이 제작한 블렌딩 티를 판매하며, 블렌더에게 인센티브나 로열티를 주는 식으로 비즈니스를 하고 있다. 아래는 A사가 우리 데이터베이스 설계 팀에게 요구하는 Business rules & Requirements이다.
<br></br>
### 3. User Requirements & Business Rules
1. 고객(Customer)의 유형은 비회원, 정회원(Regular), 구독회원(Subscriber)로 나뉜다. 비회원은 정회원이나 구독회원 모두에 속하지 않는 고객이며, 구독회원과 정회원은 당연히 겸할 수 있다. 모든 고객은 공통적으로 ID(unique identifier), Name, Address(시/동/호), PhoneNumber(여러개 연락처 기재 가능), Gender, Birth Date와 로그인시 필요한 Login ID, Login Password 정보를 저장한다. 
메모) 비회원일 경우에 이 Login ID, Login Password가 Null이나 휴대전화 번호 등으로 대체될 수 있다.
1-1. 정회원(Regular)의 경우 구매 등의 활동을 할때마다 쌓이게 될 마일리지(포인트)를 Point에 저장하게 된다. 비회원의 경우 정규회원이 아니니 이러한 혜택을 받을 수 없게 해야 하며, 구독자의 경우 불규칙적으로 구매금액에 비례하여 포인트를 받는 정회원과 달리 꾸준히 정액제로 결제하므로 구독 활동에 있어 이러한 포인트는 제공되지 않게 해달라는 것이 A사의 요구이다.(다만 구독회원일 지라도 일반회원으로서 별도 구매를 할 때에는 포인트가 적립된다.)
1-2. 구독회원(SubScriber)은 정기적인 결제가 필요하기 때문에 신용카드 번호(CreditCard Number)를 저장해야 한다. 각각의 구독회원은 하나의 구독제(Rate_Plan)를 선택하여 구독할수 있으며, 각각의 구독제는 여러 구독회원들에게 구독되어질 수 있다. Rate_Plan은 Plan_ID(Unique Identifier), 구독제의 이름인 Plan Name, 구독 가격인 Price, 매달 제공되는 차의 수량인 Provided Count 정보를 저장해야 한다. 구독을 한 회원만이 구독회원 데이터베이스에 저장이 되는 반면, 고객에 의해 구독되어 지지 않은 구독제더라도 나중에 누군가에 의해 구독이 될 수 있기에 데이터베이스에 저장되도록 해야한다.

2. A사는 각각의 고객에 의해 발생한 주문(Order) 정보를 저장하길 원한다. 주문에는 Order ID(Unique Identifier)와 언제 주문이 일어났는지에 대한 Order Date가 저장된다. 각각의 고객은 여러개의 주문을 할 수 있으며, 각각의 주문은 한명의 고객에 의해 일어난다. 고객에 의해 발생 된 주문만이 데이터베이스에 저장되어질수 있는 반면, 주문을 하지 않은 고객이라도 데이터베이스에 저장될 수 있다.
3. A사는 블렌딩 티(Blending Tea)에 대해 Tea ID, Name, Stock(재고수량), Price(가격)를 저장하길 원하며, 각각의 블렌딩 티는 여러 주문(Order)에 주문(orderred)되어질수 있고(각각의 주문은 여러 블렌딩 티를 주문(orderred)할수 있다는 말의 의미는 각각의 주문 데이터에는 여러 블렌딩 티를 담을 수 있다는 의미로 보는것이 이해가 쉽다.)
, 각각의 주문은 여러 블렌딩 티를 주문할수 있다. Blending Tea를 주문한 Order만이 데이터베이스에 저장되는 반면, 주문이 되어지지 않은 Blending Tea일지라도 데이터베이스에 저장되어질 수 있다. 또한 블렌딩 티가 주문 되어질때, 주문된 수량(Quantity)가 저장된다.

4. 블렌딩 티는 기본이 되어지는 차에 다른차나 재료들을 섞어 제작이 되어지는데, A사는 이러한 기본이 되어지는 차나 재료들을 Material에 저장하고 싶어한다. Material에는 블렌딩 티와 비슷하게 Material ID(Unique Identifier), Name, Stock, Price 정보가 저장된다. 각각의 블렌딩 티는 여러 Material을 이용하여 제작되어지고, 각각의 Material 또한 여러 Blending Tea의 제작에 쓰일 수 있다. 앞서 말했듯 Blending Tea는 기존에 존재하는 차에 다른 차나 재료들을 추가하여 만들어진 것이므로 반드시 Material 으로 제작되어야 하는 반면, 아직 Blending Tea의 제작에 쓰이지 않은 Material이라도 나중에 새로운 종류의 Blending Tea의 제작 등에 쓰일 수 있기 때문에 데이터베이스에 존재할 수 있어야 한다. 추가적으로, Material이 Blending Tea의 제작에 이용될때, 얼만큼의 양(Amount)이 들어갔는지 표시한다.
참고) A사는 Material에 대해 공급자가 제시하는 가격이 아닌 A사가 희망하는 가격에 맞춰주는 공급자들로부터 계약을 체결하여 Material을 공급받고 있다. 이는 우리 팀이 ERD 설계시 재료의 가격에 대한 데이터를 담고있는 Price애트리뷰트를 Material 릴레이션타입 쪽에 설정한 이유이다.
5. 각각의 Material은 공급업체(Supplier)에 의해 공급되는데, 공급업체는 Supply ID(Unique Identifier), Name, Address(시/동/호), PhoneNumber 의 정보를 가지고 있으며, 각각의 Supplier는 여러 Material을 공급할 수 있고, 각각의 Material 또한 여러 Supplier에 의해 공급될 수 있다.
아직 Supplier에 의해 공급된 적이 없는 Material도 데이터베이스에 존재할 수 있지만, Material을 한번이라도 공급한 적이 있는 Supplier만이 데이터베이스에 저장된다.
공급이 이뤄질때 날짜와 공급수량에 대한 정보가 기록된다.
메모) Supplier와 Material의 Realtionship Type에 기록된 Date는 후에 Relational Model로 변환할때 새로 생성될 릴레이션에 임의적으로 Primary key의 일부로 설정하여 Material ID + Supply ID + Date의 형식으로 기본키를 이루게 하여 각각의 공급에 대한 정보를 기록할수 있도록 활용할 계획이다.

6. Blending Tea는 Blender에 의해 만들어진다. Blender에는 Blender ID(Unique Identifier), Name, Address(시/동/호), PhoneNumber 를 저장한다. 
Blender 중에는 Blending Tea를 만들기 전에 A사와 계약을 하는 경우도 있기 때문에 아직 만든 Blending Tea가 없는 Blender도 저장될 수 있지만 Blending Tea의 경우 Blender가 만드는 것이기에 반드시 해당 티를 만든 Blender가 존재해야만 한다. 이 때, A사는 Blender에게 Blending Tea를 만들어서 팔 때 마다 Blender에게 일정량의 Royalty를 지급한다.
7. 각각의 Blender는 자신을 관리하는 Employee 1명을 배정받아 관리된다.
Employee에 대한 정보는 Employee ID(Unique Identifier), Name, Address(시/동/호), PhoneNumber 그리고 Salary가 필요하다.
Employee는 여러명의 Blender를 관리할 수 있다. 또한 A사에서는 사수 - 부사수간의 1대1 사내교육을 실시하고 있다. 보통 사수와 부사수의 경우 직위가 사원과 주임 정도일 확률이 높고, 사수나 부사수가 없는 고참 직원들이나, 교육이 딱히 필요 없는 부서에 소속된 직원 등은 이 사내교육에 참여하지 않을 수 있다는 비즈니스 룰을 데이터베이스에 반영해야 한다. 회사에서는 사내교육이 이루어질 때 이에 대한 격려의 의미로 교육기간에 따라 Incentive를 차등지급하는데 이를 위해 가르치는 날짜와 끝난 날짜를 기록한다(Start Date, End Date).

8. A사에는 여러가지의 Department가 있고 이를 저장하는데 각각의 DepartmentID(Unique Identifier), Name, PhoneNumber, FAXNumber, Location을 저장한다.
각각의 Department에는 최소 한명에서 여러 Employee가 속할 수 있으며, 모든 Employee는 반드시 1개의 부서에(만) 속해야 한다.

9. A사는 아랍 문화권에 대한 이해를 높이고자 사원들에게 반드시 1개이상의 Lecture를 들을 것을 규칙으로 두고 있다. Lecture는 Lecture ID(Unique Identifier), Name, TutorName, Time, Place의 데이터를 저장해야 하며, 각각의 Employee는 여러 개의 강의를 들을 수 있고 각각의 강의는 여러명이 들을 수 있다. 또한 그 누구의 Employee도 수강하지 않은 Lecture라도 데이터베이스에 존재할 수 있다. 강의를 들으면 Employee가 Lecture를 들은 날짜와 Lecture가 끝난 이후에 퀴즈를 실시하여 그 성적을 기록한다.
<br></br>
### 4. Conceptual design (ERD) <br/>
<img width="1049" alt="image" src="https://user-images.githubusercontent.com/96376539/209355789-538e551b-efa4-4fc2-9a28-e4cef2f6d060.png"></img>
<br/><br/>
### 5. Logical design (Relational schema) <br/>
Department(Department_ID, DepartmentName, DepartmentPhoneNum, FAXNumber, Location)<br/>
Employee(Employee_ID, EmployeeName, Si, Dong, Ho, PhoneNumber, Salary, Department_ID, Mentor_ID, StartDate, EndDate, Incentive)<br/>
FOREIGN KEY (Department_ID) REFERENCES Department(Department_ID)<br/>
FOREIGN KEY (Mentor_ID) REFERENCES Employee(Employee_ID)<br/><br/>

Lecture(Lecture_ID, LectureName, TutorName, Time, Place)<br/>
Lecture_Taken(Employee_ID, Lecture_ID, Date, Grade)<br/>
FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)<br/>
FOREIGN KEY (Lecture_ID) REFERENCES Lecture(Lecture_ID)<br/><br/>

Blender(Blender_ID, Name, Age, Si, Dong, Ho, PhoneNumber, Gender, Employee_ID)<br/>
FOREIGN KEY (Employee_ID) REFERENCES Employee(Employee_ID)<br/><br/>

BlendingTea(Tea_ID, Name, Stock, Price, Blender_ID, Royalty)<br/>
FOREIGN KEY (Blender_ID) REFERENCES Blender(Blender_ID)<br/><br/>

Material(Material_ID, Name, Stock, Price)<br/>
BlendingTea_Manufactured(Tea_ID, Material_ID, Amount)<br/>
FOREIGN KEY (Tea_ID) REFERENCES BlendingTea (Tea_ID)<br/>
FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID)<br/><br/>

Supplier(Supplier_ID, Name, Si, Dong, Ho, PhoneNumber)<br/>
Material_Supplied(Material_ID, Supplier_ID, Quantity, Date)<br/>
FOREIGN KEY (Material_ID) REFERENCES Material(Material_ID)<br/>
FOREIGN KEY (Supplier_ID) REFERENCES Supplier(Supplier_ID)<br/><br/>

Customer(Customer_ID, Name, Si, Dong, Ho, LoginID, LoginPassword, Gender, BirthDate)<br/>
Customer_PhoneNumber(Customer_ID, PhoneNumber)<br/>
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)<br/><br/>

Regular(Customer_ID, Point)<br/>
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID) <br/><br/>

Rate_Plan(Plan_ID, PlanName, Price, ProvidedCount)<br/>
Subscriber(Customer_ID, CreditCardNumber, Plan_ID, SubscribeDate)	<br/>
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)	<br/>
FOREIGN KEY (Plan_ID) REFERENCES Rate_Plan(Plan_ID)<br/><br/>

Order(Order_ID, OrderDate, Customer_ID)<br/>
FOREIGN KEY (Customer_ID) REFERENCES Customer(Customer_ID)<br/><br/>

BlendingTea_Ordered(Tea_ID, Order_ID, Quantity)<br/>
FOREIGN KEY (Tea_ID) REFERENCES BlendingTea(Tea_ID)<br/>
FOREIGN KEY (Order_ID) REFERENCES Order(Order_ID)<br/>

* 정규형 Check <br/>
Relation의 모든 Attribute가 Atomic 하므로 : 1NF 충족 <br/>
Every non-primary-key attribute is FULLY functionally dependent on the primary key 즉, Partial Functional Dependecy 가 없으므로 : 2NF 충족 <br/>
Transitive Functional Dependency 가 없으므로 : 3NF 충족 <br/><br/>


### 6. Physical design & Data dictionary <br/>
이 단계에서 Denormalization은 하지 않기로 결정. Data dictionary는 Data Dictionary.pdf 파일 참조 <br/><br/>

### 7. Creating tables & Insert data <br/>
Create&Insert.sql 파일 참조 <br/><br/>

### 8. Useful SQL <br/>
1.어떤 고객이 O0012 주문을 한다고 가정하면, 아래와 같은 SQL이 동작하여 블렌딩 티의 재고 상태가 갱신된다. <br/>
```sql
UPDATE 
(
SELECT stock,quantity
FROM blendingtea, blendingtea_ordered, ordertable
WHERE blendingtea.tea_id = blendingtea_ordered.tea_id 
AND blendingtea_ordered.order_id = ordertable.order_id
AND ordertable.order_id = 'O0012'
)
SET stock = stock - quantity;
```
설명 : O0012 주문에 대한 주문수량(quantity) 만큼 blending tea의 재고(stock)가 빠져야 하므로,
조인을 통해 어떤 블렌딩 티(tea_id)가 어떤 주문(order_id)에 사용되었는지 정보를 파악해야 한다. 따라서 테이블들을 위와 같이 조인해주고, blendingtea_orderred의 주문된 quantity만큼 blendingtea의 재고인 stock을 빼주고 이를 갱신해주면 재고 갱신이 되는것이다. 해당 SQL문을 실행시키면 200개이던 T0014의 재고가 O0012의 주문수량인 88개만큼 빠져서 112개가 된 것을 확인할 수 있다.<br/><br/>
2.공급업체가 원재료를 공급할때 아래와 같은 SQL을 통해 재고 정보를 업데이트한다.
공급자 S0012가 원재료 M0005를 공급한다고 가정하면, 아래와 같은 SQL이 동작한다.<br/>
```sql
UPDATE 
(
SELECT stock, quantity
FROM material, material_supplied, supplier
WHERE material.material_id = material_supplied.material_id
AND material_supplied.supplier_id = supplier.supplier_id
AND supplier.supplier_id = 'S0012'
AND material.material_id = 'M0005'
)
SET stock = stock+quantity;
```
설명 : 공급을 받으면 받은 만큼 재고가 늘어나야 한다. 위 SQL의 상황에선 S0012 id를 가진 공급자(Supplier)로부터 M0005 id를 가진 원재료(Material)를 공급받는 상황을 가정한다. 재고를 갱신하려면 우선 조인을 통해 어떤 공급자(supplier_id)가 어떤 원재료(material_id)를 공급했는지 정보를 파악해야 한다. 따라서 조인을 통해 이를 추적하여 material_supplied로 연결해주고, material_supplied의 quantity만큼 material의 stock에 더해주면 원재료의 재고 갱신이 완료된다.
<br/><br/>
3. 가장 가장 많이 판매된 블렌딩 티를 확인하기 위하여 아래와 같은 쿼리를 사용한다. <br/>
```sql
SELECT tea_id, tea_name, sell 
FROM (SELECT tea_id, SUM(quantity) as sell from blendingtea_ordered GROUP BY tea_id) NATURAL JOIN blendingtea 
WHERE sell = (SELECT MAX(sell) FROM (SELECT tea_id,SUM(quantity) as sell from blendingtea_ordered GROUP BY tea_id));
```
설명: 가장 잘 팔리는 차와 그 차의 판매량을 알아보기 위해 현재 ordertable에 올라온 주문에서 판매된 차별로 판매된 양의 합을 구하고 이 중 판매량이 가장 큰 차의 ID와 이름, 판매량을 불러온다.
<br/><br/>
4. 각각의 블랜더가 만든 블랜딩 티의 개수/판매량의 합을 보여주는 뷰 <br/>
```sql
CREATE OR REPLACE VIEW made
AS SELECT blender_id,
COUNT(*) as maded,
SUM(quantity) as sales_rate
FROM blendingtea, blendingtea_ordered
WHERE blendingtea.tea_id = blendingtea_ordered.tea_id GROUP BY blender_id;
```
설명: 회사에 속해있는 블랜더가 몇개의 블랜딩 티를 만들었는지를 보여주고 각각의 만들어진 티들의 판매량의 합을 나타내는 뷰이다, OR REPLACE 를 명시하였기 때문에 판매량이나 새로운 블랜딩 티가 개발이 되면 해당 쿼리를 실행시키면 업데이트도 가능하다.
<br/><br/>
5. 고객이 자신의 구매 내역을 확인하고 싶을 경우 고객에게 아래의 VIEW를 제공한다. View에는 자신이 언제 어떤 주문을 했고, 그 주문에서 어떤 차를, 몇개를 시켰고 총 얼마를 결제했는지(블렌딩 티의 개당 가격 * 주문 수량) 확인할 수 있다. - 아래의 상황은 C0001 고객이 자신의 구매 내역을 조회하는 상황이다.<br/>
```sql
CREATE OR REPLACE VIEW purchase_history
AS SELECT ordertable.order_id, order_date, blendingtea.tea_name, blendingtea_ordered.quantity, blendingtea_ordered.quantity * blendingtea.price as purchase_price
FROM ordertable,blendingtea_ordered,blendingtea
WHERE ordertable.order_id = blendingtea_ordered.order_id
AND blendingtea_ordered.tea_id = blendingtea.tea_id
AND ordertable.customer_id = 'C0001';
```
설명: OR REPLACE VIEW로 만들어서 기존에 같은 이름의 VIEW가 있더라도 새롭게 그때 그때 뷰를 생성할 수 있게 하였다(그냥 CREATE VIEW를 사용하면 기존에 purchase_history 뷰를 생성했을 경우 새롭게 뷰를 갱신하지 못한다.) 해당 주문에 대해(ordertable.order_id) 어떤 블렌딩 티가 주문되어졌는지 확인하기 위해 blendingtea_ordered 테이블과 조인해 주었고, 해당 블렌딩 티의 개당 가격을 알아야 하기에 가격 정보가 저장되어진 blendingtea 테이블과 조인해 주었다.
<br/><br/>

6. 구독자(Subscriber)의 경우 아래의 SQL과 같이 정기적으로 ordertable과 blendingtea_ordered 에 새로운 주문이 rate_plan에 명시된 개수와 고객이 선택한 차로 insert 시켜준다. <br/>
```sql
INSERT INTO ordertable (order_id,order_date,customer_id) select 'O0019', subscribe_date,customer_id from subscriber NATURAL JOIN rate_plan where customer_id='C0012' ;

INSERT INTO blendingtea_ordered (tea_id,order_id,quantity) select 'T0009', order_id,provided_amount from subscriber NATURAL JOIN rate_plan natural join ordertable where order_id='O0019';
```
설명: rate_plan 테이블의 provied amount는 해당 구독제를 결제했을 때 달마다 몇개의 차가 고객에게 배송되는지의 양이다.
만일 구독제로 해당 기업의 서비스를 이용하는 C0012 고객이 차 ID가 T0009인 상품을 정기적으로 받기로 선택했다고 가정하면 고객이 구독한 구독제에서 제공되는 provided amount 만큼 해당 차가 한달에 한번씩 고객에게 배송될 것이다. 이는 provided amount 만큼의 차 주문이 ordertable에 들어가는 것과 같기에 위와 같은 SQL이 필요한 것이다.
subscriber가 정기 구독이 매달 업데이트가 될 때 마다 order table과 blendingtea_ordered 테이블에 새로운 주문을 넣어서 기록에 남긴다. 위 쿼리는 C0012 고객이 업데이트가 되었을 때 마지막 주문인 O0018뒤에 O0019을 추가 하면서 blendingtea_ordered 에도 고객이 지정한 T0009가 해당 rate_plan에 적혀있는 provided amount만큼 주문기록이 자동으로 추가된다. 즉, 이 고객의 경우 매달 30개의 차가 제공되는 Basic Plan을 채택한 고객이기에 30개의 수량만큼 order가 발주되는 것이다.
<br/><br/>

7. 블렌더의 연령대(평균)별 받는 로열티를 오름차순으로 나타낸다. <br/>
```sql
SELECT royalty, AVG(blender.age) as Average_age 
FROM blender, blendingtea 
WHERE blender.blender_id = blendingtea.blender_id 
GROUP BY royalty 
ORDER BY AVG(blender.age);
```
<br/><br/>

8. 블렌더의 나이가 30이하와 성별에 따라 개발되는 차의 이름을 오름차순으로 나타낸다. 차를 개발하는 사람의 나이와 성별에 따라 어떤 종류의 티를 만드는지 파악할 수 있다. <br/>
```sql
SELECT age,gender, tea_name 
FROM blender, blendingtea 
WHERE blender.blender_id = blendingtea.blender_id and age<30 
GROUP BY age, gender, tea_name 
ORDER BY tea_name; 
```
<br/><br/>

9. 고객이 구독할 요금제의 이름, 가격, 제공되는 차의 개수를 비싼 가격순으로 보여준다. <br/>
```sql
SELECT plan_name, price, provided_amount 
FROM rate_plan 
ORDER BY price DESC;
```
<br/><br/>

10. A를 많이 받은 직원 순으로 정렬하여 우수 직원을 시상하기 위해 아래와 같이
강의를 수강한 직원 중 성적 A를 받은 직원의 이름, 전화번호, A를 받은 횟수를 보여준다. <br/>
```sql
SELECT emp_name,phone_number, count(emp_id) as grade_A 
FROM lecture_taken NATURAL JOIN employee 
WHERE grade = 'A'
group by emp_id,emp_name,phone_number
order by grade_A DESC;
```
<br/><br/>

11. 해당 기업은 최근 구독한 고객들에게 이벤트를 준비중에 있기에 2022년 12월 이후로 구독한 구독자의 이름, 주소(시,동,호), 로그인 ID,구독일을 아래의 SQL문을 통해 파악한다.. 최근에 구독한 사람 순으로 정렬해서 구독 갱신한 사람을 구분한다. <br/>
```sql
SELECT customer_name,si,dong,ho,login_id,subscribe_date
FROM customer NATURAL JOIN subscriber 
WHERE subscribe_date > '2022-11-30' 
ORDER BY subscribe_date DESC;
```
<br/><br/>

12. 90년대 출생한 고객중 성별 기준으로 고객을 나누어 수를 센다. 서비스를 이용하는 고객이 
청년층이 얼마나 이용하는지, 어떤 성별이 주로 이용하는지  파악하는데 사용한다. <br/>
```sql
SELECT gender,count(customer_id) as gender_count 
FROM customer 
WHERE birthdate > '1989-12-31' AND birthdate < '2000-01-01' 
GROUP BY gender;
```
<br/><br/>

13. 고객이나 직원, 블랜더가 이사할 때 아래와 같은 UPDATE 문으로 주소를 업데이트 할 수 있다. <br/>
```sql
UPDATE customer 
SET si = '부천', dong = '송내동', ho ='13'
WHERE customer_id = 'C0003';
```


