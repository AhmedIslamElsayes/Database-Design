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