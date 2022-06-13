-- New table w/ employees & titles (some help + ideas from Nick Foley - github.com/NickFoley47)
SELECT employees.emp_no, employees.first_name, employees.last_name, titles.title, titles.from_date, titles.to_date
INTO titles_retiring
FROM employees
LEFT JOIN titles
ON employees.emp_no = titles.emp_no
WHERE (birth_date BETWEEN '1952-01-01' AND '1955-12-31')
ORDER BY emp_no ASC;

-- Use Dictinct with Orderby to remove duplicate rows
SELECT DISTINCT ON (emp_no) emp_no, first_name, last_name, title
INTO titles_unique
FROM titles_retiring
WHERE to_date = ('9999-01-01')
ORDER BY emp_no ASC, to_date DESC;

-- Counting employees by job title who are also pending retirement
SELECT COUNT(title),
title
INTO retiring_titles
FROM unique_titles
GROUP BY title
ORDER BY COUNT DESC;

-- Determining employee mentorship program eligibility
SELECT DISTINCT ON (employees.emp_no) employees.emp_no, employees.first_name, employees.last_name, employees.birth_date, dept_emp.from_date, dept_emp.to_date, titles.title
INTO mentorship_eligibilty
FROM employees
INNER JOIN dept_emp ON employees.emp_no = dept_emp.emp_no
INNER JOIN titles ON employees.emp_no = titles.emp_no
WHERE employees.birth_date BETWEEN '1965-01-01' AND '1965-12-31' 
AND dept_emp.to_date = ('9999-01-01') 
ORDER BY employees.emp_no;