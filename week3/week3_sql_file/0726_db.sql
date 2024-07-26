uSE fisa;


-- 부서가 accounting인 사람의 이름과 deptno를 emp, dept를 조인해서 확인
SELECT e.ename, e.deptno
FROM emp e , dept d
WHERE emp.deptno = dept.deptno
     AND dept.dname = 'accounting';

(SELECT * FROM dept d WHERE d.dname = 'ACCOUNTING');


SELECT ename, deptno
FROM emp
WHERE deptno = (SELECT deptno FROM dept d WHERE dname = 'ACCOUNTING');  -- 서브쿼리 안에서 테이블을 부른 이름을 외부에서 사용할 수 없다.

SELECT * FROM emp;
-- 스미스와 같은 부서인 사람의 이름을 알고 싶다. 
SELECT e.ename, e.deptno
FROM emp e
WHERE deptno = (SELECT e.deptno
FROM emp e
WHERE e.ename = 'SMITH');
-- 스미스와 같은 부서인 사람의 이름을 알고 싶다. (스미스는 제외)
SELECT e.ename, e.deptno
FROM emp e
WHERE deptno = (SELECT e.deptno
FROM emp e
WHERE e.ename = 'SMITH')
     AND e.ename != 'SMITH';


---
SELECT e.ename,
        ( SELECT d.dname
            FROM dept d
        WHERE e.deptno = d.deptno) AS dep --
    FROM emp e;                           -- 외부쿼리와 연관성이 있는 쿼리


-- 2. FROM 절에서의 서브쿼리
-- 서브쿼리가 반환하는 결과 집합을 하나의 테이블처럼 사용하는 쿼리문
-- 서브쿼리 안에서 사용해도 된다
-- FROM -> WHERE -> SELECT
SELECT b.deptno, b.empno, c.ename
            FROm emp b,
                emp c
            where b.empno = c.empno;

SELECT a.deptno, a.dname
FROM dept a
ORDER BY 1;
-- 두 쿼리문 합치기
SELECT a.deptno, a.dname, mgr.empno 
    FROM dept a,
    (SELECT b.deptno, b.empno, c.ename
                    FROM emp b,
                        emp c
                    WHERE b.empno = c.empno) mgr -- FROM 절 서브쿼리는 원본에서 재성성한 테이블이기에 별칭 생성
    ORDER BY 1;
-- 매니저 검색
SELECT * 
FROM emp e
WHERE e.job = 'MANAGER';

SELECT d.dname, d.deptno, a.ename
        FROM dept d,(
            SELECT * 
            FROM emp e
            WHERE e.job = 'MANAGER'
        ) as a
    WHERE d.deptno = a.empno

-- 매니저 부서번호

-- smith 씨랑 급여가 같거나 더 많은 상원명과 급여를 검색해주세요 - 부등호
-- 1. smith 급여 테이블 생성, sal
SELECT sal FROM emp WHERE ename = 'SMITH';
-- 2. where절에 삽입
SELECT ename, sal
FROM emp
WHERE sal >= (
    SELECT sal FROM emp WHERE ename = 'SMITH'
) AND ename NOT LIKE 'SMITH';

-- 급여가 3000불 이상인 사원이 소속된 부서(10, 20)에 속한 사원이름 급여 검색
-- 1. 부서가 10, 20인 테이블 생성
SELECT * FROM emp;
SELECT *
FROM emp
WHERE deptno = 10 OR deptno = 20;
-- 2. 3000불 이상인 사람 급여 생성
SELECT e.ename, e.sal
FROM (
    SELECT *
    FROM emp
    WHERE deptno = 10 OR deptno = 20
) as e
WHERE e.sal >= 3000;

--- 각 부서별로 SAL가 가장 높은사람은?
-- 1. 가장 높은 SAL 테이블
SELECT max(sal) FROM emp;
-- 2. 부서별 높은 사람
SELECT ename, deptno, sal
FROM emp
WHERE sal in (
    SELECT MAX(sal)
    FROM emp
    GROUP BY deptno
) ORDER BY 2;


SELECT * FROM box_office LIMIT 3;
-- 2018년에 가장 많은 매출을 기록한 영화보다 더 많은 매출을 기록한 2019년도 영화 검색
-- 1.2018년에 가장 많은 매출
SELECT max(sale_amt) FROM box_office WHERE release_date >= '2018-01-01' AND release_date <= '2018-12-31';
-- 2. 2019년도에서 sale 비교
SELECT movie_name, sale_amt FROM box_office
WHERE sale_amt > (
    SELECT max(sale_amt) FROM box_office WHERE release_date >= '2018-01-01' AND release_date <= '2018-12-31'
);
-- 2019년에 개봉한 영화 중
-- 2018년에 개봉하지 않았던 영화의 순위, 영화면 감독을 검색
SELECT max(sale_amt) FROM box_office WHERE release_date >= '2018-01-01' AND release_date <= '2019-12-31';

