---1) Database Operations
CREATE DATABASE Hospital_Backup_DB;
DROP DATABASE IF EXISTS [Hospital Backup DB];
ALTER DATABASE Hospital_Backup_DB
MODIFY NAME = Medical_Center_DB;
use Medical_Center_DB;

/*Create a temporary table named #temp patient vitals with columns: temp id INT, patient id
VARCHAR(50), blood pressure VARCHAR(10), temperature DECIMAL(4,2), heart rate INT*/
create table #temp(
temp_id int , 
patient_id VARCHAR(50), 
blood_pressure VARCHAR(10),
temperature DECIMAL(4,2),
heart_rate INT
)
--2)TABLE OPERATIONS--
---Create a permanent table named ”staff” with columns
CREATE TABLE staff (
    staff_id VARCHAR(50) PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    position VARCHAR(100),
    department_id VARCHAR(50),
    hire_date DATE,
    salary DECIMAL(10,2)
)
--Drop the table
DROP TABLE staff;

--Rename the table ”patients” to ”clients”
EXEC sp_rename 'patients', 'clients';

---Truncate all records from the ”lab results
TRUNCATE TABLE lab_results;

---10. Create a copy of the ”doctors” table named ”doctors backup” with all its data
SELECT *
INTO doctors_backup
FROM doctors;
---3 SELECT QueriesSELECT *
FROM patients
WHERE patient_id = 'PAT015';

SELECT first_name, last_name, phone
FROM patients
WHERE last_name = 'Al-Fayed';

SELECT *
FROM doctors
WHERE department_id = 'DEPT001';

SELECT *
FROM appointments
WHERE appointment_date = '2024-02-15';

SELECT *
FROM patients
WHERE date_of_birth BETWEEN '1990-01-01' AND '1995-12-31';

---4 INSERT Operations
INSERT INTO patients (patient_id, first_name,last_name,date_of_birth,gender,address,phone,email,emergency_contact,blood_type,allergies)VALUES 
('PAT051','Ali','Hassan','1988-11-03','Male','123 Palm Street, Dubai','971-555-0123','ali.hassan@email.com','Fatima Hassan-971-555-0124','B+','None');

INSERT INTO medicines (medicines_id, name, description, stock_quantity, unit_price, expiry_date) VALUES
('MED016', 'Paracetamol', 'Pain reliever', 1500, 7.50, '2026-05-31'),
('MED017', 'Amoxicillin-Clavulanate', 'Antibiotic', 800, 22.75, '2025-10-15'),
('MED018', 'Metoprolol Succinate', 'Beta blocker', 600, 18.25, '2025-11-30');

INSERT INTO appointments 
(appointments_id, appointment_date, appointment_time, status, reason, notes, department_id, doctor_id, patient_id)
VALUES 
('APP051', '2024-03-10', '10:30:00', 'Scheduled', 'Routine Checkup', 'First visit for patient PAT025', 'DEPT001', 'DOC003', 'PAT025');

INSERT INTO departments (department_id, name, location, phone)
VALUES ('DEPT011', 'Physical Therapy', 'Floor 5, Wing A', '555-1011');

INSERT INTO lab_tests (lab_tests_id, name, description, cost)
VALUES 
('LAB011', 'HIV Test', 'Test for HIV antibodies', 150.00),
('LAB012', 'Hepatitis Panel', 'Test for Hepatitis A, B, and C', 225.00)

---5 UPDATE Operations
UPDATE patients
SET phone = '966-500-2007'
WHERE patient_id = 'PAT007'

UPDATE appointments
SET status = 'COMPLETED'
WHERE appointments_id  = 'APT012'

UPDATE medicines
SET stock_quantity = 2500
WHERE medicines_id = 'MED005';

UPDATE doctors
SET email = 'lisa.thomas@medicalcenter.com'
WHERE doctor_id = 'DOC008';

UPDATE bills
SET payment_status = 'Paid',
    paid_amount = 350.00
WHERE bills_id = 'BILL004';

---5 DELETE Operations
DELETE FROM patients
WHERE patient_id = 'PAT042';

