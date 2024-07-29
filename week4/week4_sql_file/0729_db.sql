-- 5.integrity.sql
/* DB 자체적으로 강제적인 제약 사항 설정
	

1. 제약조건 적용 방식
	1-1. table 생성시 적용
		- create table의 마지막 부분에 설정
			방법1 - 제약조건명 없이 설정
			방법2 - constraints 제약조건명 명시
			
            create table people(
                컬럼명 자료형 제약조건
            );

            create table people(
                컬럼명 자료형 제약조건
            ) CONSTRAINT 제약명 제약조건 (컬럼)
		- 참고 : mysql의 pk에 설정한 사용자 정의 제약조건명은 data 사전 table에서 검색 불가



	1-2. alter 명령어로 제약조건 추가
	- 이미 존재하는 table의 제약조건 수정(추가, 삭제)명령어
		alter table 테이블명 add/modify 컬럼명 타입 제약조건;
		
	1-3. 제약조건 삭제(drop)
		- table삭제 
		alter table 테이블명 alter 컬럼명 drop 제약조건;


2. Data Dictionary란?
	- 제약 조건등의 정보 확인
	- MySQL Server의 개체에 관한 모든 정보 보유하는 table
		- 일반 사용자가 검색은 가능하나 insert/update/delete 불가
	- information_schema

3. 제약 조건 종류
	emp와 dept의 관계
		- dept 의 deptno가 원조 / emp 의 deptno는 참조
		- dept : 부모 table / emp : 자식 table(dept를 참조하는 구조)
		- dept의 deptno는 중복 불허(not null) - 기본키(pk, primary key)
		- emp의 deptno - 참조키(fk, foreign key, 외래키)
	
	
	2-1. PK[primary key] - 기본키, 중복불가, null불가, 데이터들 구분을 위한 핵심 데이터
		: not null + unique
	2-2. not null - 반드시 데이터 존재
	2-3. unique - 중복 불가, null 허용
	2-4. check - table 생성시 규정한 범위의 데이터만 저장 가능 
	2-5. default - insert시에 특별한 데이터 미저장시에도 자동 저장되는 기본 값
				- 자바 관점에는 멤버 변수 선언 후 객체 생성 직후 멤버 변수 기본값으로 초기화
	* 2-6. FK[foreign key] 
		- 외래키[참조키], 다른 table의 pk를 참조하는 데이터 
		- table간의 주종 관계가 형성
		- pk 보유 table이 부모, 참조하는 table이 자식

		
*/
use fisa


-- fk_emp_dept 
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 삭제를 허용하지 않습니다.
-- 즉, dept 테이블에서 deptno 값이 삭제되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 삭제가 실패합니다.
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 업데이트를 허용하지 않습니다.
-- 즉, dept 테이블에서 deptno 값이 변경되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 업데이트가 실패합니다.


ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE NO ACTION ON UPDATE NO ACTION; 


DESC emp;

-- 신짱구를 40번 부서로 넣은 후
INSERT INTO fisa.emp VALUES (1, '신짱구', '유치원생', 2, now(), 800, null, 40); 

-- 50으로 변경해주시고, 삭제  

 SELECT * FROM fisa.emp;

SELECT * FROM information_schema.TABLE_CONSTRAINTS;
SELECT *
from information_schema.TABLE_CONSTRAINTS
where `TABLE_NAME` in ('emp');


-- NULL 여부는 다른 테이블에 영향을 미치지 않기 때문에 Modify 명령어를 사용한다.
-- CASCADE : 폭포
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 삭제를 허용합니다.
-- 즉, dept 테이블에서 deptno 값이 삭제되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 삭제가 성공합니다.
-- 참조하는 테이블(emp)에 해당 외래 키 값이 존재하면 업데이트를 허용합니다.
-- 즉, dept 테이블에서 deptno 값이 변경되려 할 때, emp 테이블에 동일한 deptno 값이 존재하면 업데이트가 성공합니다.