-- 1. 2018년에 개봉한 영화
SELECT movie_name FROM box_office WHERE year(release_date) = 2018;
-- 2. 2019년에 개봉한 영화 중~
SELECT movie_name, ranks, director
FROM box_office
WHERE YEAR(release_date) = 2019 AND movie_name not in (
    SELECT
        movie_name
    FROM box_office
     WHERE year(release_date) = 2018
)

-- CTE, Common Table Expression FROM 절에서는 사용하기 위한 파생 테이블의 별명을 붙여서 사용할 수 있습니다 
USE fisa;
WITH mgr AS (SELECT b.deptno, b.empno, c.ename
					  FROM emp b, emp c
					 WHERE b.empno = c.empno
       )  -- AS 뒤에 있는 쿼리로 만들어진 테이블을 메인쿼리에서 mgr이라고 부르겠다 
       
SELECT a.deptno, a.dname, mgr.empno
  FROM dept a, mgr -- mgr이라고 부르고 있습니다 
 WHERE a.deptno = mgr.deptno
 ORDER BY 1;

use fisa; 
 -- 모든 부서의 정보와 함꼐 커미션이 있는 직원들의 커미션과 이름을 조회
SELECT e.comm, e.ename, d.deptno, d.dname, d.loc
FROM emp e, dept d
WHERE e.comm IS NOT NULL AND e.comm != 0
ORDER BY ename, deptno;
 -- 모든 부서의 부서별 연봉에 대한 총합과 평균, 표준 편차를 구하고
 -- 모든 부서의 사원수를 구하기
SELECT d.deptno, d.dname, avg(e.sal)
FROM emp e LEFT JOIN dept d
ON e.deptno = d.deptno
GROUP BY deptno
ORDER BY 1;

 -- 각 관리자의 부하직원수와 부하직원들의 평균연봉을 구하기
SELECT d.deptno, d.dname, avg(e.sal), COUNT(e.ename)
FROM emp e LEFT JOIN dept d
ON e.deptno = d.deptno
GROUP BY deptno
ORDER BY 1;

 #SUB-Query
 -- where 절에서의 서브쿼리
 -- scott과 같은 부서에 있는 직원 이름을 검색해보기
 -- 1. scott 부서 출력
 SELECT deptno FROM emp WHERE ename = 'SCOTT';
 -- 2. 같은 부서 직원 이름 검색
 SELECT ename, deptno FROM emp WHERE deptno = (
     SELECT deptno FROM emp WHERE ename = 'SCOTT'
 ) AND ename != 'SMITH';

 -- 직무(job)이 Manager인 사람들이 속한 부서의 부서번호와 부서명, 지역을 조회
    -- Manager 사람들이 다수이기 때문에 where 절에 in 을 활용
SELECT job FROM emp WHERE job = 'MANAGER';

SELECT d.deptno, d.dname, d.loc, e.ename
FROM emp e, dept d
WHERE e.job in (
    SELECT job FROM emp WHERE job = 'MANAGER'
)

#from 절에서의 서브쿼리가
-- emp 테이블에서 급여가 2000이 넘는 사람들의 이름과 부서번호, 부서이름, 지역 조회
-- 1. 급여가 2000넘는 table
SELECT * FROM emp WHERE sal > 2000;

SELECT d.deptno, d.dname, d.loc, e.ename, e.sal
FROM dept d, (
            SELECT * FROM emp WHERE sal > 2000
           ) as e
ORDER BY 1;

-- emp 테이블에서 커미션이 있는 사람들의 이름과 부서번호, 부서이름, 지역을 조회
-- join 절에서의 서브쿼리
SELECT * FROM emp WHERE comm IS NOT NULL;

SELECT e.ename, d.deptno, d.dname, d.loc
FROM dept d RIGHT OUTER JOIN (
    SELECT * FROM emp WHERE comm IS NOT NULL
) as e ON d.deptno = e.deptno;

-- 모든 부서의 부서이름과 지역 부서내의 평균 급여를 조회
SELECT d.dname, d.loc, AVG(e.sal) AS average 
FROM
 dept d 
    JOIN emp e 
        ON e.deptno = d.deptno
GROUP BY d.dname, d.loc;



--- DML

CREATE TABLE emp02 SELECT empno, ename, deptno FROM emp WHERE 1=0 ; -- 거짓이니까 텅 빈 테이블이라는 것
SELECT * FROM emp02;

DROP TABLE IF EXISTS emp02;
