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