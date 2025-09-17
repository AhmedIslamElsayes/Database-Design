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