DELETE FROM appointments
WHERE appointment_date < '2020-01-01';

WITH DuplicatePatients AS (
    SELECT 
        patient_id,
        first_name,
        last_name,
        date_of_birth,
        ROW_NUMBER() OVER (
            PARTITION BY first_name, last_name, date_of_birth
            ORDER BY patient_id
        ) AS row_num
    FROM patients
)
DELETE FROM DuplicatePatients
WHERE row_num > 1

DELETE from medicines
where expiry_date < CAST(GETDATE() AS DATE)

DELETE FROM lab_results
WHERE patient_id = 'PAT018';

--------7) WHERE Clause
--. Find all female patients born before 1985
SELECT *
FROM patients
WHERE gender = 'Female'
  AND date_of_birth < '1985-01-01';

  --Find patients with blood type ’O+’ who have no allergies
SELECT *
FROM patients
WHERE blood_type = 'O+'
  AND (allergies IS NULL OR allergies = 'None');

  --. Find all appointments for doctor with doctor id ’DOC005’ that are marked as ’Completed’
  SELECT *
FROM appointments
WHERE doctor_id = 'DOC005'
  AND status = 'Completed';

--Find all bills with total amount greater than $300 and payment status ’Pending’
SELECT *
FROM bills
WHERE total_amount > 300
  AND payment_status = 'Pending';

--Find medicines with stock quantity less than 100 and unit price greater than $15
  SELECT *
FROM medicines
WHERE stock_quantity < 100
  AND unit_price > 15;

---8) HAVING Clause
--Find departments that have more than 3 doctors assigned to them
  SELECT department_id, COUNT(doctor_id) AS doctor_count
FROM doctors
GROUP BY department_id
HAVING COUNT(doctor_id) >2 ;

--Find doctors who have conducted more than 5 appointments
SELECT doctor_id, COUNT(appointments_id) AS appointment_count
FROM appointments
GROUP BY doctor_id
HAVING COUNT(appointments_id) > 5;

--Find patients who have had more than 2 appointments
SELECT patient_id, COUNT(appointments_id) AS appointment_count
FROM appointments
GROUP BY patient_id
HAVING COUNT(appointments_id) > 2;

-- Find medicine types that have an average price greater than $20
SELECT name AS medicine_name, AVG(unit_price) AS avg_price
FROM medicines
GROUP BY name
HAVING AVG(unit_price) > 20;

--Find departments that have an average appointment duration longer than 30 minutes
SELECT department_id, AVG(appointment_time) AS avg_time
FROM appointments
GROUP BY department_id
HAVING AVG(appointment_time) > 30;

---9 ORDER BY Clause
--List all patients ordered by last name in ascending order
SELECT *
FROM patients
ORDER BY last_name ASC;

--List appointments ordered by appointment date descending and appointment time ascending
SELECT *
FROM appointments
ORDER BY appointment_date DESC, appointment_time ASC;

--List medicines ordered by unit price descending, then by name ascending
SELECT *
FROM medicines
ORDER BY unit_price DESC, name ASC;

--List doctors ordered by specialization ascending, then by last name ascending
SELECT *
FROM doctors
ORDER BY specialization ASC, last_name ASC;

---List bills ordered by total amount descending, then by billing date ascending
SELECT *
FROM bills
ORDER BY total_amount DESC, billing_date ASC;

---10 GROUP BY Clause---. Count the number of patients by gender
50. Calculate the average appointment duration by department
SELECT gender, COUNT(*) AS patient_count
FROM patients
GROUP BY gender;

--. Count the number of appointments by status
SELECT status, COUNT(*) AS appointment_count
FROM appointments
GROUP BY status

-- Calculate the total bill amount by payment status
SELECT payment_status, SUM(total_amount) AS total_bill_amount
FROM bills
GROUP BY payment_status;

---- Count patients by blood type
SELECT blood_type, COUNT(*) AS patient_count
FROM patients
GROUP BY blood_type;
---LIMIT Clause
SELECT TOP 5 *
FROM patients
ORDER BY date_of_birth ASC;

SELECT TOP 10 *
FROM medicines
ORDER BY unit_price DESC;

