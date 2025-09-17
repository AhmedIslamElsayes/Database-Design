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
