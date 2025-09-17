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