SELECT TOP 5 *
FROM appointments
ORDER BY appointment_date DESC, appointment_time DESC;

SELECT TOP 3 d.doctor_id, d.first_name, d.last_name, COUNT(a.appointments_id) AS total_appointments
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
ORDER BY total_appointments DESC;

SELECT TOP 5 *
FROM bills
ORDER BY total_amount DESC;

---12 DISTINCT Clause
SELECT DISTINCT specialization
FROM doctors;

SELECT DISTINCT blood_type
FROM patients;

SELECT DISTINCT status
FROM appointments;

SELECT DISTINCT payment_method
FROM bills;

SELECT DISTINCT allergies
FROM patients;

---FETCH
SELECT TOP 10 *
FROM patients
ORDER BY date_of_birth DESC;

SELECT *
FROM appointments
ORDER BY appointment_date ASC
OFFSET 10 ROWS
FETCH NEXT 5 ROWS ONLY;

SELECT TOP 3 *
FROM medicines
ORDER BY unit_price DESC;

SELECT TOP 5 *
FROM bills
ORDER BY total_amount DESC;

SELECT TOP 10 *
FROM doctors
ORDER BY last_name ASC;

---Aliases
SELECT first_name + last_name AS [Full Name]
FROM patients;

SELECT 
    appointment_date AS [Visit Date],
    appointment_time AS [Visit Time]
FROM appointments;

SELECT first_name + last_name AS [Physician Name],
       specialization AS [Specialty]
FROM doctors;

SELECT total_amount AS [Total Charge],
       paid_amount AS [Amount Paid]
FROM bills;

SELECT name AS [Drug Name],
       unit_price AS [Price per Unit]
FROM medicines;

--- AND Operator
SELECT *
FROM patients
WHERE gender = 'Female'
  AND blood_type = 'A+'
  AND (allergies IS NULL OR allergies = 'None');

  SELECT *
FROM appointments
WHERE department_id = 'DEPT001'
  AND status = 'Completed'
  AND appointment_date >= '2024-01-01'
  AND appointment_date <= '2024-01-31';

  SELECT *
FROM bills
WHERE total_amount > 500
  AND payment_status = 'Pending'
  AND billing_date >= DATEADD(DAY, -30, GETDATE());

  SELECT *
FROM doctors
WHERE department_id = 'DEPT007'
  AND last_name LIKE 'S%'
  AND specialization LIKE '%Surgeon%';

  SELECT *
FROM patients
WHERE date_of_birth BETWEEN '1980-01-01' AND '1990-12-31'
  AND blood_type LIKE 'O%'
  AND (allergies IS NULL OR allergies = 'None');

 ---OR Operator
  SELECT *
FROM patients
WHERE blood_type IN ('O+', 'O-');

SELECT *
FROM appointments
WHERE department_id='DEPT001'or department_id= 'DEPT002'

SELECT *
FROM bills
WHERE payment_status ='Paid'OR payment_status = 'Partial'

SELECT *
FROM doctors
WHERE specialization ='Cardiologist'or specialization = 'Neurologist'

SELECT *
FROM patients
WHERE allergies ='Penicillin'or allergies =  'Aspirin'

--Logical Operators
SELECT *
FROM patients
WHERE gender != 'Male';

SELECT *
FROM appointments
WHERE status != 'Completed';

SELECT *
FROM bills
WHERE paid_amount < total_amount;

SELECT *
FROM medicines
WHERE expiry_date > GETDATE();

SELECT *
FROM doctors
WHERE department_id <> 'DEPT007';

----LIKE Operator
SELECT *
FROM patients
WHERE last_name LIKE 'Al-%';

SELECT *
FROM doctors
WHERE first_name LIKE '%a';

SELECT *
FROM medicines
WHERE name LIKE '%cin%';

SELECT *
FROM departments
WHERE location LIKE '%Floor 1%';

SELECT *
FROM patients
WHERE email LIKE '%@gmail.com';

SELECT *
FROM patients
WHERE address LIKE '%Riyadh%'
   OR address LIKE '%Dubai%'
   OR address LIKE '%Doha%';