-- 부서번호, 부서이름, 부서가 있는 지역 

USE fisa;

drop table IF EXISTs emp;
drop table IF EXISTs dept;
DROP TABLE IF EXISTS salgrade;

CREATE TABLE dept (
    deptno               int  NOT NULL ,
    dname                varchar(20),
    loc                  varchar(20),
    CONSTRAINT pk_dept PRIMARY KEY ( deptno )
 );
 
CREATE TABLE emp (
    empno                int  NOT NULL  AUTO_INCREMENT,
    ename                varchar(20),
    job                  varchar(20),
    mgr                  smallint ,
    hiredate             date,
    sal                  numeric(7,2),
    comm                 numeric(7,2),
    deptno               int,
    CONSTRAINT pk_emp PRIMARY KEY ( empno ) -- 중복되지 않고, 고유한 값을 가지고 있는 컬럼 '기본키' 
 );
 
CREATE TABLE salgrade
 ( 
	GRADE INT,
	LOSAL numeric(7,2),
	HISAL numeric(7,2) 
);

insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');

desc dept;
desc emp;
desc salgrade;

-- STR_TO_DATE() : 단순 문자열을 날짜 형식의 타입으로 변환 
insert into emp values( 7839, 'KING', 'PRESIDENT', null, STR_TO_DATE ('17-11-1981','%d-%m-%Y'), 5000, null, 10);
insert into emp values( 7698, 'BLAKE', 'MANAGER', 7839, STR_TO_DATE('1-5-1981','%d-%m-%Y'), 2850, null, 30);
insert into emp values( 7782, 'CLARK', 'MANAGER', 7839, STR_TO_DATE('9-6-1981','%d-%m-%Y'), 2450, null, 10);
insert into emp values( 7566, 'JONES', 'MANAGER', 7839, STR_TO_DATE('2-4-1981','%d-%m-%Y'), 2975, null, 20);
insert into emp values( 7788, 'SCOTT', 'ANALYST', 7566, DATE_ADD(STR_TO_DATE('13-7-1987','%d-%m-%Y'), INTERVAL -85 DAY)  , 3000, null, 20);
insert into emp values( 7902, 'FORD', 'ANALYST', 7566, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 3000, null, 20);
insert into emp values( 7369, 'SMITH', 'CLERK', 7902, STR_TO_DATE('17-12-1980','%d-%m-%Y'), 800, null, 20);
insert into emp values( 7499, 'ALLEN', 'SALESMAN', 7698, STR_TO_DATE('20-2-1981','%d-%m-%Y'), 1600, 300, 30);
insert into emp values( 7521, 'WARD', 'SALESMAN', 7698, STR_TO_DATE('22-2-1981','%d-%m-%Y'), 1250, 500, 30);
insert into emp values( 7654, 'MARTIN', 'SALESMAN', 7698, STR_TO_DATE('28-09-1981','%d-%m-%Y'), 1250, 1400, 30);
insert into emp values( 7844, 'TURNER', 'SALESMAN', 7698, STR_TO_DATE('8-9-1981','%d-%m-%Y'), 1500, 0, 30);
insert into emp values( 7876, 'ADAMS', 'CLERK', 7788, DATE_ADD(STR_TO_DATE('13-7-1987', '%d-%m-%Y'),INTERVAL -51 DAY), 1100, null, 20);
insert into emp values( 7900, 'JAMES', 'CLERK', 7698, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 950, null, 30);
insert into emp values( 7934, 'MILLER', 'CLERK', 7782, STR_TO_DATE('23-1-1982','%d-%m-%Y'), 1300, null, 10);


INSERT INTO SALGRADE VALUES (1,700,1200);
INSERT INTO SALGRADE VALUES (2,1201,1400);
INSERT INTO SALGRADE VALUES (3,1401,2000);
INSERT INTO SALGRADE VALUES (4,2001,3000);
INSERT INTO SALGRADE VALUES (5,3001,9999);

