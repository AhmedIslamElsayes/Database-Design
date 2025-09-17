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

---10 GROUP BY Clause
---. Count the number of patients by gender
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