--- IN Operator
   SELECT *
FROM doctors
WHERE specialization IN ('Cardiologist', 'Neurologist', 'Pediatrician');

SELECT *
FROM appointments
WHERE status IN ('Scheduled', 'Completed', 'Cancelled');

SELECT *
FROM medicines
WHERE unit_price BETWEEN 10 AND 50;

SELECT *
FROM bills
WHERE payment_method IN ('Credit Card', 'Debit Card', 'Cash');

---- IS NULL Operator
SELECT *
FROM patients
WHERE emergency_contact IS NULL;

SELECT *
FROM appointments
WHERE doctor_id IS NULL;

SELECT *
FROM bills
WHERE payment_method IS NULL;

SELECT *
FROM medical_records
WHERE diagnosis IS NULL;

SELECT *
FROM patients
WHERE allergies IS NULL;

----- UNION, UNION ALL, and EXCEPT Operators
SELECT first_name
FROM patients
UNION
SELECT first_name
FROM doctors;

SELECT last_name
FROM patients
UNION ALL
SELECT last_name
FROM doctors;

SELECT patient_id
FROM patients
EXCEPT
SELECT patient_id
FROM appointments;

SELECT patient_id AS person_id, 
       first_name + ' ' + last_name AS full_name, 
       'Patient' AS type
FROM patients
UNION
SELECT doctor_id AS person_id, 
       first_name + ' ' + last_name AS full_name, 
       'Doctor' AS type
FROM doctors;

SELECT medicines_id
FROM medicines
EXCEPT
SELECT medicine_id
FROM prescription_medicines;

----BETWEEN Operator
SELECT *
FROM appointments
WHERE appointment_date BETWEEN '2024-03-01' AND '2024-03-07';

SELECT *
FROM patients
WHERE date_of_birth BETWEEN '1980-01-01' AND '1990-12-31';

SELECT *
FROM bills
WHERE billing_date BETWEEN '2024-02-01' AND '2024-02-29'
  AND total_amount BETWEEN 200 AND 500;

  SELECT *
FROM medicines
WHERE unit_price BETWEEN 10 AND 25;

SELECT *
FROM lab_tests
WHERE cost BETWEEN 50 AND 100;

---- ALL/ANY Operators
SELECT *
FROM patients
WHERE date_of_birth < ALL (
    SELECT date_of_birth
    FROM patients
    WHERE address LIKE '%Dubai%'
)

SELECT d.doctor_id, d.first_name, d.last_name, d.department_id
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name, d.department_id
HAVING COUNT(a.appointments_id) > ANY (
    SELECT COUNT(a2.appointments_id)
    FROM doctors d2
    JOIN appointments a2 ON d2.doctor_id = a2.doctor_id
    WHERE d2.department_id = 'DEPT002'
    GROUP BY d2.doctor_id
);

SELECT *
FROM medicines
WHERE unit_price > ALL (
    SELECT unit_price
    FROM medicines
    WHERE description LIKE '%Pain Reliever%'
);

SELECT *
FROM bills
WHERE total_amount > ANY (
    SELECT total_amount
    FROM bills
    WHERE payment_method = 'Insurance'
);

SELECT *
FROM appointments
WHERE appointment_time < ALL (
    SELECT appointment_time
    FROM appointments
    WHERE patient_id = 'PAT001'
)

--EXISTS Operator
SELECT *
FROM doctors d
WHERE EXISTS (
    SELECT 1
    FROM appointments a
    WHERE a.doctor_id = d.doctor_id
      AND a.status = 'Completed'
)

SELECT *
FROM patients p
WHERE EXISTS (
    SELECT 1
    FROM bills b
    WHERE b.patient_id = p.patient_id
      AND b.payment_status != 'Paid'
)

SELECT *
FROM medicines m
WHERE EXISTS (
    SELECT 1
    FROM prescription_medicines pm
    WHERE pm.medicine_id = m.medicines_id
);

SELECT *
FROM departments d
WHERE not EXISTS (
    SELECT 1
    FROM doctors doc
    WHERE doc.department_id = d.department_id
)