COMMIT;

SELECT * FROM DEPT;
SELECT * FROM EMP;
SELECT * FROM SALGRADE;

COMMIT;

CREATE Table emp03 SELECT * FROM emp;

-- primary key로 empno설정,ename은 unique라는 제약조건으로 설정
DROP TABLE emp03;
CREATE Table emp03(
    empno int PRIMARY KEY,
    ename varchar(10) not null,
    age int NOT NULL DEFAULT 1
);


use fisa;

show tables;
show databases;

-- 1. table 삭제
drop table if exists emp01;


-- 2. 사용자 정의 제약 조건명 명시하기
-- 개발자는 sql 문법 ok된 상태로 table + 제약조건 생성
-- db 관점에서 기록
use fisa;
create table emp01(
	empno int NOT NULL,
	ename varchar(10)
);

desc emp01;

-- mysql에 사전 table 검색 : 테이블에 대한 테이블 (현재 DB에 대한 메타데이터)


-- mysql에 사전 table 검색 : 테이블에 대한 테이블 (현재 DB에 대한 메타데이터)


-- EMP와 DEPT 테이블에 모두 deptno라는 열이 존재한다면, 쿼리 결과는 다음과 같습니다

 
-- 3. emp table의 제약조건 조회
-- table 생성시 컬럼 선언시에 not null ???

-- 테이블의 메타데이터 

-- 각 테이블별로 컬럼에 대한 메타데이터를 관리하는 다른 테이블이 있음
-- NULL/NOT NULL은 컬럼에는 영향을 미치지만 다른 테이블에는 영향을 미치지 않음 -> COLUMNS 단위로 관리됩니다. 

-- 4. drop 후 dictionary table 검색


-- NULL 여부는 다른 테이블에 영향 미치지 않기 때문에 MODIFY 명령어 사용 
-- emp01에 대한 정보가 소멸된 상태 확인을 위한 명령어
-- table 삭제시 제약조건도 자동 삭제

-- emp01 PRIMARY KEY를 empno로 걸어주세요 


-- *** unique ***
-- 5. unique : 고유한 값만 저장 가능, null 허용  
-- UNIQUE는 제약조건을 거는 순간 INDEX(색인)이 들어갑니다
use fisa;
create table emp01(
	empno int NOT NULL,
	ename varchar(10)
);

desc emp01;

-- empno 컬럼에 UNIQUE라는 제약조건을 걸어 emp02라는 테이블을 만들기 
CREATE TABLE emp02 SELECT * from emp01 WHERE 1=0;
DESC emp02;

-- ?? empno 컬럼에 UNIQUE라는 제약조건을 걸기


SELECT *
FROM INFORMATION_SCHEMA.TABLE_CONSTRAINTS  -- 다른 테이블, 컬럼에 영향을 미치는 조건만 관리됩니다 
WHERE TABLE_NAME IN ('EMP');
DESC fisa.emp01;

SELECT * from emp02;

-- 6. alter 명령어로 ename에 unique 적용


-- ename이 tester인 사람 삭제


-- ? ename 컬럼에 unique 설정 추가



-- *** Primary key ***

-- 7. pk설정 : 데이터 구분을 위한 기준 컬럼, 중복과 null 불허
DROP TABLE IF EXISTS emp03;

select * from information_schema.TABLE_CONSTRAINTS tc 
where table_name='emp03';




-- 읽기 쉬운 코드가 좋은 코드 



-- ? 동일한 1값 insert 시도해 보기
INSERT INTO emp03 VALUES (1, 'master');

-- 8. 사용자 정의 제약 조건명 명시 하면서 pk 설정(권장)
-- 제약 조건명 : pk_empno_emp03
/* table명 관련컬럼명 제약조건을 적용한 이름 권장
 * pk_empno_emp03 : emp03 table의 empno 컬럼은 pk > 작은거부터 큰거 
 * 	emp03_empno_pk or pk_emp03_empno ..
 */

 


