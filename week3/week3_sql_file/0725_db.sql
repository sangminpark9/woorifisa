
-- 6
SELECT * FROM dept;
SELECT e.ename, e.sal, d.loc
FROM emp e, dept d
WHERE d.loc = 'NEW YORK' AND d.deptno = e.deptno;

-- 7

SELECT e.ename, e.hiredate, d.dname
FROM emp e, dept d
WHERE d.dname = 'ACCOUNTING' AND d.deptno = e.deptno;

--8

SELECT e.ename, e.job, d.dname
FROM emp e, dept d
WHERE d.deptno = e.deptno;

-- not-equi 조인
-- 부등호를 가지고도 조인이 된다.

SELECT e.ename, s.grade, e.sal, s.losal, s.hisal
FROM emp e, salgrade s
WHERE s.losal < e.sal AND e.sal < s.hisal;


-- 3. self 조인
-- 11. smith 직원의 매니저 이름 검색

SELECT *
FROM emp e, emp m -- 같은 테이블에 다른 별칭을 붙여서
WHERE e.ename = 'SMITH' AND e.mgr = m.empno;

--12. SMITH와 동일한 부서에서 근무하는 사원의 이름 검색
-- 단, SMITH 이름은 제외하면서 검색