SELECT *
FROM patients p
WHERE NOT EXISTS (
    SELECT 1
    FROM appointments a
    WHERE a.patient_id = p.patient_id
)

---aggregate function
SELECT COUNT(*) AS male_patient_count
FROM patients
WHERE gender = 'Male';

SELECT SUM(total_amount - paid_amount) AS total_outstanding_balance
FROM bills;

SELECT MIN(unit_price) AS lowest_medicine_price
FROM medicines;

SELECT MAX(total_amount) AS highest_bill_amount
FROM bills;

SELECT AVG(cost) AS average_lab_test_cost
FROM lab_tests;

---27 JOINs (INNER, LEFT, RIGHT, FULL)
SELECT a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.notes,
       a.department_id,
       p.first_name +  p.last_name AS patient_full_name,
       d.first_name +  d.last_name AS doctor_full_name
FROM appointments a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT p.patient_id,
       p.first_name +  p.last_name AS patient_full_name,
       a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.department_id,
       a.doctor_id
FROM patients p
LEFT JOIN appointments a ON p.patient_id = a.patient_id;

SELECT d.doctor_id,
       d.first_name + d.last_name AS doctor_full_name,
       a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.department_id,
       a.patient_id
FROM appointments a
RIGHT JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT p.patient_id,
       p.first_name +  p.last_name AS patient_full_name,
       d.doctor_id,
       d.first_name +  d.last_name AS doctor_full_name,
       a.appointments_id,
       a.appointment_date,
       a.appointment_time,
       a.status,
       a.reason,
       a.department_id
FROM patients p
FULL OUTER JOIN appointments a ON p.patient_id = a.patient_id
FULL OUTER JOIN doctors d ON a.doctor_id = d.doctor_id;

SELECT a.appointments_id,
       p.first_name +  p.last_name AS patient_full_name,
       d.first_name +  d.last_name AS doctor_full_name,
       dept.name AS department_name,
       mr.diagnosis,
       b.total_amount AS total_bill_amount
FROM appointments a
INNER JOIN patients p ON a.patient_id = p.patient_id
INNER JOIN doctors d ON a.doctor_id = d.doctor_id
INNER JOIN departments dept ON a.department_id = dept.department_id
LEFT JOIN medical_records mr ON a.appointments_id = mr.appointment_id
LEFT JOIN bills b ON a.appointments_id = b.appointment_id
WHERE a.appointments_id = 'APT005';

---Date Functions
SELECT patient_id,
       first_name +last_name AS patient_full_name,
       YEAR(date_of_birth) AS year_of_birth
FROM patients;

SELECT patient_id,
       first_name +  last_name AS patient_full_name,
       DATEDIFF(YEAR, date_of_birth, GETDATE()) AS age
FROM patients;

SELECT *
FROM appointments
WHERE DATENAME(WEEKDAY, appointment_date) = 'Monday';

SELECT bills_id,
       billing_date,
       DATEADD(DAY, 30, billing_date) AS due_date,
       total_amount,
       paid_amount,
       payment_status
FROM bills;

SELECT appointments_id,
       appointment_date,
       DATEDIFF(DAY, GETDATE(), appointment_date) AS days_until_appointment,
       patient_id,
       doctor_id,
       status
FROM appointments
WHERE appointment_date > GETDATE();

---29 String Functions
select UPPER(last_name) 
from patients

select CONCAT(first_name, ' ' , last_name ) as Fullname
from doctors

SELECT SUBSTRING(blood_type, 1, 3) as first_three_chars
FROM patients;

SELECT address ,
       LTRIM(RTRIM(address)) as cleaned_address
FROM patients;

SELECT  allergies,
       REPLACE(allergies, 'None', 'No Known Allergies') as updated_allergies
FROM patients;

-----Views
create view vPatientAppointments as
SELECT 
	p.first_name + ' ' + p.last_name as full_name_pat ,
	a.appointment_date,
	d.first_name + ' ' + d.last_name as full_name_dot 
FROM patients p
JOIN appointments a 
    ON p.patient_id = a.patient_id
JOIN doctors d 
    ON a.doctor_id = d.doctor_id; 