-- 사용자 정의 제약조건명 확인도 가능
-- pk와 not null은 확인 불가 : 한테이블에 하나밖에 없어서 고유한 값 

/* emp의 pk - empno      사원번호가 기본키, 고유값, 중복 : 사원은 중복될 수 없으니까 
 * dept의 pk - deptno    부서번호가 기본키, 고유값, 중복 : 부서간에 사무실은 공유할 수 있으니까 
 */


-- *** foreign key ***

-- 11. 외래키[참조키]
-- emp table 기반으로 emp04 복제 단 제약조건은 적용되지 않음
-- alter 명령어로 table의 제약조건 추가 
DROP TABLE IF EXISTS emp04;
CREATE TABLE emp04 SELECT * FROM emp;
DESC emp04; 
DESC emp; -- 컬럼 자체의 조건
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp04'; 
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp'; -- 다른 테이블 / 다른 컬럼과의 조건
SELECT * FROM emp04; 
-- 생성시 fk 설정
/* dept의 deptno를 참조하는 emp04의 deptno 생성
 */


-- ALTER TABLE 테이블명 MODIFY 컬럼명 자료형 부가적인 제약조건;




-- 12. alter & fk drop : dict table에서 이름 확인후 삭제 


-- ? dept의 deptno를 참조하는 fk 설정하기


-- 부서번호, 부서이름, 부서가 있는 지역 
insert into dept values(10, 'ACCOUNTING', 'NEW YORK');
insert into dept values(20, 'RESEARCH', 'DALLAS');
insert into dept values(30, 'SALES', 'CHICAGO');
insert into dept values(40, 'OPERATIONS', 'BOSTON');

insert into emp values( 7839, 'KING', 'PRESIDENT', null, STR_TO_DATE ('17-11-1981','%d-%m-%Y'), 5000, null, 10);
insert into emp values( 7698, 'BLAKE', 'MANAGER', 7839, STR_TO_DATE('1-5-1981','%d-%m-%Y'), 2850, null, 30);
insert into emp values( 7782, 'CLARK', 'MANAGER', 7839, STR_TO_DATE('9-6-1981','%d-%m-%Y'), 2450, null, 10);
insert into emp values( 7566, 'JONES', 'MANAGER', 7839, STR_TO_DATE('2-4-1981','%d-%m-%Y'), 2975, null, 20);
insert into emp values( 7788, 'SCOTT', 'ANALYST', 7566, DATE_ADD(STR_TO_DATE('13-7-1987','%d-%m-%Y'), INTERVAL -85 DAY)  , 3000, null, 20);
insert into emp values( 7902, 'FORD', 'ANALYST', 7566, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 3000, null, 20);
insert into emp values( 7369, 'SMITH', 'CLERK', 7902, STR_TO_DATE('17-12-1980','%d-%m-%Y'), 800, null, 20);
insert into emp values( 7499, 'ALLEN', 'SALESMAN', 7698, STR_TO_DATE('20-2-1981','%d-%m-%Y'), 1600, 300, 30);
insert into emp values( 7521, 'WARD', 'SALESMAN', 7698, STR_TO_DATE('22-2-1981','%d-%m-%Y'), 1250, 500, 30);
insert into emp values( 7654, 'MARTIN', 'SALESMAN', 7698, STR_TO_DATE('28-09-1981','%d-%m-%Y'), 1250, 1400, 30);
insert into emp values( 7844, 'TURNER', 'SALESMAN', 7698, STR_TO_DATE('8-9-1981','%d-%m-%Y'), 1500, 0, 30);
insert into emp values( 7876, 'ADAMS', 'CLERK', 7788, DATE_ADD(STR_TO_DATE('13-7-1987', '%d-%m-%Y'),INTERVAL -51 DAY), 1100, null, 20);
insert into emp values( 7900, 'JAMES', 'CLERK', 7698, STR_TO_DATE('3-12-1981','%d-%m-%Y'), 950, null, 30);
insert into emp values( 7934, 'MILLER', 'CLERK', 7782, STR_TO_DATE('23-1-1982','%d-%m-%Y'), 1300, null, 10);


SELECT * FROM DEPT;
SELECT * FROM EMP;

-- NO ACTION
-- dept의 deptno 중 emp가 참조하고 있는 값이 있으면 건드릴 수 없음
ALTER TABLE emp 
ADD CONSTRAINT fk_emp_dept FOREIGN KEY ( deptno ) REFERENCES dept( deptno ) 
ON DELETE NO ACTION ON UPDATE NO ACTION; 

UPDATE dept SET deptno=100 WHERE deptno=10; 

-- emp에서도 deptno에 없는 값을 사용할 수 없음
UPDATE emp SET deptno=100 WHERE deptno=10;

-- 삭제도 불가
DELETE FROM dept WHERE deptno=10;

alter table emp drop foreign key fk_emp_dept;

SELECT * FROM dept;

-- ON CASCADE CASCADE - 폭포 -- 업데이트할 때 해당 내용이 상속되는 조건 
-- dept의 deptno 중 emp가 참조하고 있는 값이 있으면 건드릴 수 없음
DROP TABLE IF EXISTS emp04; 
CREATE TABLE emp04 SELECT * FROM emp;
alter table emp04 add foreign key (deptno) references dept (deptno) 
ON DELETE CASCADE ON UPDATE CASCADE;




-- ?? 참조되고 있는 dept의 deptno를 200으로 변경


-- 참조하고 있는 emp04의 deptno를 20을 200으로 변경은 불가


-- 다른 테이블(dept)에 있는 기존 행에 있는 외래키가 참조하지 않는 값(40)이 업데이트되면 그 때 현재 테이블은 어떻게 바뀌어야 할까? 




-- *** check ***	
-- 13. check : if 조건식과 같이 저장 직전의 데이터의 유효 유무 검증하는 제약조건 
DROP TABLE IF EXISTS emp05;
CREATE TABLE emp05(
	empno int primary key,
    ename varchar(10) not null,
    age int,
    check (age >0)
);


-- 0초과 데이터만 저장 가능한 check
desc emp05;

insert into emp05 (1, 'master', -3);
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp05'; 
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp'; -- 다른 테이블 / 다른 컬럼과의 조건

-- ? 14. age값이 1~100까지만 DB에 저장하는 테이블 emp05 생성
-- 힌트 : between ~ and ~



-- 16. alter & check
drop table if exists emp05;
create table emp05(
	empno int,
	ename varchar(10) not null,
	age int
);

select * from information_schema.TABLE_CONSTRAINTS 
where table_name='emp05';

alter table emp05 add check (age > 0);

desc emp05;
select * from information_schema.TABLE_CONSTRAINTS where table_name='emp05';
insert into emp05 values(1, 'master', 10);
-- insert into emp05 values(2, 'master', -10); 에러

select * from emp05;



-- *** default ***
-- 18. 컬럼에 기본값 자동 설정
-- insert시에 데이터를 저장하지 않아도 자동으로 기본값으로 초기화(저장)
/* java 관점에선 멤버 변수가 있는 클래스를 기반으로 객체 생성시에
 * 자동 초기화 되는 원리와 흡사
 * 단지, table 생성시에 기본 초기값 지정 
 */
DROP TABLE IF EXISTS emp05;
CREATE TABLE emp05(
	empno int primary key,
    ename varchar(10) not null,
    age int default 1 -- 0 
);


desc emp05;
SELECT * FROM emp05;
insert into emp05 (empno, ename) VALUES (7, 'master'); -- 자리수 일치해야 값이 들어간다 

-- age 컬럼에 데이터 저장 생략임에도 1이라는 값 자동 저장

-- 20. alter & default


-- 6.index.sql