select *  from vPatientAppointments

insert into patients (patient_id , first_name , last_name, date_of_birth)
 values ('PAT052' , 'mirna' , 'ahmed' ,'2001-07-07')

EXEC sp_rename 'vPatientAppointments', 'vPatientVisits';
 
 drop view vPatientVisits

 create view vDailyRevenue AS
 select  billing_date , 
		SUM(paid_amount) AS total_revenue
FROM bills
GROUP BY billing_date
select * from vDailyRevenue
------
----Subqueries
ALTER TABLE doctors
ADD salary int 
SELECT first_name + ' ' + last_name
FROM doctors
where salary = (SELECT MAX(salary) from doctors)

select distinct p.first_name + ' ' + p.last_name
from patients p
where p.patient_id IN (
    SELECT a.patient_id
    FROM appointments a
    WHERE a.doctor_id IN (
        SELECT d.doctor_id
        FROM doctors d
        WHERE d.department_id = 'DEPT001'
    )
)

select  m.medicines_id, m.name, m.unit_price, m.stock_quantity
from medicines m
where m.unit_price > (
    select AVG(m2.unit_price)
    from medicines m2
    where m2.stock_quantity = m.stock_quantity
)

SELECT appointments_id
       appointment_date,
       (SELECT COUNT(*)
        FROM appointments 
        WHERE patient_id = patient_id) as aaa
FROM appointments 

select dep.name from departments dep 
join doctors d ON dep.department_id = d.department_id
where d.department_id in ( SELECT department_id
    FROM doctors 
    WHERE specialization LIKE '%Surgeon%'
    GROUP BY department_id) 

SELECT p.patient_id, p.first_name + ' ' + p.last_name as name
FROM patients p join bills b
on p.patient_id = b.patient_id
WHERE  b.patient_id in (
    SELECT patient_id
    FROM bills 
    WHERE payment_status = 'Pending'
)

select d.first_name + ' ' + d.last_name AS name,
       d.doctor_id,
       count(a.appointments_id) AS total_appointments,
       (select avg(cnt)
        from (
            select COUNT(*) AS cnt
            from appointments
            group by doctor_id
        ) t) AS avg_appointments_per_doctor
FROM doctors d
JOIN appointments a ON d.doctor_id = a.doctor_id
GROUP BY d.doctor_id, d.first_name, d.last_name
HAVING COUNT(a.appointments_id) > 1;

select m.name 
from medical_records mr 
join prescriptions p 
on mr.patient_id = p.patient_id
join prescription_medicines pm 
on pm.prescription_id =p.prescriptions_id
join medicines m
on m.medicines_id = pm.medicine_id
where mr.patient_id =(select patient_id 
					from  medical_records 
					where patient_id = 'PAT001')

UPDATE m
SET m.stock_quantity = m.stock_quantity + 50
FROM medicines m
JOIN prescription_medicines pm ON m.medicines_id = pm.medicine_id
join prescriptions p
on pm.prescription_id = p.prescriptions_id
WHERE p.prescriptions_id in ( SELECT prescriptions_id
    FROM prescriptions 
    WHERE  prescription_date >= DATEADD(MONTH, -1, GETDATE())
    GROUP BY prescriptions_id
    HAVING COUNT(*) > 10 )

DELETE lt
FROM lab_tests lt
 JOIN lab_results lr ON lt.lab_tests_id = lr.lab_results_id
WHERE  lab_results_id not in (
    SELECT DISTINCT lab_tests_id FROM lab_results
)

----Backup and Restore
BACKUP DATABASE [Hospital_DB]
TO DISK = 'D:\depi\SQL\Hospital_DB Full.bak'
WITH NAME = 'Hospital DB Full Backup',
     DESCRIPTION = 'Full Backup of Hospital_DB database',
     INIT,
     STATS = 10;

----Restore
RESTORE DATABASE [Hospital_DB]
FROM DISK = 'D:\depi\SQL\Hospital_DB Full.bak'
WITH 
    FILE = 1,
    NOUNLOAD,
    REPLACE,
    STATS = 10;