/*
1. db의 빠른 검색을 위한 색인 기능의 index 학습
    - primary key에는 기본적으로 자동 index로 설정됨 
    
    - DB 자체적으로 빠른 검색 기능 부여
        이 빠른 검색 기능 - index
    - 어설프게 사용자 정의 index 설정시 오히려 검색 속도 다운
    - 데이터 셋의 15% 이상의 데이터들이 잦은 변경이 이뤄질 경우 index 설정 비추

2. 주의사항
    - index가 반영된 컬럼 데이터가 수시로 변경되는 데이터라면 index 적용은 오히려 부작용
    
3. 문법
    CREATE INDEX index_name
    ON table_name (column1, column2, ...);
*/

use fisa;

-- 1. index용 검색 속도 확일을 위한 table 생성 
drop table if exists emp01;

-- 존재하는 table로 부터 복제시에는 제약조건은 미적용
create table emp01 as select * from emp;
desc emp01;

-- empno로 검색시에 빠른 검색이 가능하게 색인 기능 적용
create index idx_emp01_empno on emp01(empno);
desc emp01;

-- drop index
alter table emp01 drop index idx_emp01_empno;

-- 코드 참고: <이것이 MYSQL이다>, 한빛출판사, 9장
DROP DATABASE IF EXISTS sqldb;
CREATE DATABASE sqldb;

USE sqldb;
CREATE TABLE usertbl 
( userID  CHAR(8) NOT NULL PRIMARY KEY, 
  name    VARCHAR(10) NOT NULL, 
  birthYear   INT NOT NULL,  
  addr    CHAR(2) NOT NULL,
  mobile1   CHAR(3) NULL, 
  mobile2   CHAR(8) NULL, 
  height    SMALLINT NULL, 
  mDate    DATE NULL 
);

-- <실습 1> --

USE sqldb;
CREATE TABLE  tbl1
    (   a INT PRIMARY KEY,
        b INT,
        c INT
    );

SHOW INDEX FROM tbl1;
/* 
1. Table  테이블명 표기
2. Non_unique  인덱스가 중복된 값이 가능하면 1 중복값이 허용되지 않는 UNIQUE INDEX이면 0을 표시함
3. Key_name  인덱스의 이름을 표시하며 인덱스가 해당 테이블의 기본키라면 PRIMARY로 표시함.
4. Seq_in_index  멀티컬럼이 인덱스인 경우 해당 필드의 순서를 표시함.
5. Column_name  해당 필드의 이름을 표시함.
6. Collation  인덱스에서 해당 필드가 정렬되는 방법을 표시함.
7. Cardinality  인덱스에 저장된 유일한 값들의 수를 표시함.
                (해당 컬럼의 중복된 수치. 중복도가 낮으면 카디널리티가 높다고 표현하고, 중복도가 높으면 카디널리티가 낮다고 표현)
8. Sub_part  인덱스 접두어.
9. Packed  키가 압축되는packed 방법.
10. Null  해당 필드가 NULL을 저장할 수 있으면 YES, 아니면 NO.
11. Index_type  인덱스가 어떤 형태로 구성되어 있는지 나타내며 MySQL은 대부분 B-tree 자료구조를 사용.
12. Comment  해당 필드를 설명하는 것이 아닌 인덱스에 관한 기타 정보.
13. Index_comment  인덱스에 관한 모든 기타 정보를 표시함.
*/

CREATE TABLE  tbl2
    (   a INT PRIMARY KEY, 
        b INT UNIQUE,
        c INT UNIQUE,
        d INT
    );
SHOW INDEX FROM tbl2;

CREATE TABLE  tbl3
    (   a INT UNIQUE,
        b INT UNIQUE,
        c INT UNIQUE,
        d INT
    );
SHOW INDEX FROM tbl3;

CREATE TABLE  tbl4
    (   a INT UNIQUE NOT NULL,
        b INT UNIQUE,
        c INT UNIQUE,
        d INT
    );
SHOW INDEX FROM tbl4;

CREATE TABLE  tbl5
    (   a INT UNIQUE NOT NULL,
        b INT UNIQUE ,
        c INT UNIQUE,
        d INT PRIMARY KEY
    );
SHOW INDEX FROM tbl5;

CREATE DATABASE IF NOT EXISTS sqldb;
USE sqldb;
DROP TABLE IF EXISTS usertbl;
CREATE TABLE usertbl 
( userID  char(8) NOT NULL PRIMARY KEY, 
  name    varchar(10) NOT NULL,
  birthYear   int NOT NULL,
  addr    nchar(2) NOT NULL 
 );


INSERT INTO usertbl VALUES('LSG', '이승기', 1987, '서울');
INSERT INTO usertbl VALUES('KBS', '김범수', 1979, '경남');
INSERT INTO usertbl VALUES('KKH', '김경호', 1971, '전남');
INSERT INTO usertbl VALUES('JYP', '조용필', 1950, '경기');
INSERT INTO usertbl VALUES('SSK', '성시경', 1979, '서울');
SELECT * FROM usertbl;

ALTER TABLE usertbl DROP PRIMARY KEY ;
ALTER TABLE usertbl 
    ADD CONSTRAINT pk_name PRIMARY KEY(name);
SELECT * FROM usertbl;

-- </실습 1> --

CREATE DATABASE IF NOT EXISTS sqldb;
USE sqldb;
DROP TABLE IF EXISTS clustertbl;
CREATE TABLE clustertbl -- Cluster Index를 가진 테이블 생성
( userID  CHAR(8) ,
  name    VARCHAR(10) 
);
INSERT INTO clustertbl VALUES('LSG', '이승기');
INSERT INTO clustertbl VALUES('KBS', '김범수');
INSERT INTO clustertbl VALUES('KKH', '김경호');
INSERT INTO clustertbl VALUES('JYP', '조용필');
INSERT INTO clustertbl VALUES('SSK', '성시경');
INSERT INTO clustertbl VALUES('LJB', '임재범');
INSERT INTO clustertbl VALUES('YJS', '윤종신');
INSERT INTO clustertbl VALUES('EJW', '은지원');
INSERT INTO clustertbl VALUES('JKW', '조관우');
INSERT INTO clustertbl VALUES('BBK', '바비킴');

SELECT * FROM clustertbl; -- 입력한 순서대로 값이 들어갑니다

ALTER TABLE clustertbl
    ADD CONSTRAINT PK_clustertbl_userID
        PRIMARY KEY (userID);

SELECT * FROM clustertbl;  -- PK가 걸린 ID의 ABCD 순으로 정렬됩니다 (클러스터 인덱스 설정됨)


DROP TABLE IF EXISTS secondarytbl;
CREATE TABLE secondarytbl -- Secondary Table 약자
( userID  CHAR(8),
  name    VARCHAR(10)
);
INSERT INTO secondarytbl VALUES('LSG', '이승기');
INSERT INTO secondarytbl VALUES('KBS', '김범수');
INSERT INTO secondarytbl VALUES('KKH', '김경호');
INSERT INTO secondarytbl VALUES('JYP', '조용필');
INSERT INTO secondarytbl VALUES('SSK', '성시경');
INSERT INTO secondarytbl VALUES('LJB', '임재범');
INSERT INTO secondarytbl VALUES('YJS', '윤종신');
INSERT INTO secondarytbl VALUES('EJW', '은지원');
INSERT INTO secondarytbl VALUES('JKW', '조관우');
INSERT INTO secondarytbl VALUES('BBK', '바비킴');


ALTER TABLE secondarytbl
    ADD CONSTRAINT UK_secondarytbl_userID
        UNIQUE (userID); -- UNIQUE가 걸리면 보조 인덱스가 자동 생성됩니다

SELECT * FROM secondarytbl;

INSERT INTO clustertbl VALUES('FNT', '푸니타');
INSERT INTO clustertbl VALUES('KAI', '카아이');

INSERT INTO secondarytbl VALUES('FNT', '푸니타');
INSERT INTO secondarytbl VALUES('KAI', '카아이');

-- <실습 2> --
DROP TABLE IF EXISTS mixedtbl;
CREATE TABLE mixedtbl
( userID  CHAR(8) NOT NULL ,
  name    VARCHAR(10) NOT NULL,
  addr     char(2)
);
INSERT INTO mixedtbl VALUES('LSG', '이승기', '서울');
INSERT INTO mixedtbl VALUES('KBS', '김범수', '경남');
INSERT INTO mixedtbl VALUES('KKH', '김경호', '전남');
INSERT INTO mixedtbl VALUES('JYP', '조용필',  '경기');
INSERT INTO mixedtbl VALUES('SSK', '성시경', '서울');
INSERT INTO mixedtbl VALUES('LJB', '임재범',  '서울');
INSERT INTO mixedtbl VALUES('YJS', '윤종신',  '경남');
INSERT INTO mixedtbl VALUES('EJW', '은지원', '경북');
INSERT INTO mixedtbl VALUES('JKW', '조관우', '경기');
INSERT INTO mixedtbl VALUES('BBK', '바비킴',  '서울');


ALTER TABLE mixedtbl
    ADD CONSTRAINT PK_mixedtbl_userID
        PRIMARY KEY (userID);

ALTER TABLE mixedtbl
    ADD CONSTRAINT UK_mixedtbl_name
        UNIQUE (name) ;

SHOW INDEX FROM mixedtbl;

SELECT addr FROM mixedtbl WHERE name = '임재범';

-- </실습 2> --



-- <실습 3> --

USE sqldb;
SELECT * FROM usertbl;

USE sqldb;
SHOW INDEX FROM usertbl;

SHOW TABLE STATUS LIKE 'usertbl';

CREATE INDEX idx_usertbl_addr 
   ON usertbl (addr);
   
SHOW INDEX FROM usertbl;

SHOW TABLE STATUS LIKE 'usertbl';

ANALYZE TABLE usertbl;
SHOW TABLE STATUS LIKE 'usertbl';

CREATE UNIQUE INDEX idx_usertbl_birtyYear
    ON usertbl (birthYear);

CREATE UNIQUE INDEX idx_usertbl_name
    ON usertbl (name);

SHOW INDEX FROM usertbl;

INSERT INTO usertbl VALUES('GPS', '김범수', 1983, '미국', NULL  , NULL  , 162, NULL);

CREATE INDEX idx_usertbl_name_birthYear
    ON usertbl (name,birthYear);
DROP INDEX idx_usertbl_name ON usertbl;

SHOW INDEX FROM usertbl;

SELECT * FROM usertbl WHERE name = '윤종신' and birthYear = '1969';

CREATE INDEX idx_usertbl_mobile1
    ON usertbl (mobile1);

SELECT * FROM usertbl WHERE mobile1 = '011';

SHOW INDEX FROM usertbl;

DROP INDEX idx_usertbl_addr ON usertbl;
DROP INDEX idx_usertbl_name_birthYear ON usertbl;
DROP INDEX idx_usertbl_mobile1 ON usertbl;

ALTER TABLE usertbl DROP INDEX idx_usertbl_addr;
ALTER TABLE usertbl DROP INDEX idx_usertbl_name_birthYear;
ALTER TABLE usertbl DROP INDEX idx_usertbl_mobile1;

ALTER TABLE usertbl DROP PRIMARY KEY;

SELECT table_name, constraint_name
    FROM information_schema.referential_constraints
    WHERE constraint_schema = 'sqldb';

ALTER TABLE buyTbl DROP FOREIGN KEY buytbl_ibfk_1;
ALTER TABLE usertbl DROP PRIMARY KEY;

-- </실습 3> --

